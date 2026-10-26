package com.ruinedmango;

import com.ruinedmango.guestbook.GuestbookEntry;
import com.ruinedmango.guestbook.GuestbookRepository;
import gg.jte.ContentType;
import gg.jte.TemplateEngine;
import gg.jte.resolve.DirectoryCodeResolver;
import io.javalin.Javalin;
import io.javalin.http.Context;
import io.javalin.http.staticfiles.Location;
import io.javalin.rendering.template.JavalinJte;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.file.Path;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class App {
    private static final Logger LOGGER = LoggerFactory.getLogger(App.class);
    private static final int DEFAULT_PORT = 7070;
    private static final Path TEMPLATE_DIRECTORY = Path.of("src/main/jte");
    private static final Path DEV_CLASS_DIRECTORY = Path.of("build/jte-dev-classes");

    private final int port;
    private final boolean dev;
    private final GuestbookRepository guestbook;

    public App() {
        this(portFromEnvironment(), devFromEnvironment(), GuestbookRepository.fromEnvironment());
    }

    public App(int port, boolean dev) {
        this(port, dev, GuestbookRepository.inMemory());
    }

    public App(int port, boolean dev, GuestbookRepository guestbook) {
        this.port = port;
        this.dev = dev;
        this.guestbook = guestbook;
    }

    public Javalin createApp() {
        guestbook.initialize();

        return Javalin.create(config -> {
            if (dev) {
                config.bundledPlugins.enableDevLogging();
            }

            config.fileRenderer(new JavalinJte(templateEngine()));

            if (dev) {
                config.staticFiles.add(staticFiles -> {
                    staticFiles.directory = "src/main/resources/public";
                    staticFiles.location = Location.EXTERNAL;
                });
            } else {
                config.staticFiles.add("/public");
            }

            config.routes.get("/", this::index);
            config.routes.get("/health", ctx -> ctx.result("ok"));
            config.routes.get("/guestbook", this::guestbookPage);
            config.routes.post("/guestbook", this::signGuestbook);
            config.routes.get("/api/hello", ctx -> ctx.render("components/hello.jte"));
            config.routes.get("/api/titlebar", ctx -> ctx.render("components/titlebar.jte"));
        });
    }

    public void launch() {
        Javalin app = createApp();
        app.start(port);
        LOGGER.info(
                "RuinedMango listening on http://localhost:{} ({})",
                app.port(),
                dev ? "development" : "production"
        );
    }

    private void index(Context ctx) {
        ctx.render("index.jte", Map.of("dev", dev));
    }

    private void guestbookPage(Context ctx) {
        renderGuestbook(
                ctx,
                guestbook.recent(),
                Map.of(),
                "",
                "",
                ctx.queryParam("signed") != null
        );
    }

    private void signGuestbook(Context ctx) {
        String name = formValue(ctx, "name").trim();
        String message = formValue(ctx, "message").trim();
        String website = formValue(ctx, "website").trim();

        if (!website.isEmpty()) {
            ctx.redirect("/guestbook?signed=1");
            return;
        }

        Map<String, String> errors = new LinkedHashMap<>();
        if (name.isEmpty()) {
            errors.put("name", "Please add your name.");
        } else if (name.length() > 50) {
            errors.put("name", "Keep your name under 50 characters.");
        }

        if (message.isEmpty()) {
            errors.put("message", "Please write a message.");
        } else if (message.length() > 500) {
            errors.put("message", "Keep your message under 500 characters.");
        }

        if (!errors.isEmpty()) {
            ctx.status(422);
            renderGuestbook(ctx, guestbook.recent(), errors, name, message, false);
            return;
        }

        guestbook.add(name, message);
        ctx.redirect("/guestbook?signed=1");
    }

    private void renderGuestbook(
            Context ctx,
            List<GuestbookEntry> entries,
            Map<String, String> errors,
            String name,
            String message,
            boolean signed
    ) {
        ctx.render("guestbook.jte", Map.of(
                "dev", dev,
                "entries", entries,
                "errors", errors,
                "name", name,
                "message", message,
                "signed", signed
        ));
    }

    private static String formValue(Context ctx, String name) {
        String value = ctx.formParam(name);
        return value == null ? "" : value;
    }

    private TemplateEngine templateEngine() {
        if (dev) {
            // Compile templates on demand so edits are picked up without a restart.
            return TemplateEngine.create(
                    new DirectoryCodeResolver(TEMPLATE_DIRECTORY),
                    DEV_CLASS_DIRECTORY,
                    ContentType.Html
            );
        }

        // Templates are precompiled into the application jar by the jte Gradle plugin.
        return TemplateEngine.createPrecompiled(ContentType.Html);
    }

    private static int portFromEnvironment() {
        String value = System.getenv("PORT");
        if (value == null || value.isBlank()) {
            return DEFAULT_PORT;
        }

        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            LOGGER.warn("Invalid PORT '{}', falling back to {}", value, DEFAULT_PORT);
            return DEFAULT_PORT;
        }
    }

    private static boolean devFromEnvironment() {
        String environment = System.getenv().getOrDefault("APP_ENV", "production");
        return "development".equalsIgnoreCase(environment)
                || "dev".equalsIgnoreCase(environment)
                || "true".equalsIgnoreCase(System.getenv("APP_DEV"));
    }
}
