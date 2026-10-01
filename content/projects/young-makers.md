---
title: "MotionSmith for Young Makers: Educator Co-Design and Enactment of a Mechanical CAD System"
category: "research"
paper: "synn2027youngmakers"
order: 1
hero_eyebrow: "In review"
# Hand-broken hero title lines — the mark carries the accent color.
# Title text = the paper title verbatim (main.tex), line-broken for the web.
title_mark: "MotionSmith"
title_lines:
  - { mark: "MotionSmith", rest: "for Young Makers:" }
  - { rest: "Educator Co-Design and Enactment" }
  - { rest: "of a Mechanical CAD System" }
# Paper teaser caption, verbatim (main.tex teaser figure).
teaser_caption: "MotionSmith is a sketch-based computational design system for automata making, adapted for young makers through participatory design with STEM educators. From left to right: (A) educators co-design the system in a hybrid workshop; (B) the resulting system is redesigned around young makers, through a classroom-oriented authoring workflow, a reusable fabrication kit, and instructional supports, enabling a maker to sketch an intended motion and explore synthesized, fabricable mechanism candidates, and move from digital design toward physical construction; and (C) educators enact the refined system in middle-school classrooms, where young makers collaboratively design and construct automata."
# Compressed from the abstract (00-abstract.tex); expressions preserved.
summary: "A sketch-based system for automata making originally developed with expert artists, adapted for young makers through a three-phase participatory design study with four K–8 STEM educators — and enacted in middle-school classrooms by three of them with 129 students at two schools."
affiliations:
  - "Georgia Tech"
author_affil: [1, 1, 1]
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
overview_heading: "Bringing expert-oriented mechanical CAD into classrooms."
# The workshop figures (paper figs 3/4) render as a two-up gallery with their
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
      alt: "Three panels illustrating the educator co-design process, with an unnumbered research-team revision block between Panels B and C: Experience as first-time users (10 hours in person over Days 1–2), Reframe as classroom facilitators (5 hours in person on Day 3), and Review & co-design as pedagogical designers (approximately 5 hours remotely), the research-team block synthesizing revisions to the digital system, physical kit, and facilitation supports."
      label: "Three perspectives"
      wide: true
      caption: "Educator co-design across three perspectives. (A) Experience through use and fabrication as first-time users. (B) Reframe through planning as classroom facilitators. (C) Review & co-design as pedagogical designers, reviewing revisions, developing lesson plans, and commenting on draft classroom-enactment criteria. The dashed return arrow represents their further critique and proposed refinements. The unnumbered block between (B) and (C) represents a research-team synthesis of educator experiences and classroom requirements into revisions to the digital system, physical kit, and facilitation supports."
# Demo = a scripted screen recording of the live revised system at /ms.
demo:
  src: "/videos/young-makers-demo.mp4"
  poster: "/videos/young-makers-poster.webp"
  alt: "Screen recording of a guided MotionSmith walkthrough: picking the Make a hand wave starter, exploring the layered 2.5D character canvas, playing the hand-wave motion, examining the four-bar mechanism candidate and prompt panel, and viewing the build plan and assembly steps."
  intro: "A walkthrough of the revised system — the classroom-oriented authoring workflow, the reusable fabrication kit, and the instructional supports — recorded from the live deployment at alansynn.com/ms."
# System section mirrors the paper's §3 (baseline + tensions) → §5 (five
# considerations + revisions). The workflow figure is paper fig 2 with its
# verbatim caption; the stage panels carry the five consideration titles
# verbatim, each followed by its resulting revision (compressed).
system:
  heading: "Educator-informed design considerations and revisions"
  intro: "MotionSmith is a sketch-based computational design system originally developed through participatory design with expert automata artists. Before the educator collaboration, the research team identified three assumptions of the expert workflow that might become consequential in classrooms — concerning the formulation of motion goals, the interpretation of computational information, and the transition from digital design to physical construction — and prepared starting conditions for educators to examine through hands-on use: a dual-path workflow, interactive mathematical explanations, and a grid-constrained environment paired with a reusable physical kit. Educators' input informed five design considerations linking their experiences and classroom requirements to revisions of MotionSmith, the physical kit, and instructional supports."
  workflow:
    src: "/images/young-makers/original-system.webp"
    # Paper fig 2, panels verbatim (letter badges intact) but arranged in two
    # rows — A | C on top, B full-width below — so the original system's UI
    # (panel B) renders ~1100px wide on the page instead of ~610px in the
    # paper's 3:1 strip; the caption stays verbatim. `wide: true` lifts the
    # portrait-capture max-height cap (the composite is landscape-shaped).
    wide: true
    alt: "Three panels from the paper's original-system figure, arranged in two rows for legibility: the sketched motion path on the articulated character rig (A) and the fabricated physical automaton (C) on top, and the original MotionSmith interface — Welcome, Character Selection, Path Editor, and Mechanism Design steps with the mechanism-generation controls — full-width below."
    caption: "Original MotionSmith workflow. Users (A) sketch a motion path on an articulated character rig, (B) compare and edit synthesized mechanism candidates, and (C) export fabrication files for physical construction."
  stages:
    - index: "01"
      title: "Providing a Concrete Yet Revisable Design Goal"
      text: "Motion-first is now the default workflow: the system opens with a blank articulated-character template, and users can retain the template or replace it with an imported image as their ideas develop. When the template is retained, its component outlines are incorporated into the exported fabrication files, so the character can be constructed and personalized through physical craft."
    - index: "02"
      title: "Sustaining Progress Across Entry, Interruption, and Recovery"
      text: "A browser-based version removes installation barriers on school-managed devices; prepared examples and a workflow overview provide recognizable starting points; manual save and load let users download an editable project file and reimport it to continue across class periods; and a history of up to ten coarse-grained events lets users return to earlier design states."
    - index: "03"
      title: "Making Mechanism and Assembly Relationships Spatially Legible"
      text: "The simulation canvas now uses a layered 2.5D visualization that spatially separated overlapping components while retaining the underlying planar mechanism model, fixed joints are differentiated from moving connections, and a stacked assembly view in the fabrication instructions shows component order, connection locations, and required spacing before physical construction."
    - index: "04"
      title: "Aligning Digital Designs with Reusable Classroom Materials"
      text: "Cut-to-length illustration-board linkages are replaced with reusable plywood linkages in standardized lengths, a shared size and labeling scheme spans the software, fabrication files, and physical kit, printable parts condense into a one- or two-page packet, and screen-based instructions show connection locations, layering, spacers, and assembly order."
    - index: "05"
      title: "Supporting Educator-Configured Explanation and Activity"
      text: "Explanatory support became a configurable resource for classroom facilitation: an on-demand prompt panel from which educators select questions asking students to predict how a change would affect motion, compare alternatives, explain an observed result, or diagnose a difference between simulated and physical behavior, supplemented by real-world application examples linked to curated online videos."
  zoom:
    src: "/images/young-makers/ms-canvas.webp"
    alt: "The revised MotionSmith Mechanism Foundry: a four-bar linkage candidate playing on the layered canvas beside the prompt panel, stack readout, rig-opacity and explode sliders, and kit-compatible link-hole parameters."
    caption: "The revised system, live at alansynn.com/ms — a four-bar candidate in the Mechanism Foundry with the on-demand prompt panel and kit-compatible link-hole parameters (3-, 9-, 5-hole)."
  interface:
    heading: "The revisions, in the live system"
    copy: "The simulation canvas uses a layered 2.5D visualization that spatially separates overlapping components, fixed joints are differentiated from moving connections, and a stacked assembly view joins the fabrication instructions. An on-demand prompt panel lets educators select questions aligned with their instructional goals — asking students to predict, compare, explain, or diagnose."
# The enactment study under its own name (§6). stat values are the paper's.
results_heading: "Classroom enactment"
stat_callouts:
  - { value: "4", label: "K–8 STEM educators in the three-phase participatory design study" }
  - { value: "5", label: "educator-informed design considerations, implemented as revisions to the workflow, kit, and instructional supports" }
  - { value: "3", label: "classroom enactments at two schools, led by three of the four educators" }
  - { value: "129", label: "middle-school students in the enacted classroom activities" }
# Compiled from §6.2's prose — the revision's old classroom-settings table is
# commented out in the tex, so the page rebuilds the settings from the text.
results:
  caption: "Classroom settings for the three educator-led enactments, compiled from Section 6.2 of the paper."
  note: "All three educators planned projects in groups of two or three students; 36 fabrication kits were prepared and 18 supplied to each school; both schools provide a Chromebook for every student. T1's enactment is documented through educator reports and materials, while T3's second and T4's third sessions were directly observed."
  columns: ["Case", "Class", "Students", "Sessions"]
  rows:
    - {
        cells:
          [
            "T1 · Grade 6 STEAM",
            "2 classes",
            "58",
            "4 × ~45 min",
          ],
      }
    - {
        cells:
          [
            "T3 · Grade 8 Engineering Foundation",
            "1 class",
            "35",
            "3 × 60 min",
          ],
      }
    - {
        cells:
          [
            "T4 · Grade 6 STEM",
            "1 class",
            "36",
            "3 × 55 min",
          ],
      }
# §6.3 accounts, verbatim where quoted. Case images are crops of the paper's
# own deployment montage (Fig. 8): T1 → panel F, T3 → panel D, T4 → panel B
# (the panels the prose cites for each classroom). Captions name the panel.
cases_heading: "Educator-led classroom enactments"
cases_intro: "Three criteria — sustained and productive engagement, intentional design and iterative revision, and interest in continuing or extending the activity — guided attention during the enactments; T2 noted that “effective iteration is more than making changes.” In post-activity interviews, all three educators reported high student engagement and expressed plans to use MotionSmith and the accompanying kits again."
cases:
  - tab: "T1 · Grade 6 STEAM"
    subtitle: "2 classes · 58 students · 4 sessions"
    image: "/images/young-makers/case-t1.webp"
    alt: "MotionSmith running on a laptop beside a hand-drawn segmented character on paper."
    caption: "A student-drawn character accompanies MotionSmith use (paper Fig. 8, panel F)."
    lede: "T1 integrated MotionSmith into an ongoing activity themed “Imagine Yourself as a Scientist”: students first drew their scientist characters and designed movements for them in MotionSmith, and divided responsibilities between digital design and physical construction when projects moved to team work."
    facts:
      - {
          label: "Differentiated roles",
          text: "“We split the class into roles, computer scientists and graphic designers,” T1 reported during enactment; some students concentrated on digital design while others constructed the mechanisms for their envisioned scientist characters.",
        }
      - {
          label: "Engagement and access",
          text: "T1 reported in text messages that students “really like the simulation,” and recorded in his written notes that students wanted to continue working on their projects; the simulation was initially blocked and ran slowly on the school network, and he described difficulty recalling a procedure during class: “I couldn't remember how to do it and I don't have the time to try and figure it out with the students here.”",
        }
      - {
          label: "Continuity across sessions",
          text: "Students lost unsaved progress when they reloaded the page or reopened the browser window, and the limited recovery history was insufficient for some students; T1 requested browser-based autosaving and additional recovery checkpoints, since manual save and load still depended on students remembering to save.",
        }
  - tab: "T3 · Grade 8 Engineering Foundation"
    subtitle: "1 class · 35 students · 3 sessions"
    image: "/images/young-makers/case-t3.webp"
    alt: "Several students gathered around a workstation running MotionSmith, with a nearby laptop displaying a teacher-provided activity document in Google Classroom."
    caption: "Students working with MotionSmith alongside a teacher-provided activity document (paper Fig. 8, panel D)."
    lede: "T3 began with 15–20 minutes of exploration on Chromebooks, then moved the activity to a computer lab, where desktop computers offered larger monitors and each team received a fabrication kit; designs began from the blank character template, with the physical components explored alongside the mechanism designs."
    facts:
      - {
          label: "Purposeful revision",
          text: "“What change had the biggest effect on the movement? What happened? Why do you think this happened?” — T3 reported asking questions like these frequently; his Exploration Challenge sheet asked students to change a motion or setting, try an alternative mechanism or design choice, and document the result through a screenshot and written reflection.",
        }
      - {
          label: "An alternative six-bar",
          text: "When a student asked whether the physical assembly could differ from the generated blueprint, T3 documented his encouragement of the direction; the student explored an alternative six-bar configuration, consulted the school-supported AI chat for guidance on how the mechanism could be constructed, and continued developing the design — exploration T3 described as educationally valuable.",
        }
      - {
          label: "What T3 asked for next",
          text: "T3 noted that students “stayed on it” and wanted more time; he proposed networked access to saved group projects so he could review progress from his own computer, a teacher-facing interface for selecting shared projects as whole-class examples, and support for more advanced students to design complex mechanisms from scratch.",
        }
  - tab: "T4 · Grade 6 STEM"
    subtitle: "1 class · 36 students · 3 sessions"
    image: "/images/young-makers/case-t4.webp"
    alt: "Two students seated together in front of a desktop monitor displaying an articulated character and mechanism in MotionSmith."
    caption: "Collaborative character and mechanism design at a shared workstation (paper Fig. 8, panel B)."
    lede: "T4 devoted the first session to individual exploration and asked students to save their design files; in the second session he organized students into pairs and distributed the fabrication kits, and each pair reviewed its members' saved designs and negotiated a shared direction for the team project."
    facts:
      - {
          label: "The high-five pair",
          text: "One group wanted two characters to high-five; as students developed the idea, they recognized that one character needed to use its left hand and the other its right, and coordinated changes to their designs. T4 interpreted the episode as evidence that students were developing motion ideas, identifying constraints, and working through them together.",
        }
      - {
          label: "Kit boxes and continuity",
          text: "T4 emphasized the value of the kit boxes, which held the accompanying components, fit the available storage, and allowed work to continue across sessions.",
        }
      - {
          label: "Simpler starting points",
          text: "Complex character-motion design remained demanding for his Grade 6 students, T4 felt; he wanted activities to begin with simpler mechanical actions, such as moving an object, while retaining students' freedom to personalize and decorate their artifacts.",
        }
citation_heading: "Cite this work."
citation_intro: "The paper is under review; the BibTeX below reflects its current public citation — venue and DOI follow acceptance."
acknowledgments: "With thanks to the four educators who co-designed, critiqued, and carried this work into their classrooms, and to the two schools that opened their doors."
---

Bringing expert-oriented mechanical CAD into classrooms requires attention to
novice learners, material constraints, and instructional goals. We examine this
adaptation through MotionSmith, a sketch-based system for automata making
originally developed with expert artists. In a three-phase participatory design
study, four K–8 STEM educators used the system, proposed and reviewed revisions,
and developed classroom activities. Their input informed five design
considerations and revisions to the authoring workflow, reusable fabrication
kit, and instructional supports. Subsequent classroom enactments led by three
educators involved 129 middle-school students at two schools. Educator accounts
and classroom observations documented how educators adapted the shared workflow
while preserving student design choices, how they guided purposeful revision,
and how project continuity required preserving digital designs and unfinished
physical builds across class periods.

Moving novel interactive systems from research prototypes or expert practice
into educational settings remains difficult: educators must learn the
technology, manage technical and material friction for novice students,
coordinate shared resources and limited class time, and translate the
system-enabled activities into meaningful learning opportunities. Before the
educator collaboration, the research team prepared three starting conditions
for educators to examine through hands-on use — a dual-path workflow supporting
motion-first and mechanism-first design, interactive mathematical explanations,
and a grid-constrained software environment paired with a reusable physical
fabrication kit — alongside three anticipated educational tensions concerning
how learners formulate motion goals, interpret computational feedback, and
translate digital designs into physical artifacts.

The study asks how STEM educators identify and reshape the system, material,
and facilitation conditions needed to adapt an expert-oriented mechanical CAD
tool for classroom use; how they translate computational mechanism design into
classroom automata-making activities, instructional supports, and learning
goals; and how the educator-informed system is enacted in middle-school
classrooms — what supports and breakdowns emerge as students design and
fabricate automata. It contributes the five design considerations, the revised
workflow, kit, and instructional resources that implement them, and situated
classroom accounts documenting how educators guided design exploration, sought
different levels of mechanical complexity, and encountered difficulties
preserving unfinished projects.

Several limitations bound these findings: the classroom educators had
participated in the co-design, direct researcher observation covered one
session each in T3's and T4's classes while T1's enactment is documented
through educator reports, and the analysis examined classroom organization and
resource use rather than learning gains. The paper concludes: "Adapting
expert-oriented CAD for classrooms involves shaping the software, materials,
and instructional supports around how young makers collaboratively develop
their projects and how educators guide that work."
