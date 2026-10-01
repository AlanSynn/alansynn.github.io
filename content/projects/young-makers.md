---
title: "MotionSmith for Young Makers: Participatory Design and Deployment of a Mechanical Movement Design System with STEM Educators"
category: "research"
paper: "synn2027youngmakers"
order: 1
hero_eyebrow: "In review"
# Hand-broken hero title lines — the mark carries the accent color.
# Title text = the paper title verbatim (main.tex), line-broken for the web.
title_mark: "MotionSmith"
title_lines:
  - { mark: "MotionSmith", rest: "for Young Makers:" }
  - { rest: "Participatory Design and Deployment of" }
  - { rest: "a Mechanical Movement Design System" }
  - { rest: "with STEM Educators" }
# Paper teaser caption, verbatim (main.tex teaser figure).
teaser_caption: "MotionSmith is a sketch-based computational design system for automata making, adapted for young makers through participatory design with STEM educators. From left to right: (A) educators co-design the system in a hybrid workshop; (B) a maker sketches an intended motion and MotionSmith synthesizes fabricable mechanism candidates; (C) educators deploy the refined system in middle-school classrooms where (D) young makers design and fabricate working automata."
# Compressed from the abstract (00-abstract.tex); expressions preserved.
summary: "A sketch-based mechanical CAD system originally developed with expert automata artists, reshaped by four K–8 STEM educators into a classroom-facing environment — through a three-phase participatory design workshop and classroom deployments led by three participating educators."
affiliations:
  - "Georgia Tech"
author_affil: [1, 1, 1, 1]
# Hero CTA chips: the live revised system. links[0] renders solid; non-anchor
# links open in a new tab (isInternalHref treats /ms as internal — see
# AcademicProject.astro). Code / Demo / BibTeX chips derive from papers.bib +
# the demo block.
links:
  - { label: "Try MotionSmith", url: "/ms" }
nav:
  - Overview
  - Demo
  - System
  - Results
  - Cases
  - Citation
overview_heading: "Reshaping an expert-oriented CAD tool into a classroom-facing environment."
# The workshop figures (paper figs 41/42) render as a two-up gallery with their
# verbatim captions; the heading override replaces the graphics default.
gallery_heading: "The co-design workshop"
gallery:
  columns: 2
  items:
    - src: "/images/young-makers/workshop-preparation.webp"
      alt: "A three-part figure comparing the original MotionSmith system with the configuration prepared for the educator participatory design workshops."
      label: "Starting configuration"
      wide: true
      caption: "Researcher-led workshop starting configuration before educator co-design. (A) Original MotionSmith supported a motion-first workflow. (B) We added a mechanism-first entry point so that motion-first and mechanism-first exploration could converge in a shared authoring space. (C) We matched the constrained digital design space to a reusable physical kit through a 15 × 15 grid, four gear sizes, and ten indexed linkage lengths. These elements were study starting conditions rather than educator-derived refinements."
    - src: "/images/young-makers/workshop-timeline.webp"
      alt: "A compact timetable with three equal-width phase columns: Days 1–2 (10 hours in person), Day 3 (5 hours in person), and a remote phase of approximately 5 hours."
      label: "Three-phase timetable"
      wide: true
      caption: "Three-phase timetable for the completed educator participatory-design workshop. Phase 1 (Days 1–2; 10 hours in person) asked educators to work as first-time users who explored MotionSmith, built automata, and documented breakdowns, questions, and redesign suggestions. Phase 2 (Day 3; 5 hours in person) shifted their perspective to classroom facilitators who mapped the student journey and designed instructional supports, coordination strategies, and assessment checkpoints. Phase 3 (remote; approximately 5 hours) asked educators to work as pedagogical designers who reviewed the revisions, proposed further refinements, and developed lesson plans and classroom-enactment criteria."
# Demo = a scripted screen recording of the live revised system at /ms.
demo:
  src: "/videos/young-makers-demo.mp4"
  poster: "/videos/young-makers-poster.webp"
  alt: "Screen recording of a guided MotionSmith walkthrough: picking the Make a hand wave starter, exploring the layered 2.5D character canvas, playing the hand-wave motion, examining the four-bar mechanism candidate and prompt panel, and viewing the build plan and assembly steps."
  intro: "A walkthrough of the revised system — classroom-oriented authoring workflows, a constrained reusable fabrication kit, and educator-facing scaffolds — recorded from the live deployment at alansynn.com/ms."
# System section mirrors the paper's §3 (baseline + tensions) → §5
# (considerations + revisions). The workflow figure is paper fig 31 with its
# verbatim caption; the stage panels carry the four consideration titles
# verbatim, each followed by its resulting revision (compressed).
system:
  heading: "Educator-informed design considerations and revisions"
  intro: "MotionSmith is a sketch-based computational design system originally developed through participatory design with expert automata artists. The original workflow supports makers through three main stages — identifying a motion goal, exploring mechanism candidates, and exporting fabrication-ready outputs — and was designed to be iterative rather than linear."
  workflow:
    src: "/images/young-makers/original-system.webp"
    alt: "A three-panel pipeline diagram showing the MotionSmith workflow from sketching a motion goal, through exploring parameterized mechanism candidates, to exporting fabrication-ready files, with bidirectional arrows indicating iteration between stages."
    caption: "Overview of the original MotionSmith workflow. Users (a) identify a motion goal by sketching a path on an articulated character rig, (b) explore computationally synthesized mechanism candidates across three families with approximate motion-match scores and edit their parameters, and (c) export fabrication-ready layered vectors for laser cutting, 3D printing, or hand-cutting. Arrows indicate that the workflow is iterative rather than linear."
  stages:
    - index: "01"
      title: "Sustaining Progress Across Entry, Interruption, and Recovery"
      text: "File-based saving and resumption; the workflow divided into smaller, recoverable stages; prepared examples and a workflow overview as recognizable starting points; localized recovery controls alongside the global reset; and a browser-based version for school-managed devices."
    - index: "02"
      title: "Making Mechanism and Assembly Relationships Spatially Legible"
      text: "A layered 2.5D visualization that spatially separated overlapping components, fixed joints differentiated from moving connections, and a stacked assembly view showing component order, connection locations, and required spacing before physical construction."
    - index: "03"
      title: "Aligning Digital Designs with Reusable Classroom Materials"
      text: "Cut-to-length linkages replaced with reusable plywood linkages in standardized lengths, a shared size and labeling scheme across the software, fabrication files, and physical kit, and printable parts condensed into a one- or two-page packet."
    - index: "04"
      title: "Supporting Educator-Configured Explanation and Activity"
      text: "Real-world application examples linked to curated online videos, and an on-demand prompt panel from which educators select questions aligned with their instructional goals — asking students to predict, compare, explain, or diagnose."
  zoom:
    src: "/images/young-makers/ms-canvas.webp"
    alt: "The revised MotionSmith Mechanism Foundry: a four-bar linkage candidate playing on the layered canvas beside the prompt panel, stack readout, rig-opacity and explode sliders, and kit-compatible link-hole parameters."
    caption: "The revised system, live at alansynn.com/ms — a four-bar candidate in the Mechanism Foundry with the on-demand prompt panel and kit-compatible link-hole parameters (3-, 9-, 5-hole)."
  interface:
    heading: "The revisions, in the live system"
    copy: "The simulation canvas uses a layered 2.5D visualization that spatially separates overlapping components, fixed joints are differentiated from moving connections, and a stacked assembly view joins the fabrication instructions. An on-demand prompt panel lets educators select questions aligned with their instructional goals."
# The deployment study under its own name (§6). stat values are the paper's.
results_heading: "Classroom enactment"
stat_callouts:
  - { value: "4", label: "K–8 STEM educators in the three-phase hybrid participatory design workshop" }
  - { value: "3", label: "middle-school classroom deployments led by participating educators" }
  - { value: "~20 h", label: "of co-design across three phases, in-person and remote" }
  - { value: "40–80 min", label: "class periods the activities were designed to span" }
# The deployment table as the paper has it (§6, Table: columns and rows
# verbatim; per-cell line breaks become "·").
results:
  caption: "Overview of the three classroom deployments and representative evidence."
  note: "Approximately 80 students participated across T3's and T4's separate School A classes in total. Case identifiers follow the paper (T1–T4; Schools A and B)."
  columns: ["Case", "Local activity configuration", "Representative enactment evidence", "Operational context"]
  rows:
    - {
        cells:
          [
            "T1 · Grade 6 STEAM · 3 sessions; ~200 · 38 focal",
            "Imagine Yourself as a Scientist; “computer scientists” and “graphic designers”",
            "Differentiated roles across simulation, character design, and construction; projects resumed across sessions",
            "Saved/reopened projects; group boxes; 16 reusable kits + spares; district access approval",
          ],
      }
    - {
        cells:
          [
            "T3 · Grade 8 STEM · 3 sessions · 24 focal",
            "Open exploration across character motion, mechanisms, and fabrication",
            "Groups chose their own designs and progressed through the digital-to-physical workflow",
            "Work continued across sessions; shared kits; School A IT approval",
          ],
      }
    - {
        cells:
          [
            "T4 · Grade 8 STEM · 4 sessions · 26 focal",
            "10–15 min Exploration Challenge; screenshot + reflection",
            "Copilot-supported troubleshooting; question about changing the physical assembly from the blueprint",
            "Group-box storage; component reuse; School A managed devices",
          ],
      }
# §6.3 accounts, verbatim where quoted. Case images are the paper's own teaser
# panels (C/D crops) and the live prompt panel; captions describe the images
# honestly rather than asserting a specific classroom match.
cases_heading: "Educator-led classroom enactments"
cases_intro: "The refined criteria focused on evidence of students' design processes through reflection, goal-linked revision, documentation, sharing, and transfer — T2 stated that “effective iteration is more than making changes.” Three of the educators then enacted the configuration in their own middle-school classrooms."
cases:
  - tab: "T1 · Grade 6 STEAM"
    subtitle: "School B · 3 sessions"
    image: "/images/young-makers/classroom-session.webp"
    alt: "Middle-school students working in MotionSmith on desktop computers during a classroom deployment."
    caption: "Students working in MotionSmith during a classroom deployment (paper teaser, panel C)."
    lede: "At School B, T1 connected MotionSmith to his existing Imagine Yourself as a Scientist activity, in which students designed a character and its movement before moving toward physical construction."
    facts:
      - {
          label: "Differentiated roles",
          text: "“We split the class into roles, computer scientists and graphic designers.” Students working at the computer concentrated on simulation and motion design, while other group members worked on character design, decoration, and construction.",
        }
      - {
          label: "Continuity across sessions",
          text: "Groups reopened saved MotionSmith projects during later periods and stored unfinished physical work together in group boxes; reusable mechanism components were returned to the shared kits after completion.",
        }
      - {
          label: "Scale",
          text: "Approximately 200 students participated across T1's classes using 16 kits plus spare components.",
        }
  - tab: "T3 · Grade 8 STEM"
    subtitle: "School A · 3 sessions"
    image: "/images/young-makers/student-automaton.webp"
    alt: "Students assembling a fabricated automaton from plywood gears and linkages on a pegboard."
    caption: "Assembling fabricated automata from the reusable kit (paper teaser, panel D)."
    lede: "At School A, T3 used MotionSmith as a largely open exploration, allowing groups to choose what they wanted to make and to explore character motion and mechanisms without assigning a single target design."
    facts:
      - {
          label: "Open exploration",
          text: "Groups chose their own designs and progressed through the digital-to-physical workflow — from digital character and motion design through mechanism exploration and into physical construction.",
        }
      - {
          label: "Pace",
          text: "Groups progressed at different rates, and unfinished work continued during subsequent periods.",
        }
      - {
          label: "Operational context",
          text: "Work continued across sessions; shared kits; School A IT approval.",
        }
  - tab: "T4 · Grade 8 STEM"
    subtitle: "School A · 4 sessions"
    image: "/images/young-makers/ms-prompts.webp"
    alt: "The revised system's prompt panel: an educator-configurable question with Try, Look, and Hint supports, above the stack readout and kit-compatible link-hole parameters."
    caption: "The revised system's on-demand prompt panel (alansynn.com/ms) — educators select questions aligned with their instructional goals."
    lede: "T4 framed part of his School A deployment through a teacher-created Exploration Challenge, instructing students that their task was “not to master it” but to “experiment, notice what changes,” documented through a screenshot and brief reflection."
    facts:
      - {
          label: "Copilot-supported troubleshooting",
          text: "One student encountering a technical problem consulted the school's supported Copilot service; T4 asked the student how the returned information could be applied to the problem and prompted the student to identify a possible next step.",
        }
      - {
          label: "A question from the blueprint",
          text: "At least two groups had begun building when one student asked whether the assembly could be “different from [the] blueprint.” The available note does not record whether the group subsequently changed the assembly or mechanism.",
        }
      - {
          label: "Operational context",
          text: "Group-box storage; component reuse; School A managed devices.",
        }
citation_heading: "Cite this work."
citation_intro: "The paper is under review; the BibTeX below reflects its current public citation — venue and DOI follow acceptance."
acknowledgments: "With thanks to the four educators who co-designed, critiqued, and carried this work into their classrooms, and to the two schools that opened their doors."
---

Interactive systems developed for expert makers can be difficult to bring into
classrooms, where successful use depends not only on the interface, but also on
materials, facilitation, and curricular goals. We investigate this challenge
through MotionSmith, a sketch-based mechanical CAD system for designing automata
that was originally developed with expert automata artists. We conducted a
three-phase hybrid participatory design workshop with four K-8 STEM educators,
who engaged with MotionSmith as first-time users, instructional facilitators,
and pedagogical designers. Their participation reframed the design problem from
supporting individual mechanical authoring to supporting classroom activity
across digital design, physical fabrication, and educator facilitation. Based on
this collaboration, we revised MotionSmith with classroom-oriented authoring
workflows, a constrained reusable fabrication kit, and educator-facing
scaffolds, while educators developed activities and learning goals around
computational mechanical design. We then examined the educator-informed system
through middle-school classroom deployments led by three participating
educators. These deployments surfaced how students moved between intended
motion, computational mechanisms, and physical assemblies, as well as where
fabrication and sensemaking still required educator support.

Less is known about how educators can reshape an expert-oriented mechanical CAD
system into a classroom-facing environment that supports novice sensemaking,
material preparation, facilitation, and curricular integration. Before the
educator collaboration, the research team prepared three adaptations for
classroom-oriented exploration: a dual-path workflow supporting both
motion-first and mechanism-first design, interactive mathematical explanations,
and a grid-constrained software environment paired with a reusable physical
fabrication kit — starting points for the collaboration rather than outcomes of
it. The team also identified three assumptions that might become consequential
in classrooms, concerning the formulation of motion goals, the interpretation of
computational information, and the transition from digital design to physical
construction; these were researcher-generated starting points that educators
could examine, challenge, and extend through hands-on use.

The research asks how STEM educators identify and reshape the system, material,
and facilitation conditions needed to adapt an expert-oriented mechanical CAD
tool for classroom use; how they translate computational mechanism design into
classroom activities, supports, and learning goals; and how the educator-informed
system is enacted in middle-school classrooms — what supports and breakdowns
emerge as students design and fabricate automata. Together, the findings show
how educators can reshape an expert-oriented CAD tool into a classroom-facing
environment and identify broader considerations for educational CAD systems
whose use depends on coordinating computation, materials, facilitation, and
curricular integration.

Several limitations bound these findings: the co-design cohort was a single
group of four STEM educators, the classroom deployment involved three of them at
two schools, accounts of student experience are observation-, artifact-, and
teacher-reported rather than drawn from student interviews, and the
transformation was developed for automata specifically. The paper's conclusion:
"The broader implication for educational fabrication tools is that they must
ship as kits, scaffolds, and curricula rather than as software alone, and that
bringing educators into the design of such tools, as both co-designers and
classroom implementers, is what made a classroom-facing system legible in this
study."
