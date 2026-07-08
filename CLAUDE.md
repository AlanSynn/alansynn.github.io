# CLAUDE.md

Source-of-truth context for AI agents (Claude Code, Cursor, Codex, …) working in
this repo. `AGENTS.md` is a symlink to this file so every tool reads the same
guidance. See `README.md` for the full human-facing docs.

## What this is

Alan Synn's integrated academic presence — **one repo, one content source →
website + resume + CV + targeted variants**. Live at alansynn.com.

## The one invariant that matters

**`content/` is the single content source — the only directory a human edits.**
Both renderers read it:

- **Web** → Astro components (`src/components/`, `src/pages/`); structured YAML
  + bib are imported through the single access point `src/lib/data.ts`.
- **PDF** → Typst (`resume/typst/lib.typ`, the shared template; `resume.typ` /
  `cv.typ` are 5-line entry files).

Editing a file in `content/` updates the web AND the resume/CV. Don't duplicate
content into components or `.typ` files — keep it in `content/`. Generated
artifacts (`src/data/papers.json`, `src/data/video-clips.json`) live under
`src/data/` and are never hand-edited.

## Build commands (`just`)

| Command | What |
|---|---|
| `just build` | web + default resume/CV PDFs (full pipeline) |
| `just web` | Astro build only |
| `just dev` | dev server `localhost:4321` |
| `just resume [target]` | `public/pdfs/resume[-target].pdf` |
| `just cv [target]` | `public/pdfs/cv[-target].pdf` |
| `just pdfs` | resume + cv (defaults) |

Targets: `graphics` \| `ml-systems` (filter pubs + swap research blurb). Defined
in `content/targets.yaml` (id → `{ blurb, keywords }`); adding a target there is
the only step, no code edit. Per-entry `only:` / `except:` flags on any YAML
entry.

## Conventions (don't break these)

- **A pre-commit gate runs on every commit** (husky + lint-staged). It aborts
  the commit if any of three checks fail: `lint-staged` (prettier on staged
  code only — `content/` + generated + vendored are protected by
  `.prettierignore`, so human edits are never reformatted), `astro check`
  (types), and `just web` (full build = Zod strict-schema validation + render +
  asset graph — mirrors CI, so a deploy-breaking commit is caught locally).
  Bypass a WIP commit with `git commit --no-verify`. The hook auto-installs on
  `bun install` via the `prepare` script, so fresh clones get it for free.
- **Edit content in `content/`**, never in code or generated files. Generated:
  `src/data/papers.json` (from `content/papers.bib` via
  `scripts/gen-papers-json.mjs`), `src/data/video-clips.json`,
  `public/pdfs/*.pdf`, `dist/`.
- **PDFs are committed** because CI is web-only. After changing any
  `content/*` (incl. `papers.bib`), run `just pdfs` and commit the regenerated
  PDFs alongside the source change so web and PDF stay in sync.
- **Publications live in `content/papers.bib`** — one `@inproceedings`/
  `@article` entry per paper, the single source for web + PDF. Two flags drive
  visibility, and they mean different things — don't conflate them:
  - `selected` → the paper prints in the resume/CV PDF (`lib.typ` filters on it).
  - `featured` → the paper surfaces at the TOP of the homepage `#publications`;
    every non-featured entry folds under the "All publications" toggle. Web-only;
    the PDF ignores it. A `featured` paper MUST also be `selected` —
    `enforcePaperIntegrity` fails the build otherwise (a homepage-top paper must
    appear in the CV).
  **When you add or edit an entry, fill EVERY applicable field** — `preview`
  (thumbnail image), `doi`, `pdf`, `code` (repo), `website` (project page),
  `video` (YouTube id or `/videos/<name>.mp4`), `abstract`. Hunt the values down
  via web search + extraction (DOI page, author/project page, GitHub, YouTube);
  never leave a gap you can fill. Assets: preview images → `public/images/papers/`
  (or `.../motionsmith/`), videos → `public/videos/`, committed PDFs →
  `public/pdfs/`. Every entry's `abbr` MUST have a matching key in
  `content/venues.yaml` (with `name`/`url`/`type`) or the venue badge renders as
  bare text with no link. After editing `papers.bib`, regen
  `src/data/papers.json` (`scripts/gen-papers-json.mjs`); if `selected` changed,
  also run `just pdfs` and commit the new PDFs.
- **Structured YAML is validated at build.** `src/lib/content-schema.ts`
  holds a **strict** Zod schema for every structured YAML in `content/` (site,
  cv, honors, references, research-interests, news, venues, coauthors,
  targets); `data.ts` parses each through its schema so a typo (bad key / wrong
  type / missing field) **or an unknown key** fails the build loudly with a
  located error — a dead field can never silently do nothing (the failure mode
  that once left `tagline` / `skills.yaml` / `bibtex_show` edited-but-ignored).
  The four career-timeline sections (education / experience / teaching /
  activities) share one entry model
  `{ period, title, location?, body, only?/except? }` and live together in
  **`content/cv.yaml`** — one file, one schema, one history (do not re-split).
  `enforcePaperIntegrity` (same file) warns on a paper whose `abbr` is missing
  from `venues.yaml`, and **throws** on a `featured`/`selected` mismatch.
- **Email stays obfuscated on the web.** Served HTML must contain 0 raw
  `mailto:alansynn@gatech.edu` links (anti-crawler). The PDF legitimately shows
  the raw address — that's fine, it's not crawler-facing. Don't de-obfuscate the
  web email without explicit instruction.
- **Repo language is English** — content, code comments, commit messages, docs.
- **Readability is non-negotiable** when tuning density/typography on the web:
  don't shrink fonts below the current `--step-*` sizes or reduce contrast to
  gain space. Compact by shortening wording or tightening layout, never by
  making text harder to read.
- **Verify before claiming done.** For web layout changes, measure (e.g.
  Playwright DOM geometry: line count vs. line-height), don't eyeball.
- **News is one file, capped to 8.** `content/news.yaml` is a single YAML list
  of `{ date, link?, highlight?, body }` items (newest first is easiest to
  read; the homepage sorts by `date` regardless and shows the 8 most recent).
  Each `body` is one full sentence sized to fill the column width (never a 2–3
  word stub), markdown inline OK (`**bold**`, `_italic_`, `[label](url)`).
  Order events across separate items by date (e.g. CHI: a January "accepted"
  item and an April "presenting" item), don't merge them.
- **Academic project pages (`/projects/<slug>`, frontmatter `paper: <citekey>`)
  are a deliberate 1:1 port of the bespoke motionsmith microsite design** — the
  user explicitly wanted pages identical to the original microsite, NOT the site
  system. **Do not "re-skin" this page back to Newsreader/Hanken — the bespoke
  Manrope/indigo design is intentional (light mode).** Dark mode is the one
  exception: it mirrors the **main site's** dark palette (`#13171a` bg, `#e9e6e0`
  text, `#2a3137` lines, `#6ba8ff` accent) so project pages read as part of
  alansynn.com when a reader switches themes — light is bespoke Manrope/indigo,
  dark is the site palette. The theme toggle sits header-right
  (`ThemeToggle.astro`, `#theme-toggle`).
  - **TRUE CSS isolation via a route split (the load-bearing part).**
    `src/pages/projects/[slug].astro` serves academic pages ONLY and imports
    `AcademicProject` → `MicrositeShell` → `src/styles/project-page.css` (a
    verbatim port of the microsite's 4 CSS files, scoped under `:root` tokens:
    Manrope, ink `#1b1f28`, indigo `#5a6cff`). NO site `main.css`/`base.css`/
    `tokens.css` is in that route's graph, so the microsite's global element
    rules and the 7 colliding class names it shares with the site (`.hero`,
    `.section`, `.site-footer`, …) can never leak — isolation is structural, not
    cascade-order-based. (The earlier one-route approach bundled BOTH
    stylesheets into every project page and leaked nondeterministically as Astro
    reordered chunks; the split is load-order-safe.) Work/engineering projects
    (no `paper:`) keep site chrome via their own **static** route files —
    `src/pages/projects/{aka-musio-robot,flysher-game-server,protopia-privacy-dl}.astro`
    → `SimpleProject` → `Base`.
  - **Footgun guard.** `[slug].astro` `getStaticPaths` throws at build time with
    a precise message if (a) a `paper:` citekey doesn't resolve in
    `content/papers.bib`, or (b) a work project (no `paper:`) has no matching
    static route file (it would 404 otherwise). Adding a work project = copy a
    static route file, change the slug.
  - **Parity is verified, not eyeballed.** The port reproduces the original
    microsite's DOM with its ORIGINAL class names + a Playwright computed-style
    fingerprint diff (per-class color/font/spacing/box/geometry vs the rendered
    original served locally) is the oracle: **0 style diffs, 0 site-chrome
    leaks, 61/61 classes matched.** In **light** mode, body color must be the
    microsite ink `rgb(27,31,40)` — distinct from the site's `#15171c`, so a
    black body = site `base.css` leaked. (In dark, the two palettes converge by
    design — both are the site dark ink — so body color can't discriminate there;
    the stylesheet-graph check does.) `scripts/check-isolation.mjs` is the
    regression guard: it loads a real academic route in **both** themes and
    asserts (1) no site main/tokens/base stylesheet in the graph, (2) the light
    microsite ink, (3) `data-theme` set by MicrositeShell's no-flash init. Keep
    the `body` rule free of an explicit `font-size` — it's what lets Chromium's
    monospace default (13px) size the BibTeX `<pre>` to match the original.
  - The interactive pieces — sticky hide-on-scroll header + mobile menu,
    scroll-spy nav, click-to-launch demo video, 1.85× interface lens, tabbed
    case carousel, copy button, reveal-on-scroll, and the graphics extras
    (comparison slider, results/ablation table, gallery, synced video
    comparison) — are wired in a single consolidated `<script>` in
    `AcademicProject.astro` that listens to `astro:page-load`, so they re-init
    on every View-Transition client-side nav. The script uses a `teardown[]`
    array (run before re-init) for anything that attaches window/document
    listeners or creates IntersectionObservers (header, demo, reveal, section
    tracking) — so a VT swap never leaves a dangling scroll-rAF or a stale
    observer firing on detached nodes. Element-scoped widgets (carousel, lens,
    copy buttons — the latter idempotent via `data-copy-bound`) need no teardown;
    their listeners die with the swapped DOM. All JS hooks are `data-*`
    (class-agnostic) so class renames never break behavior.
  - **Theme is consistent across site↔project View-Transition nav.** Both shells
    (site `Base.astro` and `MicrositeShell`) run the same no-flash init: resolve
    `localStorage('theme')` (default `light`) → set `[data-theme]` on `<html>`
    before paint, then re-apply on `astro:after-swap`. A single
    `window.__themeListenerBound` guard means exactly one `after-swap` listener
    exists across both shells (they share one `document`), so the attribute
    survives client-side nav either direction without flipping. Verified: a
    user-set theme stays stable through project→home→project; a toggle persists.
    `ThemeToggle.astro`'s click handler is delegated on `document` (matches
    `#theme-toggle`), so it survives VT swaps too.
  - **AI/ML/robotics method blocks** (frontmatter-driven, rendered inline by
    `AcademicProject`, all optional — present → section shows): `stat_callouts`
    (big-number grid atop Results), `equations` (numbered figures — `mathml`
    renders natively via `set:html`, **no KaTeX dep**; `latex` is a plain-text
    fallback), `algorithm` (pseudocode box, auto line numbers), `code` (filename
    bar + copy, plain mono — Shiki highlights only markdown fences, not
    frontmatter strings, so this is first-party by design), `faq` (native
    `<details>` accordion — no JS), `acknowledgments` (quiet closing section).
    These are the commonly-needed graphics/AI/robotics layouts, pre-built so a
    real paper page copies only what it needs. All token-driven in
    `project-page.css`, so they adapt to dark mode automatically.
  - Bibliographic fields (title/authors/venue/DOI/PDF/code/video/BibTeX) all
    **derive** from the linked `papers.bib` entry via `paper:` frontmatter —
    never duplicate them in the `.md`. The BibTeX block is a **clean citation**
    synthesized from the paper (type + title + author + venue + year + doi), NOT
    a dump of `paper.raw` — `raw` carries internal housekeeping flags
    (`selected`/`featured`/`preview`/`video`/`pdf`/`website`/`code`/`abstract`)
    that must never appear in a citation a reader copies.
  - `content/projects/motionsmith.md` is the live pilot; `example-graphics.md`
    (`unlisted: true`) exercises **every** feature — all graphics extras + every
    AI/ML method block — as living documentation. **Unlisted ≠ draft.** `draft:
    true` is the hard exclusion: `[slug].astro` `getStaticPaths` filters it out
    of the production build entirely (dev-only). `unlisted: true` BUILDS the page
    (reachable by direct URL) but (a) the `astro.config.mjs` sitemap `filter`
    drops it from `sitemap-0.xml`, (b) `MicrositeShell` emits
    `<meta name="robots" content="noindex,nofollow">` (via the `noindex` prop
    AcademicProject passes from `d.unlisted`), and (c) it's `category: research`
    so it's already absent from the homepage grid. Net: every feature present,
    never indexed or linked. To add another unlisted page: set `unlisted: true`
    AND add its path to the sitemap `filter` (the filter sees URL strings only,
    so the exclusion is path-based).

## Stack

Astro 5 + `astro-typst` (Typst→HTML for prose/math), Vite, TypeScript. Typst
0.15.x for PDFs — pinned in `.tool-versions` (a reproducibility floor, not a
ceiling; bump it intentionally to adopt new Typst features). CV layout
primitives are first-party in `resume/typst/layout.typ` (adapted from
`cv-soft-and-hard` 0.1.0, MIT, © Jonas Pleyer — no `@preview` runtime dep).
Fonts: web uses Newsreader (display) + Hanken Grotesk (body) + IBM Plex Mono;
PDFs use Typst's bundled Libertinus Serif (the academic-CV serif norm, kept by
design). Design tokens in `src/styles/tokens.css`. `just` orchestrates
everything (`justfile`).

## Deploy

Push `main` → `.github/workflows/deploy.yml` builds the web to GitHub Pages
(`alansynn.com`, `public/CNAME`). PDFs travel in the commit, not built on CI.
