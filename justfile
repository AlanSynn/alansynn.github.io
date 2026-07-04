# ============================================================================
# justfile — Alan Synn's academic homepage. Drives the LaTeX resume/CV pipeline
# (reads shared YAML + papers.json) and the Astro web build.
#
# Common:
#   just            # = just build  (web + default PDFs)
#   just resume     # public/pdfs/resume.pdf
#   just cv         # public/pdfs/cv.pdf
#   just resume graphics
#   just cv ml-systems
#   just pdfs       # resume + cv (default variants)
#   just web        # npm run build
# ============================================================================

# default `just` with no recipe builds everything (web + default PDFs).
default: build

# --- PDF pipeline ----------------------------------------------------------

# Generate + compile a one-page resume. Optional target id filters/reorders
# publications and swaps the research-interest lead (e.g. `just resume graphics`).
resume target='':
    #!/usr/bin/env bash
    set -euo pipefail
    node scripts/gen-papers-json.mjs
    node scripts/gen-resume-tex.mjs --doc resume --target "{{target}}"
    if [ -z "{{target}}" ]; then STEM="resume"; else STEM="resume-{{target}}"; fi
    cd resume
    xelatex -interaction=nonstopmode -halt-on-error -output-directory build "build/$STEM.tex" \
        || { echo "--- xelatex failed (pass 1), tail of $STEM.log ---"; tail -60 "build/$STEM.log"; exit 1; }
    xelatex -interaction=nonstopmode -halt-on-error -output-directory build "build/$STEM.tex" \
        || { echo "--- xelatex failed (pass 2), tail of $STEM.log ---"; tail -60 "build/$STEM.log"; exit 1; }
    mkdir -p ../public/pdfs
    cp "build/$STEM.pdf" "../public/pdfs/$STEM.pdf"
    echo "built public/pdfs/$STEM.pdf"

# Generate + compile the full academic CV. Optional target id (e.g. `just cv ml-systems`).
cv target='':
    #!/usr/bin/env bash
    set -euo pipefail
    node scripts/gen-papers-json.mjs
    node scripts/gen-resume-tex.mjs --doc cv --target "{{target}}"
    if [ -z "{{target}}" ]; then STEM="cv"; else STEM="cv-{{target}}"; fi
    cd resume
    xelatex -interaction=nonstopmode -halt-on-error -output-directory build "build/$STEM.tex" \
        || { echo "--- xelatex failed (pass 1), tail of $STEM.log ---"; tail -60 "build/$STEM.log"; exit 1; }
    xelatex -interaction=nonstopmode -halt-on-error -output-directory build "build/$STEM.tex" \
        || { echo "--- xelatex failed (pass 2), tail of $STEM.log ---"; tail -60 "build/$STEM.log"; exit 1; }
    mkdir -p ../public/pdfs
    cp "build/$STEM.pdf" "../public/pdfs/$STEM.pdf"
    echo "built public/pdfs/$STEM.pdf"

# Build the default resume + CV PDFs (no target variants).
pdfs: resume cv

# --- Web -------------------------------------------------------------------

web:
    npm run build

# Build everything: web first, then default PDFs.
build: web pdfs

dev:
    npm run dev

# --- Misc ------------------------------------------------------------------

clips:
    node scripts/video-clips.mjs

clean:
    rm -rf dist .astro
