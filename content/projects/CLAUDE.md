# CLAUDE.md — authoring `content/projects/`

Path-scoped agent guidance for this directory: **content authoring rules** for
project pages. The architecture invariants (academic-route CSS isolation, the
`[slug].astro` footgun guard, theme survival across View Transitions, the
`/ms` escape hatch, method-block rendering) live in the **root `CLAUDE.md`**
("Academic project pages" bullet) — don't duplicate them here.

This file is deliberately **excluded from the projects content collection**
(`src/content.config.ts` glob negates `CLAUDE.md`/`AGENTS.md` — without that,
this file would parse as a project entry and fail the strict schema or become
a phantom `/projects/claude` route). Don't remove the negation.

## Two page kinds, two wiring rules

- **Work project** (`category: work`, the default): create
  `content/projects/<slug>.md` **AND** a static route file
  `src/pages/projects/<slug>.astro` → `SimpleProject`. Missing route file =
  the `[slug].astro` guard throws at build. To add one, copy an existing
  static route file and change the slug.
- **Academic paper page** (`category: research` + `paper: <citekey>`): the
  `.md` alone suffices — `[slug].astro` routes it through `AcademicProject`.
  Bibliographic fields (title/authors/venue/DOI/PDF/code/BibTeX) **derive from
  the linked `papers.bib` entry** — never duplicate them in frontmatter. The
  citekey must resolve in `content/papers.bib` or the build throws.
- The strict Zod schema in `src/content.config.ts` is the authoritative field
  list (unknown key = build failure with a located error). Field-level
  comments live on the schema itself; the groups, briefly:
  - shared: `title`, `period`, `org`, `category`, `order`, `date`, `summary`,
    `image`, `video`, `links`
  - academic hero: `paper`, `hero_eyebrow`, `title_mark`, `title_lines`,
    `teaser_caption`, `event_dates`, `affiliations`, `author_affil`,
    `overview_heading`, `takeaways`, `nav`
  - sections: `demo`, `system`, `cases` (+ `cases_heading`/`cases_intro`/
    `cases_in_results`/`cases_outro`), `citation_heading`/`citation_intro`,
    `results_heading`/`results`, `ablation`, `gallery_heading`/`gallery`,
    `comparisons`, `video_comparison`
  - method blocks (AI/ML/robotics pages): `stat_callouts`, `equations`,
    `algorithm`, `code`, `faq`, `acknowledgments`, `closing`
  - visibility: `unlisted`, `draft`

## Fidelity discipline (paper pages)

Every sentence, number, caption, and quote on an academic page must **trace to
the paper source** (the submission tex, e.g. `~/Workspace/msym`) — port
sentences verbatim or compress without re-wording; never invent headlines,
takeaways, or aggregations. Keep the paper's anonymized identifiers (T1–T4,
Schools A/B). Never imply learning gains. Photos: no identifiable persons or
student info, EXIF/GPS stripped on export, and a changed image gets a **new
filename** (cache-bust).

## Visibility flags

- `unlisted: true` → the page still **builds** (direct URL works) but emits
  `<meta robots noindex>` and is dropped from the sitemap
  (`astro.config.mjs` filter — hardcoded path; adding an unlisted page means
  adding its path there). Use for owner-review pages held from public
  navigation.
- `draft: true` → skipped from the production build entirely (dev-only).
- An in-review paper's homepage row visibility is controlled separately, by
  the bib entry's flags (`hidden`/`web_off`/`featured`/`selected` — see the
  legend at the top of `content/papers.bib`) and by whether `website=` is
  present (absent `website` = unlinked title, no Project Page chip). Mind the
  difference: `hidden` folds the row behind the "All publications" toggle but
  the title/authors STAY in the served HTML + the Pagefind index; `web_off`
  removes the row entirely. Under a double-anonymous review, use `web_off`.

## Taking young-makers public

`content/projects/young-makers.md` + its bib entry are currently **fully held
from the web** (owner directive 2026-10-02, CHI 2027 double-anonymous review
— notification 2026-12-17): the page is `draft: true` (404s in production,
renders in `just dev`) and the homepage row is excluded entirely via
`web_off={true}` in the bib entry. To publish (owner decision — do not do
this unprompted):

1. `content/papers.bib` (synn2027youngmakers): delete the `web_off={true}`
   line and re-add `website={/projects/young-makers}` — restores the row
   (title links the page + "Project Page" chip). Then `just pdfs` and commit
   the regenerated PDFs (the bib is PDF-source; check-pdf-sync enforces this
   at commit).
2. `content/projects/young-makers.md`: delete `draft: true`.
3. `astro.config.mjs`: drop the `!page.includes('/projects/young-makers')`
   line from the sitemap filter.
4. `scripts/check-isolation.mjs`: re-add `/projects/young-makers` to
   `ACADEMIC_ROUTES` (the route exists again).
5. `just web`, then verify: the homepage row is visible top-of-publications
   with the title linking the page, the page is in `sitemap-0.xml`, and no
   `noindex` meta remains on it.
6. **At acceptance** (notification 2026-12-17), additionally: restore
   `booktitle`, fill `doi`/`pdf`, switch `abbr` to the real `venues.yaml` key,
   and update the project page's links — `/ms` and the GitHub repo move to
   `motionsmith.org` / `github.com/motionsmith/motionsmith`. The
   venue-omission rationale (what leaks where) is documented in the
   `papers.bib` comment above the entry.

The same steps template any future in-review paper page: author the page,
`draft: true` (+ `unlisted: true` + sitemap path if it must stay reachable),
bib entry with `web_off={true}`, no `website`, and a bare "In review" abbr
until acceptance.
