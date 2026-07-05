# ============================================================================
# justfile — Alan Synn's academic homepage. Drives the Typst CV/resume
# pipeline (reads the SAME src/data/*.yaml + papers.json the Astro web reads)
# and the Astro web build.
#
# Common:
#   just            # = just build  (web + default PDFs)
#   just resume     # public/pdfs/resume.pdf
#   just cv         # public/pdfs/cv.pdf
#   just resume graphics
#   just cv ml-systems
#   just pdfs       # resume + cv (default variants)
#   just web        # bun run build
# ============================================================================

# default `just` with no recipe builds everything (web + default PDFs).
default: build

# --- PDF pipeline (Typst) --------------------------------------------------
# resume/typst/{resume,cv}.typ import lib.typ (the shared template). Variants
# are produced by passing --input target=<graphics|ml-systems>; lib.typ swaps
# the research blurb + filters/reorders publications accordingly.

# Compile a one-page resume. Optional target id filters/reorders publications
# and swaps the research-interest lead (e.g. `just resume graphics`).
resume target='':
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    if [ -z "{{target}}" ]; then STEM="resume"; else STEM="resume-{{target}}"; fi
    mkdir -p public/pdfs
    typst compile --root . resume/typst/resume.typ "public/pdfs/$STEM.pdf" --input target="{{target}}" \
        || { echo "--- typst failed (resume $STEM) ---"; exit 1; }
    echo "built public/pdfs/$STEM.pdf"

# Compile the full academic CV. Optional target id (e.g. `just cv ml-systems`).
cv target='':
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    if [ -z "{{target}}" ]; then STEM="cv"; else STEM="cv-{{target}}"; fi
    mkdir -p public/pdfs
    typst compile --root . resume/typst/cv.typ "public/pdfs/$STEM.pdf" --input target="{{target}}" \
        || { echo "--- typst failed (cv $STEM) ---"; exit 1; }
    echo "built public/pdfs/$STEM.pdf"

# Build the default resume + CV PDFs (no target variants).
pdfs: resume cv

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

clean:
    rm -rf dist .astro
