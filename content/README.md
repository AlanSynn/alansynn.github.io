# `content/` — the only directory you edit

Everything user-facing lives here. Change a file, run `just build` (web) or
`just pdfs` (resume/CV), and both renderers pick it up. Code under `src/` and
`resume/` reads from here — you rarely need to touch it.

Each file has a header comment explaining its fields; this file is just the map.

## Identity & contact
- `site.yaml` — name, title, email, phone, URL, socials, hero tagline, SEO
  description/keywords. **The single source for who you are.**

## CV sections
- `cv.yaml` — the career timeline: `education` / `experience` / `teaching` /
  `activities` as four sections in one file (they share one entry model).
  Entry: `{ period, title, location?, body, only?/except? }`. Per-entry
  targeting for PDF variants via `only:`/`except:`.
- `honors.yaml` — grouped `{ group, items[] }`.
- `references.yaml` — reference contacts (rendered on the CV).
- `skills.yaml` — categorized technical skills.
- `research-interests.yaml` — bio statements + focus areas. The homepage bio
  and the PDF research blurb both read this.

## Publications
- `papers.bib` — **the only publication source.** Add `@inproceedings{...}` /
  `@article{...}` entries here. Fields like `selected`, `abbr`, `pdf`, `code`,
  `website`, `video` control how each paper shows on web + PDF. (`papers.json`
  is generated from this — don't edit it; it lives in `src/data/`.)

## Lookups
- `venues.yaml` — venue abbreviation → `{ url, color }` for badges.
- `coauthors.yaml` — lastname → firstname variants + URL, used to hyperlink
  author names in publication lists.

## Lists & prose
- `news.yaml` — **news, one file.** A list of `{ date, link?, highlight?, body }`.
  The homepage shows the **8 most recent** (sorted by `date`). Add new items at
  the top. `body` is one full sentence, markdown inline OK. If a body has an
  apostrophe, double it (`'Alan''s …'`). See the file header for the full schema.
- `projects/*.md` — one file per project (frontmatter + markdown body). Each
  gets its own `/projects/<slug>` page.
- `blog/*.typ` — long-form posts in Typst.
- `about.typ`, `research-statement.typ` — longer Typst prose.

## Supporting (edit rarely)
- `blog.typ` — shared Typst macro template imported by every blog post. Not
  content; edit only to change how posts render.

## Binary assets (live in `public/`, not here)
Astro serves binaries from `public/`, so these are edited there by convention:
- `public/profile-photo.webp` — homepage headshot.
- `public/og.png` — social share image.
- `public/pdfs/*.pdf` — resume/CV PDFs (regenerated via `just pdfs`, committed).

## After editing
- Web only → `just build` (or `just dev` to preview).
- Touched `papers.bib` or anything the PDF shows → `just pdfs`, then commit the
  regenerated PDFs alongside the source change.
