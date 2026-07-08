---
# ──────────────────────────────────────────────────────────────────────────
# TEMPLATE / EXAMPLE PAGE — unlisted (built + reachable by direct URL, but
# excluded from the sitemap + any listing, and emits <meta robots noindex>).
# Exercises every feature of the academic project-page system so it doubles as
# living documentation. (One exception: `title_lines` — hand-broken multi-line
# title — is shown in motionsmith.md; this template uses `title_mark`, the two
# being alternative title treatments.) Every asset below is branded placeholder
# filler under public/images/example/ (clearly not real results). Copy this file, swap the
# `paper:` citekey, drop the fields you don't need, and replace the SVGs.
# Linked paper content/papers.bib#synn2026neuralcaustic is itself a fictional
# `demo={true}` entry (filtered out of the homepage + CV) so this template
# round-trips the full pipeline without leaking into real publications.
#
# Field guide: bibliographic facts (title / authors / venue / DOI / PDF / code /
# video / abstract / BibTeX) all DERIVE from the `paper:` citekey via
# content/papers.bib — never re-state them here. The fields below are
# PRESENTATION only: they shape how the derived facts are laid out. Every field
# is optional (drop the ones you don't want → that section hides). Block
# comments below mark each section the body renders.
# ──────────────────────────────────────────────────────────────────────────
title: "NeuralCaustic: Inverse Caustic Design with Differentiable Optics"
category: "research"
paper: "synn2026neuralcaustic"
order: 99
unlisted: true

# --- Hero (title / authors / venue / link-chips / teaser) -------------------
# hero_eyebrow: venue pill above the title (defaults to "<abbr> <year>" if unset).
# title_mark:   title PREFIX rendered in the accent color (the rest muted); omit
#               for a uniform title. Use the hand-broken `title_lines` instead for
#               multi-line control (not used here).
# summary:      one-line thesis under the title (the "what + why" in a breath).
# event_dates:  appended to the venue line as "venue / <event_dates>".
# teaser_caption: <figcaption> under the hero teaser image (paper.preview).
hero_eyebrow: "SIGGRAPH 2026 (Template)"
title_mark: "NeuralCaustic:"
teaser_caption: "Given a target light pattern (left), NeuralCaustic recovers the refracting surface that focuses it into the intended caustic (right). Placeholder art."
summary: "Specify a target light pattern and recover the lens geometry that focuses it — in seconds, with measurably lower error than optimization baselines."
event_dates: "August 9–13, 2026"

# Author affiliation superscripts + legend. `affiliations` is the numbered
# legend (1-based); `author_affil` is the per-author index INTO that list, in
# author order. Its length MUST equal the paper's author count (enforced at
# build — AcademicProject throws if they differ), since each author gets one
# superscript. Drop both fields to render authors with no superscripts.
affiliations:
  - "Georgia Tech"
  - "ETH Zürich"
author_affil: [1, 2, 1]

# --- Overview ---------------------------------------------------------------
# overview_heading: the section <h2> (defaults to "Overview"). `takeaways` is the
# 3-up highlight grid BELOW the overview body prose — each { title, text } is a card.
overview_heading: "Invert the caustic, keep the surface fabricable."
takeaways:
  - title: "Differentiable ray tracing drives the inversion."
    text: "A differentiable tracer propagates target-image gradients back to surface geometry, letting a single optimize step replace hours of trial-and-error search."
  - title: "A neural radiance prior keeps surfaces fabricable."
    text: "The prior regularizes recovered geometry toward smooth, manufacturable surfaces while preserving fine caustic detail under real illumination."
  - title: "Recovered surfaces reproduce under real light."
    text: "Printed lenses focus physical light into the intended patterns with lower measured error than optimization baselines across a 24-image gallery."

# --- Sticky section nav -----------------------------------------------------
# Labels for the sticky scroll-spy nav (header-right). Order = render order top-
# to-bottom; each label must match a section the body emits, or its nav entry
# won't highlight. Drop `nav` to hide the sticky nav entirely.
nav:
  - Overview
  - Demo
  - System
  - Formulation
  - Results
  - Comparison
  - Gallery
  - Cases
  - FAQ
  - Citation

# --- Demo (click-to-launch video) -------------------------------------------
# Poster shown until click; `src` swaps in on click (saves the heavy load until
# the reader asks). `intro` is the paragraph above the player.
demo:
  src: "/videos/motionsmith-demo.mp4"
  poster: "/images/example/demo-poster.svg"
  alt: "NeuralCaustic pipeline walkthrough — target image to recovered lens to projected caustic. Placeholder footage."
  intro: "A walkthrough of the NeuralCaustic pipeline — from a target light pattern through surface recovery to the projected caustic. (Placeholder footage in the template.)"

# --- System (workflow figure + pipeline + zoom interface) -------------------
# `intro` prose, a `workflow` figure, numbered `stages` (the pipeline cards —
# `index` is the big marker, e.g. "01"), and a `zoom` magnifier image (hover to
# inspect on hover-capable devices; hidden on touch). `interface` is an optional
# paired heading + copy block under the zoom.
system:
  heading: "Differentiable tracing plus a neural prior, end to end."
  intro: "NeuralCaustic pairs a differentiable ray tracer with a neural radiance prior. A designer specifies a target light pattern; the tracer inverts it to candidate surface geometry; the prior regularizes the surface toward something smooth and fabricable; the result is exported as a printable mesh."
  workflow:
    src: "/images/example/workflow.svg"
    alt: "NeuralCaustic system workflow — target image, differentiable tracing, neural regularization, fabricable mesh. Placeholder diagram."
  stages:
    - index: "01"
      title: "Specify a target"
      text: "Import or draw the desired caustic pattern; the target becomes the loss the tracer inverts against."
    - index: "02"
      title: "Recover the surface"
      text: "A differentiable ray tracer backpropagates image error into lens geometry while a neural prior keeps the surface smooth."
    - index: "03"
      title: "Fabricate the lens"
      text: "Export the recovered surface as a printable mesh and verify the projected caustic under real illumination."
  zoom:
    src: "/images/example/interface.svg"
    alt: "NeuralCaustic interface — target pattern next to the recovered lens mesh. Placeholder art."
    caption: "The interface shows the target pattern beside the recovered lens; hover the lens to inspect surface detail. Placeholder art."
  interface:
    heading: "One workspace for target, recovery, and fabrication preview."
    copy: "The application keeps target editing, surface recovery, mesh regularization, and printable export in one place, so the move from a light pattern to a fabricable lens stays continuous."

# --- AI/ML method blocks (Formulation + Algorithm + Code sections) ----------
# Numbered equation figures. `mathml` renders natively (no KaTeX dep); `latex`
# is a plain-text fallback. Auto-numbered (1), (2), …
equations:
  - label: "Inverse-design objective (data term + fabricability prior)"
    mathml: |
      <math display="block">
        <mi>L</mi><mo>(</mo><mi>θ</mi><mo>)</mo>
        <mo>=</mo>
        <msub><mi mathvariant="double-struck">E</mi><mrow><mi>x</mi><mo>~</mo><mi>p</mi><mo>(</mo><mi>x</mi><mo>)</mo></mrow></msub>
        <mo>[</mo>
        <msup><mrow><mo>‖</mo><msub><mi>R</mi><mi>θ</mi></msub><mo>(</mo><mi>x</mi><mo>)</mo><mo>−</mo><mi>T</mi><mo>(</mo><mi>x</mi><mo>)</mo><mo>‖</mo></mrow><mn>2</mn></msup>
        <mo>]</mo>
        <mo>+</mo><mi>λ</mi><mi mathvariant="double-struck">Ω</mi><mo>(</mo><msub><mi>R</mi><mi>θ</mi></msub><mo>)</mo>
      </math>
  - label: "Edge-preserving smoothness prior (keeps surfaces printable)"
    latex: "Ω(R_θ) = Σᵢ Δ²h / (1 + Δ²h)    — penalizes roughness while preserving sharp caustic detail"
# Pseudocode / algorithm box. `lines` carry `code` + optional `comment`.
algorithm:
  caption: "Algorithm 1 — NeuralCaustic surface recovery"
  lines:
    - { code: "Input:  target image T, prior weight λ", comment: "fabricability ↔ fidelity knob" }
    - { code: "Initialize surface S₀ ← flat lens" }
    - { code: "for k = 1 … K do" }
    - { code: "    rays ← differentiably-trace(Sₖ, light)" }
    - { code: "    g ← ∇_S ‖project(rays) − T‖² + λ · Ω(Sₖ)" }
    - { code: "    Sₖ₊₁ ← Sₖ − η · g" }
    - { code: "until ‖g‖ < ε" }
    - { code: "return mesh(S_K)", comment: "export printable STL" }
# Code block with filename + copy. Plain mono (Shiki highlights only markdown
# fences, not frontmatter strings) — kept first-party on purpose.
code:
  filename: "recover.py"
  language: "python"
  source: |
    import torch
    from neuralcaustic import DifferentiableTracer, NeuralPrior

    tracer = DifferentiableTracer(resolution=512)
    prior = NeuralPrior(smoothness=0.8)

    def recover(target: torch.Tensor, steps: int = 200):
        # surface height field; gradients flow through the tracer.
        surface = torch.zeros(1, 512, 512, requires_grad=True)
        opt = torch.optim.Adam([surface], lr=1e-2)
        for _ in range(steps):
            caustic = tracer.render(surface)
            loss = ((caustic - target) ** 2).mean() + prior(surface)
            opt.zero_grad(); loss.backward(); opt.step()
        return prior.to_mesh(surface.detach())

# --- Comparison slider (ours-vs-theirs / before-after) ----------------------
# The graphics money shot: a draggable handle splits `before` / `after`. Each
# side is { src, alt }; `label_before` / `label_after` tag the handles. Drop the
# whole `comparisons` list to omit the slider.
comparisons:
  - before:
      src: "/images/example/comp-input.svg"
      alt: "Target caustic pattern (input). Placeholder art."
    after:
      src: "/images/example/comp-ours.svg"
      alt: "Caustic produced by the recovered NeuralCaustic surface. Placeholder art."
    label_before: "Target"
    label_after: "Ours"
    caption: "Drag to compare the target light pattern with the caustic produced by the recovered surface. Placeholder art."

# Big-number stat callouts (grid at the top of the Results section).
stat_callouts:
  - { value: "4.2 s", label: "avg. recovery time (vs 184 s optimization baseline)" }
  - { value: "+6.4 dB", label: "PSNR lift over the optimization baseline" }
  - { value: "24 / 24", label: "gallery targets reproduced under real light" }
  - { value: "25 µm", label: "SLA print layer height, optical face clean" }

# --- Quantitative results table ---------------------------------------------
# `columns` header the table; each `row.cells` is one method (same column order).
# `highlight: true` bolds a row (mark "Ours"). `caption`/`note` frame the table.
# Arrows in column headers are a convention to signal metric direction.
results:
  caption: "Quantitative results on the 24-image gallery. Higher PSNR and lower LPIPS are better; Ours is highlighted."
  note: "Baseline times are single-threaded on an M2 Pro. ± values are std. dev. over five seeds. Numbers are fictional placeholder data."
  columns: ["Method", "PSNR ↑", "LPIPS ↓", "Time (s) ↓"]
  rows:
    - { cells: ["Optimization baseline", 21.4, 0.182, 184.0] }
    - { cells: ["Optimization + prior", 23.1, 0.141, 167.5] }
    - { cells: ["NeuralCaustic (ours)", 27.8, 0.087, 4.2], highlight: true }

# --- Ablation table ---------------------------------------------------------
# Same shape as `results` (columns/rows/highlight/caption) — isolate each
# component to show it earns its keep. Rendered as a second table under Results.
ablation:
  caption: "Ablation isolating each component. Removing the prior hurts smoothness; removing the differentiable tracer hurts fidelity."
  columns: ["Variant", "PSNR ↑", "LPIPS ↓"]
  rows:
    - { cells: ["No neural prior", 24.9, 0.121] }
    - { cells: ["Non-differentiable tracer", 22.6, 0.158] }
    - { cells: ["Full model", 27.8, 0.087], highlight: true }

# --- Results gallery --------------------------------------------------------
# Multi-image grid; `columns` sets the column count. Each item is
# { src, alt, caption, label } — `label` is the small tag on the tile.
gallery:
  columns: 3
  items:
    - { src: "/images/example/gallery-1.svg", alt: "Recovered caustic — spiral. Placeholder art.", caption: "Spiral target, recovered in 3.8 s.", label: "spiral" }
    - { src: "/images/example/gallery-2.svg", alt: "Recovered caustic — leaf. Placeholder art.", caption: "Leaf target, fine venation preserved.", label: "leaf" }
    - { src: "/images/example/gallery-3.svg", alt: "Recovered caustic — wave. Placeholder art.", caption: "Wave target, smooth leading edge.", label: "wave" }
    - { src: "/images/example/gallery-4.svg", alt: "Recovered caustic — grid. Placeholder art.", caption: "Grid target, sharp intersections.", label: "grid" }
    - { src: "/images/example/gallery-5.svg", alt: "Recovered caustic — bloom. Placeholder art.", caption: "Bloom target, radial symmetry.", label: "bloom" }
    - { src: "/images/example/gallery-6.svg", alt: "Recovered caustic — echo. Placeholder art.", caption: "Echo target, nested rings.", label: "echo" }

# --- Synced video comparison ------------------------------------------------
# Side-by-side players; scrubbing one seeks the other (the synced "play head").
# `left`/`right` are { src, poster, label }. Drop to omit.
video_comparison:
  left:
    src: "/videos/motionsmith-demo.mp4"
    poster: "/images/example/video-left.svg"
    label: "Baseline"
  right:
    src: "/videos/motionsmith-demo.mp4"
    poster: "/images/example/video-right.svg"
    label: "Ours"
  caption: "Side-by-side synced playback — scrub one and the other follows. (Placeholder footage stands in for both sides in the template.)"

# --- Cases (tabbed carousel) ------------------------------------------------
# `cases_heading`/`cases_intro` open the section; each `cases[].tab` is a
# carousel tab. A tab carries an `image` + `alt` + `caption`, a `subtitle`, a
# `lede`, and a `facts` list ({ label, text } key/value rows). Keyboard-accessible.
cases_heading: "Two stress-test targets show where each component earns its keep."
cases_intro: "Each case runs the full pipeline from a target image through surface recovery to a printed lens verified under real illumination."
cases:
  - tab: "Spiral lens"
    subtitle: "Spiral / Differentiable tracer"
    image: "/images/example/gallery-1.svg"
    alt: "Spiral caustic case — target, recovered lens, projected result. Placeholder art."
    caption: "Target, recovered surface, and projected caustic for the spiral case. Placeholder art."
    lede: "A spiral target stress-tests the tracer's ability to reproduce continuous curvature."
    facts:
      - {
          label: "Mechanism",
          text: "A single smooth aspheric surface recovers the spiral within one optimize step.",
        }
      - {
          label: "Fabrication",
          text: "The mesh prints on a resin SLA printer at 25 µm layer height with no support scarring on the optical face.",
        }
      - {
          label: "Why it matters",
          text: "Continuous targets validate that the prior does not over-smooth gentle curvature.",
        }
  - tab: "Grid lens"
    subtitle: "Grid / Neural prior"
    image: "/images/example/gallery-4.svg"
    alt: "Grid caustic case — target, recovered lens, projected result. Placeholder art."
    caption: "Target, recovered surface, and projected caustic for the grid case. Placeholder art."
    lede: "A grid target isolates the neural prior's contribution to sharp-feature fidelity."
    facts:
      - {
          label: "Mechanism",
          text: "Sharp intersections require the prior to preserve high-frequency detail without ringing.",
        }
      - {
          label: "Fabrication",
          text: "Grid lenses are cast in clear resin and polished flat before illumination testing.",
        }
      - {
          label: "Why it matters",
          text: "Discrete targets confirm the prior regularizes geometry, not image sharpness.",
        }

# --- Citation ---------------------------------------------------------------
# `citation_heading`/`citation_intro` open the section. The visible BibTeX +
# copy button DERIVE from the `paper:` bib entry (not restated here); the
# abstract feeds the document <head> (scholar meta + description), not this block.
citation_heading: "Read the paper and cite NeuralCaustic."
citation_intro: "The full paper is available as a local PDF. The DOI and BibTeX are included below for quick reference."
# FAQ accordion (native <details> — no JS). Closing-section convention.
faq:
  - q: "Does this need a GPU?"
    a: "Recovery runs on a single laptop GPU in seconds; the differentiable tracer is the bottleneck, not the prior."
  - q: "Can I fabricate the recovered lenses myself?"
    a: "Yes — export the recovered mesh as STL and print on a resin SLA printer at 25 µm. Polish the optical face flat before illumination testing."
  - q: "Which targets fail?"
    a: "Discrete high-contrast targets with sharp intersections ring slightly; the ablation shows the prior trades a hair of sharpness for fabricability."
  - q: "Is the code released?"
    a: "The reference snippet above is illustrative; the full repository accompanies the camera-ready release."
# Acknowledgments prose (quiet closing section, rendered after Citation).
acknowledgments: "Thanks to the fabrication lab for SLA print time, and to the reviewers for the ablation suggestion that isolated the prior's contribution."
---

> **This is a template page.** It renders every feature of the project-page
> system — hero with affiliation superscripts, summary, sticky scroll-spy nav,
> overview + takeaways, click-to-launch demo, system pipeline + zoom magnifier,
> numbered equations, pseudocode algorithm, copy-able code block, stat callouts,
> results + ablation tables, comparison slider, results gallery, synced video
> comparison, tabbed cases, FAQ accordion, a derived citation block, and
> acknowledgments. All figures are branded placeholder art under
> `public/images/example/`; the linked paper is a fictional `demo={true}` entry.
> Copy this file as the starting point for a real project page.

NeuralCaustic inverts the caustic-design problem: rather than search for a
surface that *might* focus light into a desired pattern, a differentiable ray
tracer propagates the target image's gradients directly back into lens geometry.
The result is a recovered surface that, once fabricated, focuses real light into
the intended caustic — produced in seconds instead of the hours of
trial-and-error optimization that earlier methods required.

The central difficulty is that many surfaces produce nearly identical caustics,
so raw inversion recovers geometry that focuses correctly in simulation but is
too rough to manufacture. A neural radiance prior regularizes the recovered
surface toward smooth, printable meshes while preserving the fine detail that
makes a caustic legible, letting designers move from a target image to a
fabricable lens without a manual cleanup pass.

Across a 24-image gallery spanning continuous and discrete targets, the
recovered surfaces reproduce the intended patterns under real-world illumination
with measurably lower error than optimization baselines — and the ablation
confirms that both the differentiable tracer and the prior are load-bearing,
with the tracer driving fidelity and the prior keeping the surface fabricable.
