package com.ruinedmango;

import java.util.Map;

import io.javalin.Javalin;
import io.javalin.rendering.template.JavalinJte;

public class Main {
	public static void main(String[] args) {
		Javalin app = Javalin.create(config -> {

			config.fileRenderer(new JavalinJte(JavalinJte.Companion.directoryTemplateEngine()));

			config.routes.get("/", ctx -> {
				ctx.render("index.jte", Map.of("dev", Boolean.getBoolean("app.dev")));
			});

			config.staticFiles.add("/public");

			config.routes.get("/api/hello", ctx -> {
				ctx.render("components/hello.jte");
			});
		});
		app.start(7070);
	}
}
