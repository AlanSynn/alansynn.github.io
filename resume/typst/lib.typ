// ============================================================================
// lib.typ — shared CV/resume template. Page style (margins + link underline),
// section headers (heading + accent rule), and the two-column entry grid come
// from the first-party layout.typ toolkit (adapted from cv-soft-and-hard 0.1.0,
// MIT, © Jonas Pleyer — brought in-house so the template is fully owned and
// freely editable; no @preview runtime dependency). We deliberately do NOT
// override Typst's default text font (Libertinus Serif), size, or paragraph
// leading/spacing — those defaults ARE the reference template's typography, and
// overriding them (an earlier version set New Computer Modern + 0.9em leading)
// was the source of the line-spacing mismatch.
//
// Layered on top of the toolkit: the markdown-inline parser, "me"-author
// bolding, publication classification (journal / conference / preprint), and
// the per-target variant logic.
//
// Reads the SAME content source the Astro web reads (content/*.yaml +
// content/cv.yaml for the four timeline sections + src/data/papers.json), so
// editing a YAML field updates web + CV + resume together.
//
// Variants (per-target show/hide):
//   --input target=graphics | ml-systems
//     • swaps the research blurb + publication keyword filter for this target
//       (both defined in content/targets.yaml — add a target there, no code edit)
//     • filters/reorders publications by keyword (matched-first on CV,
//       matched-only on resume)
//     • honors per-entry visibility: any yaml entry may carry
//         only:   [graphics]   # show only for these targets
//         except: [ml-systems] # hide for these targets
//
// Compile from repo root:
//   typst compile --root . resume/typst/cv.typ public/pdfs/cv.pdf
//   typst compile --root . resume/typst/cv.typ public/pdfs/cv-graphics.pdf --input target=graphics
// ============================================================================

#import "./layout.typ": styling, section, entry, global-theme

// Brand accent (web --accent navy #1d4e89) — passed to styling() so section
// rules + link underlines carry the site brand across the CV/resume.
#let accent = rgb("1d4e89")

// ---- 1. Load shared data (root-relative via --root .) ---------------------
#let site        = yaml("/content/site.yaml")
#let cvdata      = yaml("/content/cv.yaml")
#let education   = cvdata.education
#let experience  = cvdata.experience
#let teaching    = cvdata.teaching
#let activities  = cvdata.activities
#let honors      = yaml("/content/honors.yaml")
#let references  = yaml("/content/references.yaml")
#let ri          = yaml("/content/research-interests.yaml")
#let venues      = yaml("/content/venues.yaml")
#let targets     = yaml("/content/targets.yaml")
#let papers      = json("/src/data/papers.json")

// ---- 2. Targeting ---------------------------------------------------------
// Targeted variants (id → { blurb, keywords }) live in content/targets.yaml,
// validated on the web side by targetsSchema. Adding a target there is the only
// step — this file reads it automatically (no code edit, no separate keyword
// list to keep in sync).
#let target = sys.inputs.at("target", default: "")

#if target != "" and target not in targets {
  panic("Unknown --input target=\"" + target + "\". Known: " + targets.keys().join(", ") + ".")
}

// Owner family name (lower-cased) — used to bold + underline "me" in author lists.
#let me-family = lower(site.last_name)

// ---- 3. Markdown inline → Typst content -----------------------------------
// Handles [label](url), **bold**, *italic*, recursively (bold/italic inside a
// link label, links inside bold, etc.). UTF-8 chars (—, ·, →, &) render
// literally — no LaTeX escaping, which removes the markdown-leak bug class.
#let md-inline(s, depth: 0) = {
  if s == none { return [] }
  if type(s) != str { s = str(s) }
  if s == "" { return [] }
  if depth > 24 { return s }

  // Earliest match across the three patterns (str.match returns absolute
  // start/end of the first match anywhere in the string).
  let best = none
  let lm = s.match(regex("\[([^\]]*)\]\(([^)]*)\)"))
  if lm != none and (best == none or lm.start < best.start) {
    best = (start: lm.start, end: lm.end, type: "link",
            url: lm.captures.at(1), label: lm.captures.at(0))
  }
  let bm = s.match(regex("\*\*([^*]+?)\*\*"))
  if bm != none and (best == none or bm.start < best.start) {
    best = (start: bm.start, end: bm.end, type: "bold", text: bm.captures.at(0))
  }
  let im = s.match(regex("\*([^*]+?)\*"))
  if im != none and (best == none or im.start < best.start) {
    best = (start: im.start, end: im.end, type: "italic", text: im.captures.at(0))
  }

  if best == none { return s }

  let before = s.slice(0, best.start)
  let after = s.slice(best.end)
  let tok = {
    if best.type == "link" {
      link(best.url)[#md-inline(best.label, depth: depth + 1)]
    } else if best.type == "bold" {
      text(weight: "bold")[#md-inline(best.text, depth: depth + 1)]
    } else {
      emph[#md-inline(best.text, depth: depth + 1)]
    }
  }
  // Concatenate with `+` (not markup spaces) so a comma immediately after a
  // bold/link run stays tight — "graphics," not "graphics ,".
  return before + tok + md-inline(after, depth: depth + 1)
}

// ---- 4. Per-entry visibility (only: / except: on any yaml entry) ----------
#let entry-visible = e => {
  if "only" in e {
    let only = if type(e.only) == str { (e.only,) } else { e.only }
    return target in only
  }
  if "except" in e {
    let ex = if type(e.except) == str { (e.except,) } else { e.except }
    return target not in ex
  }
  true
}

// ---- 5. Bullet body parsing (indent-level aware) --------------------------
// Splits a markdown bullet body into (level, text) lines by leading indent
// (4-space indent → level 1, 8 → 2), mirroring the original LaTeX generator.
#let parse-body-lines = body => {
  if body == none { return () }
  let out = ()
  for raw in body.split("\n") {
    let pos = raw.position(regex("\S"))
    if pos == none { continue }
    let trimmed = raw.slice(pos)
    let level = calc.floor(pos / 4)
    let text = if trimmed.starts-with("- ") { trimmed.slice(2) } else { trimmed }
    out.push((level: level, text: text))
  }
  out
}

// PDF-only period tidy: open-ended ranges ("2022 -" / "2022-") become
// "2022 – Present", and mid hyphens ("2020 - 2022") use an en-dash. Web shows
// the raw YAML period; this keeps the academic-CV typographic norm local to
// the PDF without touching the shared data source.
#let format-period = p => {
  if p == none or p == "" { return "" }
  let s = p
  s = s.replace(regex(" *-$"), " – Present")
  s = s.replace(regex(" *-+ *"), " – ")
  s
}

// ---- 6. Entry on the package grid (cv-soft-and-hard idiom) ----------------
// Mirrors template/main.typ: entry(left-text, right-text) where left-text is
// markup — a bold title followed by a native bullet list — and right-text is
// the italic period. Bullets live in the LEFT (1fr) column by design (the
// package template does the same); the right (auto) column carries only the
// date. (An earlier version put bullets in `description` colspan-2 — that is a
// real package feature, but the reference template does not use it, and using
// it diverged from the canonical spacing.)
#let cv-entry = e => {
  if not entry-visible(e) { return [] }
  let period = format-period(e.at("period", default: ""))
  let title = e.at("title", default: "")
  let location = e.at("location", default: none)
  let body = e.at("body", default: none)
  let lines = parse-body-lines(body)
  let lead = ()
  if location != none and location != "" { lead.push((level: 0, text: location)) }
  let items = lead + lines

  let left = {
    text(weight: "bold")[#md-inline(title)]
    if items.len() > 0 {
      v(0.3em)
      list(
        marker: [•],
        indent: 1.2em,
        body-indent: 0.5em,
        ..items.map(l => {
          if l.level == 0 { md-inline(l.text) }
          else { emph[#md-inline(l.text)] }
        }),
      )
    }
  }
  entry(left, emph[#period])
}

#let entries = list => {
  for e in list { cv-entry(e) }
}

// ---- 7. Publications ------------------------------------------------------
#let months = ("", "Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.",
               "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec.")

#let datestamp = p => {
  if p.month != none and p.month >= 1 and p.month <= 12 {
    [#months.at(p.month) #p.year]
  } else {
    [#p.year]
  }
}

// Surname + initial (e.g. "D. Synn") — the convention both reference CVs
// (Sehoon Ha, Danfei Xu) use; full given names are unusual in publication lists.
#let format-name = a => {
  if a.given != none and a.given != "" {
    [#(a.given.first() + ".")~#a.family]
  } else { a.family }
}

#let format-authors = authors => {
  let parts = authors.map(a => {
    let name = format-name(a)
    if lower(a.family) == me-family {
      text(weight: "bold")[#underline[#name]]
    } else { name }
  })
  let n = parts.len()
  if n == 0 { [] }
  else if n == 1 { parts.first() }
  else if n == 2 { [#parts.at(0) and #parts.at(1)] }
  else {
    let out = parts.at(0)
    for i in range(1, n - 1) { out = [#out, #parts.at(i)] }
    [#out, and #parts.at(n - 1)]
  }
}

// Sort key: negative year+month so an ascending sort yields newest-first
// (and ties keep source order). Month-less pubs sort as "earliest" in-year.
// When a target is set, matched pubs get a large offset so they sort to the
// TOP of their journal/conference/preprint group — otherwise the per-group
// date sort would wipe the matched-first ordering that pubs-for("cv")
// establishes (regression caught in review: v1 iterated matched+rest as-is).
#let pub-sort-key = p => {
  let m = if p.month == none { 0 } else { p.month }
  let base = 0 - (p.year * 12 + m)
  if target != "" and target in targets {
    let abbr = if p.abbr == none { "" } else { p.abbr }
    let hay = lower(p.title + " " + p.venue + " " + abbr)
    if targets.at(target).keywords.any(k => hay.contains(k)) { base - 1000000 }
    else { base }
  } else { base }
}

// Classify a paper → "journal" | "conference" | "preprint". Prefers the
// explicit `type` on its venue in content/venues.yaml (the source of truth);
// falls back to a string heuristic on venue + abbr only when the venue lacks a
// type (or the paper has no abbr). New venues classify by editing venues.yaml.
#let pub-type = p => {
  let abbr = if p.abbr == none { "" } else { p.abbr }
  if abbr != "" and abbr in venues and "type" in venues.at(abbr) {
    return venues.at(abbr).at("type")
  }
  let hay = lower(p.venue + " " + abbr)
  if hay.contains("arxiv") or hay.contains("preprint") { return "preprint" }
  if (
    hay.contains("access") or hay.contains("transactions") or hay.contains("journal")
  ) { return "journal" }
  "conference"
}

// Numbered publication item: hanging indent so wrapped lines clear the [n].
#let pub-item = (n, p) => {
  let venue = if p.abbr != none and p.abbr != "" { p.abbr } else { p.venue }
  block(width: 100%, spacing: 0.5em)[
    #grid(
      columns: (1.5em, 1fr),
      column-gutter: 0.3em,
      align: (right + top, left + top),
      [#text(weight: "bold")[#n]],
      [#format-authors(p.authors), "#p.title," #emph[#venue], #datestamp(p).],
    )
  ]
}

// Split a paper list into (journal, conference, preprint) preserving order.
#let split-by-type = list => {
  let j = (); let c = (); let p = ()
  for paper in list {
    let t = pub-type(paper)
    if t == "journal" { j.push(paper) }
    else if t == "conference" { c.push(paper) }
    else { p.push(paper) }
  }
  (journal: j, conference: c, preprint: p)
}

// Target keyword filter: matched-first (CV) or matched-only (resume).
#let match-pubs = list => {
  if target == "" or target not in targets { return (matched: list, rest: ()) }
  let kws = targets.at(target).keywords
  let matched = ()
  let rest = ()
  for p in list {
    let abbr = if p.abbr == none { "" } else { p.abbr }
    let hay = lower(p.title + " " + p.venue + " " + abbr)
    if kws.any(k => hay.contains(k)) { matched.push(p) } else { rest.push(p) }
  }
  (matched: matched, rest: rest)
}

#let pubs-for = doc => {
  if doc == "resume" {
    let selected = papers.filter(p => p.selected)
    if target == "" { selected } else { match-pubs(selected).matched }
  } else {
    if target == "" { papers } else {
      let s = match-pubs(papers)
      s.matched + s.rest
    }
  }
}

// Render publications. CV: journal / conference / preprint subsections (each
// numbered independently, newest-first). Resume: one flat numbered list.
#let pubs-section = doc => {
  let list-all = pubs-for(doc)
  if doc == "cv" {
    let s = split-by-type(list-all)
    for (label, group) in (
      ("Refereed Journal Articles", s.journal),
      ("Refereed Conference Papers", s.conference),
      ("Preprints", s.preprint),
    ) {
      if group.len() == 0 { continue }
      text(weight: "bold")[#label]
      v(0.2em)
      let sorted = group.sorted(key: pub-sort-key)
      for (i, p) in sorted.enumerate() { pub-item(i + 1, p) }
      v(0.3em)
    }
  } else {
    let sorted = list-all.sorted(key: pub-sort-key)
    for (i, p) in sorted.enumerate() { pub-item(i + 1, p) }
  }
}

// ---- 8. Honors, References ------------------------------------------------
#let honors-block = groups => {
  for g in groups.filter(entry-visible) {
    text(weight: "bold")[#md-inline(g.group)]
    v(0.2em)
    list(
      marker: [•],
      indent: 1.2em,
      body-indent: 0.5em,
      ..g.items.map(it => md-inline(it)),
    )
    v(0.3em)
  }
}

#let references-block = refs => {
  for (i, r) in refs.enumerate() {
    let role = r.at("role", default: none)
    let aff = r.at("affiliation", default: none)
    let dept = r.at("department", default: none)
    let email = r.at("email", default: none)
    let url = r.at("url", default: none)
    let contact = if email != none { link("mailto:" + email)[#email] }
                  else if url != none { link(url)[#url] }
                  else { none }
    // Stack only present fields. A trailing `\` outside the conditional (the
    // old form) emitted a line break even when aff/dept was none, leaving
    // visible blank lines that made a reader misattribute one ref's email to
    // the next.
    let lines = (text(weight: "bold")[#r.name],)
    if role != none { lines.push(role) }
    if aff != none { lines.push(aff) }
    if dept != none { lines.push(dept) }
    if contact != none { lines.push(contact) }
    block(width: 100%, spacing: 0.6em)[#lines.join(linebreak())]
  }
}

// ---- 9. Research blurb (target swap + CV multi-paragraph) ----------------
#let research-blurb = doc => {
  if target != "" and target in targets {
    md-inline(targets.at(target).blurb)
  } else if doc == "cv" and ri.statements.len() > 1 {
    for s in ri.statements { par[#md-inline(s)] }
  } else {
    md-inline(ri.statements.at(0, default: ""))
  }
}

// ---- 10. Title block (package idiom: = Name heading + metadata lines) -----
// Mirrors template/main.typ: a level-1 heading carries the name, with the
// role/affiliation and a contact line beneath. No manual size/weight on the
// name — the heading style is the title typography, per the package template.
// Every line is content-driven (site.yaml): title · affiliation, an optional
// "Advised by …" line, then email · url. (The department field renders on the
// web hero and in the Education section below; omitted here to keep the centered
// title on one line.) The hero on the web renders from the SAME fields, so
// editing site.yaml updates both surfaces in lockstep.
#let advisor-line() = {
  let arr = if "advisors" in site and type(site.advisors) == array { site.advisors } else { () }
  if arr.len() != 0 {
    let linked = arr.map(a => link(a.url)[#a.name])
    let n = linked.len()
    let joined = if n == 1 { linked.at(0) }
    else if n == 2 { [#linked.at(0) and #linked.at(1)] }
    else {
      let out = linked.at(0)
      for i in range(1, n - 1) { out = [#out, #linked.at(i)] }
      [#out, and #linked.at(n - 1)]
    }
    [Advised by #joined]
  }
}

#let title-block = align(center)[
  = #site.name
  #md-inline(site.title) · #md-inline(site.affiliation) \
  #if ("advisors" in site and site.advisors.len() > 0) [
    #advisor-line() \
  ]
  #link("mailto:" + site.email)[#site.email] · #link(site.url)[#site.url]
]

// ---- 11. PDF metadata title ----------------------------------------------
#let doc-title-str = doc => {
  let kind = if doc == "cv" { "CV" } else { "Resume" }
  if target != "" {
    site.name + " — " + kind + " (" + target + ")"
  } else {
    site.name + " — " + kind
  }
}

// ---- 12. Body assembly ----------------------------------------------------
#let cv-body = doc => [
  // Accent is passed via styling(accent-color: ...) at the doc entry points
  // (resume-doc / cv-doc); layout.typ sets it into global-theme.
  #title-block
  #section("Research Interests")
  #research-blurb(doc)
  #section("Education")
  #entries(education)
  #section(if doc == "cv" { "Professional Experience" } else { "Experience" })
  #entries(experience)
  #section(if doc == "cv" { "Publications" } else { "Selected Publications" })
  #pubs-section(doc)
  #if doc == "cv" [
    #section("Honors & Awards")
    #honors-block(honors)
    #section("Teaching")
    #entries(teaching)
    #section("Activities & Service")
    #entries(activities)
    #section("References")
    #references-block(references)
  ]
]

// ---- 13. Document entry points (used by resume.typ / cv.typ) --------------
// NO `set text(font/size)` and NO `set par(leading/spacing)`: Typst's defaults
// (Libertinus Serif, 11pt, default leading/spacing) ARE cv-soft-and-hard's
// typography. The earlier override (`set par(leading: 0.9em, spacing: 0.6em)`
// + New Computer Modern) was the source of the line-spacing mismatch —
// measured against the package template, default settings now reproduce its
// within-paragraph and between-block gaps to within 0.1pt.
//
// Consequence: with template-matching spacing the resume is ~2 pages (the
// content — 11 publications, 8 experience entries — is genuinely 2 pages
// worth). The previous 1-page resume only achieved that via denser-than-
// template block spacing, which is exactly the mismatch this migration fixes.
// `lang: "en"` enables smart quotes / hyphenation. Page numbering "1 / 1".
#let resume-doc = it => {
  set text(lang: "en")
  set page(numbering: "1 / 1")
  set document(title: doc-title-str("resume"), author: site.name)
  styling(cv-body("resume"), accent-color: accent)
}

#let cv-doc = it => {
  set text(lang: "en")
  set page(numbering: "1 / 1")
  set document(title: doc-title-str("cv"), author: site.name)
  styling(cv-body("cv"), accent-color: accent)
}

// ---- 14. Paper one-pager (paper-page.typ) --------------------------------
// A printable single-page handout for ONE paper — title / authors / venue /
// links / abstract / BibTeX — selected by `--input citekey=<key>`. The PDF
// analog of the web academic project page: it reads the SAME papers.bib source
// (via src/data/papers.json), so handout and web page stay in sync. The handout
// a conference, application, or collaborator wants, formatted once.
//
// Compile from repo root:
//   typst compile --root . resume/typst/paper-page.typ public/pdfs/paper-synn2026motionsmith.pdf \
//       --input citekey=synn2026motionsmith

// Full-name author line (papers print full given names, unlike the CV's
// surname+initial). "me" is bolded + underlined, matching format-authors.
#let paper-authors = authors => {
  let parts = authors.map(a => {
    let name = if a.given != none and a.given != "" { [#a.given #a.family] } else { a.family }
    if lower(a.family) == me-family {
      text(weight: "bold")[#underline[#name]]
    } else { name }
  })
  let n = parts.len()
  if n == 0 { [] }
  else if n == 1 { parts.first() }
  else if n == 2 { [#parts.at(0) and #parts.at(1)] }
  else {
    let out = parts.at(0)
    for i in range(1, n - 1) { out = [#out, #parts.at(i)] }
    [#out, and #parts.at(n - 1)]
  }
}

// Web-relative URL → absolute (handout links must resolve standalone, not via
// the site host). Passes http(s) URLs through unchanged.
#let abs-url = u => {
  if u == none { return none }
  if u.starts-with("http://") or u.starts-with("https://") { return u }
  site.url + u
}

// video field → watchable URL: a bare id is a YouTube id; anything else is a
// path/URL (made absolute). Mirrors the web link-chip builder.
#let paper-video-url = v => {
  if v == none { return none }
  let absish = v.starts-with("http://") or v.starts-with("https://") or v.ends-with(".mp4") or v.ends-with(".webm")
  if absish { abs-url(v) } else { "https://www.youtube.com/watch?v=" + v }
}

// Find a paper by citekey; panic loudly with a re-run hint if absent (e.g. the
// demo entry is filtered out of papers.json, or the json is stale).
#let find-paper = key => {
  let matches = papers.filter(p => p.key == key)
  if matches.len() == 0 {
    panic("paper-page: citekey \"" + key + "\" not in src/data/papers.json. " +
          "Run `bun scripts/gen-papers-json.mjs`, or pick a non-demo citekey.")
  }
  matches.first()
}

#let paper-doc = it => {
  let key = sys.inputs.at("citekey", default: "")
  if key == "" {
    panic("paper-page needs --input citekey=<citekey> (e.g. `just paper synn2026motionsmith`).")
  }
  let p = find-paper(key)

  set text(lang: "en")
  set par(justify: true)
  set document(title: p.title, author: site.name)

  // Venue · location · date line.
  let venue-text = if p.venue != none and p.venue != "" { p.venue } else { p.abbr }

  // Link row — only present fields, joined by a middot.
  let links = ()
  if p.pdf != none { links.push(link(abs-url(p.pdf))[PDF]) }
  if p.doi != none { links.push(link("https://doi.org/" + p.doi)[DOI]) }
  if p.code != none { links.push(link(abs-url(p.code))[Code]) }
  if p.website != none { links.push(link(abs-url(p.website))[Project]) }
  let vu = paper-video-url(p.video)
  if vu != none { links.push(link(vu)[Video]) }

  styling(
    [
      // Title
      #align(center)[#text(size: 1.45em, weight: "bold")[#p.title]]
      #v(0.5em)
      // Authors (full names; "me" bolded)
      #align(center)[#paper-authors(p.authors)]
      #v(0.3em)
      // Venue · location · date
      #align(center)[
        #emph[#venue-text]
        #if p.address != none and p.address != "" [ · #p.address]
        · #datestamp(p)
      ]
      #v(0.5em)
      // Link row
      #if links.len() > 0 [
        #align(center)[
          #text(size: 0.9em)[
            #for (i, lk) in links.enumerate() {
              lk
              if i < links.len() - 1 [ · ]
            }
          ]
        ]
        #v(0.5em)
      ]
      // Abstract
      #section("Abstract")
      #p.abstract
      // BibTeX
      #section("Citation (BibTeX)")
      #block(
        inset: 0.8em,
        radius: 0.4em,
        fill: luma(247),
        stroke: 0.5pt + luma(210),
      )[
        #text(size: 0.78em)[#raw(p.raw, block: true)]
      ]
    ],
    accent-color: accent,
  )
}
