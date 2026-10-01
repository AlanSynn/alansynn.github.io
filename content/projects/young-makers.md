---
title: "MotionSmith for Young Makers: Educator Co-Design and Enactment of a Mechanical CAD System"
category: "research"
paper: "synn2027youngmakers"
order: 1
hero_eyebrow: "In review"
title_mark: "MotionSmith for Young Makers:"
# Hand-broken hero title lines — the mark carries the accent color.
title_lines:
  - { mark: "MotionSmith for Young Makers:", rest: "Educator Co-Design" }
  - { rest: "and Enactment of a" }
  - { rest: "Mechanical CAD System" }
teaser_caption: "From co-design with educators (A) through the revised system (B) to classroom deployment (C–D), where young makers design and fabricate working automata."
summary: "A sketch-based mechanical CAD system adapted for K–8 classrooms through three-phase educator co-design — then enacted by three educators with 129 middle-school students."
affiliations:
  - "Georgia Tech"
author_affil: [1, 1, 1, 1]
overview_heading: "From expert studios to middle-school classrooms."
takeaways:
  - title: "Educators shaped every revision."
    text: "Four K–8 STEM educators worked as novice makers, classroom facilitators, and pedagogical designers — each perspective fed concrete changes to the system, the kit, and its supports."
  - title: "The tool changed for classroom reality."
    text: "Guided entry, save-and-resume projects, a layered 2.5D canvas, a labeled reusable kit, and educator-configured prompts answer the constraints of real class periods."
  - title: "The result ran in real classrooms."
    text: "Three educators enacted the configuration with 129 middle-school students at two schools, resuming digital and physical work across sessions."
nav:
  - Overview
  - System
  - Results
  - Cases
  - Citation
system:
  heading: "The same pipeline, reconfigured for classroom life."
  intro: "Educator feedback reshaped the workflow around 40–80-minute periods, shared reusable kits, and school-managed devices: guided entry, save-and-resume projects, a layered 2.5D canvas, labeled fabrication output, and educator-configured prompts."
  workflow:
    src: "/images/young-makers/classroom-workflow.webp"
    alt: "Six-stage classroom workflow — guided entry, author, understand, prepare, build, and test-and-revise — pairing each digital stage with the physical kit."
    caption: "The classroom-facing workflow pairs every digital stage with the reusable kit and the educator's facilitation layer."
  stages:
    - index: "01"
      title: "Enter with a project"
      text: "Prepared motion tasks and examples give students a recognizable starting point — motion-first or mechanism-first — with nothing to install on school devices."
    - index: "02"
      title: "Design and understand"
      text: "Students shape motion and mechanism side by side, with a layered 2.5D view and interactive explanations connecting each edit to the movement it produces."
    - index: "03"
      title: "Build, test, revise"
      text: "Labeled plywood kits, stacked assembly views, and on-demand prompts carry designs into physical builds that survive across class periods."
# The deployment study, under its own name (results_heading) instead of
# "Quantitative results" — an HCI enactment study, not a benchmark.
results_heading: "Classroom enactment"
stat_callouts:
  - { value: "4", label: "K–8 STEM educators in the three-phase co-design workshop" }
  - { value: "129", label: "middle-school students reached across the enactments" }
  - { value: "2", label: "schools hosting three educator-led deployments" }
  - { value: "~20 h", label: "of co-design across in-person and remote phases" }
results:
  caption: "Three educator-led deployments of the co-designed configuration."
  note: "Identifiers follow the paper's anonymization (T1–T4; Schools A and B). Approximately 80 students participated across T3's and T4's School A classes in total."
  columns: ["Case", "Context", "Sessions", "Students", "Activity configuration"]
  rows:
    - {
        cells:
          [
            "T1",
            "Grade 6 STEAM · School B",
            "3",
            "~200 (38 focal)",
            "Imagine Yourself as a Scientist — split roles: computer scientists and graphic designers",
          ],
      }
    - {
        cells:
          [
            "T3",
            "Grade 8 STEM · School A",
            "3",
            "24 focal",
            "Open exploration across character motion, mechanisms, and fabrication",
          ],
      }
    - {
        cells:
          [
            "T4",
            "Grade 8 STEM · School A",
            "4",
            "26 focal",
            "10–15-minute Exploration Challenge with screenshot + reflection",
          ],
      }
cases_heading: "From expert tool to classroom configuration."
cases_intro: "Three artifacts trace the adaptation: the original expert-oriented system, the researcher-led starting configuration, and the three-phase co-design timetable."
cases:
  - tab: "Original system"
    subtitle: "Expert-oriented / Motion-first"
    image: "/images/young-makers/original-system.webp"
    alt: "Original MotionSmith workflow — sketch a motion goal, explore synthesized mechanism candidates, export fabrication-ready layered vectors."
    caption: "The original workflow: (a) sketch a motion goal on an articulated rig, (b) explore candidates across three mechanism families, (c) export layered vectors."
    lede: "MotionSmith began as a studio tool for expert makers — the classroom work starts from what it already did well."
    facts:
      - {
          label: "Workflow",
          text: "Users sketch a motion path, explore computationally synthesized candidates with approximate motion-match scores, and edit parameters before export.",
        }
      - {
          label: "Export",
          text: "Fabrication-ready layered vectors support laser cutting, 3D printing, or hand-cutting — the workflow is iterative rather than linear.",
        }
      - {
          label: "Why it matters",
          text: "The expert-oriented strengths are the baseline the educator co-design adapts, not replaces.",
        }
  - tab: "Starting configuration"
    subtitle: "Workshop preparation / Researcher-led"
    image: "/images/young-makers/workshop-preparation.webp"
    alt: "Workshop starting configuration — dual-path entry converging in a shared authoring space, beside a matched digital-and-physical kit."
    caption: "(A) The original motion-first system, (B) the added mechanism-first entry point, (C) the digital design space matched to a reusable physical kit."
    lede: "Before educators arrived, two adaptations and a matched physical kit turned the expert tool into an object of critique."
    facts:
      - {
          label: "Dual-path entry",
          text: "A mechanism-first path joined the original motion-first pipeline, so users could start from parameterized mechanism families or from a character motion.",
        }
      - {
          label: "Matched kit",
          text: "A 15×15 pegboard grid, four plywood gear sizes, and ten indexed linkage lengths mirrored the software's constrained parameters one-to-one.",
        }
      - {
          label: "Starting conditions",
          text: "These were researcher-led starting points for critique, not educator-derived outcomes — the co-design shaped what came next.",
        }
  - tab: "Co-design phases"
    subtitle: "Three phases / ~20 hours"
    image: "/images/young-makers/workshop-timeline.webp"
    alt: "Three-phase timetable — experience as first-time users, reframe as classroom facilitators, review and co-design as pedagogical designers."
    caption: "Phase 1 (Days 1–2, 10 h), Phase 2 (Day 3, 5 h), and remote Phase 3 (~5 h), with the design response and outputs of each phase."
    lede: "Four educators moved through three complementary perspectives instead of holding fixed roles."
    facts:
      - {
          label: "Phase 1 — Experience",
          text: "Days 1–2, ten hours in person: educators built their own automata and documented breakdowns, questions, and redesign suggestions.",
        }
      - {
          label: "Phase 2 — Reframe",
          text: "Day 3, five hours: they mapped the student journey and designed instructional supports, coordination strategies, and assessment checkpoints.",
        }
      - {
          label: "Phase 3 — Co-design",
          text: "About five hours remote: they reviewed the revisions, proposed further refinements, and wrote lesson plans for their own classrooms.",
        }
citation_heading: "Cite this work."
citation_intro: "The paper is under review. The BibTeX below will be finalized with the venue and DOI upon acceptance."
acknowledgments: "With thanks to the four educators who co-designed, critiqued, and carried this work into their classrooms, and to the two schools that opened their doors."
---

MotionSmith began as a sketch-based design system for automata making, developed
with expert artists. Bringing it into classrooms is not a matter of simpler
buttons: novice learners, 40-to-80-minute periods, shared materials, and school
device policies all press on the same tool. This project examines that
adaptation through participatory design with the people who run the classroom —
K–8 STEM educators.

Four educators joined a three-phase co-design workshop: first experiencing the
system as novice makers, then reframing it as classroom facilitators, and
finally co-designing revisions as pedagogical designers. Their input produced
four design considerations — sustaining student progress across entry,
interruption, and recovery; making mechanism and assembly relationships
spatially legible; aligning digital designs with reusable classroom materials;
and supporting educator-configured explanation and activity — together with a
revised configuration of MotionSmith, a reusable fabrication kit, and
instructional supports.

Three of the educators then enacted the configuration in their own
middle-school classrooms, reaching 129 students across two schools. Educator
accounts and classroom observations document how the shared workflow held up:
educators guided purposeful revision, while project continuity required
preserving digital designs and unfinished physical builds across class periods.
