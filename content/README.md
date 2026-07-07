# `content/` — the only directory you edit

Everything user-facing lives here. Change a file, run `just build` (web) or
`just pdfs` (resume/CV), and both renderers pick it up. Code under `src/` and
`resume/` reads from here — you rarely need to touch it.

Each file has a header comment explaining its fields; this file is the map.

> **Validation.** Every structured YAML below is checked by a **strict** Zod
> schema at build (`src/lib/content-schema.ts`). A typo, a wrong type, a
> missing required field, *or an unknown key* fails the build loudly with a
> located error — so a field can never silently do nothing.

## Identity & contact
- `site.yaml` — **the single source for who you are.** Name, title, affiliation,
  department, location, email/phone, socials, advisors, SEO. The homepage hero
  and the CV/resume title block both render from it, so editing affiliation /
  department / advisors updates both surfaces together.

## CV timeline
- `cv.yaml` — the career timeline: `education` / `experience` / `teaching` /
  `activities` as four sections in one file (they share one entry model).
  Entry: `{ period, title, location?, body, only?/except? }`. Per-entry
  targeting via `only:`/`except:` is honored on **both** web and PDF (web = the
  default/untargeted view, so it mirrors the default CV: `only:` hides, `except:`
  shows).
- `honors.yaml` — grouped `{ group, items[] }`. The same `only:`/`except:`
  targeting applies.
- `references.yaml` — reference contacts (rendered on the CV).

## Research voice
- `research-interests.yaml` — `statements[]` (the bio, rendered top-down on the
  web and as the default PDF blurb) + `focus_areas[]`. Targeted PDF variants
  swap in a different blurb (see `targets.yaml`).

## Lookups
- `venues.yaml` — venue abbreviation → `{ name, url, type }` for badges.
  `type` (`journal` / `conference` / `preprint`) drives the CV's publication
  grouping; set it once per venue and the PDF classifies from it.
- `coauthors.yaml` — lastname → firstname variants + URL, used to hyperlink
  author names in publication lists.

## Targeted PDF variants
- `targets.yaml` — each id (e.g. `graphics`, `ml-systems`) → `{ blurb, keywords }`.
  `just resume <id>` / `just cv <id>` filter publications by keyword match and
  swap in the blurb. **Adding a target here is the only step** — no code edit.
  The web is the default/untargeted view and ignores this file.

## Publications
- `papers.bib` — **the only publication source.** Add `@inproceedings{...}` /
  `@article{...}` entries here. Two flags drive visibility (they mean different
  things — don't conflate them):
  - `selected` → the paper prints in the resume/CV PDF.
  - `featured` → the paper surfaces at the TOP of the homepage `#publications`.
    Must also be `selected` (a featured-but-not-selected paper fails the build).
  Fill every applicable field — `preview`, `doi`, `pdf`, `code`, `website`,
  `video`, `abstract` — via search/extraction; never leave a gap you can fill.
  Assets: preview images → `public/images/papers/`, videos → `public/videos/`,
  committed PDFs → `public/pdfs/`. Every `abbr` must have a matching key in
  `venues.yaml` or the badge renders as bare text. (`papers.json` is generated
  from this — don't edit it; it lives in `src/data/`.)

## Lists & prose
- `news.yaml` — **news, one file.** A list of `{ date, link?, highlight?, body }`.
  The homepage shows the **8 most recent** (sorted by `date`). Add new items at
  the top. `body` is one full sentence, markdown inline OK. If a body has an
  apostrophe, double it (`'Alan''s …'`).
- `projects/*.md` — one file per project (frontmatter + markdown body). Each
  gets its own `/projects/<slug>` page. Set `category: research` to keep the
  slug page but **exclude** it from the homepage grid (research output lives in
  `#publications`); the default `category: work` surfaces it.
- `blog/*.typ` — long-form posts in Typst.

## Supporting (edit rarely)
- `blog.typ` — shared Typst macro template imported by every blog post. Not
  content; edit only to change how posts render.

## Binary assets (live in `public/`, not here)
Astro serves binaries from `public/`, so these are edited there by convention:
- `public/profile-photo.webp` — homepage headshot.
- `public/og.png` — social share image.
- `public/pdfs/*.pdf` — resume/CV PDFs (regenerated via `just pdfs`, committed).

## Removed (do not re-add without a consumer)
These previously lived here but had **no renderer** — editing them changed
nothing, with no build signal. They were deleted to keep "edit `content/` and
you're done" truthful. Recoverable from git history; re-add only alongside a
real consumer (e.g. an `/about` route, a CV "Systems" section):
`skills.yaml`, `about.typ`, `research-statement.typ`.

## After editing
- Web only → `just build` (or `just dev` to preview).
- Touched `papers.bib` or anything the PDF shows → `just pdfs`, then commit the
  regenerated PDFs alongside the source change.
