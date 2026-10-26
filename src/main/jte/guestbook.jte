@import com.ruinedmango.guestbook.GuestbookEntry
@import java.time.ZoneOffset
@import java.time.format.DateTimeFormatter

@param boolean dev
@param java.util.List<GuestbookEntry> entries
@param java.util.Map<String, String> errors
@param String name
@param String message
@param boolean signed

<!doctype html>
<html lang="en" class="scroll-smooth">
<head>
    @template.components.head(dev, "Guestbook — RuinedMango", "Leave a note in the RuinedMango guestbook.")
</head>

<body class="min-h-screen overflow-x-hidden bg-night text-paper antialiased selection:bg-signal selection:text-night">
<a href="#main"
   class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:z-50 focus:rounded-card focus:bg-paper focus:px-4 focus:py-2 focus:font-semibold focus:text-night">
    Skip to content
</a>

@template.components.atmosphere()

@template.components.site-header()

<main id="main" class="relative z-10 mx-auto max-w-3xl px-6 pt-16 pb-20 sm:pt-24">
    <div class="max-w-2xl">
        <p class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
            <span class="size-1.5 rounded-full bg-signal"></span>
            Transmission 04 / Guestbook
        </p>
        <h1 class="mt-2 text-4xl font-bold tracking-tight text-balance sm:text-5xl">Leave a note.</h1>
        <p class="mt-4 text-lg leading-relaxed text-mist">
            Say hi, share what you're building, or tell me the site could be faster. Keep it kind.
        </p>
    </div>

    @if(signed)
    <div role="status"
         class="mt-8 flex items-center gap-3 rounded-card border border-wire warm-card p-4 text-sm text-paper">
        <span class="beacon size-1.5 rounded-full bg-signal"></span>
        Thanks for signing the guestbook.
    </div>
    @endif

    <form method="post" action="/guestbook"
          class="mt-10 rounded-card border border-wire warm-card p-6 sm:p-8">
        <div class="grid gap-5">
            <div>
                <label for="name"
                       class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Name</label>
                <input id="name" name="name" type="text" value="${name}" required maxlength="50" autocomplete="name"
                       aria-describedby="name-error"
                       class="mt-2 w-full rounded-card border border-wire bg-night/60 px-3 py-2 text-sm text-paper outline-none transition-colors placeholder:text-mist/50 focus:border-sodium focus:ring-2 focus:ring-sodium/20">
                <p id="name-error" class="mt-1 font-mono text-[11px] text-signal">${errors.getOrDefault("name", "")}</p>
            </div>

            <%-- Honeypot: hidden from people, tempting to bots. --%>
            <div class="hidden" aria-hidden="true">
                <label for="website">Website</label>
                <input id="website" name="website" type="text" tabindex="-1" autocomplete="off">
            </div>

            <div>
                <label for="message"
                       class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Message</label>
                <textarea id="message" name="message" rows="5" required maxlength="500" aria-describedby="message-error"
                          class="mt-2 w-full resize-y rounded-card border border-wire bg-night/60 px-3 py-2 text-sm leading-relaxed text-paper outline-none transition-colors placeholder:text-mist/50 focus:border-sodium focus:ring-2 focus:ring-sodium/20">${message}</textarea>
                <p id="message-error" class="mt-1 font-mono text-[11px] text-signal">${errors.getOrDefault("message", "")}</p>
            </div>
        </div>

        <div class="mt-5 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <p class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Plain text only · Your message is public</p>
            <button type="submit"
                    class="focus-ring inline-flex items-center justify-center rounded-card bg-gradient-to-r from-paper via-[#f2d9ba] to-sodium px-4 py-2.5 text-sm font-semibold text-night shadow-[0_0_30px_-12px_rgba(217,154,78,0.45)] transition-[filter] hover:brightness-110">
                Sign the guestbook
            </button>
        </div>
    </form>

    <section aria-labelledby="entries-heading" class="section-glow mt-16 border-t border-wire/80 pt-8">
        <div class="flex items-end justify-between gap-4">
            <h2 id="entries-heading" class="text-2xl font-bold tracking-tight">Recent notes</h2>
            <span class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">${entries.size()} shown</span>
        </div>

        <div class="mt-6 space-y-3">
            @if(entries.isEmpty())
            <div class="rounded-card border border-dashed border-wire p-10 text-center">
                <p class="text-sm text-mist">No entries yet. Be the first to sign.</p>
            </div>
            @else
            @for(GuestbookEntry entry : entries)
            <article class="rounded-card border border-wire warm-card p-5">
                <div class="flex items-start gap-4">
                    <div class="grid size-10 shrink-0 place-items-center rounded-full border border-wire bg-gradient-to-br from-ash to-ember/25 font-mono text-sm font-semibold text-sodium">
                        ${entry.initial()}
                    </div>
                    <div class="min-w-0 flex-1">
                        <div class="flex flex-wrap items-baseline justify-between gap-2">
                            <h3 class="font-semibold text-paper">${entry.name()}</h3>
                            <time datetime="${entry.createdAt().toString()}"
                                  class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">
                                ${DateTimeFormatter.ofPattern("MMM d, yyyy").withZone(ZoneOffset.UTC).format(entry.createdAt())}
                            </time>
                        </div>
                        <p class="mt-2 text-sm leading-relaxed break-words whitespace-pre-line text-mist">${entry.message()}</p>
                    </div>
                </div>
            </article>
            @endfor
            @endif
        </div>
    </section>

    <p class="mt-10 font-mono text-[11px] leading-relaxed tracking-[0.18em] text-mist uppercase">
        Entries are stored in an embedded H2 database · No account · No tracking · No third-party service
    </p>
</main>

@template.components.site-footer()
</body>
</html>
