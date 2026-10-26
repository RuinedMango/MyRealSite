#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if ! command -v bun >/dev/null 2>&1; then
    echo "error: bun is required. Install it from https://bun.sh" >&2
    exit 1
fi

# Install once before starting either process.
(cd frontend && bun install)

# Resolve the toolchain Java and runtime classpath from Gradle. This compiles
# the app once, then we run it directly so Ctrl+C stops everything.
dev_env="$(./gradlew --quiet --console=plain printDevEnv -PskipFrontend)"
java_bin="$(printf '%s\n' "$dev_env" | head -n 1)"
classpath="$(printf '%s\n' "$dev_env" | tail -n 1)"
if [ -z "$java_bin" ] || [ -z "$classpath" ]; then
    echo "error: could not determine the development runtime" >&2
    exit 1
fi

(cd frontend && exec bun run dev) &
vite_pid=$!

app_pid=""
running=true

start_app() {
    APP_ENV=development "$java_bin" -cp "$classpath" com.ruinedmango.Main &
    app_pid=$!
}

stop_app() {
    if [ -n "$app_pid" ] && kill -0 "$app_pid" 2>/dev/null; then
        kill "$app_pid" 2>/dev/null || true
        wait "$app_pid" 2>/dev/null || true
    fi
    app_pid=""
}

cleanup() {
    running=false
    stop_app
    if [ -n "${vite_pid:-}" ] && kill -0 "$vite_pid" 2>/dev/null; then
        kill "$vite_pid" 2>/dev/null || true
        wait "$vite_pid" 2>/dev/null || true
    fi
}
trap cleanup EXIT INT TERM

# Watch source timestamps so edits trigger a fresh compile.
stamp="build/dev-java.stamp"
mkdir -p build
touch "$stamp"

start_app

echo "Vite dev server: http://localhost:5173"
echo "Javalin app:     http://localhost:7070"
echo "Watching Java sources. Edits trigger a recompile and restart."

while $running; do
    sleep 1
    [ -f "$stamp" ] || touch "$stamp"

    changed="$(find src/main/java -type f -name '*.java' -newer "$stamp" -print | head -n 1 || true)"
    if [ -n "$changed" ]; then
        # Update the stamp before compiling so edits made during compilation
        # are picked up on the next pass.
        touch "$stamp"
        echo "Java change detected: $changed"
        echo "Compiling..."

        if (./gradlew --quiet --console=plain classes -PskipFrontend); then
            echo "Restarting Javalin..."
            stop_app
            start_app
        else
            echo "Compilation failed; keeping the current app running." >&2
        fi
    fi
done
