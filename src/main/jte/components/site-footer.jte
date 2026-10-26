@import java.time.Year

<footer class="relative z-10 section-glow border-t border-wire/80">
    <div class="mx-auto flex max-w-5xl flex-col gap-3 px-6 py-8 font-mono text-[11px] tracking-[0.18em] text-mist uppercase sm:flex-row sm:items-center sm:justify-between">
        <p class="flex items-center gap-2">
            <span class="size-1.5 rounded-full bg-signal"></span>
            End of transmission
        </p>
        <div class="flex flex-wrap items-center gap-4">
            <a href="/guestbook" class="focus-ring rounded-sm transition-colors hover:text-paper">Guestbook</a>
            <a href="https://github.com/ruinedmango/MyRealSIte" target="_blank" rel="noreferrer"
               class="focus-ring rounded-sm transition-colors hover:text-paper">View source</a>
            <span>© ${Year.now().getValue()} RuinedMango</span>
        </div>
    </div>
</footer>
