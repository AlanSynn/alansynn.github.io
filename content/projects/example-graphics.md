---
# ──────────────────────────────────────────────────────────────────────────
# TEMPLATE / EXAMPLE PAGE — draft:true (dev-only, never published).
# Exercises EVERY feature of the academic project-page system so it doubles as
# living documentation. Every asset below is branded placeholder filler under
# public/images/example/ (clearly not real results). Copy this file, swap the
# `paper:` citekey, drop the fields you don't need, and replace the SVGs.
# Linked paper content/papers.bib#synn2026neuralcaustic is itself a fictional
# `demo={true}` entry (filtered out of the homepage + CV) so this template
# round-trips the full pipeline without leaking into real publications.
# ──────────────────────────────────────────────────────────────────────────
title: "NeuralCaustic: Inverse Caustic Design with Differentiable Optics"
category: "research"
paper: "synn2026neuralcaustic"
order: 99
draft: true
hero_eyebrow: "SIGGRAPH 2026 (Template)"
title_mark: "NeuralCaustic:"
teaser_caption: "Given a target light pattern (left), NeuralCaustic recovers the refracting surface that focuses it into the intended caustic (right). Placeholder art."
summary: "Specify a target light pattern and recover the lens geometry that focuses it — in seconds, with measurably lower error than optimization baselines."
event_dates: "August 9–13, 2026"
affiliations:
  - "Georgia Tech"
  - "ETH Zürich"
author_affil: [1, 2, 1]
overview_heading: "Invert the caustic, keep the surface fabricable."
takeaways:
  - title: "Differentiable ray tracing drives the inversion."
    text: "A differentiable tracer propagates target-image gradients back to surface geometry, letting a single optimize step replace hours of trial-and-error search."
  - title: "A neural radiance prior keeps surfaces fabricable."
    text: "The prior regularizes recovered geometry toward smooth, manufacturable surfaces while preserving fine caustic detail under real illumination."
  - title: "Recovered surfaces reproduce under real light."
    text: "Printed lenses focus physical light into the intended patterns with lower measured error than optimization baselines across a 24-image gallery."
nav:
  - Overview
  - Demo
  - System
  - Results
  - Comparison
  - Gallery
  - Cases
  - Citation
demo:
  src: "/videos/motionsmith-demo.mp4"
  poster: "/images/example/demo-poster.svg"
  alt: "NeuralCaustic pipeline walkthrough — target image to recovered lens to projected caustic. Placeholder footage."
  intro: "A walkthrough of the NeuralCaustic pipeline — from a target light pattern through surface recovery to the projected caustic. (Placeholder footage in the template.)"
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
results:
  caption: "Quantitative results on the 24-image gallery. Higher PSNR and lower LPIPS are better; Ours is highlighted."
  note: "Baseline times are single-threaded on an M2 Pro. ± values are std. dev. over five seeds. Numbers are fictional placeholder data."
  columns: ["Method", "PSNR ↑", "LPIPS ↓", "Time (s) ↓"]
  rows:
    - { cells: ["Optimization baseline", 21.4, 0.182, 184.0] }
    - { cells: ["Optimization + prior", 23.1, 0.141, 167.5] }
    - { cells: ["NeuralCaustic (ours)", 27.8, 0.087, 4.2], highlight: true }
ablation:
  caption: "Ablation isolating each component. Removing the prior hurts smoothness; removing the differentiable tracer hurts fidelity."
  columns: ["Variant", "PSNR ↑", "LPIPS ↓"]
  rows:
    - { cells: ["No neural prior", 24.9, 0.121] }
    - { cells: ["Non-differentiable tracer", 22.6, 0.158] }
    - { cells: ["Full model", 27.8, 0.087], highlight: true }
gallery:
  columns: 3
  items:
    - { src: "/images/example/gallery-1.svg", alt: "Recovered caustic — spiral. Placeholder art.", caption: "Spiral target, recovered in 3.8 s.", label: "spiral" }
    - { src: "/images/example/gallery-2.svg", alt: "Recovered caustic — leaf. Placeholder art.", caption: "Leaf target, fine venation preserved.", label: "leaf" }
    - { src: "/images/example/gallery-3.svg", alt: "Recovered caustic — wave. Placeholder art.", caption: "Wave target, smooth leading edge.", label: "wave" }
    - { src: "/images/example/gallery-4.svg", alt: "Recovered caustic — grid. Placeholder art.", caption: "Grid target, sharp intersections.", label: "grid" }
    - { src: "/images/example/gallery-5.svg", alt: "Recovered caustic — bloom. Placeholder art.", caption: "Bloom target, radial symmetry.", label: "bloom" }
    - { src: "/images/example/gallery-6.svg", alt: "Recovered caustic — echo. Placeholder art.", caption: "Echo target, nested rings.", label: "echo" }
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
citation_heading: "Read the paper and cite NeuralCaustic."
citation_intro: "The full paper is available as a local PDF. The DOI and BibTeX are included below for quick reference."
---

> **This is a template page.** It renders every feature of the project-page
> system — hero with affiliation superscripts, summary, sticky scroll-spy nav,
> overview + takeaways, click-to-launch demo, system pipeline + zoom magnifier,
> results + ablation tables, comparison slider, results gallery, synced video
> comparison, tabbed cases, and a derived citation block. All figures are
> branded placeholder art under `public/images/example/`; the linked paper is a
> fictional `demo={true}` entry. Copy this file as the starting point for a real
> project page.

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
