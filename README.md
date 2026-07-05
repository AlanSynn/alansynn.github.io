# Alan Synn — Integrated Academic Presence

[![Astro](https://img.shields.io/badge/Astro-5-ff5d01?logo=astro&logoColor=fff)](https://astro.build)
[![Typst](https://img.shields.io/badge/Typst-0.15-239dad?logo=typst&logoColor=fff)](https://typst.app)
[![bun](https://img.shields.io/badge/bun-1.3-000?logo=bun&logoColor=fff)](https://bun.sh)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178c6?logo=typescript&logoColor=fff)](https://www.typescriptlang.org)

One repo, one source of truth → **website + resume + CV + targeted variants.** Live at **[alansynn.com](https://alansynn.com)**.

```
                      edit here
                 ┌───────────────┐
                 │ src/data/*.yaml│
                 │  + papers.bib │ ◄─── the single content source
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

- **Web** — Astro + Typst (Typst compiles prose/equations to HTML/MathML at build time; no client-side MathJax).
- **Resume / CV** — a native Typst template (`resume/typst/`) reading the same data; PDFs render to `public/pdfs/`.
- **Targeted variants** — `just resume graphics` / `just cv ml-systems` filter publications and re-frame research interests for a specific field.
- **Video** — every paper/project video is cut to a muted 0–15s clip (ffmpeg/yt-dlp), lazy-loaded.

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

Requirements: `bun` 1.3+, `just`, `typst` 0.15+, `ffmpeg` (`yt-dlp` optional).

## Single source of truth

```
src/data/                  ← edit content HERE; web + resume + cv all read it
  site.yaml, research-interests.yaml, education.yaml, experience.yaml,
  honors.yaml, teaching.yaml, activities.yaml, references.yaml,
  venues.yaml, coauthors.yaml
  papers.bib                 publications (the ONLY pub source)
  papers.json                generated from papers.bib — don't hand-edit
content/                   longer prose (Typst) + collections
  blog/*.typ, news/*.md, projects/*.md, about.typ, research-statement.typ
resume/typst/              Typst CV/resume template (PDF engine)
  lib.typ                    shared module: data loaders, target logic, render fns
  resume.typ, cv.typ         5-line entry files
scripts/                   gen-papers-json.mjs (bib→json), video-clips.mjs
public/pdfs/               generated resume/CV PDFs (committed; CI is web-only)
justfile                   the build orchestrator
```

### Edit cycle

- **A publication** → add an entry to `src/data/papers.bib` (`selected`, `abbr`, `pdf`, `code`, `website`, `video`, `slides`, `abstract`, `preview`). Then `just build`.
- **A news / project / blog post** → drop a file in `content/news|projects/*.md` or `content/blog/*.typ`.
- **A CV detail** → edit the matching `src/data/*.yaml`. Web + resume + CV all update.
- **A targeted resume** → `just resume <target>` (`graphics`, `ml-systems` built in; add more in `resume/typst/lib.typ`). Per-entry show/hide: any YAML entry may carry `only: [graphics]` or `except: [ml-systems]`.
- **A video figure** → set `video={...}` in `papers.bib` or a project's frontmatter, run `just clips`, commit the clip + manifest.

## Design

Light-first, white, academic. Newsreader (display) + Hanken Grotesk (body) + IBM Plex Mono. Petrol accent. The signature motif is a four-bar **coupler curve** (kinematics); a real-time IK robot arm waves from the footer. Light/dark toggle (persists, follows system). Tokens in `src/styles/tokens.css`.

## Deploy

Push `main` → `.github/workflows/deploy.yml` builds the web to GitHub Pages via bun. Requirements:

- Repo **Settings → Pages → Source = GitHub Actions**.
- `public/CNAME` = `alansynn.com`.
- Resume/CV **PDFs are committed** (generated locally via `just pdfs`, since CI is web-only). Re-run `just pdfs` after content changes, then commit.

## Credits

Web on [`ahxt/academic-homepage-typst`](https://github.com/ahxt/academic-homepage-typst). Resume/CV rendered by Typst (`resume/typst/lib.typ`), porting the layout of Zach Scrivena's [`simple-resume-cv`](https://github.com/zachscrivena/simple-resume-cv). Content migrated from an earlier `alshedivat/al-folio` Jekyll site.
