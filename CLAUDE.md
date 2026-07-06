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
in `resume/typst/lib.typ` (`target-keywords`, `target-blurb`); per-entry
`only:` / `except:` flags on any YAML entry.

## Conventions (don't break these)

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
    the PDF ignores it.
  **When you add or edit an entry, fill EVERY applicable field** — `preview`
  (thumbnail image), `doi`, `pdf`, `code` (repo), `website` (project page),
  `video` (YouTube id or `/videos/<name>.mp4`), `abstract`. Hunt the values down
  via web search + extraction (DOI page, author/project page, GitHub, YouTube);
  never leave a gap you can fill. Assets: preview images → `public/images/papers/`
  (or `.../motionsmith/`), videos → `public/videos/`, committed PDFs →
  `public/pdfs/`. Every entry's `abbr` MUST have a matching key in
  `content/venues.yaml` (with `name`/`url`/`color`) or the venue badge renders as
  bare text with no link/color. After editing `papers.bib`, regen
  `src/data/papers.json` (`scripts/gen-papers-json.mjs`); if `selected` changed,
  also run `just pdfs` and commit the new PDFs.
- **Structured YAML is validated at build.** `src/lib/content-schema.ts`
  holds the Zod schema for every structured YAML in `content/` (site, cv,
  honors, references, skills, research-interests, news); `data.ts` parses each
  through its schema so a typo (bad key / wrong type / missing field) fails the
  build loudly with a located error. The four career-timeline sections
  (education / experience / teaching / activities) share one entry model
  `{ period, title, location?, body, only?/except? }` and live together in
  **`content/cv.yaml`** — one file, one schema, one history (do not re-split).
  `warnPaperIntegrity` (same file) warns on a paper whose `abbr` is missing
  from `venues.yaml`, or whose `featured`/`selected` flags disagree.
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
