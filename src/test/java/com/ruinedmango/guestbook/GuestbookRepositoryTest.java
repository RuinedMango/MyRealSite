package com.ruinedmango.guestbook;

import org.junit.jupiter.api.Test;

import java.time.Instant;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class GuestbookRepositoryTest {

    @Test
    void storesAndReturnsEntriesNewestFirst() {
        GuestbookRepository repository = GuestbookRepository.inMemory();
        repository.initialize();

        repository.add("Alice", "First");
        repository.add("Bob", "Second");

        List<GuestbookEntry> entries = repository.recent();

        assertEquals(2, entries.size());
        assertEquals("Bob", entries.get(0).name());
        assertEquals("Alice", entries.get(1).name());
    }

    @Test
    void preservesMessageAndTimestamp() {
        GuestbookRepository repository = GuestbookRepository.inMemory();
        repository.initialize();

        Instant before = Instant.now().minusSeconds(1);
        GuestbookEntry created = repository.add("Alice", "Line one\nLine two — quoted");
        Instant after = Instant.now().plusSeconds(1);

        GuestbookEntry stored = repository.recent().get(0);

        assertEquals(created.id(), stored.id());
        assertEquals("Line one\nLine two — quoted", stored.message());
        assertTrue(stored.createdAt().isAfter(before));
        assertTrue(stored.createdAt().isBefore(after));
    }

    @Test
    void initialHandlesUnicodeNames() {
        assertEquals("A", new GuestbookEntry(1, "alice", "hi", Instant.now()).initial());
        assertEquals("🥭", new GuestbookEntry(2, "🥭 mango", "hi", Instant.now()).initial());
    }
}
