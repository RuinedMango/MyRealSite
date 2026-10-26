# RuinedMango

A small server-rendered website built with Javalin, JTE, HTMX, Alpine.js and
Tailwind CSS. The frontend is bundled by Vite and installed with Bun.

The visual direction is **Beacon / Analog Night**: a red beacon in a dark analog
landscape, rare sodium-amber light, CRT texture, and warm gradient bloom. The
redesign plan lives in [`ROADMAP.md`](ROADMAP.md).

## Requirements

- JDK 27 (Gradle provisions it automatically via the Foojay toolchain resolver)
- [Bun](https://bun.sh) for frontend dependencies and Vite

The Gradle daemon is pinned to Java 27 in `gradle/gradle-daemon-jvm.properties`
so the JTE precompiler can read the app's Java 27 class files.

## Development

```bash
./scripts/dev.sh
# or, as an alias:
./gradlew dev
```

This starts Vite on <http://localhost:5173> and the Javalin app on
<http://localhost:7070>. The dev page loads Vite's HMR client, so CSS and
TypeScript edits apply without a full reload. JTE template edits trigger a full
browser reload automatically.

Java source edits are detected, recompiled, and the app is restarted. Refresh
the browser after a Java restart. Changes to dependencies or the Gradle build
require restarting `./scripts/dev.sh`.

If you prefer to run the two processes yourself:

```bash
cd frontend && bun install && bun run dev
# in another terminal
APP_ENV=development ./gradlew run -PskipFrontend
```

## Build and run

```bash
./gradlew build
./gradlew run
```

`build` compiles the JTE templates, builds the frontend assets, and packages the
precompiled templates inside the jar. The resulting application runs on a Java
27 runtime and does not need Bun or the template sources.

For a single self-contained jar:

```bash
java -jar build/libs/newSite-all.jar
```

That jar includes Javalin, Jetty, JTE, logging, the frontend assets, and the
precompiled templates. The regular `newSite.jar` and the
`build/install/newSite` distribution are also produced.

## Content

The portfolio page lives in `src/main/jte/index.jte`; the navigation is in
`src/main/jte/components/titlebar.jte`. Replace the placeholder email, GitHub
links, and project cards there with your own details.

## Static files and images

Put images in `src/main/resources/public/images/` and reference them by URL:

```html
<img src="/images/hero.webp" alt="Description" width="1200" height="630" loading="lazy">
```

Javalin serves `src/main/resources/public` at `/`. In development it reads from
that source directory, so new files show up on refresh. Production copies the
directory into the jar.

For images imported by JavaScript or CSS, put them in `frontend/src/assets/`
and import them so Vite hashes and bundles them:

```ts
import hero from "./assets/hero.webp";
```

## Guestbook

The guestbook at `/guestbook` is stored in an embedded H2 database. H2 is pure
Java, file-backed, and needs no separate database server. By default the file is
`data/guestbook.mv.db`; the `data/` directory is ignored by git.

Set `GUESTBOOK_DB` to a different JDBC URL to move the database:

```bash
GUESTBOOK_DB='jdbc:h2:file:/var/lib/ruinedmango/guestbook' ./gradlew run
```

To back it up, stop the app and copy the `.mv.db` file.

## Checks

```bash
./gradlew test          # Javalin route tests
./gradlew frontendCheck # TypeScript type-check
./gradlew check         # everything
```

## Configuration

| Variable       | Default                          | Description                                      |
|----------------|----------------------------------|--------------------------------------------------|
| `PORT`         | `7070`                           | HTTP port                                        |
| `APP_ENV`      | `production`                     | Set to `development` for Vite assets + dev logs  |
| `APP_DEV`      | unset                            | `true` is a shorthand for development mode       |
| `GUESTBOOK_DB` | `jdbc:h2:file:./data/guestbook`  | H2 JDBC URL for guestbook storage                |

## Project layout

```
src/main/java/com/ruinedmango/   Javalin app and entry point
src/main/jte/                    JTE templates (index + HTMX fragments)
src/main/resources/logback.xml   Logging configuration
frontend/src/                    TypeScript entry point and Tailwind styles
frontend/vite.config.ts          Vite build configuration
scripts/dev.sh                   Vite + app with asset/template hot reload and Java restart
```
