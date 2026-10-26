@param boolean dev

<!doctype html>
<html lang="en" class="scroll-smooth">
<head>
    @template.components.head(dev, "RuinedMango — Software Developer", "RuinedMango is a software developer building fast, considered web experiences with Java, TypeScript, and modern hypermedia.")
</head>

<body class="min-h-screen overflow-x-hidden bg-night text-paper antialiased selection:bg-signal selection:text-night">
<a href="#main"
   class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:z-50 focus:rounded-card focus:bg-paper focus:px-4 focus:py-2 focus:font-semibold focus:text-night">
    Skip to content
</a>

@template.components.atmosphere()

@template.components.site-header()

<main id="main" class="relative z-10">
    <%-- Hero: one red beacon, one distant sodium light. --%>
    <section class="mx-auto max-w-5xl px-6 pt-20 pb-20 sm:pt-28">
        <div class="grid items-center gap-14 lg:grid-cols-[1.15fr_0.85fr]">
            <div>
                <p class="inline-flex flex-wrap items-center gap-2 rounded-card border border-wire bg-ash/60 px-3 py-1 font-mono text-[11px] tracking-[0.18em] uppercase">
                    <span class="beacon size-1.5 rounded-full bg-signal"></span>
                    <span class="text-paper">On air</span>
                    <span class="text-wire">/</span>
                    <span class="normal-case tracking-normal text-mist">Open to new opportunities</span>
                </p>

                <h1 class="mt-6 max-w-2xl text-4xl font-bold tracking-tight text-balance sm:text-6xl">
                    Software developer crafting
                    <span class="chromatic bg-gradient-to-r from-signal via-[#ff7a45] to-sodium bg-clip-text text-transparent">fast, considered</span>
                    web experiences.
                </h1>

                <p class="mt-6 max-w-xl text-lg leading-relaxed text-mist">
                    I work across the stack — server-rendered Java, modern TypeScript,
                    and the small details that make an interface feel right.
                </p>

                <div class="mt-8 flex flex-wrap gap-3">
                    <a href="#work"
                       class="focus-ring inline-flex items-center gap-2 rounded-card bg-gradient-to-r from-paper via-[#f2d9ba] to-sodium px-4 py-2.5 text-sm font-semibold text-night shadow-[0_0_30px_-12px_rgba(217,154,78,0.45)] transition-[filter] hover:brightness-110">
                        See my work
                        <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.75" class="size-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14M13 6l6 6-6 6"/>
                        </svg>
                    </a>
                    <a href="#contact"
                       class="focus-ring inline-flex items-center rounded-card border border-wire px-4 py-2.5 text-sm font-semibold text-paper transition-colors hover:border-sodium/60 hover:bg-sodium/5">
                        Get in touch
                    </a>
                </div>

                <div class="mt-8 flex items-center gap-3 text-sm text-mist">
                    <a href="https://github.com/ruinedmango" target="_blank" rel="noreferrer"
                       class="focus-ring rounded-sm transition-colors hover:text-paper">GitHub</a>
                    <span aria-hidden="true" class="text-wire">/</span>
                    <a href="mailto:ruinedmango@ruinedmango.com"
                       class="focus-ring rounded-sm transition-colors hover:text-paper">Email</a>
                </div>
            </div>

            <%-- Receiver panel. --%>
            <div class="relative">
                <div class="absolute -inset-4 -z-10 rounded-card bg-ember/15 blur-2xl"></div>
                <div class="warm-card crt relative overflow-hidden rounded-card border border-wire shadow-2xl shadow-black/40">
                    <div class="scanlines pointer-events-none absolute inset-0 opacity-40"></div>
                    <div class="relative flex items-center gap-2 border-b border-wire px-4 py-3">
                        <span class="size-2 rounded-full bg-signal"></span>
                        <span class="size-2 rounded-full bg-wire"></span>
                        <span class="size-2 rounded-full bg-wire"></span>
                        <span class="flicker ml-2 font-mono text-[11px] tracking-[0.18em] text-mist uppercase">RX 07 / Night band</span>
                    </div>
                    <div class="relative space-y-5 p-5 font-mono text-sm leading-relaxed">
                        <div>
                            <p class="text-[11px] tracking-[0.18em] text-mist uppercase">$ whoami</p>
                            <p class="mt-1 text-paper">RuinedMango — software developer</p>
                        </div>
                        <div>
                            <p class="text-[11px] tracking-[0.18em] text-mist uppercase">$ stack</p>
                            <p class="mt-1 text-mist">Java · Javalin · JTE</p>
                            <p class="text-mist">TypeScript · HTMX · Tailwind</p>
                        </div>
                        <div>
                            <p class="text-[11px] tracking-[0.18em] text-mist uppercase">$ status</p>
                            <p class="mt-1 flex items-center gap-2 text-signal">
                                <span class="beacon size-1.5 rounded-full bg-signal"></span>
                                building useful things
                            </p>
                        </div>
                        <div class="flex items-center justify-between border-t border-wire pt-4">
                            <span class="text-[11px] tracking-[0.18em] text-mist uppercase">87.6 MHz</span>
                            <span class="flex items-end gap-0.5" aria-hidden="true">
                                <span class="h-1 w-1 bg-sodium"></span>
                                <span class="h-2 w-1 bg-sodium"></span>
                                <span class="h-3 w-1 bg-sodium"></span>
                                <span class="h-1.5 w-1 bg-sodium/40"></span>
                                <span class="h-2.5 w-1 bg-sodium/40"></span>
                            </span>
                            <span class="flex items-center gap-1.5 text-[11px] tracking-[0.18em] text-sodium uppercase">
                                <span class="size-1 rounded-full bg-sodium"></span>
                                Signal locked
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- Selected work. --%>
    <section id="work" class="section-glow scroll-mt-24 border-t border-wire/80">
        <div class="mx-auto max-w-5xl px-6 py-20">
            <div class="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
                <div>
                    <p class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
                        <span class="size-1.5 rounded-full bg-signal"></span>
                        Transmission 01 / Selected work
                    </p>
                    <h2 class="mt-2 text-3xl font-bold tracking-tight sm:text-4xl">Things I've built.</h2>
                </div>
                <p class="max-w-sm text-sm leading-relaxed text-mist">
                    A few projects that show how I think about product, systems, and interface.
                </p>
            </div>

            <div class="mt-10 grid gap-4 md:grid-cols-2">

                <a href="https://github.com/ruinedmango/MyRealSite" target="_blank" rel="noreferrer"
                   class="focus-ring group relative overflow-hidden rounded-card border border-wire warm-card p-6 transition-colors hover:border-sodium/40 sm:p-8 md:col-span-2">
                    <div class="absolute top-0 right-0 h-48 w-48 rounded-full bg-ember/20 blur-3xl"></div>
                    <div class="relative">
                        <div class="flex items-center justify-between gap-4">
                            <span class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
                                <span class="size-1.5 rounded-full bg-signal"></span>
                                Featured project
                            </span>
                            <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                 stroke-width="1.75"
                                 class="size-5 text-mist transition-transform group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-sodium">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M7 17 17 7M8 7h9v9"/>
                            </svg>
                        </div>
                        <h3 class="mt-4 text-2xl font-semibold tracking-tight text-paper transition-colors group-hover:text-sodium">
                            MyRealSite
                        </h3>
                        <p class="mt-3 max-w-2xl text-sm leading-relaxed text-mist">
                            A server-rendered portfolio and hypermedia playground built with Javalin, JTE, HTMX,
                            Alpine, and Tailwind. It hot-reloads templates and frontend assets in development and
                            ships as a single runnable jar.
                        </p>
                        <ul class="mt-5 flex flex-wrap gap-2">
                            <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                                Java
                            </li>
                            <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                                Javalin
                            </li>
                            <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                                JTE
                            </li>
                            <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                                HTMX
                            </li>
                            <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                                Tailwind
                            </li>
                        </ul>
                    </div>
                </a>

                <a href="https://github.com/ruinedmango" target="_blank" rel="noreferrer"
                   class="focus-ring group rounded-card border border-wire warm-card p-6 transition-colors hover:border-sodium/40">
                    <div class="flex items-center justify-between gap-4">
                        <span class="font-mono text-[11px] tracking-[0.2em] text-mist uppercase">Open source</span>
                        <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.75"
                             class="size-5 text-mist transition-transform group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-sodium">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M7 17 17 7M8 7h9v9"/>
                        </svg>
                    </div>
                    <h3 class="mt-4 text-xl font-semibold tracking-tight text-paper transition-colors group-hover:text-sodium">
                        Experiments in hypermedia
                    </h3>
                    <p class="mt-3 text-sm leading-relaxed text-mist">
                        Small prototypes exploring progressive enhancement, server-rendered UI, and how little
                        JavaScript a good interface actually needs.
                    </p>
                    <ul class="mt-5 flex flex-wrap gap-2">
                        <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                            HTMX
                        </li>
                        <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                            Alpine
                        </li>
                        <li class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">
                            JTE
                        </li>
                    </ul>
                </a>

                <a href="#contact"
                   class="focus-ring group flex flex-col justify-between rounded-card border border-dashed border-wire warm-card p-6 transition-colors hover:border-sodium/50">
                    <div>
                        <span class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
                            <span class="size-1.5 rounded-full bg-signal"></span>
                            Available for work
                        </span>
                        <h3 class="mt-4 text-xl font-semibold tracking-tight text-paper transition-colors group-hover:text-sodium">
                            Have something in mind?
                        </h3>
                        <p class="mt-3 text-sm leading-relaxed text-mist">
                            I'm open to freelance projects and full-time roles. Tell me what you're building and
                            how I can help.
                        </p>
                    </div>
                    <span class="mt-5 inline-flex items-center gap-2 font-mono text-[11px] tracking-[0.18em] text-sodium uppercase">
                        Start a conversation
                        <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="1.75" class="size-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14M13 6l6 6-6 6"/>
                        </svg>
                    </span>
                </a>
            </div>
        </div>
    </section>

    <%-- About. --%>
    <section id="about" class="section-glow scroll-mt-24 border-t border-wire/80">
        <div class="mx-auto grid max-w-5xl gap-12 px-6 py-20 lg:grid-cols-[0.9fr_1.1fr]">
            <div>
                <p class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
                    <span class="size-1.5 rounded-full bg-signal"></span>
                    Transmission 02 / About
                </p>
                <h2 class="mt-2 text-3xl font-bold tracking-tight text-balance sm:text-4xl">
                    Developer by trade, tinkerer by default.
                </h2>
                <div class="mt-5 space-y-4 text-sm leading-relaxed text-mist">
                    <p>
                        I'm RuinedMango, a software developer focused on the web. I like server-rendered systems,
                        clean interfaces, and tools that get out of the way.
                    </p>
                    <p>
                        Most of my work lives between Java services and the browser. I care about fast feedback
                        loops, accessible defaults, and code that's boring in the best way.
                    </p>
                    <p>
                        When I'm not building, I'm usually reading, breaking my own tooling, or looking for a
                        better way to ship.
                    </p>
                </div>

                <dl class="mt-8 grid grid-cols-2 gap-3 text-sm">
                    <div class="rounded-card border border-wire bg-ash/60 p-4">
                        <dt class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Based in</dt>
                        <dd class="mt-1 text-paper">Remote</dd>
                    </div>
                    <div class="rounded-card border border-wire bg-ash/60 p-4">
                        <dt class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Focus</dt>
                        <dd class="mt-1 text-paper">Web products & tooling</dd>
                    </div>
                </dl>
            </div>

            <div class="rounded-card border border-wire warm-card p-6 sm:p-8">
                <div class="flex items-center justify-between gap-4">
                    <h3 class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
                        <span class="size-1.5 rounded-full bg-signal"></span>
                        Toolkit
                    </h3>
                    <span class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Day to day</span>
                </div>

                <dl class="mt-6 space-y-6">
                    <div>
                        <dt class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Backend</dt>
                        <dd class="mt-2 flex flex-wrap gap-2">
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Java</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Javalin</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">JTE</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">REST APIs</span>
                        </dd>
                    </div>
                    <div>
                        <dt class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Frontend</dt>
                        <dd class="mt-2 flex flex-wrap gap-2">
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">TypeScript</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">HTMX</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Alpine.js</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Tailwind CSS</span>
                        </dd>
                    </div>
                    <div>
                        <dt class="font-mono text-[11px] tracking-[0.18em] text-mist uppercase">Tooling</dt>
                        <dd class="mt-2 flex flex-wrap gap-2">
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Gradle</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Vite</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Bun</span>
                            <span class="rounded-sm border border-wire bg-night/60 px-2 py-1 font-mono text-[11px] tracking-wider text-mist uppercase">Git</span>
                        </dd>
                    </div>
                </dl>

                <div class="mt-8 border-t border-wire pt-5">
                    <p class="text-xs leading-relaxed text-mist">
                        Currently exploring: hypermedia-driven interfaces, JTE, and developer experience for
                        JVM + Vite projects.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <%-- Contact. --%>
    <section id="contact" class="section-glow scroll-mt-24 border-t border-wire/80">
        <div class="mx-auto max-w-5xl px-6 py-20">
            <div class="relative overflow-hidden rounded-card border border-wire warm-card p-8 sm:p-12">
                <div class="absolute -top-20 -right-20 h-64 w-64 rounded-full bg-ember/25 blur-3xl"></div>
                <div class="relative max-w-2xl">
                    <p class="flex items-center gap-2 font-mono text-[11px] tracking-[0.2em] text-mist uppercase">
                        <span class="size-1.5 rounded-full bg-signal"></span>
                        Transmission 03 / Contact
                    </p>
                    <h2 class="mt-2 text-3xl font-bold tracking-tight text-balance sm:text-4xl">
                        Let's build something that works.
                    </h2>
                    <p class="mt-4 text-sm leading-relaxed text-mist">
                        I'm open to freelance projects, full-time roles, and interesting conversations. The
                        fastest way to reach me is email.
                    </p>

                    <%-- Replace this address with your real email. --%>
                    <div x-data="{ copied: false }" class="mt-7 flex flex-wrap items-center gap-3">
                        <a href="mailto:ruinedmango@ruinedmango.com"
                           class="focus-ring inline-flex items-center gap-2 rounded-card bg-gradient-to-r from-paper via-[#f2d9ba] to-sodium px-4 py-2.5 text-sm font-semibold text-night shadow-[0_0_30px_-12px_rgba(217,154,78,0.45)] transition-[filter] hover:brightness-110">
                            Email me
                            <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                 stroke-width="1.75" class="size-4">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14M13 6l6 6-6 6"/>
                            </svg>
                        </a>
                        <button type="button"
                                @click="navigator.clipboard?.writeText('ruinedmango@ruinedmango.com'); copied = true"
                                class="focus-ring inline-flex items-center rounded-card border border-wire px-4 py-2.5 text-sm font-semibold text-paper transition-colors hover:border-sodium/60 hover:bg-sodium/5">
                            <span x-text="copied ? 'Copied' : 'Copy address'" aria-live="polite">Copy address</span>
                        </button>
                    </div>

                    <p class="mt-5 text-xs text-mist">
                        Or find me on
                        <a href="https://github.com/ruinedmango" target="_blank" rel="noreferrer"
                           class="focus-ring rounded-sm text-paper underline decoration-wire underline-offset-4 transition-colors hover:decoration-sodium">
                            GitHub
                        </a>, or <a href="/guestbook"
                                    class="focus-ring rounded-sm text-paper underline decoration-wire underline-offset-4 transition-colors hover:decoration-sodium">sign
                            the guestbook</a>.
                    </p>
                </div>
            </div>
        </div>
    </section>
</main>

@template.components.site-footer()
</body>
</html>
