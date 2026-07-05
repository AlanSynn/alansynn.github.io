// ============================================================================
// lib.typ — shared CV/resume template for the academic homepage.
//
// Reads the SAME content source the Astro web reads (src/data/*.yaml +
// papers.json) and renders the academic CV/resume that simpleresume used to.
// Entry files resume.typ / cv.typ import this and pick a layout via #show.
//
// Variants (per-target show/hide, the user's "하나의 typst으로 다양한 관리"):
//   --input target=graphics | ml-systems
//     • swaps the research-interest blurb (target-blurb below)
//     • filters/reorders publications by keyword (matched-first on CV,
//       matched-only on resume)
//     • honors per-entry visibility: any yaml entry may carry
//         only:   [graphics]   # show only for these targets
//         except: [ml-systems] # hide for these targets
//
// Compile from repo root:
//   typst compile --root . resume/typst/resume.typ public/pdfs/resume.pdf
//   typst compile --root . resume/typst/resume.typ public/pdfs/resume-graphics.pdf --input target=graphics
// ============================================================================

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
  "ml-systems": ("training", "dataloader", "batch", "distributed", "streaming",
                 "privacy", "inference", "system", "cloud", "kubernetes"),
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
// literally — no LaTeX escaping, which removes the r6 markdown-leak bug class.
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

// ---- 5. Bullet rendering (indent-level aware) -----------------------------
#let bullet-markers = ("•", "◦", "▸")

#let bullet-line(body, level: 0) = {
  let marker = bullet-markers.at(level, default: "•")
  block(width: 100%, spacing: 0pt, breakable: true)[
    #pad(left: level * 1.3em)[
      #grid(
        columns: (0.9em, 1fr),
        column-gutter: 0.35em,
        align: (right + top, left + top),
        [#marker],
        [#body],
      )
    ]
  ]
}

// Split a markdown bullet body into (level, text) lines by leading indent
// (mirrors gen-resume-tex.mjs mdBody indent thresholds: 4 → level 1, 8 → 2).
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

#let render-detail = (loc, body) => {
  let lines = parse-body-lines(body)
  let lead = ()
  if loc != none and loc != "" { lead.push((level: 0, text: loc)) }
  [
    #for l in lead + lines {
      bullet-line(md-inline(l.text), level: l.level)
    }
  ]
}

// ---- 6. Entry block (title \hfill period + detail bullets) ----------------
#let entry = e => {
  if not entry-visible(e) { return [] }
  let period = e.at("period", default: "")
  let title = e.at("title", default: "")
  let location = e.at("location", default: none)
  let body = e.at("body", default: none)
  block(width: 100%, spacing: 0pt)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      column-gutter: 0.8em,
      [#text(weight: "bold")[#md-inline(title)]],
      [#period],
    )
    #render-detail(location, body)
  ]
}

#let entries = list => [
  #for (i, e) in list.enumerate() {
    entry(e)
    if i < list.len() - 1 { v(0.55em) }
  }
]

// ---- 7. Section header (bold title + rule) --------------------------------
#let section = name => block(width: 100%, spacing: 0pt)[
  #v(0.9em)
  #text(weight: "bold")[#name]
  #v(-0.5em)
  #line(length: 100%, stroke: 0.5pt)
]

// ---- 8. Publications ------------------------------------------------------
#let months = ("", "Jan.", "Feb.", "Mar.", "Apr.", "May", "Jun.",
               "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec.")

#let datestamp = p => {
  if p.month != none and p.month >= 1 and p.month <= 12 {
    [#months.at(p.month) #p.year]
  } else {
    [#p.year]
  }
}

#let format-name = a => {
  if a.given != none and a.given != "" [#a.given~#a.family] else { a.family }
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

#let pub-item = (n, p) => {
  let venue = if p.abbr != none and p.abbr != "" { p.abbr } else { p.venue }
  block(width: 100%, spacing: 0pt, breakable: true)[
    #grid(
      columns: (1.5em, 1fr),
      column-gutter: 0.3em,
      align: (left + top, left + top),
      [#[#n]],
      [#format-authors(p.authors), "#p.title," #emph[#venue], #datestamp(p).],
    )
  ]
}

// Split into (matched, rest) by target keyword; preserves order within each.
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

#let pubs-block = (list, group-by-year: false) => [
  #for (i, p) in list.enumerate() {
    let n = i + 1
    if group-by-year {
      let prev = if i > 0 { list.at(i - 1).year } else { none }
      if prev != p.year {
        if i > 0 { v(0.55em) }
        block(width: 100%, spacing: 0pt)[#text(weight: "bold")[#p.year]]
      }
    }
    pub-item(n, p)
  }
]

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

// ---- 9. Honors, References ------------------------------------------------
#let honors-block = groups => [
  #for g in groups {
    bullet-line(text(weight: "bold")[#md-inline(g.group)], level: 0)
    for item in g.items {
      bullet-line(md-inline(item), level: 1)
    }
  }
]

#let references-block = refs => [
  #for (i, r) in refs.enumerate() {
    if i > 0 { v(0.9em) }
    let role = r.at("role", default: none)
    let aff = r.at("affiliation", default: none)
    let dept = r.at("department", default: none)
    let email = r.at("email", default: none)
    let url = r.at("url", default: none)
    let contact = {
      if email != none { link("mailto:" + email)[#email] }
      else if url != none { link(url)[#url] }
    }
    block(width: 100%, spacing: 0pt)[
      #text(weight: "bold")[#r.name]#linebreak()
      #if role != none [#role#linebreak()]
      #if aff != none [#aff#linebreak()]
      #if dept != none [#dept#linebreak()]
      #contact
    ]
  }
]

// ---- 10. Research blurb (target swap + CV multi-paragraph) ----------------
#let research-blurb = doc => [
  #if target != "" and target in target-blurb {
    md-inline(target-blurb.at(target))
  } else if doc == "cv" and ri.statements.len() > 1 {
    for s in ri.statements { par[#md-inline(s)] }
  } else {
    md-inline(ri.statements.at(0, default: ""))
  }
]

// ---- 11. Title block (centered name + email • phone • url) ----------------
#let title-block = align(center)[
  #text(size: 18pt, weight: "bold")[#site.name]
  #v(0.1em)
  #text(size: 10pt)[
    #link("mailto:" + site.email)[#site.email] • #site.phone • #link(site.url)[#site.url]
  ]
]

// ---- 12. PDF metadata title ----------------------------------------------
#let doc-title-str = doc => {
  let kind = if doc == "cv" { "CV" } else { "Resume" }
  if target != "" {
    site.name + " — " + kind + " (" + target + ")"
  } else {
    site.name + " — " + kind
  }
}

// ---- 13. Page style + body assembly ---------------------------------------
#let style = it => {
  set page(paper: "us-letter", margin: (top: 0.5in, bottom: 0.5in, x: 0.55in))
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(leading: 0.62em, spacing: 0.6em, justify: false)
  it
}

#let cv-body = doc => [
  #title-block
  #v(0.3em)
  #section("Research Interests")
  #research-blurb(doc)
  #section("Education")
  #entries(education)
  #section("Professional Experience")
  #entries(experience)
  #section(if doc == "cv" { "Publications" } else { "Selected Publications" })
  #pubs-block(pubs-for(doc), group-by-year: doc == "cv")
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

// ---- 14. Document entry points (used by resume.typ / cv.typ) --------------
#let resume-doc = it => {
  set page(paper: "us-letter", margin: (top: 0.5in, bottom: 0.5in, x: 0.55in))
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(leading: 0.62em, spacing: 0.6em, justify: false)
  set document(title: doc-title-str("resume"), author: site.name)
  cv-body("resume")
}

#let cv-doc = it => {
  set page(paper: "us-letter", margin: (top: 0.5in, bottom: 0.5in, x: 0.55in))
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(leading: 0.62em, spacing: 0.6em, justify: false)
  set document(title: doc-title-str("cv"), author: site.name)
  cv-body("cv")
}
