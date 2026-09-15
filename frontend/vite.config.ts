import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
	plugins: [
		tailwindcss(),
	],

	server: {
		port: 5173,
	},

	build: {
		outDir: "../src/main/resources/public/assets",
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
