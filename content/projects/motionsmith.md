---
title: "MotionSmith: A Sketch-Based Design System for Automata Making"
category: "research"
paper: "synn2026motionsmith"
order: 0
hero_eyebrow: "CHI 2026 Full Paper"
title_mark: "MotionSmith:"
# Pixel-exact hero title line-breaks — 1:1 with the original microsite's
# hand-broken <h1>. Line 1 carries the bold mark; lines 2-3 are the muted rest.
title_lines:
  - { mark: "MotionSmith:", rest: "A Sketch-Based" }
  - { rest: "Design System" }
  - { rest: "for Automata Making" }
teaser_caption: "Three artist-led automata pair motion sketches with fabricated outcomes across four-bar and cam-driven mechanisms."
summary: "A sketch-based computational design system that helps automata makers express motion, compare mechanisms, refine designs, and export fabrication-ready parts."
event_dates: "April 13–17, 2026"
affiliations:
  - "Georgia Tech"
  - "UC Santa Barbara"
author_affil: [1, 2, 1, 1]
overview_heading: "Built to connect creative intent, mechanism design, and fabrication."
takeaways:
  - title: "Participatory design shaped the workflow."
    text: "Controls, pacing, and fabrication support were refined through long-term collaboration with expert makers."
  - title: "Three stages keep the tool readable."
    text: "The system moves from motion sketching to mechanism generation to export while keeping the intermediate steps visible."
  - title: "Three finished artifacts ground the contribution."
    text: "A shy elephant, a cheering man, and a tin robot demonstrate the expressive range of the workflow."
nav:
  - Overview
  - Demo
  - System
  - Cases
  - Citation
demo:
  src: "/videos/motionsmith-demo.mp4"
  poster: "/images/motionsmith/motionsmith-demo-poster.webp"
  alt: "MotionSmith workflow walkthrough, from motion sketch to fabricated automaton."
system:
  heading: "Three stages keep the workflow easy to follow."
  intro: "MotionSmith moves from motion-path sketching to mechanism generation to fabrication export in one continuous pipeline."
  workflow:
    src: "/images/motionsmith/motionsmith-workflow.webp"
    alt: "MotionSmith workflow from motion-path sketching to fabrication-ready export."
    caption: "The pipeline preserves a clear transition from sketch, to candidate mechanism, to fabrication-ready output."
  stages:
    - index: "01"
      title: "Identify a goal"
      text: "Import a character, define the rig, sketch a motion path, and adjust pacing or smoothness."
    - index: "02"
      title: "Generate mechanisms"
      text: "Compare four-bar, cam-follower, and gear candidates, then refine the selected mechanism directly on canvas."
    - index: "03"
      title: "Support fabrication"
      text: "Export SVG or PDF blueprint packets that bridge the digital design to a physical automaton."
  interface:
    heading: "One workspace for drawing, simulation, editing, and export."
    copy: "The application keeps authoring, mechanism comparison, parametric refinement, pacing review, and blueprint export in one place, so the workflow stays continuous as the design becomes more concrete."
  zoom:
    src: "/images/motionsmith/motionsmith-interface.webp"
    alt: "MotionSmith desktop interface showing path editing, mechanism recommendations, and export tools."
    caption: "Hover the interface to inspect path editing, mechanism recommendations, and export tools."
cases_heading: "Three artist-led deployments show how the system holds up in practice."
cases_intro: "Each deployment spans the full handoff from MotionSmith authoring, to mechanism choice, to fabrication and the finished automaton."
cases:
  - tab: "Lu Lyu"
    subtitle: "Shy elephant / Four-bar"
    image: "/images/motionsmith/motionsmith-case-lu.webp"
    alt: "Lu Lyu's shy elephant process from MotionSmith authoring to fabrication and final automaton."
    caption: "A-F shows authoring, four-bar refinement, printed parts, assembly, frame mounting, and the finished shy elephant."
    lede: "The piece evolved from a simpler leg lift into a quieter flower-holding gesture with a distinct shy rhythm."
    facts:
      - {
          label: "Mechanism",
          text: "LL chose a four-bar linkage because it supported a clear raise-pause-settle rhythm within the explored mechanism set.",
        }
      - {
          label: "Fabrication",
          text: "MotionSmith SVG output was extruded in Fusion 360, then combined with 3D-printed linkages, cardstock layers, and brass fasteners.",
        }
      - {
          label: "Why it matters",
          text: "The case shows how expressive intent and motion matching can be considered together during mechanism selection.",
        }
  - tab: "Tom Haney"
    subtitle: "Cheering man / Cams"
    image: "/images/motionsmith/motionsmith-case-tom.webp"
    alt: "Tom Haney's cheering man process from MotionSmith authoring to fabrication and final automaton."
    caption: "A-F shows authoring, cam selection, paper templates, wire linkages, frame assembly, and the finished cheering motion."
    lede: "This deployment turned iterative arm-raising sketches into a cleaner, more humorous cheering gesture."
    facts:
      - {
          label: "Mechanism",
          text: "TH selected cams because they created a clear apex accent and supported the intended cheering gesture within the explored mechanism set.",
        }
      - {
          label: "Fabrication",
          text: "MotionSmith blueprints became asymmetric paper cams, wire linkages, and wooden followers mounted in a synchronized frame.",
        }
      - {
          label: "Why it matters",
          text: "The case highlights how simplicity, visual clarity, and trajectory accuracy can be balanced together.",
        }
  - tab: "Marc Horovitz"
    subtitle: "Tin robot / Compound cam"
    image: "/images/motionsmith/motionsmith-case-marc.webp"
    alt: "Marc Horovitz's tin robot process from MotionSmith authoring to fabrication and final automaton."
    caption: "A-F shows authoring, cam generation, paper templates, limb preparation, backing-board assembly, and the final angel-like pose."
    lede: "The robot expanded from arm motion to a fuller angel-like gesture with coordinated arm and leg accents."
    facts:
      - {
          label: "Mechanism",
          text: "MH composed a compound cam using larger arm cams and smaller leg cams to balance presence, comprehensibility, and fabrication effort.",
        }
      - {
          label: "Fabrication",
          text: "Printed blueprint packets were used as cutting guides for paper and wood parts before assembly on a backing board.",
        }
      - {
          label: "Why it matters",
          text: "The case shows how MotionSmith can hand off most of the process even when multi-motion synthesis still needs manual completion.",
        }
citation_heading: "Read the paper and cite MotionSmith."
citation_intro: "The full paper is available as a local PDF. The DOI and BibTeX are included below for quick reference."
---

MotionSmith is a sketch-based design system for automata making, developed
through participatory design with three expert makers. It helps users sketch a
desired motion, explore generated mechanisms, refine a chosen design, and export
fabrication-ready files.

Across a year-long design process, we found that makers needed tools that
support creative intent, fluid iteration, and mechanically simple outcomes. The
final workflow keeps users in control while bridging early motion ideas to
working, fabricable mechanisms.
