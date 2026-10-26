<div aria-hidden="true" class="pointer-events-none fixed inset-0 z-0 overflow-hidden">
    <div class="absolute -top-48 -right-48 h-[38rem] w-[38rem] rounded-full bg-ember/25 blur-3xl"></div>
    <div class="absolute -bottom-56 -left-40 h-[32rem] w-[32rem] rounded-full bg-sodium-dim/20 blur-3xl"></div>
    <div class="absolute top-0 left-1/2 h-[52rem] w-[48rem] -translate-x-1/2 bg-[radial-gradient(ellipse_at_center,rgba(217,154,78,0.08),transparent_65%)]"></div>
    <div class="absolute right-0 bottom-0 left-0 h-72 bg-gradient-to-t from-signal/10 to-transparent"></div>

    <div class="wire-grid absolute inset-0 opacity-70"></div>

    <%-- Distant tower. Visible from tablet width up. --%>
    <svg viewBox="0 0 200 520" fill="none" stroke="currentColor" stroke-width="1.35"
         class="absolute top-16 right-0 hidden h-[30rem] w-[18rem] text-mist/30 md:block lg:h-[40rem] lg:w-[24rem] lg:text-mist/40">
        <path d="M100 18v502" opacity=".55"/>
        <path d="M76 96h48M68 156h64M60 216h80M52 276h96M44 336h112M36 396h128" opacity=".4"/>
        <path d="M100 18 76 96M100 18l24 78M76 96 60 216M124 96l16 120M60 216 44 336M140 216l16 120M44 336 36 396M156 336l8 60" opacity=".3"/>
        <circle cx="100" cy="18" r="30" class="fill-signal/5"/>
        <circle cx="100" cy="18" r="16" class="fill-signal/10"/>
        <circle cx="100" cy="18" r="8" class="fill-signal/20"/>
        <circle cx="100" cy="18" r="3.5" class="fill-signal stroke-none"/>
        <circle cx="100" cy="18" r="11" class="stroke-signal/40"/>
        <circle cx="100" cy="18" r="22" class="stroke-signal/20"/>
    </svg>

    <div class="scanlines scanline-drift absolute inset-0 opacity-25"></div>
    <div class="vignette absolute inset-0"></div>
    <div class="grain-overlay absolute inset-0"></div>

    <div class="absolute top-1/2 left-4 hidden -translate-y-1/2 xl:block">
        <span class="font-mono text-[10px] tracking-[0.35em] text-mist/40 uppercase [writing-mode:vertical-rl]">
            Night band / 87.6 MHz / signal locked
        </span>
    </div>
</div>
