package com.ruinedmango;

import io.javalin.testtools.FormBody;
import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class AppTest {

    @Test
    void indexRendersProductionAssets() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.get("/");
            String body = response.body().string();

            assertEquals(200, response.code());
            assertTrue(body.contains("<title>RuinedMango"));
            assertTrue(body.contains("/assets/index.js"));
            assertTrue(body.contains("/assets/index.css"));
            assertFalse(body.contains("localhost:5173"));
        });
    }

    @Test
    void portfolioSectionsRender() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            String body = client.get("/").body().string();

            assertTrue(body.contains("id=\"work\""), "work section should exist");
            assertTrue(body.contains("id=\"about\""), "about section should exist");
            assertTrue(body.contains("id=\"contact\""), "contact section should exist");
            assertTrue(body.contains("MyRealSite"), "featured project should render");
        });
    }

    @Test
    void indexRendersViteClientInDevelopment() {
        JavalinTest.test(new App(0, true).createApp(), (server, client) -> {
            var response = client.get("/");
            String body = response.body().string();

            assertEquals(200, response.code());
            assertTrue(body.contains("http://localhost:5173/@vite/client"));
            assertTrue(body.contains("http://localhost:5173/src/main.ts"));
            assertFalse(body.contains("/assets/index.js"));
        });
    }

    @Test
    void markupIsValidHtmlStructure() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            String body = client.get("/").body().string();

            int bodyIndex = body.indexOf("<body");
            int headerIndex = body.indexOf("<header");
            int mainIndex = body.indexOf("<main");

            assertTrue(bodyIndex >= 0, "page should have a body");
            assertTrue(headerIndex > bodyIndex, "header should be inside body");
            assertTrue(mainIndex > headerIndex, "main should come after the header");
        });
    }

    @Test
    void titlebarFragmentRenders() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.get("/api/titlebar");
            String body = response.body().string();

            assertEquals(200, response.code());
            assertTrue(body.contains("RuinedMango"));
            assertFalse(body.toLowerCase().contains("<!doctype"), "fragments must not include a doctype");
        });
    }

    @Test
    void helloFragmentRenders() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.get("/api/hello");
            String body = response.body().string();

            assertEquals(200, response.code());
            assertTrue(body.contains("Hello from HTMX"));
            assertFalse(body.toLowerCase().contains("<!doctype"), "fragments must not include a doctype");
        });
    }

    @Test
    void healthEndpointResponds() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.get("/health");

            assertEquals(200, response.code());
            assertEquals("ok", response.body().string());
        });
    }

    @Test
    void guestbookPageRenders() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.get("/guestbook");
            String body = response.body().string();

            assertEquals(200, response.code());
            assertTrue(body.contains("Guestbook"));
            assertTrue(body.contains("No entries yet"));
        });
    }

    @Test
    void guestbookAcceptsFormSubmission() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.request("/guestbook", builder -> builder.post(
                    new FormBody.Builder()
                            .add("name", "Alice")
                            .add("message", "Hello from the test")
                            .build()
            ));

            assertEquals(302, response.code());

            String body = client.get("/guestbook").body().string();
            assertTrue(body.contains("Alice"));
            assertTrue(body.contains("Hello from the test"));
        });
    }

    @Test
    void guestbookValidatesEmptyFields() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.request("/guestbook", builder -> builder.post(
                    new FormBody.Builder()
                            .add("name", "")
                            .add("message", "")
                            .build()
            ));
            String body = response.body().string();

            assertEquals(422, response.code());
            assertTrue(body.contains("Please add your name."));
            assertTrue(body.contains("Please write a message."));
        });
    }

    @Test
    void guestbookEscapesHtml() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            client.request("/guestbook", builder -> builder.post(
                    new FormBody.Builder()
                            .add("name", "<script>alert(1)</script>")
                            .add("message", "Hello")
                            .build()
            ));

            String body = client.get("/guestbook").body().string();
            assertTrue(body.contains("&lt;script&gt;alert(1)&lt;/script&gt;"));
            assertFalse(body.contains("<script>alert(1)</script>"));
        });
    }

    @Test
    void guestbookHoneypotDoesNotStoreEntries() {
        JavalinTest.test(new App(0, false).createApp(), (server, client) -> {
            var response = client.request("/guestbook", builder -> builder.post(
                    new FormBody.Builder()
                            .add("name", "Bot")
                            .add("message", "Spam")
                            .add("website", "https://spam.example")
                            .build()
            ));

            assertEquals(302, response.code());

            String body = client.get("/guestbook").body().string();
            assertFalse(body.contains("Spam"));
        });
    }
}
