// ============================================================================
// lib.typ: shared CV/resume/paper-handout template. The CV and resume render
// in the owner's academiccv.cls 양식 (academic.typ: Latin Modern, cls geometry,
// gray running header/footer, hidelinks-style links: the resume compressed to
// one page via density knobs); the one-page paper handout keeps the first-party
// layout.typ toolkit (adapted from cv-soft-and-hard 0.1.0, MIT, © Jonas Pleyer
//: brought in-house so the template is fully owned and freely editable; no
// @preview runtime dependency).
//
// Layered on top: the markdown-inline parser, self-author bolding, publication
// classification (journal / conference / preprint), and the per-target variant
// logic.
//
// Reads the SAME content source the Astro web reads (content/*.yaml +
// content/cv.yaml for the career-timeline sections + src/data/papers.json), so
// editing a YAML field updates web + CV + resume together.
//
// Variants (per-target show/hide):
//   --input target=graphics | ml-systems
//     • swaps the research blurb + publication keyword filter for this target
//       (both defined in content/targets.yaml: add a target there, no code edit)
//     • filters/reorders publications by keyword (matched-first on CV,
//       matched-only on resume)
//     • honors per-entry visibility: any yaml entry may carry
//         only:   [graphics]   # show only for these targets
//         except: [ml-systems] # hide for these targets
//
// Compile (prefer the `just` recipes: they regen src/data/papers.json first;
// a raw `typst compile` skips that and can render against a stale JSON):
//   just cv                    # → public/pdfs/alansynn-cv.pdf
//   just cv graphics           # → public/pdfs/alansynn-cv-graphics.pdf
// Equivalent raw form (run `bun scripts/gen-papers-json.mjs` first):
//   typst compile --root . resume/typst/cv.typ public/pdfs/alansynn-cv.pdf
//   typst compile --root . resume/typst/cv.typ public/pdfs/alansynn-cv-graphics.pdf --input target=graphics
// ============================================================================

#import "./layout.typ": styling, section
#import "./academic.typ": acad-page, acad-name-header, acad-section, acad-subsection, acad-entry-grid, acad-items, acad-pub-item

// Brand accent (web --accent navy #1d4e89): passed to styling() so the paper
// handout's section rules + link underlines carry the site brand.
#let accent = rgb("1d4e89")

// ---- 1. Load shared data (root-relative via --root .) ---------------------
#let site        = yaml("/content/site.yaml")
#let cvdata      = yaml("/content/cv.yaml")
#let education   = cvdata.education
#let experience  = cvdata.experience
#let teaching    = cvdata.teaching
#let activities  = cvdata.activities
#let outreach    = cvdata.outreach
#let projects    = cvdata.projects
#let service     = cvdata.service
#let patents     = cvdata.patents
#let honors      = yaml("/content/honors.yaml")
#let references  = yaml("/content/references.yaml")
#let ri          = yaml("/content/research-interests.yaml")
#let venues      = yaml("/content/venues.yaml")
#let targets     = yaml("/content/targets.yaml")
#let papers      = json("/src/data/papers.json")

// ---- 2. Targeting ---------------------------------------------------------
// Targeted variants (id → { blurb, keywords }) live in content/targets.yaml,
// validated on the web side by targetsSchema. Adding a target there is the only
// step: this file reads it automatically (no code edit, no separate keyword
// list to keep in sync).
#let target = sys.inputs.at("target", default: "")

#if target != "" and target not in targets {
  panic("Unknown --input target=\"" + target + "\". Known: " + targets.keys().join(", ") + ".")
}

// Owner family name (lower-cased): used to bold + underline "me" in author lists.
#let me-family = lower(site.last_name)

// ---- 3. Markdown inline → Typst content -----------------------------------
// Handles [label](url), **bold**, *italic*, recursively (bold/italic inside a
// link label, links inside bold, etc.). UTF-8 chars (·, →, &) render
// literally: no LaTeX escaping, which removes the markdown-leak bug class.
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
  // bold/link run stays tight: "graphics," not "graphics ,".
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

// ---- 6. Entry row (academiccv.cls cventry, both docs) ----------------------
// The cls cventry form for BOTH the CV and the resume: same 4pt pre-entry
// gap and cls bullet rhythm (3pt/2pt) on each: left / \small raggedleft-right
// tabularx row, the optional italic "role or description" line, then cvitems
// bullets. The left cell is BOLD on the CV (the cls look) and regular weight
// on the resume. The row carries `org` when the entry has it (fallback:
// title) on the CV; the resume keeps `title` on the row and drops the italic
// line. The italic line carries `role`
// (fallback: `location`); a location it doesn't consume leads the resume's
// bullets (the old resume layout's behavior: no current resume entry has
// one, so this is defensive). `more` carries CV/web-only detail the resume
// omits (a 2nd experience bullet, an advisor line, military service); the web
// Timeline mirrors the CV by concatenating body+more in data. Kept whole
// across page breaks (the cls \Needspace guard ≈ breakable: false).
#let cv-entry = (e, doc: "cv") => {
  if not entry-visible(e) { return [] }
  // Period verbatim from the yaml (owner dash policy: plain hyphen only;
  // no PDF-side rewriting).
  let period = e.at("period", default: "")
  let title = e.at("title", default: "")
  let location = e.at("location", default: none)
  let body = e.at("body", default: none)
  let more = e.at("more", default: none)
  let lines = parse-body-lines(body)
  let more-lines = if more != none and doc != "resume" { parse-body-lines(more) } else { () }
  let org = e.at("org", default: none)
  let role = e.at("role", default: none)
  let row-left = if doc == "cv" and org != none and org != "" { org } else { title }
  let italic-line = if doc == "cv" {
    if role != none and role != "" { role }
      else if location != none and location != "" { location }
      else { none }
  } else { none }
  let lead = if doc != "cv" and location != none and location != "" {
    ((level: 0, text: location),)
  } else { () }
  let items = lead + lines + more-lines
  // Row weight: the bold left cell is the cls cventry look on the CV; on the
  // resume the rows render in regular weight: nine consecutive bold rows
  // read heavy at one-page density (owner feedback, 2026-10-15). The CV path
  // is unchanged.
  block(breakable: false)[
    #v(4pt)
    #acad-entry-grid(md-inline(row-left), period, left-weight: if doc == "cv" { "bold" } else { none })
    #if italic-line != none {
      par(emph[#md-inline(italic-line)])
    }
    #if items.len() > 0 {
      acad-items(..items.map(l => {
        if l.level == 0 { md-inline(l.text) }
        else { emph[#md-inline(l.text)] }
      }))
    }
  ]
}

#let entries = (list, doc: "cv") => {
  for e in list { cv-entry(e, doc: doc) }
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

// Join rendered author-name parts with commas + a final "and". Shared by the
// CV/resume academic publication lines (pub-line-academic).
#let join-and = parts => {
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
// TOP of their journal/conference/preprint group: otherwise the per-group
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

// Academic (cls-style) publication line, fed to acad-pub-item by both docs:
// full given names ("DoangJoo Synn"), “Title.” + italic venue + year, and a
// doi: link when present. Mirrors cv.tex's \cvpublications entries. The self
// name is bold WITHOUT the underline: academiccv.cls sets hidelinks, so the
// academic CV carries no visible link styling at all. Year only (no months),
// matching the cls's publication lists.
#let pub-line-academic = p => {
  let parts = p.authors.map(a => {
    // \cvself prints "DoangJoo Synn": strip parenthetical infixes ("(Alan)")
    // the bib carries, so the academic CV's author lines match the cls.
    let given = if a.given != none and a.given != "" { a.given.replace(regex(" *\([^)]*\)"), "") } else { none }
    let name = if given != none and given != "" { [#given #a.family] } else { a.family }
    if lower(a.family) == me-family {
      text(weight: "bold")[#name]
    } else { name }
  })
  // "doi:…" is the link LABEL (markup); the href is built in code mode. Venue
  // is optional (the in-review preprint has none → "….” Year." like tex's M1).
  let doi = if p.doi != none and p.doi != "" { [ #link("https://doi.org/" + str(p.doi))[doi:#p.doi].] } else { [] }
  let venue = if p.venue != none and p.venue != "" { [#emph[#p.venue], ] } else { [] }
  [#join-and(parts). “#p.title.” #venue #p.year.#doi]
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
  // Targeted resume whose keywords match zero selected papers → the section
  // would render its header with no entries (silent empty list). Panic naming
  // the target so content/targets.yaml keywords get widened instead of a blank
  // "Selected Publications" shipping. (Default resume has all selected papers,
  // so this only fires under a --input target=... that matches nothing.)
  if doc == "resume" and target != "" and list-all.len() == 0 {
    panic(
      "resume target '" + target + "' matched zero selected papers: widen its keywords in content/targets.yaml, or the Selected Publications section renders empty.",
    )
  }
  // The cls's 6pt itemsep, and the absorbed-spacing trap: a grid-only block
  // (acad-pub-item) contributes no spacing in Typst 0.15, so the itemsep
  // needs an explicit v() between items. Same 6pt on both docs.
  if doc == "cv" {
    // Academic CV: cls-style subsections with stable letter labels (C/J/P +
    // recency rank within the group): mirrors cv.tex's C1..C5/J1..J4/P1
    // numbering. (cv.tex labels are hand-written for cross-reference
    // stability; these are derived. If exact label stability across reorders
    // ever matters, add a label={C1} field to papers.bib and read it here.)
    let s = split-by-type(list-all)
    for (label, letter, group) in (
      ("Refereed Conference Papers", "C", s.conference),
      ("Refereed Journal Articles", "J", s.journal),
      ("Preprints", "P", s.preprint),
    ) {
      if group.len() == 0 { continue }
      acad-subsection(label)
      let sorted = group.sorted(key: pub-sort-key)
      let m = sorted.len()
      for (i, p) in sorted.enumerate() {
        acad-pub-item(letter + str(i + 1), pub-line-academic(p))
        if i < m - 1 { v(6pt) }
      }
      v(0.3em)
    }
  } else {
    // Resume: the same academic hanging list, one flat numbered run: the
    // journal/conference subsection grouping is CV-only detail.
    let sorted = list-all.sorted(key: pub-sort-key)
    let m = sorted.len()
    for (i, p) in sorted.enumerate() {
      acad-pub-item(str(i + 1), pub-line-academic(p))
      if i < m - 1 { v(6pt) }
    }
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
  } else if (doc == "cv" or doc == "resume") and ri.statements.len() > 1 {
    for s in ri.statements { par[#md-inline(s)] }
  } else {
    md-inline(ri.statements.at(0, default: ""))
  }
}

// ---- 10. Title block (cls \makecvheader, both docs) ------------------------
// The cls header on BOTH documents: left-aligned bold 25pt name, subtitle,
// \small contact line: acad-name-header's cls defaults, no doc split. Every
// line is content-driven (site.yaml): title · affiliation, then email · url.
// The hero on the web renders from the SAME fields, so editing site.yaml
// updates web + PDFs in lockstep. Contact = email · site url ONLY; the phone
// number the LaTeX original carried is deliberately absent (owner directive).
#let title-block = doc => {
  acad-name-header(
    site.name,
    [#md-inline(site.title) · #md-inline(site.affiliation)],
    // Label drops the scheme (cls contact line prints "alansynn.com"); href keeps it.
    [#link("mailto:" + site.email)[#site.email] · #link(site.url)[#site.url.replace(regex("^https?://"), "")]],
  )
}

// ---- 11. PDF metadata title ----------------------------------------------
#let doc-title-str = doc => {
  // The CV mirrors the cls \hypersetup pdftitle ("Name: Curriculum Vitae");
  // the resume keeps its "Name: Resume" form. Target variants append the id.
  let suffix = if target != "" { " (" + target + ")" } else { "" }
  if doc == "cv" {
    site.name + ": Curriculum Vitae" + suffix
  } else {
    site.name + ": Resume" + suffix
  }
}

// ---- 12. Body assembly ----------------------------------------------------
// Both docs share ONE rhythm: the cls's own (acad-section / acad-items /
// acad-pub-item defaults); `doc` selects only the section SET and the
// entry/pub-list shape.
#let cv-body = doc => {
  let sec(title) = acad-section(title)
  [
  #title-block(doc)
  #sec("Research Interests")
  #research-blurb(doc)
  #sec("Education")
  #entries(education, doc: doc)
  // Section order diverges by doc (plan §4.1 vs §5.2). The CV fronts Projects
  // and Publications before Professional Experience: academic legitimacy
  // before the full industry record, and carries the CV-only tail (Patent
  // Applications / Teaching / Invited Talks & Outreach / Scholarly Activities /
  // Honors / Activities). The one-page resume keeps the academic 양식 with the
  // compact section set: Research Interests → Education → Experience →
  // Selected Publications. The public CV omits References (plan §5.11: a
  // separate application sheet); the references-block helper +
  // references.yaml stay for that sheet.
  #if doc == "cv" [
    #sec("Selected Research Projects")
    #entries(projects, doc: doc)
    #sec("Publications")
    #pubs-section(doc)
    #sec("Patent Applications")
    #for (i, pt) in patents.enumerate() {
      acad-pub-item("IP" + str(i + 1), md-inline(pt.body))
      if i < patents.len() - 1 { v(6pt) }
    }
    #sec("Professional Experience")
    #entries(experience, doc: doc)
    #sec("Teaching")
    #entries(teaching, doc: doc)
    #sec("Invited Talks & Outreach")
    #entries(outreach, doc: doc)
    #sec("Scholarly Activities")
    #entries(service, doc: doc)
    #sec("Honors & Awards")
    #honors-block(honors)
    #sec("Activities & Service")
    #entries(activities, doc: doc)
  ] else [
    #sec("Experience")
    #entries(experience, doc: doc)
    #sec("Selected Publications")
    #pubs-section(doc)
  ]
  ]
}

// ---- 13. Document entry points (used by resume.typ / cv.typ) --------------
// Both documents render in the owner's academiccv.cls 양식 (academic.typ) via
// acad-page. They compile SEPARATELY (cv.typ never evaluates resume-doc and
// vice versa), so each doc's density is scoped to its own compilation.
//
// The resume is the CV's 양식 at the CV's FULL rhythm: same section gaps
// (13/7pt), entry gaps (4pt), bullet gaps (3/2pt), publication itemsep (6pt),
// 25pt name: so every spacing the eye reads is IDENTICAL to the CV (owner
// feedback 2026-10-15: the earlier knob-tightened rhythm read cramped next
// to the CV). The one-page fit is funded by global levers that don't touch
// the rhythm: 10pt text (the standard resume size; leading is em-based, so
// line pitch scales proportionally at the same 0.65em) and slightly narrower
// margins (0.65in sides / 0.5in top+bottom vs the cls's 0.78/0.72/0.70:
// still normal resume margins). Measured: 11pt + cls margins and 10pt + cls
// margins both overflow by exactly one 3-line publication; 10pt + these
// margins holds one page. The targeted resume variants carry a subset of the
// content, so they fit a fortiori.
#let resume-doc = it => {
  acad-page(
    cv-body("resume"),
    site.name,
    doc-title-str("resume"),
    size: 10pt,
    margin: (left: 0.65in, right: 0.65in, top: 0.5in, bottom: 0.5in),
    doc-type: "Resume",
  )
}

#let cv-doc = it => {
  // The cls's own rhythm: no density knobs.
  acad-page(cv-body("cv"), site.name, doc-title-str("cv"))
}

// ---- 14. Paper one-pager (paper-page.typ) --------------------------------
// A printable single-page handout for ONE paper: title / authors / venue /
// links / abstract / BibTeX: selected by `--input citekey=<key>`. The PDF
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
  let absish = v.starts-with("http://") or v.starts-with("https://") or v.ends-with(".mp4") or v.ends-with(".webm") or v.ends-with(".ogg")
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

// Clean BibTeX citation synthesized from the parsed paper: NOT a dump of p.raw.
// (raw carries internal housekeeping flags: selected/featured/preview/video/
// pdf/website/code/abstract: that must never appear in a citation a reader
// copies.) Mirrors the web synthesis in AcademicProject.astro (bibRows) so the
// PDF handout and the web page emit the SAME entry: type + title + author +
// venue + year + doi. Type + author are read from raw via regex because the
// parsed shape exposes p.title/p.venue/p.doi but not the entry type or the
// verbatim author string.
#let bibtex-citation = p => {
  let tm = p.raw.match(regex("@(\\w+)\\s*\\{"))
  let typ = if tm != none { tm.captures.at(0) } else { "misc" }
  let rows = (("title", p.title),)
  // Verbatim author string from raw preserves "Family, Given (Note)" form the
  // parsed p.authors array would flatten; fall back to rebuilding from it.
  let am = p.raw.match(regex("author\\s*=\\s*\\{([^}]+)\\}"))
  if am != none {
    rows.push(("author", am.captures.at(0)))
  } else {
    let names = p.authors.map(a =>
      if a.given != none and a.given != "" { [#a.given #a.family] } else { a.family })
    rows.push(("author", names.join(" and ")))
  }
  if p.venue != none and p.venue != "" { rows.push(("booktitle", p.venue)) }
  if p.year != none { rows.push(("year", str(p.year))) }
  if p.doi != none { rows.push(("doi", p.doi)) }
  let body = rows.map(((k, v)) => "  " + k + " = {" + str(v) + "}").join(",\n")
  "@" + typ + "{" + p.key + ",\n" + body + ",\n}"
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

  // Link row: only present fields, joined by a middot.
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
        #text(size: 0.78em)[#raw(bibtex-citation(p), block: true)]
      ]
    ],
    accent-color: accent,
  )
}
