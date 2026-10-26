<header class="sticky top-0 z-40 relative border-b border-wire/80 bg-night/80 backdrop-blur">
    <div class="pointer-events-none absolute inset-x-0 bottom-0 h-px bg-gradient-to-r from-transparent via-signal/40 to-transparent"></div>
    <div hx-get="/api/titlebar" hx-trigger="load" hx-swap="innerHTML">
        @template.components.titlebar()
    </div>
</header>
