package com.ruinedmango.guestbook;

import java.time.Instant;
import java.util.Locale;

public record GuestbookEntry(long id, String name, String message, Instant createdAt) {

    public String initial() {
        if (name.isEmpty()) {
            return "?";
        }
        return new String(Character.toChars(name.codePointAt(0))).toUpperCase(Locale.ROOT);
    }
}
