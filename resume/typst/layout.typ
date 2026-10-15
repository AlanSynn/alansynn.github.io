// ============================================================================
// layout.typ — first-party paper-handout layout toolkit.
//
// Adapted from cv-soft-and-hard 0.1.0 by Jonas Pleyer (MIT License,
// © Jonas Pleyer; source https://github.com/jonaspleyer/cv-soft-and-hard).
// Brought in-house as first-party code so the template is fully owned and
// freely editable — the upstream @preview package is no longer a runtime
// dependency. (MIT attribution preserved per license; see CLAUDE.md "Stack".)
//
// The CV and resume now render in the academiccv.cls 양식 (academic.typ);
// this toolkit's remaining consumer is the one-page paper handout
// (paper-page.typ). Provides:
//   global-theme — accent-color state shared across sections/links
//   styling      — page margins + link underline + accent setup
//   section      — level-2 heading with an accent rule beneath
// (The old two-column `entry` and `subsection` primitives were removed once
// their last consumer — the pre-academic resume layout — was replaced.)
//
// Two intentional changes vs upstream 0.1.0:
//   1. styling(accent-color:) is FIXED here. Upstream's state-update lambda
//      ended on `pt.insert(...)` which returns `none`, collapsing global-theme
//      and crashing any later `.at("accent-color")`. The lambda now returns the
//      mutated dict, so callers pass the accent directly via styling(...) and
//      lib.typ no longer needs the global-theme.update workaround.
//   2. icons.typ is NOT carried over (the repo renders no skill icons). Re-add
//      it from upstream if icon badges are ever wanted.
// ============================================================================

// Page theme state — single source for the accent color.
#let global-theme = state("theme", ("accent-color": black))

// Page styling: set the accent color, underline links in the accent, set page
// margins. accent-color flows into global-theme so `section`'s accent rule and
// the link underline share one color.
#let styling(body, accent-color: none) = {
  if accent-color != none {
    global-theme.update(pt => {
      pt.insert("accent-color", accent-color)
      pt  // return the mutated dict (fixes the upstream-0.1.0 bug)
    })
  }
  context {
    let theme = global-theme.get()
    let accent-color = theme.at("accent-color")
    // Links stay clickable but NOT visibly underlined (plan §4.7/§6): accent
    // color carries the affordance. underline(ct, ...) was visual noise across
    // every institution/company/advisor link.
    show link: ct => text(fill: accent-color)[#ct]
    set page(margin: (left: 2.5cm, right: 2.5cm, top: 2cm))
    body
  }
}

// Section header: a level-2 heading with an accent-colored rule beneath.
#let section(title, note: none, before: 4pt) = {
  v(before)
  box(grid(
    columns: 2,
    [#heading(title, level: 2)],
    context {
      let accent-color = global-theme.get().at("accent-color")
      line(start: (0% + 2pt, 0% + 8pt), length: 100%, stroke: accent-color)
    },
  ))
  if note != none { text(note, size: 7pt) }
}
