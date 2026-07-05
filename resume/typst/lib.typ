// ============================================================================
// lib.typ — shared CV/resume template, built on @preview/cv-soft-and-hard.
//
// Page style (margins + link underline), section headers (heading + accent
// rule), and the two-column entry grid come from the cv-soft-and-hard
// package. Layered on top: the markdown-inline parser, "me"-author bolding,
// publication classification (journal / conference / preprint), and the
// per-target variant logic.
//
// Reads the SAME content source the Astro web reads (src/data/*.yaml +
// papers.json), so editing a YAML field updates web + CV + resume together.
//
// Variants (per-target show/hide):
//   --input target=graphics | ml-systems
//     • swaps the research-interest blurb (target-blurb below)
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

#import "@preview/cv-soft-and-hard:0.1.0": styling, section, entry

// NOTE: cv-soft-and-hard 0.1.0 exposes an `accent-color` parameter on
// `styling`, but it is broken in this version (the state update that
// propagates the color is discarded, so reading it crashes). We therefore
// use the package's default (black) accent for section rules + link
// underlines, which is also the academic-CV norm. Section/entry/styling
// below are the package's own functions.

// ---- 1. Load shared data (root-relative via --root .) ---------------------
#let site        = yaml("/src/data/site.yaml")
#let education   = yaml("/src/data/education.yaml")
#let experience  = yaml("/src/data/experience.yaml")
#let honors      = yaml("/src/data/honors.yaml")
#let teaching    = yaml("/src/data/teaching.yaml")
#let activities  = yaml("/src/data/activities.yaml")
#let references  = yaml("/src/data/references.yaml")
#let ri          = yaml("/src/data/research-interests.yaml")
#let papers      = json("/src/data/papers.json")

// ---- 2. Targeting ---------------------------------------------------------
#let target = sys.inputs.at("target", default: "")

#let target-keywords = (
  graphics: ("motion", "automata", "kinematic", "sketch", "graphics",
             "animation", "tangible", "makecode", "creativity", "design"),
  // NOTE: "system" / "cloud" were dropped from ml-systems — substring match
  // caught "Design System" (MotionSmith title), "Computing Systems" (CHI venue
  // boilerplate → Tangible), and "Point Cloud" (FBS title), pulling graphics
  // papers to the TOP of the ml-systems resume. Every legit ML-systems paper
  // here has a stronger keyword (dataloader / distributed / training / batch /
  // streaming / privacy / inference), so dropping the two ambiguous ones is safe.
  "ml-systems": ("training", "dataloader", "batch", "distributed", "streaming",
                 "privacy", "inference", "kubernetes"),
)

#let target-blurb = (
  graphics: "My research explores computational design and creativity, with a focus on representing and supporting creative intent in generative and interactive systems. I build models and interfaces that translate high-level human intent into expressive, controllable outcomes, spanning domains such as computer graphics, motion synthesis, and kinematic design.",
  "ml-systems": "My research builds high-efficiency and scalable machine learning systems, with a focus on automated dataloader tuning, memory-aware and distributed training, and privacy-preserving inference. I work across cloud and distributed computing to make ML training and deployment faster, more resource-efficient, and easier to use.",
)

#if target != "" and target not in target-keywords {
  panic("Unknown --input target=\"" + target + "\". Known: " + target-keywords.keys().join(", ") + ".")
}

// Owner family name (lower-cased) — used to bold + underline "me" in author lists.
#let me-family = lower(site.last_name)

// ---- 3. Markdown inline → Typst content -----------------------------------
// Ports scripts/gen-resume-tex.mjs mdInline() 1:1, emitting Typst content.
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
// (mirrors gen-resume-tex.mjs mdBody indent thresholds: 4 → level 1, 8 → 2).
#let bullet-markers = ("•", "◦", "▸")

#let parse-body-lines = body => {
  if body == none { return () }
  let out = ()
  for raw in body.split("\n") {
    let pos = raw.position(regex("\S"))
    if pos == none { continue }
    let trimmed = raw.slice(pos)
    let level = calc.min(bullet-markers.len() - 1, calc.floor(pos / 4))
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

// ---- 6. Entry (title + period + body bullets) on the package grid --------
// Uses cv-soft-and-hard's entry(left, right, description): bold title left,
// period right, bullets in `description` (package renders it full-width via
// grid.cell colspan: 2 — avoids the empty column of whitespace beside the
// right-aligned period that you get when bullets live in `left`).
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
  let desc = if items.len() == 0 { none } else { {
    v(0.25em)
    list(
      marker: ([•], [◦], [▸]),
      indent: 0.6em,
      body-indent: 0.5em,
      spacing: 0.5em,
      ..items.map(l => {
        if l.level == 0 { md-inline(l.text) }
        else { emph[#md-inline(l.text)] }
      }),
    )
  } }
  entry(text(weight: "bold")[#md-inline(title)], period, description: desc)
}

#let entries = list => {
  for (i, e) in list.enumerate() {
    cv-entry(e)
    if i < list.len() - 1 { v(0.5em) }
  }
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
  if target != "" and target in target-keywords {
    let abbr = if p.abbr == none { "" } else { p.abbr }
    let hay = lower(p.title + " " + p.venue + " " + abbr)
    if target-keywords.at(target).any(k => hay.contains(k)) { base - 1000000 }
    else { base }
  } else { base }
}

// Classify a paper by venue string → "journal" | "conference" | "preprint".
// Heuristic on venue + abbr; update papers.json with explicit fields if the
// heuristic ever misfires.
#let pub-type = p => {
  let abbr = if p.abbr == none { "" } else { p.abbr }
  let hay = lower(p.venue + " " + abbr)
  if hay.contains("arxiv") or hay.contains("preprint") { return "preprint" }
  if (
    hay.contains("access") or hay.contains("transactions") or hay.contains("journal")
    or hay.contains("tkips") or hay.contains("ktsde")
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
  if target == "" or target not in target-keywords { return (matched: list, rest: ()) }
  let kws = target-keywords.at(target)
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
  for g in groups {
    text(weight: "bold")[#md-inline(g.group)]
    v(0.2em)
    list(
      marker: ([•], [◦], [▸]),
      indent: 0.6em,
      body-indent: 0.5em,
      spacing: 0.45em,
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
  if target != "" and target in target-blurb {
    md-inline(target-blurb.at(target))
  } else if doc == "cv" and ri.statements.len() > 1 {
    for s in ri.statements { par[#md-inline(s)] }
  } else {
    md-inline(ri.statements.at(0, default: ""))
  }
}

// ---- 10. Title block (centered name + role/affiliation + contact line) ---
// Mirrors the reference CVs (Sehoon Ha, Danfei Xu), which put the role +
// institution directly under the name so a reviewer sees affiliation before
// scrolling to Education.
#let title-block = align(center)[
  #text(size: 18pt, weight: "bold")[#site.name]
  #v(0.15em)
  #text(size: 10.5pt)[#md-inline(site.title) · #md-inline(site.affiliation)]
  #v(0.2em)
  #text(size: 10pt)[
    #link("mailto:" + site.email)[#site.email] • #site.phone • #link(site.url)[#site.url]
  ]
  #v(0.4em)
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
// Page numbering "1 / 1" = current / total (both ref CVs number pages).
#let resume-doc = it => {
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(leading: 0.9em, spacing: 0.6em, justify: false)
  set page(numbering: "1 / 1")
  set document(title: doc-title-str("resume"), author: site.name)
  styling(cv-body("resume"))
}

#let cv-doc = it => {
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(leading: 0.9em, spacing: 0.6em, justify: false)
  set page(numbering: "1 / 1")
  set document(title: doc-title-str("cv"), author: site.name)
  styling(cv-body("cv"))
}
