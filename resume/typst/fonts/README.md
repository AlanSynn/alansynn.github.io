# Latin Modern (vendored fonts)

The CV template (`resume/typst/academic.typ`) reproduces the owner's LaTeX CV
class (`academiccv.cls`), which sets Latin Modern. The four roman faces
(regular / bold / italic / bold-italic) are vendored here so `typst compile`
renders identically on any machine — Typst's bundled set does not include
Latin Modern.

- Source: TeX Live (`texmf-dist/fonts/opentype/public/lm/`), copied 2026-10-15.
- License: GUST FONT LICENSE (permitted redistribution; see the license text in
  the Latin Modern release). Files: `lmroman10-{regular,bold,italic,bolditalic}.otf`.
- Wired into the build via `--font-path resume/typst/fonts` on every `typst
  compile` in the justfile. Harmless for resume/paper handouts (they never
  request the family).

`just cv` is the only consumer (`academic.typ` → `text(font: "Latin Modern
Roman")`). If you add a sans/mono face, copy it here and note it above.
