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
  - Citation
overview_heading: "Bringing expert-oriented mechanical CAD into classrooms."
# Gallery bridges co-design → classroom (the paper's §4 → §6 arc), rendered
# before the System section. The co-design timeline (paper fig 4) leads its own
# full-width row; below it, two squares cropped from the paper's deployment
# montage (Fig. 8): the observed classroom and a construction close-up. The
# starting-configuration figure (paper fig 3) was DROPPED — the System intro's
# prose already states those starting conditions verbatim, and it repeated the
# stage-04 kit material.
gallery_heading: "From co-design to the classroom"
gallery:
  columns: 2
  items:
    - src: "/images/young-makers/workshop-timeline.webp"
      alt: "Three panels illustrating the educator co-design process, with an unnumbered research-team revision block between Panels B and C: Experience as first-time users (10 hours in person over Days 1–2), Reframe as classroom facilitators (5 hours in person on Day 3), and Review & co-design as pedagogical designers (approximately 5 hours remotely), the research-team block synthesizing revisions to the digital system, physical kit, and facilitation supports."
      label: "Three perspectives"
      wide: true
      caption: "Educator co-design across three perspectives. (A) Experience through use and fabrication as first-time users. (B) Reframe through planning as classroom facilitators. (C) Review & co-design as pedagogical designers, reviewing revisions, developing lesson plans, and commenting on draft classroom-enactment criteria. The dashed return arrow represents their further critique and proposed refinements. The unnumbered block between (B) and (C) represents a research-team synthesis of educator experiences and classroom requirements into revisions to the digital system, physical kit, and facilitation supports."
    - src: "/images/young-makers/gallery-classroom.webp"
      alt: "Students arranging character components on a pegboard beside a laptop."
      label: "Classroom enactment"
      caption: "Students arranging character components on a pegboard beside a laptop (paper Fig. 8, panel H)."
    - src: "/images/young-makers/gallery-artifact.webp"
      alt: "Hands positioning an articulated paper character connected to wooden linkages on a physical pegboard."
      label: "Physical construction"
      caption: "Hands positioning an articulated paper character connected to wooden linkages on a physical pegboard (paper Fig. 8, panel C)."
# Demo = a scripted screen recording of the live revised system at /ms.
demo:
  src: "/videos/young-makers-demo.mp4"
  poster: "/videos/young-makers-poster.webp"
  alt: "Screen recording of a guided MotionSmith walkthrough: picking the Make a hand wave starter, exploring the layered 2.5D character canvas, playing the hand-wave motion, examining the four-bar mechanism candidate and prompt panel, and viewing the build plan and assembly steps."
  intro: "A walkthrough of the revised system — the classroom-oriented authoring workflow, the reusable fabrication kit, and the instructional supports — recorded from the live system at alansynn.com/ms."
# System section mirrors the paper's §5 (five considerations + revisions).
# The stage panels carry the five consideration titles verbatim, each followed
# by its resulting revision (compressed); the §5 figures (paper figs 5–7) then
# render full-width with their verbatim captions. The paper's original-system
# figure (fig 2) is deliberately NOT shown — owner directive (2026-10-01):
# leading with the old system's UI confused readers; the page showcases the
# revisions instead.
system:
  heading: "Educator-informed design considerations and revisions"
  intro: "MotionSmith is a sketch-based computational design system originally developed through participatory design with expert automata artists. Before the educator collaboration, the research team identified three assumptions of the expert workflow that might become consequential in classrooms — concerning the formulation of motion goals, the interpretation of computational information, and the transition from digital design to physical construction — and prepared starting conditions for educators to examine through hands-on use: a dual-path workflow, interactive mathematical explanations, and a grid-constrained environment paired with a reusable physical kit. Educators' input informed five design considerations linking their experiences and classroom requirements to revisions of MotionSmith, the physical kit, and instructional supports."
  stages:
    - index: "01"
      title: "Providing a Concrete Yet Revisable Design Goal"
      text: "Motion-first is now the default workflow: the system opens with a blank articulated-character template, and users can retain the template or replace it with an imported image as their ideas develop. When the template is retained, its component outlines are incorporated into the exported fabrication files, so the character can be constructed and personalized through physical craft."
    - index: "02"
      title: "Sustaining Progress Across Entry, Interruption, and Recovery"
      text: "A browser-based version removes installation barriers on school-managed devices; prepared examples and a workflow overview provide recognizable starting points; manual save and load let users download an editable project file and reimport it to continue across class periods; and a history of up to ten coarse-grained events lets users return to earlier design states."
    - index: "03"
      title: "Making Mechanism and Assembly Relationships Spatially Legible"
      text: "The simulation canvas now uses a layered 2.5D visualization that spatially separates overlapping components while retaining the underlying planar mechanism model, fixed joints are differentiated from moving connections, and a stacked assembly view in the fabrication instructions shows component order, connection locations, and required spacing before physical construction."
    - index: "04"
      title: "Aligning Digital Designs with Reusable Classroom Materials"
      text: "Cut-to-length illustration-board linkages are replaced with reusable plywood linkages in standardized lengths, a shared size and labeling scheme spans the software, fabrication files, and physical kit, printable parts condense into a one- or two-page packet, and screen-based instructions show connection locations, layering, spacers, and assembly order."
    - index: "05"
      title: "Supporting Educator-Configured Explanation and Activity"
      text: "Explanatory support became a configurable resource for classroom facilitation: an on-demand prompt panel from which educators select questions asking students to predict how a change would affect motion, compare alternatives, explain an observed result, or diagnose a difference between simulated and physical behavior, supplemented by real-world application examples linked to curated online videos."
  # Paper §5 figures (figs 5–7) as the paper's OWN left-to-right panel strips
  # (owner call 2026-10-01: the earlier 2-row web recompositions broke the
  # panels' reading order and hindered reading — paper-native order wins).
  # Each is a straight 200-dpi render of the paper figure PDF (2400px wide,
  # 2× retina at the 1120px shell — panels render ~265–360px, 2–3× the
  # printed paper's panels). Captions are the paper's, verbatim; alt text =
  # the paper's \Description + one sentence disclosing the arrangement.
  # `kicker` ties each figure to the stage panel it illustrates (fig 5 → 03,
  # fig 6 → 04, fig 7 → 05; the paper has no figure for 01–02).
  revisions:
    - kicker: "Consideration 03"
      src: "/images/young-makers/system-legible-strip.webp"
      alt: "The paper's three-panel figure, panels reading left to right. The panels illustrate revisions to mechanism visualization and assembly guidance. Panel A shows colored links and joints overlaid on a character's raised arm and motion path. A dashed oval highlights overlapping parts and joints. Panel B shows blue links rendered with visible thickness. Callouts identify a pivot fixed to the board and a moving connection. A magnified inset shows overlapping component layers, and a legend distinguishes the two connection types. Panel C shows purple and blue links mounted on a pegboard, with an instruction to connect the output link from G10 back to J7. Beside it, an exploded schematic arranges a fastener head, linkage, spacer, and pegboard along a dashed connection axis, with the fastener tabs opened behind the board. Annotations identify the spacer's role in setting the gap and the alignment of holes along the connection axis."
      caption: "Making mechanism and assembly relationships spatially legible. (A) The original 2D view displays character motion and overlapping mechanism geometry without showing depth ordering. (B) The revised 2.5D canvas distinguishes component layers and board-fixed pivots from moving connections while retaining planar kinematics. (C) The assembly guide specifies connection locations; an accompanying schematic illustrates component order, alignment, and spacer-defined separation at a board-mounted pivot."
    - kicker: "Consideration 04"
      src: "/images/young-makers/reusable-materials-strip.webp"
      alt: "The paper's four-panel figure, panels reading left to right. The panels illustrate revisions to materials and digital-to-physical correspondence. Panel A contrasts a schematic strip of illustration board marked for cutting with a photograph of plywood linkages arranged by length; the three-hole pair is highlighted. Panel B shows a blue three-hole linkage and four rows repeating the three-hole size label for the digital parameter, generated part list, physical kit part, and assembly instruction. Panel C shows a page titled Sample Character with separate body-part outlines, marked joint locations, and a small assembled-character preview. Panel D shows a layered character and linkage assembly on a pegboard. Below the view, Step 9 is labeled Connect character and includes the instructions Connect output and Check: Path follows. A mechanism-stack section and board-reference indicators appear beneath the instructions."
      caption: "Aligning digital designs with reusable classroom materials. (A) Standard-length plywood linkages replace cut-to-length illustration board. (B) A schematic illustrates the shared three-hole size label across the digital parameter, generated part list, physical kit component, and assembly instruction. (C) A print-packet example groups articulated-character outlines and joint locations on one page. (D) Screen-based assembly guidance shows the character and mechanism together with a connection step and board references."
    - kicker: "Consideration 05"
      src: "/images/young-makers/educator-support-strip.webp"
      alt: "The paper's three-panel figure, panels reading left to right. The panels connect educator-selected questions to mechanism exploration and application examples. Panel A lists Predict, Compare, Observe and explain, and Diagnose, with Observe and explain selected. The prompts ask about input speed, fixed pivots, gear rotation direction, and differences between physical and simulated behavior. Panel B shows two purple gears beside the selected question asking which gear turns the other way. The cues suggest adding an idler gear and observing tooth contact and rotation; a Hint control appears below. Panel C contains two application cards labeled Waving hand and Toy gearbox. Each card pairs a brief mechanism description with a video preview and a Watch video link. Text beneath each preview identifies the video as optional and refers to a generated loop if the video does not load."
      caption: "Supporting educator-configured explanation and activity. (A) An on-demand prompt panel presents questions for prediction, comparison, observation and explanation, and diagnosis that educators can select based on their instructional goals. (B) The selected question appears beside the mechanism simulation with brief cues for what students could try and observe. (C) Real-world application examples identify where a mechanism is used and describe the movement it produces, with links to curated online videos. Prompts and examples supplement the mathematical explanations."
  zoom:
    src: "/images/young-makers/ms-canvas.webp"
    alt: "The revised MotionSmith Mechanism Foundry: a four-bar linkage candidate playing on the layered canvas beside the prompt panel, stack readout, rig-opacity and explode sliders, and kit-compatible link-hole parameters."
    caption: "The revised system, live at alansynn.com/ms — a four-bar candidate in the Mechanism Foundry with the on-demand prompt panel and kit-compatible link-hole parameters (3-, 9-, 5-hole)."
  # (The former `interface:` copy block was dropped 2026-10-01 — it restated
  # stages 03/05 nearly verbatim; the stage panels + zoom caption carry it.)
# The enactment study under its own name (§6). stat values are the paper's.
results_heading: "Classroom enactment"
stat_callouts:
  - { value: "4", label: "K–8 STEM educators in the three-phase participatory design study" }
  - { value: "5", label: "educator-informed design considerations, implemented as revisions to the workflow, kit, and instructional supports" }
  - { value: "3", label: "classroom enactments at two schools, led by three of the four educators" }
  - { value: "129", label: "middle-school students in the enacted classroom activities" }
# §6.2 settings as prose (06-deployment.tex:74 + the observation note :93),
# NOT a table: the authors themselves commented the classroom-settings table
# out of the tex (06-deployment.tex:19–69) and let it go stale, and the
# per-case settings live in the case tabs' subtitles below. Note-only results
# block (no columns/rows); the note renders as centered prose.
results:
  note: "T2 could not participate because of scheduling constraints. All three educators planned projects in groups of two or three students; 36 fabrication kits were prepared and 18 supplied to each school; both schools provide a Chromebook for every student. T1's enactment is documented through educator reports and materials, while T3's second and T4's third sessions were directly observed."
# §6.3 accounts, verbatim where quoted. FUSED into the Results section above
# (cases_in_results) — the cases ARE the enactment results. Case images are
# crops of the paper's own deployment montage (Fig. 8): T1 → panel I (the
# completed automaton), T3 → panel D, T4 → panel A (assembly beside the
# on-screen guidance — the panel the construction fact cites). Captions name
# the panel.
cases_in_results: true
cases_heading: "Three educators, two schools"
cases_intro: "Three criteria — sustained and productive engagement, intentional design and iterative revision, and interest in continuing or extending the activity — guided attention during the enactments; T2 noted that “effective iteration is more than making changes.” In post-activity interviews, all three educators reported high student engagement and expressed plans to use MotionSmith and the accompanying kits again. During our observation of T3's class, students expressed interest in trying other designs and mechanisms."
# §7's readiness sentence, closing the merged section.
cases_outro: "As the paper argues, “assessing classroom readiness means examining whether students can move between digital design and physical construction using the available representations, materials, and guidance, and whether educators can support that work across several groups.”"
cases:
  - tab: "T1 · Grade 6 STEAM"
    subtitle: "2 classes · 58 students · 4 sessions"
    image: "/images/young-makers/case-t1-outcome.webp"
    alt: "A completed articulated character mounted on a pegboard and connected through wooden linkage components and fasteners."
    caption: "A completed automaton shows the resulting character and mechanism (paper Fig. 8, panel I)."
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
    lede: "T3's lesson plan emphasized problem-solving through a teacher-led mechanism “read-aloud,” during which the class would identify a mechanism's input, moving components, and output. In the enactment, T3 began with 15–20 minutes of exploration on Chromebooks, then moved the activity to a computer lab, where desktop computers offered larger monitors and each team received a fabrication kit; designs began from the blank character template, with the physical components explored alongside the mechanism designs."
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
    image: "/images/young-makers/case-t4-guidance.webp"
    alt: "A student holding wooden linkage components beside a desktop monitor displaying a mechanism on a pegboard grid with on-screen assembly guidance."
    caption: "Physical linkage assembly alongside the on-screen board layout and guidance (paper Fig. 8, panel A)."
    lede: "T4's plan connected mechanism design to curricular engineering-design objectives. His plan asked students to compare mechanisms and predict how a parameter change would affect movement before testing it in the simulation. It also included a “blueprint gate,” at which teams would explain their simulated designs before receiving fabrication materials. In the enactment, T4 devoted the first session to individual exploration and asked students to save their design files; in the second session he organized students into pairs and distributed the fabrication kits, and each pair reviewed its members' saved designs and negotiated a shared direction for the team project."
    facts:
      - {
          label: "The high-five pair",
          text: "One group wanted two characters to high-five; as students developed the idea, they recognized that one character needed to use its left hand and the other its right, and coordinated changes to their designs. T4 interpreted the episode as evidence that students were developing motion ideas, identifying constraints, and working through them together.",
        }
      - {
          label: "From screen to pegboard",
          text: "During construction, group members divided tasks between cutting character parts and assembling mechanism components on the pegboard; students consulted the on-screen board layout and assembly guidance alongside the physical parts (paper Fig. 8).",
        }
      - {
          label: "Kit boxes and continuity",
          text: "T4 emphasized the value of the kit boxes, which held the accompanying components, fit the available storage, and allowed work to continue across sessions.",
        }
      - {
          label: "Sustained participation",
          text: "T4 emphasized that he valued students' willingness to explore with peers without waiting for step-by-step directions, particularly while he attended to other classroom responsibilities.",
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
