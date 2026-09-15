plugins {
    application
	id("java")
    id("gg.jte.gradle") version "3.2.4"
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.javalin:javalin:7.2.3")
    implementation("io.javalin:javalin-rendering-jte:7.2.3")

    implementation("gg.jte:jte:3.2.4")
    implementation("gg.jte:jte-runtime:3.2.4")

	implementation("org.slf4j:slf4j-api:2.0.18")
    runtimeOnly("ch.qos.logback:logback-classic:1.6.2")	

    testImplementation(libs.junit.jupiter)
	testImplementation("io.javalin:javalin-testtools:7.2.3")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(25)
    }
}

application {
    mainClass = "com.ruinedmango.Main"
}

tasks.named<Test>("test") {
    useJUnitPlatform()
}

val frontendDir = layout.projectDirectory.dir("frontend")
val frontendNodeModules = frontendDir.dir("node_modules")

tasks.register<Exec>("frontendInstall") {
    inputs.file(frontendDir.file("package.json"))
    inputs.file(frontendDir.file("bun.lock"))
    outputs.dir(frontendNodeModules)

    workingDir(frontendDir)
    commandLine("bun", "install")
}

tasks.register<Exec>("frontendBuild") {
    dependsOn("frontendInstall")

    inputs.dir(frontendDir.dir("src"))
    inputs.file(frontendDir.file("vite.config.ts"))

    workingDir(frontendDir)
    commandLine("bun", "run", "vite", "build")
}

tasks.register<Delete>("cleanFrontend") {
    delete(layout.projectDirectory.dir("src/main/resources/public/assets"))
}

tasks.named("processResources") {
    dependsOn("frontendBuild")
}

tasks.named("clean") {
    dependsOn("cleanFrontend")
}
