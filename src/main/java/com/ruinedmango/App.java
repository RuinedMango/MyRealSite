package com.ruinedmango;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.javalin.Javalin;
import io.javalin.rendering.template.JavalinJte;

public class App {
	public static App Singleton;
	private int port;
	private static Logger LOGGER = LoggerFactory.getLogger(App.class);

	public App() {
		if (Singleton != null) {
			LOGGER.error("Only one App instance allowed!");
		} else {
			Singleton = this;
		}
		port = 7070;
	}

	public void launch() {
		Javalin app = Javalin.create(config -> {

			config.fileRenderer(new JavalinJte(JavalinJte.Companion.directoryTemplateEngine()));

			config.routes.get("/", ctx -> {
				ctx.render("index.jte", Map.of("dev", false));
			});

			config.staticFiles.add("/public");

			config.routes.get("/api/hello", ctx -> {
				ctx.render("components/hello.jte");
			});
		});
		app.start(port);
	}
}
