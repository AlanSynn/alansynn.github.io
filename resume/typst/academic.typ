// ============================================================================
// academic.typ: first-party port of the owner's LaTeX CV class
// (academiccv.cls v1.1, 2026/09/30; article-based, Latin Modern, hidelinks).
//
// CV-only layout family: resume.typ / paper-page.typ keep the
// cv-soft-and-hard-derived look in layout.typ; cv.typ is the sole consumer of
// this file (via lib.typ's cv-doc). Same in-house-template rationale as
// layout.typ: the cls is a typesetting SPEC we own the rendering of, so the
// CV pipeline stays content-driven (content/*.yaml + papers.json) while
// producing the owner's familiar academic-CV 양식.
//
// What is ported (cls → here):
//   \linespread{1.025}, parskip 2pt, parindent 0, justified → page setup below
//   geometry (letter, 0.78in sides / 0.72in top / 0.70in bottom)  → page margins
//   lmodern 11pt                                                  → vendored LM
//   \makecvheader (25/29pt bold name, subtitle, \small contact)   → acad-name-header
//   titleformat section: \large\bfseries + \titlerule             → acad-section
//   titleformat subsection: \normalsize\bfseries                  → acad-subsection
//   cventry/cvcompact tabularx (bold left, \small raggedleft 1.48in right) → acad-entry-grid
//   cvitems (bullet, leftmargin 1.1em, labelsep 0.5em, itemsep 2pt) → acad-items
//   cvpublications (hanging list, right-aligned bold labels, itemsep 6pt) → acad-pub-item
//   \cvnote (\small gray)                                         → acad-note
//   fancyhdr: gray header (name | Curriculum Vitae) from page 2 only
//     (cls \thispagestyle{cvfirst}), gray footer (date | n/N) everywhere → acad-page
//   hidelinks: links stay clickable but carry NO visible styling  → no show rule
//
// Deliberately NOT ported: the review-mode machinery (Q-labels), the phone
// number in \cvcontact (owner directive: the contact line is built from
// site.yaml and carries only email · site url), and \cvdate (the footer date
// is the compile date; the cls pins it manually).
//
// Fonts: Latin Modern OTFs vendored in resume/typst/fonts/ (GUST Font License;
// see that README). Compile with `--font-path resume/typst/fonts` (justfile
// does this on every typst invocation).
// ============================================================================

// cls \definecolor{cvgray}{gray}{0.36}
#let acad-gray = luma(92)

// Page/document setup for a whole academic-style document. The CV passes
// nothing (cls defaults); the resume compresses via size/margin/leading/
// spacing to hold one page. `name` also feeds the running header and PDF
// metadata (cls \hypersetup pdfauthor/pdftitle via \cv@name). leading 0.65em
// is Typst's default, spelled out so the cls rhythm is explicit.
#let acad-page(
  body,
  name,
  doc-title,
  size: 11pt,
  margin: (left: 0.78in, right: 0.78in, top: 0.72in, bottom: 0.7in),
  leading: 0.65em,
  spacing: 2pt,
  doc-type: "Curriculum Vitae",
) = {
  set document(title: doc-title, author: name)
  set text(font: "Latin Modern Roman", size: size, lang: "en")
  // parindent 0 is Typst's default; justify matches the article class.
  set par(justify: true, leading: leading, spacing: spacing)
  set block(spacing: spacing)
  set page(
    paper: "us-letter",
    margin: margin,
    // cls: page 1 uses \thispagestyle{cvfirst}: no running header there.
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 10pt, fill: acad-gray)
        grid(
          columns: (1fr, 1fr),
          align(left, name),
          align(right, doc-type),
        )
      }
    },
    footer: {
      // cls \fancyfoot: \cv@date left, "n / LastPage" right, footnotesize gray.
      // The date is the compile date: the PDF is rebuilt on every content
      // change, so it never goes stale (the cls pins it via \cvdate instead).
      let today = datetime.today().display("[day] [month repr:long] [year]")
      set text(size: 9pt, fill: acad-gray)
      grid(
        columns: (1fr, 1fr),
        align(left, today),
        align(right, context numbering("1 / 1", ..counter(page).get(), counter(page).final().first())),
      )
    },
  )
  body
}

// cls \makecvheader: bold name, subtitle, \small contact line. Defaults are
// the cls's own (25pt/29 name; \small = 10pt at the 11pt base).
#let acad-name-header(name, subtitle, contact, name-size: 25pt, contact-size: 10pt) = {
  text(size: name-size, weight: "bold", name)
  v(3pt)
  par[#subtitle]
  v(3pt)
  par(text(size: contact-size)[#contact])
  v(2pt)
}

// cls titleformat section: \large (12pt at 11pt base) bold + 1pt gap + rule.
// before/after tighten on the resume (5pt/3pt) to hold one page.
#let acad-section(title, before: 13pt, after: 7pt, size: 12pt) = {
  v(before)
  text(size: size, weight: "bold", title)
  v(1pt)
  line(length: 100%, stroke: 0.4pt)
  v(after)
}

// cls titleformat subsection: \normalsize bold.
#let acad-subsection(title) = {
  v(8pt)
  text(weight: "bold", title)
  v(4pt)
}

// cls cventry/cvcompact tabularx row: X (raggedright) | p{1.48in} raggedleft.
// Param names must NOT be left/right: they shadow Typst's alignment constants
// (first port attempt did, and `left + top` became content + alignment).
#let acad-entry-grid(left-text, right-text, left-weight: none) = {
  grid(
    columns: (1fr, 1.48in),
    column-gutter: 0.8em,
    align: (left + top, right + top),
    if left-weight == none { left-text } else { text(weight: left-weight)[#left-text] },
    text(size: 10pt, align(right, right-text)),
  )
}

// cls cvitems: bullet, leftmargin 1.1em, labelsep 0.5em, topsep 3pt, itemsep 2pt.
// pre/spacing tighten on the resume to hold one page.
#let acad-items(..items, pre: 3pt, spacing: 2pt) = {
  v(pre)
  list(marker: [•], indent: 1.1em, body-indent: 0.5em, spacing: spacing, ..items)
}

// cls cvpublications: hanging list: label width 2.05em right-aligned bold,
// 0.5em label separation (→ 2.55em left margin), 6pt between items.
#let acad-pub-item(label, body) = {
  grid(
    columns: (2.05em, 1fr),
    column-gutter: 0.5em,
    align: (right + top, left + top),
    text(weight: "bold", label),
    body,
  )
}

// cls \cvnote: \small gray paragraph.
#let acad-note(body) = par(text(size: 10pt, fill: acad-gray)[#body])
