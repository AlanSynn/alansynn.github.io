---
title: "MotionSmith — A Sketch-Based Design System for Automata Making"
period: "2026"
org: "Georgia Tech · UC Santa Barbara"
category: "research"
order: 10
summary: "A sketch-based computational design system for automata making, developed through participatory design with three expert makers. Sketch a motion, compare generated mechanisms, refine, and export fabrication-ready automata."
image: "/images/motionsmith/motionsmith-teaser.webp"
video: "/videos/motionsmith-demo.mp4"
links:
  - { label: "Paper (ACM DL)", url: "https://dl.acm.org/doi/10.1145/3772318.3791545" }
  - { label: "PDF", url: "/pdfs/motionsmith-chi-2026.pdf" }
  - { label: "Google Scholar", url: "https://scholar.google.com/citations?user=tAfkWYcAAAAJ" }
---

**CHI 2026 Full Paper** — *Proceedings of the 2026 CHI Conference on Human Factors in Computing Systems*, Barcelona, Spain · April 13–17, 2026.

![Three artist-designed automata shown as digital sketches above and fabricated artifacts below.](/images/motionsmith/motionsmith-teaser.webp)

## Built to connect creative intent, mechanism design, and fabrication

MotionSmith is a sketch-based design system for automata making, developed through participatory design with three expert makers. It helps users sketch a desired motion, explore generated mechanisms, refine a chosen design, and export fabrication-ready files.

Across a year-long design process, we found that makers needed tools that support creative intent, fluid iteration, and mechanically simple outcomes. The final workflow keeps users in control while bridging early motion ideas to working, fabricable mechanisms.

## Three stages keep the workflow easy to follow

MotionSmith moves from motion-path sketching to mechanism generation to fabrication export in one continuous pipeline.

![MotionSmith workflow from motion-path sketching to fabrication-ready export.](/images/motionsmith/motionsmith-workflow.webp)

1. **Identify a goal** — import a character, define the rig, sketch a motion path, and adjust pacing or smoothness.
2. **Generate mechanisms** — compare four-bar, cam-follower, and gear candidates, then refine the selected mechanism directly on canvas.
3. **Support fabrication** — export SVG or PDF blueprint packets that bridge the digital design to a physical automaton.

![MotionSmith desktop interface showing path editing, mechanism recommendations, and export tools.](/images/motionsmith/motionsmith-interface.webp)

## Three artist-led deployments

Each deployment spans the full handoff from MotionSmith authoring, to mechanism choice, to fabrication and the finished automaton.

![Lu Lyu's shy elephant process from MotionSmith authoring to fabrication and final automaton.](/images/motionsmith/motionsmith-case-lu.webp)

### Lu Lyu — Shy elephant

The piece evolved from a simpler leg lift into a quieter flower-holding gesture with a distinct shy rhythm. LL chose a four-bar linkage because it supported a clear raise-pause-settle rhythm. MotionSmith SVG output was extruded in Fusion 360, then combined with 3D-printed linkages, cardstock layers, and brass fasteners.

![Marc Horovitz's tin robot process from MotionSmith authoring to fabrication and final automaton.](/images/motionsmith/motionsmith-case-marc.webp)

### Marc Horovitz — Tin robot

![Tom Haney's cheering man process from MotionSmith authoring to fabrication and final automaton.](/images/motionsmith/motionsmith-case-tom.webp)

### Tom Haney — Cheering man

## Citation

```bibtex
@inproceedings{synn2026motionsmith,
  title     = {MotionSmith: A Sketch-Based Design System for Automata Making},
  author    = {Synn, DoangJoo (Alan) and Guo, Zhifan and Ha, Sehoon and Oh, HyunJoo},
  booktitle = {Proceedings of the 2026 CHI Conference on Human Factors in Computing Systems},
  year      = {2026},
  doi       = {10.1145/3772318.3791545}
}
```
