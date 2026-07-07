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
#   just cv-private           # private/pdfs/alansynn-cv.pdf (PHONE FULL — not committed)
#   just resume-private ml-systems   # private + a research target
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
# and swaps the research-interest lead (e.g. `just resume graphics`). Output is
# phone-less (public): the contact line omits phone unless phone=true is passed
# (see resume-private below).
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
# Phone-less (public) — see cv-private for a phone-full private build.
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

# --- Private phone-full variants --------------------------------------------
# Output to private/pdfs/ (gitignored — NEVER committed or deployed). Passes
# --input phone=true so the contact line INCLUDES the phone number. Same optional
# research target as the public recipes (e.g. `just cv-private graphics`).
resume-private target='':
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    if [ -z "{{target}}" ]; then STEM="alansynn-resume"; else STEM="alansynn-resume-{{target}}"; fi
    mkdir -p private/pdfs
    typst compile --root . resume/typst/resume.typ "private/pdfs/$STEM.pdf" \
        --input target="{{target}}" --input phone="true" \
        || { echo "--- typst failed (resume-private $STEM) ---"; exit 1; }
    echo "built private/pdfs/$STEM.pdf  (PHONE FULL — do NOT commit)"

cv-private target='':
    #!/usr/bin/env bash
    set -euo pipefail
    bun scripts/gen-papers-json.mjs
    if [ -z "{{target}}" ]; then STEM="alansynn-cv"; else STEM="alansynn-cv-{{target}}"; fi
    mkdir -p private/pdfs
    typst compile --root . resume/typst/cv.typ "private/pdfs/$STEM.pdf" \
        --input target="{{target}}" --input phone="true" \
        || { echo "--- typst failed (cv-private $STEM) ---"; exit 1; }
    echo "built private/pdfs/$STEM.pdf  (PHONE FULL — do NOT commit)"

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
