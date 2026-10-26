# Redesign Roadmap — Beacon / Analog Night

## North star

Redesign the site so it feels like **standing far away from a radio tower at
night**: mostly dark, cold air, one red beacon, and a distant sodium streetlight.
Take the quiet, analog, liminal mood of *Serial Experiments Lain* — not its
literal imagery or neon-cyberpunk clichés.

The site should still be a clear, readable portfolio. The atmosphere carries the
feeling; the content stays direct.

## Design contract

- **Red is the beacon:** status, one hero word, active nav marker, tiny ticks.
- **Sodium amber is the distant streetlight:** focus rings, one background glow,
  rare hover warmth.
- **Paper is for reading:** body text and primary buttons.
- **One light source per component.** If red and sodium appear together, they
  should be at different distances, not competing for attention.
- **Texture must not hurt readability.** No scanlines over body text.
- **Warm gradients and CRT texture are atmosphere**, not decoration on body copy.
  Keep text on quiet, readable ground.
- **Motion is slow and rare.** One beacon pulse is enough.
- **Server-rendered first.** JavaScript enhances; it does not render the page.
- **One slice at a time.** Review before spreading a pattern.

## Current baseline

Already in place:

- Portfolio landing page with hero, selected work, about, contact, and footer
- Guestbook page backed by embedded H2
- Shared JTE head/header/footer components
- HTMX navigation, Alpine copy-email interaction
- Vite HMR, JTE hot reload, Java auto-restart
- Single runnable jar
- Tests and CI

Still to resolve:

- Real name, email, GitHub links, project content, bio, and location
- Placeholder project cards and contact details
- No project detail pages
- No guestbook moderation or rate limiting
- No deployment, backup, or monitoring plan
- Current palette is zinc + amber + emerald; the new system is night + signal red
  + rare sodium amber

## Status snapshot

- [x] Visual system applied across the existing portfolio and guestbook pages
- [x] Warm CRT/grunge pass: gradients, wire grid, scanlines, tower, HUD details
- [ ] Real content, links, project details, and screenshots
- [ ] Guestbook moderation and rate limiting
- [ ] Deployment, backups, and monitoring
- [ ] Final accessibility and performance pass

The current pages are a **visual reference**, not the final content pass.

## How we will work

Default mode is **teach and pair**, not “implement the whole redesign.”

For each slice:

1. We agree on the design question.
2. I explain the principle and the options.
3. You make the first edit where practical.
4. I review the result and explain the trade-offs.
5. We verify it with the checks and a visual pass.
6. We update this roadmap and choose the next slice.

I will implement directly only when you say “implement it” or “do it for me.”

## Phase overview

| Phase | Outcome | Mode | Effort |
|---|---|---|---|
| 0 | Content, references, and decisions | Learn | 1 session |
| 1 | Design tokens and UI primitives | Pair | 1–2 sessions |
| 2 | Global shell: background, nav, footer | Pair | 1 session |
| 3 | Hero: the beacon composition | Pair | 1–2 sessions |
| 4 | Selected work cards and project content | Pair | 1–2 sessions |
| 5 | About and toolkit | Pair | 1 session |
| 6 | Contact and footer | Pair | 1 session |
| 7 | Guestbook redesign and form UX | Pair | 1–2 sessions |
| 8 | Responsive and accessibility QA | Pair | 1 session |
| 9 | Performance, SEO, metadata | Pair | 1 session |
| 10 | Deployment and operations | Ship | 1–2 sessions |
| 11 | Launch polish and backlog | Ship | 1 session |

Effort is measured in focused sessions, not calendar time.

---

## Phase 0 — Content, references, and decisions

**Goal:** Decide what the site is about before styling it.

**Do**

- Write a one-sentence description of who the site is for and what it should make
  them feel.
- Collect 5–8 visual references: radio towers at night, sodium streetlights,
  CRT/analog interfaces, *Lain* stills, industrial photography.
- Make a “do not” list: no neon purple, no matrix green, no glitch everywhere, no
  copyrighted assets, no literal *Lain* quotes.
- Replace placeholders: name, role, email, GitHub, 2–3 real projects, bio,
  location/availability.
- Choose a font strategy: system fonts first, or self-host IBM Plex Sans + Mono.
- Choose an image strategy: custom SVG tower, licensed photo, or no photo.
- Confirm the red/sodium hierarchy.

**Acceptance**

- A short content brief exists.
- Every link is real or clearly marked as a placeholder.
- The font and image decisions are written down.

**Learning:** content-first design, art direction, references vs copying.

---

## Phase 1 — Design tokens and UI primitives

**Goal:** Turn the mood into a reusable visual language.

**Do**

- Add tokens for `night`, `ash`, `wire`, `paper`, `mist`, `signal`, `ember`,
  `sodium`, and `sodium-dim`.
- Define radii (4–6px), border widths, focus rings, selection color, and font
  choices.
- Create primitives for surfaces, cards, section labels, buttons, badges, and
  links.
- Add a reduced-motion strategy and a grain/scanline utility that is opt-in.
- Build a tiny dev-only styleguide so the tokens can be compared in one place.

**Acceptance**

- Every token has a documented use.
- Text contrast is at least 4.5:1; UI/focus contrast is at least 3:1.
- A button, card, label, and input all look like the same system.
- No hardcoded amber/emerald remains in the new primitives.

**Learning:** CSS custom properties, Tailwind `@theme`, design tokens, contrast,
component APIs.

---

## Phase 2 — Global shell

**Goal:** Make the frame feel like the same night.

**Do**

- Apply the night background, grain, and a very subtle vignette.
- Restyle the sticky header and nav with wire borders and one red active marker.
- Add a keyboard-visible focus ring in sodium.
- Restyle the footer with a quiet `END OF TRANSMISSION` motif.
- Check the skip link, landmarks, and focus order.

**Acceptance**

- The shell works at 320px and 1440px.
- Keyboard navigation is visible and logical.
- No horizontal scroll.
- The header remains readable over the hero.

**Learning:** landmarks, sticky headers, focus order, responsive navigation.

---

## Phase 3 — Hero: the beacon composition

**Goal:** Make the first screen feel like a distant signal.

**Do**

- Place one red glow high/right and one sodium glow low/left.
- Turn the availability badge into an `ON AIR` beacon while keeping the plain
  “open to new opportunities” text.
- Restyle the headline, primary CTA, and social links.
- Redesign the terminal card as a receiver panel with mono labels and one red
  light.
- Optionally add a custom SVG tower silhouette with a red beacon and faint rings.
- Add one slow beacon pulse (5–6s), disabled under reduced motion.

**Acceptance**

- The red feels rare and intentional.
- The hero has one clear focal point and one primary action.
- The text remains readable if the texture is removed.
- Mobile layout has a clear reading order.

**Learning:** hierarchy, negative space, light and distance, focal points,
restrained motion.

---

## Phase 4 — Selected work

**Goal:** Make the work scannable without losing the atmosphere.

**Do**

- Design a card system: ash surface, wire border, sharp corners, a small red
  signal marker, and a clear hover/focus state.
- Write real project cards: problem, role, outcome, and stack.
- Decide whether the featured project gets a larger layout.
- Add screenshots in `src/main/resources/public/images/` with width/height,
  `loading="lazy"`, and alt text.
- Decide whether project detail pages are worth adding.

**Acceptance**

- A visitor can understand what each project is and why it matters in one scan.
- Images do not cause layout shift.
- Cards are keyboard accessible.
- No invented project history.

**Learning:** card hierarchy, content design, image optimization, case-study
structure.

---

## Phase 5 — About and toolkit

**Goal:** Make the person behind the site feel real without inventing facts.

**Do**

- Rewrite the bio in the owner's voice.
- Group the toolkit by backend, frontend, and tooling.
- Add a small “currently” or “now” note if it can be kept current.
- Use mono labels and a technical panel, but keep body copy readable.
- Check line length and vertical rhythm.

**Acceptance**

- The bio is specific and honest.
- Body line length is roughly 60–70 characters.
- The section does not become a wall of chips.

**Learning:** typography, line length, information density, voice.

---

## Phase 6 — Contact and footer

**Goal:** Make the final call to action feel calm and clear.

**Do**

- Restyle the contact panel with the new surfaces and one red detail.
- Keep the email CTA and copy-address interaction.
- Add the guestbook link without competing with the primary contact action.
- Restyle the footer and dynamic year.
- Check focus states for all links and buttons.

**Acceptance**

- There is one obvious way to get in touch.
- Every link has a visible focus state.
- The footer does not repeat too much navigation.

**Learning:** CTA hierarchy, microcopy, accessible links.

---

## Phase 7 — Guestbook redesign and form UX

**Goal:** Make the guestbook feel native to the new design and pleasant to use.

**Do**

- Restyle the form, inputs, validation states, empty state, and entries.
- Make success, error, and loading states explicit.
- Check labels, `aria-describedby`, focus order, and error announcements.
- Decide on rate limiting and moderation.
- Consider a simple moderation view or a documented SQL workflow.
- Keep the honeypot and server-side validation.

**Acceptance**

- The form is usable with a keyboard and a screen reader.
- Validation messages are associated with their fields.
- Entries remain escaped and readable.
- Spam controls are documented.

**Learning:** form UX, error handling, progressive enhancement, moderation
trade-offs.

---

## Phase 8 — Responsive and accessibility QA

**Goal:** Make the atmosphere hold up for everyone.

**Do**

- Test 320, 375, 768, 1024, and 1440px.
- Complete a keyboard-only pass.
- Check contrast for text, borders, focus rings, and disabled states.
- Verify reduced-motion behavior.
- Spot-check landmarks, headings, labels, alt text, and the skip link.
- Check zoom at 200%.

**Acceptance**

- No horizontal scroll at any tested width.
- Body text meets 4.5:1; UI and focus meet 3:1.
- Every interactive element is reachable and visible.
- The page still works with JavaScript disabled.

**Learning:** WCAG basics, responsive testing, inclusive design.

---

## Phase 9 — Performance, SEO, metadata

**Goal:** Make the site fast and findable without adding weight.

**Do**

- Optimize images (WebP/AVIF, dimensions, lazy loading).
- Check font loading if self-hosting.
- Measure LCP, CLS, and total CSS/JS size.
- Add/verify title, description, Open Graph, canonical, robots.txt, and sitemap.
- Check HTML validity.
- Decide whether to add analytics; prefer privacy-friendly or none.

**Acceptance**

- No layout shift from images or fonts.
- Metadata is accurate on every page.
- The site works well on a slow connection.

**Learning:** Core Web Vitals, progressive enhancement, metadata.

---

## Phase 10 — Deployment and operations

**Goal:** Make the site safely runnable outside the laptop.

**Do**

- Choose a host and domain.
- Set up TLS and a reverse proxy.
- Run the single jar under a process supervisor.
- Move the H2 database to a persistent volume via `GUESTBOOK_DB`.
- Document backup and restore.
- Add health checks, log rotation, and restart behavior.
- Decide on guestbook rate limiting and moderation.
- Add security headers where appropriate.

**Acceptance**

- A fresh deploy can be reproduced from the README.
- The guestbook survives a restart and can be backed up.
- `/health` is monitored.
- No secrets are committed.

**Learning:** deployment basics, persistence, backups, operational trade-offs.

---

## Phase 11 — Launch polish and backlog

**Goal:** Ship a coherent site, not a collection of experiments.

**Do**

- Proofread all copy and check every link.
- Run the full test/build suite.
- Do a final visual pass on every page.
- Update the README and this roadmap.
- Decide what belongs in the backlog: project detail pages, blog, RSS, uses page,
  now page, guestbook moderation UI.

**Acceptance**

- No placeholders remain.
- All pages share the same visual language.
- The site is tested, documented, and deployable.
- The backlog is explicit rather than hidden in TODOs.

**Learning:** launch QA, scope control, documentation.

---

## First three sessions

1. **Phase 0:** content, references, and the “do not” list. No code.
2. **Phase 1:** tokens and primitives. Small code, heavy review.
3. **Phase 2 + 3:** global shell, then the hero. This is where the mood becomes
   visible.

Starting with the hero before the tokens is tempting, but it usually creates a
one-off design that is hard to extend.

## Decisions to make

- Fonts: system stack or self-hosted IBM Plex?
- Imagery: custom SVG tower, licensed photo, or no image?
- Project depth: cards only, or dedicated case-study pages?
- Guestbook: simple public form, or moderation/rate limiting from day one?
- Hosting: where will the single jar and H2 file live?
- How much motion is acceptable without becoming distracting?

## Definition of done

- Real content, real links, no placeholders.
- The red/sodium system is consistent across every page.
- The site is readable, keyboard accessible, responsive, and fast.
- The guestbook works and is backed up.
- The site can be deployed from the README.
- The owner can explain the design decisions.
