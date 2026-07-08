# ============================================================================
# justfile — Alan Synn's academic homepage. Drives the Typst CV/resume
# pipeline (reads the SAME content/*.yaml + src/data/papers.json the Astro web
# reads) and the Astro web build.
#
# Common:
#   just            # = just build  (web + default PDFs)
#   just resume     # public/pdfs/alansynn-resume.pdf
#   just cv         # public/pdfs/alansynn-cv.pdf
#   just resume graphics
#   just cv ml-systems
#   just pdfs       # resume + cv (default variants)
#   just paper <citekey>  # public/pdfs/paper-<citekey>.pdf (single-paper handout)
#   just web        # bun run build
# ============================================================================

# default `just` with no recipe builds everything (web + default PDFs).
default: build

# --- PDF pipeline (Typst) --------------------------------------------------
# resume/typst/{resume,cv}.typ import lib.typ (the shared template). Variants
# are produced by passing --input target=<graphics|ml-systems>; lib.typ swaps
# the research blurb + filters/reorders publications accordingly.
#
# Typst version is pinned in .tool-versions (currently 0.15.x). The pin is a
# reproducibility floor, not a ceiling — bump it (and .tool-versions) when you
# want to adopt a newer Typst release. Layout primitives are first-party in
# resume/typst/layout.typ (no @preview runtime dependency).

# Compile a one-page resume. Optional target id filters/reorders publications
# and swaps the research-interest lead (e.g. `just resume graphics`).
resume target='':
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    if [ -z "{{target}}" ]; then STEM="alansynn-resume"; else STEM="alansynn-resume-{{target}}"; fi
    mkdir -p public/pdfs
    typst compile --root . resume/typst/resume.typ "public/pdfs/$STEM.pdf" --input target="{{target}}" \
        || { echo "--- typst failed (resume $STEM) ---"; exit 1; }
    echo "built public/pdfs/$STEM.pdf"

# Compile the full academic CV. Optional target id (e.g. `just cv ml-systems`).
cv target='':
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    if [ -z "{{target}}" ]; then STEM="alansynn-cv"; else STEM="alansynn-cv-{{target}}"; fi
    mkdir -p public/pdfs
    typst compile --root . resume/typst/cv.typ "public/pdfs/$STEM.pdf" --input target="{{target}}" \
        || { echo "--- typst failed (cv $STEM) ---"; exit 1; }
    echo "built public/pdfs/$STEM.pdf"

# Build the default resume + CV PDFs (no target variants).
pdfs: resume cv

# Build resume + CV for the default + EVERY target variant in content/targets.yaml
# (rebuilds the committed *-graphics.pdf / *-ml-systems.pdf etc. that `pdfs` and
# `build` skip — those variants otherwise go stale after a targets.yaml edit or a
# per-entry only:/except: change). Run after editing targets or cv structure.
pdfs-all:
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    mkdir -p public/pdfs
    build() {
      local doc="$1" stem="$2" target="${3-}"
      typst compile --root . "resume/typst/${doc}.typ" "public/pdfs/${stem}.pdf" --input target="${target}" \
        || { echo "--- typst failed (${doc} ${stem}) ---"; exit 1; }
      echo "built public/pdfs/${stem}.pdf"
    }
    build resume alansynn-resume ""
    build cv     alansynn-cv ""
    for t in $(grep -E '^[A-Za-z0-9][A-Za-z0-9-]*:$' content/targets.yaml | tr -d ':'); do
      build resume "alansynn-resume-$t" "$t"
      build cv     "alansynn-cv-$t" "$t"
    done

# Compile a single-paper one-pager handout (title/authors/venue/links/abstract/
# BibTeX) from the citekey in content/papers.bib → public/pdfs/paper-<key>.pdf.
# e.g. `just paper synn2026motionsmith`
paper citekey:
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    mkdir -p public/pdfs
    typst compile --root . resume/typst/paper-page.typ "public/pdfs/paper-{{citekey}}.pdf" \
        --input citekey="{{citekey}}" \
        || { echo "--- typst failed (paper {{citekey}}) ---"; exit 1; }
    echo "built public/pdfs/paper-{{citekey}}.pdf"

# --- Web -------------------------------------------------------------------

web:
    bun run build

# Build everything: web first, then default PDFs.
build: web pdfs

dev:
    bun run dev

# --- Misc ------------------------------------------------------------------

clips:
    bun scripts/video-clips.mjs

# CSS-isolation guard for academic project pages. Builds the site, serves it via
# `astro preview`, and asserts (Playwright) that the academic /projects/<slug>
# route carries NO site main/tokens/base stylesheet in light + dark — the
# load-bearing route-split invariant. Needs chromium (`bunx playwright install
# chromium`). Mirrors what CI runs after build.
check-isolation: web
    #!/usr/bin/env bash
    set -euo pipefail
    bun run preview &
    SERVER_PID=$!
    trap 'kill $SERVER_PID 2>/dev/null || true' EXIT
    for i in $(seq 1 40); do curl -sSf http://localhost:4321/ >/dev/null 2>&1 && break || sleep 0.5; done
    node scripts/check-isolation.mjs

clean:
    rm -rf dist .astro
