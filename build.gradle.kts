import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    application
    alias(libs.plugins.jte)
    alias(libs.plugins.shadow)
}

repositories {
    mavenCentral()
}

dependencies {
    implementation(libs.javalin)
    implementation(libs.javalin.rendering.jte)

    implementation(libs.jte)
    implementation(libs.jte.runtime)

    implementation(libs.h2)

    implementation(libs.slf4j.api)
    runtimeOnly(libs.logback.classic)

    testImplementation(libs.junit.jupiter)
    testImplementation(libs.javalin.testtools)
    testRuntimeOnly(libs.junit.platform.launcher)
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(27)
    }
}

application {
    mainClass = "com.ruinedmango.Main"
}

// Compile JTE templates ahead of time so the packaged application does not need
// a JDK or the template sources at runtime.
jte {
    precompile()
}

val frontendDir = layout.projectDirectory.dir("frontend")
val frontendNodeModules = frontendDir.dir("node_modules")
val generatedResources = layout.buildDirectory.dir("generated-resources")
val frontendAssets = layout.buildDirectory.dir("generated-resources/public/assets")
val jteClasses = layout.projectDirectory.dir("jte-classes")

// Serve the generated assets from the classpath alongside hand-written resources.
sourceSets {
    main {
        resources.srcDir(generatedResources)
    }
}

tasks.register<Exec>("frontendInstall") {
    group = "frontend"
    description = "Install frontend dependencies with Bun"

    inputs.file(frontendDir.file("package.json"))
    inputs.file(frontendDir.file("bun.lock"))
    outputs.dir(frontendNodeModules)

    workingDir(frontendDir)
    commandLine("bun", "install", "--frozen-lockfile")
}

tasks.register<Exec>("frontendBuild") {
    group = "frontend"
    description = "Build the frontend assets with Vite"

    dependsOn("frontendInstall")

    inputs.dir(frontendDir.dir("src"))
    inputs.dir(layout.projectDirectory.dir("src/main/jte"))
    inputs.file(frontendDir.file("vite.config.ts"))
    inputs.file(frontendDir.file("tsconfig.json"))
    inputs.file(frontendDir.file("package.json"))
    outputs.dir(frontendAssets)

    workingDir(frontendDir)
    commandLine("bun", "run", "build")
}

tasks.register<Exec>("frontendCheck") {
    group = "verification"
    description = "Type-check the frontend"

    dependsOn("frontendInstall")

    inputs.dir(frontendDir.dir("src"))
    inputs.file(frontendDir.file("tsconfig.json"))
    inputs.file(frontendDir.file("package.json"))

    workingDir(frontendDir)
    commandLine("bun", "run", "check")
}

// Print the Java executable and runtime classpath for scripts/dev.sh.
// Running the app directly (instead of through a nested Gradle build) lets
// Ctrl+C shut down the whole dev stack cleanly.
val devJavaExecutable = javaToolchains.launcherFor(java.toolchain)
    .map { it.executablePath.asFile.absolutePath }

val devRuntimeClasspath = sourceSets.main.get().runtimeClasspath.elements
    .map { files -> files.joinToString(System.getProperty("path.separator")) { it.asFile.absolutePath } }

tasks.register("printDevEnv") {
    group = "application"
    description = "Print the Java executable and runtime classpath for the dev script"

    dependsOn("classes")

    val javaExecutable = devJavaExecutable
    val runtimeClasspath = devRuntimeClasspath

    doLast {
        println(javaExecutable.get())
        println(runtimeClasspath.get())
    }
}

// Convenience alias for the dev script. The script owns the process lifecycle
// and the Java recompile/restart watcher.
tasks.register<Exec>("dev") {
    group = "application"
    description = "Run the app in development mode with Vite hot reload and Java restart"

    workingDir = rootDir
    commandLine("bash", "scripts/dev.sh")
}

// In development Vite serves the assets, so the production frontend build can
// be skipped with -PskipFrontend.
val skipFrontend = providers.gradleProperty("skipFrontend")
    .map { value -> value.isEmpty() || value.toBoolean() }
    .orElse(false)

if (!skipFrontend.get()) {
    tasks.named("processResources") {
        dependsOn("frontendBuild")
    }

    tasks.named<JavaExec>("run") {
        dependsOn("precompileJte")
    }
}

// Include precompiled templates in the runnable jar. They are loaded by
// TemplateEngine.createPrecompiled(...) in production.
tasks.named<Jar>("jar") {
    dependsOn("precompileJte")
    manifest {
        attributes["Main-Class"] = application.mainClass.get()
    }
    from(jteClasses) {
        include("**/*.class")
    }
}

// A single, self-contained runnable jar: app classes, precompiled templates,
// resources, and every runtime dependency.
tasks.named<ShadowJar>("shadowJar") {
    dependsOn("precompileJte")
    archiveClassifier.set("all")
    duplicatesStrategy = DuplicatesStrategy.INCLUDE
    mergeServiceFiles()

    // Merge license text from dependencies instead of leaving duplicate entries.
    append("META-INF/LICENSE")
    append("META-INF/LICENSE.txt")
    append("META-INF/LICENSE.md")
    append("META-INF/NOTICE.md")

    manifest {
        attributes["Main-Class"] = application.mainClass.get()
    }

    from(jteClasses) {
        include("**/*.class")
    }

    exclude("META-INF/*.SF", "META-INF/*.DSA", "META-INF/*.RSA")
}

// precompileJte produces classes outside of the normal source set, so add them
// to the classpaths that need to render templates.
tasks.named<Test>("test") {
    useJUnitPlatform()
    dependsOn("precompileJte")
    classpath = classpath + project.files(jteClasses)
}

tasks.named<JavaExec>("run") {
    classpath = classpath + project.files(jteClasses)
}

tasks.named("check") {
    dependsOn("frontendCheck")
}

tasks.register<Delete>("cleanFrontend") {
    delete(generatedResources)
}

tasks.named("clean") {
    dependsOn("cleanFrontend")
}
