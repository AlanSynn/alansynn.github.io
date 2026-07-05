# CLAUDE.md

Source-of-truth context for AI agents (Claude Code, Cursor, Codex, …) working in
this repo. `AGENTS.md` is a symlink to this file so every tool reads the same
guidance. See `README.md` for the full human-facing docs.

## What this is

Alan Synn's integrated academic presence — **one repo, one content source →
website + resume + CV + targeted variants**. Live at alansynn.com.

## The one invariant that matters

**`src/data/*.yaml` + `papers.bib` is the single content source.** Both
renderers read it:

- **Web** → Astro components (`src/components/`, `src/pages/`).
- **PDF** → Typst (`resume/typst/lib.typ`, the shared template; `resume.typ` /
  `cv.typ` are 5-line entry files).

Editing a YAML field updates the web AND the resume/CV. Don't duplicate content
into components or `.typ` files — keep it in `src/data/`.

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
in `resume/typst/lib.typ` (`target-keywords`, `target-blurb`); per-entry
`only:` / `except:` flags on any YAML entry.

## Conventions (don't break these)

- **Edit content in `src/data/`**, never in generated files. Generated:
  `src/data/papers.json` (from `papers.bib` via `scripts/gen-papers-json.mjs`),
  `src/data/video-clips.json`, `public/pdfs/*.pdf`, `dist/`.
- **PDFs are committed** because CI is web-only. After changing any
  `src/data/*` or `papers.bib`, run `just pdfs` and commit the regenerated PDFs
  alongside the source change so web and PDF stay in sync.
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

## Stack

Astro 5 + `astro-typst` (Typst→HTML for prose/math), Vite, TypeScript. Typst
0.15 for PDFs. Fonts: Newsreader (display) + Hanken Grotesk (body) + IBM Plex
Mono. Design tokens in `src/styles/tokens.css`. `just` orchestrates everything
(`justfile`).

## Deploy

Push `main` → `.github/workflows/deploy.yml` builds the web to GitHub Pages
(`alansynn.com`, `public/CNAME`). PDFs travel in the commit, not built on CI.
