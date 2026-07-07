# Alan Synn — Integrated Academic Presence

[![Astro](https://img.shields.io/badge/Astro-5-ff5d01?logo=astro&logoColor=fff)](https://astro.build)
[![Typst](https://img.shields.io/badge/Typst-0.15-239dad?logo=typst&logoColor=fff)](https://typst.app)
[![bun](https://img.shields.io/badge/bun-1.3-000?logo=bun&logoColor=fff)](https://bun.sh)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178c6?logo=typescript&logoColor=fff)](https://www.typescriptlang.org)

One repo, one content source → **website + resume + CV + targeted variants.** Live at **[alansynn.com](https://alansynn.com)**.

```
                      edit here
                 ┌───────────────┐
                 │  content/*    │
                 │  *.yaml       │ ◄─── the single content source
                 │  + papers.bib │      (the ONLY dir a human edits)
                 └───────┬───────┘
          ┌──────────────┴───────────────┐
          ▼                              ▼
   ┌─────────────┐                ┌─────────────┐
   │    Astro    │                │    Typst    │
   │  (web HTML) │                │  (PDF CV /  │
   │             │                │   resume)   │
   └──────┬──────┘                └──────┬──────┘
          ▼                              ▼
     alansynn.com                public/pdfs/*.pdf
```

- **Web** — Astro + Typst (Typst compiles prose/equations to HTML/MathML at build; no client-side MathJax).
- **Resume / CV** — a first-party Typst template (`resume/typst/`) reading the same data; PDFs render to `public/pdfs/`.
- **Targeted variants** — `just resume graphics` / `just cv ml-systems` filter publications and re-frame the research blurb for a specific field. Add a target in `content/targets.yaml` — no code edit.
- **Validated** — every structured YAML is parsed through a Zod schema at build, so a typo or an unknown field fails loudly instead of rendering wrong (or being silently ignored).

## Quick start

```bash
bun install      # install (bun 1.3+, see package.json#engines)
just dev         # dev server at localhost:4321
just build       # web + default resume/CV PDFs
```

| Command | What it does |
|---|---|
| `just` / `just build` | Web + default resume/CV PDFs |
| `just web` | Astro build + Pagefind index |
| `just dev` | Astro dev server (`localhost:4321`) |
| `just resume [target]` | `public/pdfs/resume[-target].pdf` |
| `just cv [target]` | `public/pdfs/cv[-target].pdf` |
| `just pdfs` | resume + cv (defaults) |
| `just clips` | regenerate video clips (needs ffmpeg; yt-dlp for YouTube) |
| `just clean` | remove `dist/`, `.astro/` |

Requirements: `bun` 1.3+, `just`, `typst` 0.15+ (pinned in `.tool-versions`), `ffmpeg` (`yt-dlp` optional).

## The one invariant

**`content/` is the only directory a human edits.** Change a file there → web + resume + CV all update. Code under `src/` (web) and `resume/typst/` (PDF) reads from `content/`; you rarely touch it. The only step that ever reaches into code is *adding a new build target*, and even that is content-driven via `content/targets.yaml`.

## Content map

```
content/                   ← edit EVERYTHING here; the only dir a human edits
  site.yaml                identity, contact, socials, advisors, SEO
  cv.yaml                  career timeline: education / experience / teaching / activities
  research-interests.yaml  bio statements + focus areas (web bio + default PDF blurb)
  honors.yaml              awards (grouped)
  references.yaml          CV reference contacts
  venues.yaml              venue badges + pub type (journal / conference / preprint)
  coauthors.yaml           author-name hyperlinks
  targets.yaml             targeted PDF variants (graphics / ml-systems)
  papers.bib               publications — the ONLY pub source
  news.yaml                news items (homepage shows the 8 most recent)
  projects/*.md            project pages (one file per project)
  blog/*.typ               long-form posts (Typst)

src/lib/content-schema.ts  Zod schemas — the shape of every YAML above (strict)
src/lib/data.ts            single import surface; parses each YAML through its schema
src/lib/papers.ts          dependency-free BibTeX parser (build-time)
src/data/                  generated only — never hand-edit (papers.json, video-clips.json)
resume/typst/              Typst CV/resume engine (PDF)
  layout.typ               first-party layout toolkit (CV primitives)
  lib.typ                  shared module: data loaders, target logic, render fns
  resume.typ, cv.typ       5-line entry files
scripts/                   gen-papers-json.mjs, video-clips.mjs, screenshot.mjs
public/pdfs/               generated resume/CV PDFs (committed; CI is web-only)
justfile                   the build orchestrator
```

### Edit cycle

- **A publication** → add an `@inproceedings{…}` / `@article{…}` entry to `content/papers.bib` (`selected`, `featured`, `abbr`, `pdf`, `code`, `website`, `video`, `preview`, `abstract`). Then `just build`.
- **A news item** → add a `{ date, link?, highlight?, body }` entry to `content/news.yaml`.
- **A project / blog post** → drop a file in `content/projects/*.md` or `content/blog/*.typ`.
- **A CV detail** → edit the matching section in `content/cv.yaml`. Web + resume + CV all update.
- **A targeted resume** → `just resume <target>` (`graphics`, `ml-systems` built in). Add a target in `content/targets.yaml`. Per-entry show/hide: any YAML entry may carry `only: [graphics]` or `except: [ml-systems]`, honored on **both** web and PDF.
- **A video figure** → set `video={...}` in `papers.bib` or a project's frontmatter, run `just clips`, commit the clip + manifest.

## Validation

`src/lib/content-schema.ts` holds a **strict** Zod schema for every structured YAML in `content/`. `src/lib/data.ts` parses each through its schema, so:

- a **bad key / wrong type / missing field** → build fails with a located error;
- an **unknown field** (a typo, or a key with no consumer) → build fails too — a dead field can never silently do nothing.

Two cross-reference rules are enforced at build via `enforcePaperIntegrity`:

- a paper whose `abbr` has no matching key in `venues.yaml` → the badge renders bare (**warn** — cosmetic, and the add-paper workflow adds the bib entry before the venue);
- a paper flagged `featured` (web-top) without `selected` (PDF) → **build fails**. A featured paper must also appear in the CV/resume.

## Design

Light-first, white, academic. Newsreader (display) + Hanken Grotesk (body) + IBM Plex Mono. Petrol accent. The signature motif is a four-bar **coupler curve** (kinematics); a real-time IK robot arm waves from the footer. Light/dark toggle (persists, follows system). Tokens in `src/styles/tokens.css`. PDFs use Typst's bundled Libertinus Serif (the academic-CV serif norm).

## Deploy

Push `main` → `.github/workflows/deploy.yml` builds the web to GitHub Pages via bun. Requirements:

- Repo **Settings → Pages → Source = GitHub Actions**.
- `public/CNAME` = `alansynn.com`.
- Resume/CV **PDFs are committed** (generated locally via `just pdfs`, since CI is web-only). Re-run `just pdfs` after content changes, then commit.

## Credits

Web on [`ahxt/academic-homepage-typst`](https://github.com/ahxt/academic-homepage-typst). Resume/CV layout primitives are first-party in `resume/typst/layout.typ`, adapted from [`cv-soft-and-hard`](https://github.com/typst/packages/raw/main/preview/cv-soft-and-hard/0.1.0) 0.1.0 (MIT, © Jonas Pleyer). Content migrated from an earlier `alshedivat/al-folio` Jekyll site.
