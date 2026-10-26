import { defineConfig, type Plugin } from "vite";
import tailwindcss from "@tailwindcss/vite";

// Javalin serves the HTML, so Vite has no idea when a .jte file changes.
// Watch the templates ourselves and ask connected browsers to reload.
const jteDirectory = decodeURIComponent(
	new URL("../src/main/jte", import.meta.url).pathname,
);

function jteReload(): Plugin {
	return {
		name: "jte-full-reload",
		configureServer(server) {
			const reload = (file: string) => {
				if (file.startsWith(jteDirectory) && file.endsWith(".jte")) {
					server.ws.send({ type: "full-reload" });
				}
			};

			server.watcher.add(jteDirectory);
			server.watcher.on("change", reload);
			server.watcher.on("unlink", reload);
		},
	};
}

export default defineConfig({
	plugins: [
		tailwindcss(),
		jteReload(),
	],

	server: {
		port: 5173,
	},

	build: {
		outDir: "../build/generated-resources/public/assets",
		emptyOutDir: true,

		rolldownOptions: {
			input: "src/main.ts",
			output: {
				entryFileNames: "index.js",
				assetFileNames: "index.[ext]",
			},
		},
	},
});
