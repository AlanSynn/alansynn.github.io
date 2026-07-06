#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude: *

#show: main.with(
  title: "Same Computer Science, Different Senses of Reality",
  desc: "Computer-science subfields often disagree not because one is more rigorous, but because they protect different kinds of rigor: possibility, constraint, and principle.",
  date: "2026-07-04",
  tags: ("research", "essay"),
)

Computer science has many subfields, and they all look like “computer science” from far away. Up close, they do not always agree on what counts as a strong contribution. Some communities value new possibilities. Some value systems that survive real constraints. Some value precise statements that can be proved, falsified, or ruled out.

The disagreement is not simply about method. It is about what each field learns to see first.

A systems researcher may first see workload, latency, locality, resource cost, and failure modes. An HCI researcher may first see interpretation, context, agency, appropriation, and sensemaking. A theory researcher may first see definitions, assumptions, quantifiers, counterexamples, and proof obligations. A graphics researcher may have to see all of these at once: representation, optimization, perception, interaction, and speed.

This is why cross-field conversations can feel strange. People are often not disagreeing about whether rigor matters. They are disagreeing about where the rigor lives.

A useful map has three corners.

- *Possibility-centered research*: research that reveals a new interaction, behavior, capability, phenomenon, or design space.
- *Constraint-centered research*: research that makes a system work under hardware, runtime, workload, resource, failure, and deployment constraints.
- *Principle-centered research*: research that formalizes a problem and establishes a guarantee, lower bound, impossibility result, convergence condition, or falsifiable hypothesis.

This is not a taxonomy. Most good work moves between these corners. The point is not to put fields into boxes. The point is to name the default question a field tends to ask first.

= Possibility-centered research: “What becomes possible?”

Parts of HCI, design tools, creative AI, visualization, and interactive graphics often begin from possibility. The object of study may be a new interaction, a new workflow, an unexpected behavior, or a phenomenon that existing framings do not yet explain well.

Typical sentences sound like this.

#examples(
  "“We explore a new interaction paradigm.”",
  "“This system opens up a new design space.”",
  "“We surface tensions in how people use AI tools.”",
  "“The behavior cannot be fully explained by existing framings.”",
)

Important words here include *explore, open up, surface, situated, design space, interpretation, appropriation, sensemaking,* and *agency*.

In this culture, ambiguity is not always a defect. Sometimes ambiguity is the phenomenon. The contribution may be to show that people interpret a tool in different ways, appropriate it for their own context, or invent workflows that the designers did not anticipate.

That does not mean “anything goes.” A possibility-centered contribution still needs discipline. It should make clear what is newly visible, what evidence supports that claim, and what boundary the claim has. But the first question is often generative:

#examples(
  "“What does this make possible that was hard to see before?”",
  "“What new behavior or interaction does it reveal?”",
  "“What design space does it open?”",
  "“What phenomenon does the existing vocabulary fail to explain?”",
)

A fatal failure here is not usually that the system is not yet optimal or not yet deployable. The more serious failure is that there is no new phenomenon.

#examples(
  "“There is no new behavior.”",
  "“The work repeats a known framing in different words.”",
  "“The artifact does not reveal a new design space.”",
  "“The analysis flattens the complexity of people, practice, or context.”",
)

This is also why early HCI or design-tool work may not start with a fully closed, falsifiable hypothesis. It may start by making a phenomenon legible enough that later work can turn it into one.

= Constraint-centered research: “Where is the real bottleneck?”

Systems, operating systems, architecture, databases, distributed systems, and networking often begin from constraint. Reality appears as hardware, resources, workloads, tail behavior, runtime effects, failure modes, and deployment conditions.

Typical sentences sound like this.

#examples(
  "“The abstraction hides locality.”",
  "“The system lacks a mechanism for efficient scheduling.”",
  "“This design fails to expose parallelism.”",
  "“Tail latency is dominated by coordination overhead.”",
  "“The assumption does not hold at scale.”",
)

Important words here include *lack, hide, expose, overhead, bottleneck, locality, throughput, latency, tail latency, scalability, robustness, utilization, cost model,* and *failure mode*.

In systems and architecture, the word *lack* is usually technical, not moral. For example:

#blockquote[
“The design lacks locality awareness.”
]

This usually means something like:

#blockquote[
“The abstraction does not expose enough of the underlying resource structure, so a hidden cost appears under a particular workload or scale.”
]

A systems critique often tries to locate the missing mechanism, hidden cost, unstated assumption, or bottleneck. The underlying instinct is simple:

#blockquote[
Hidden complexity returns. Ignored cost returns. A clean abstraction still has to meet the machine, the workload, and the deployment environment.
]

So constraint-centered researchers ask questions like:

#examples(
  "“What is the cost model?”",
  "“Which workload is this claim about?”",
  "“What happens at the tail?”",
  "“What is the failure mode?”",
  "“Does the result survive scale, contention, heterogeneity, and deployment?”",
  "“Was the bottleneck removed, or moved somewhere else?”",
)

A fatal failure here is not lack of imagination. It is a claim that does not survive the conditions it gestures toward.

#examples(
  "“The bottleneck is not identified.”",
  "“The measurement does not support the claim.”",
  "“The assumption breaks under scale.”",
  "“The workload is too narrow for the stated claim.”",
  "“The system removes one cost by hiding another.”",
)

In this culture, a strong claim is often a falsifiable claim: under workload W, on system S, with metric M, the design improves X or exposes why X is impossible under the stated constraints.

= Principle-centered research: “What can be said in general?”

Algorithms, complexity, cryptography, formal methods, and programming language theory often begin from principle. The abstraction is not a simplification that comes after the real work. It is part of the real work. The question is whether the problem is defined precisely enough that a claim can be proved, disproved, bounded, or falsified.

Typical sentences sound like this.

#examples(
  "“We prove a lower bound.”",
  "“We show correctness under the following assumptions.”",
  "“We characterize the identifiability condition.”",
  "“This problem admits no polynomial-time approximation unless...”",
  "“We provide a convergence guarantee.”",
)

Important words here include *definition, assumption, proof, correctness, optimality, lower bound, impossibility, convergence, identifiability, formal characterization, tightness,* and *counterexample*.

In this culture, the most fatal failure is a broken claim. A system working on several benchmarks may be useful, but it does not prove a universal statement. If the paper writes a universal claim, a single counterexample can be enough to break it.

Principle-centered researchers therefore look first at questions such as:

#examples(
  "“What exactly is the problem?”",
  "“What are the quantifiers?”",
  "“Which assumptions are necessary?”",
  "“Is the theorem strong enough for the claim?”",
  "“Is the guarantee proved?”",
  "“Is there a counterexample?”",
  "“Is the bound tight?”",
)

A fatal failure here is usually:

#examples(
  "“The definition is vague.”",
  "“The claim is stronger than the proof.”",
  "“An assumption is missing.”",
  "“The result does not imply the stated claim.”",
  "“There is a counterexample.”",
)

This is not indifference to practice. It is a different way of protecting truth: separate the claim from the implementation, state the conditions, then see what follows.

= Same word, different meaning: performance

A major source of misunderstanding is that different fields reuse the same words. *Performance* is the easiest example. Everyone says performance, but not everyone means the same thing.

In systems and architecture, performance often means:

- throughput
- latency
- tail latency
- memory footprint
- bandwidth
- cache behavior
- utilization
- energy efficiency
- scalability

Here, performance is mainly about *how efficiently resources are used under a workload*.

In HCI, performance can include task completion time and error rate, but it often also includes:

- user control
- learnability
- cognitive load
- trust calibration
- expressiveness
- agency
- workflow fit
- interpretability
- collaboration quality
- appropriation

Here, performance is not only “did the person finish faster?” It may be closer to: did the system help people understand, decide, coordinate, express, and act in ways that matter for their goals?

In graphics, performance often combines computational and perceptual criteria.

- frame rate
- interactivity
- convergence speed
- visual fidelity
- perceptual plausibility
- artifact reduction
- controllability
- physical plausibility
- robustness across shapes, scenes, and materials

In theory, performance is usually not empirical runtime alone. It may be expressed as:

- asymptotic complexity
- approximation ratio
- sample complexity
- regret bound
- convergence rate
- optimality gap

In AI/ML, performance may mean:

- accuracy
- generalization
- robustness
- calibration
- sample efficiency
- benchmark score
- inference cost
- scaling behavior
- capability under distribution shift
- alignment with human preference

So “the performance is good” is not yet a complete statement. The useful question is:

#blockquote[
Performance by whose standard? On what task, workload, context, and metric? Is the claim about speed, quality, control, reliability, generalization, or human outcome?
]

The same point applies to many other words: *robust, scalable, usable, interpretable, interactive, optimal, realistic,* and *general*. These are not self-explanatory across fields. They need a claim boundary.

= Why “lack” sounds different across fields

In systems and architecture, “lack” is a normal technical word.

#examples(
  "“This abstraction lacks locality awareness.”",
  "“The scheduler lacks a mechanism for heterogeneous workloads.”",
  "“The system lacks backpressure.”",
)

These sentences point to a missing mechanism. The missing mechanism then explains overhead, bottlenecks, instability, or underutilization.

In HCI and design-oriented writing, “lack” is more delicate, especially when the subject is a person, user, community, or practice.

#blockquote[
“Users lack understanding.”
]

This can sound like deficit framing: the problem is placed inside the user. HCI often tries to move the analysis toward the relation between people, representations, tools, and context.

More careful versions might be:

#examples(
  "“Users developed different mental models.”",
  "“The interface did not make the system state legible.”",
  "“Participants interpreted the feedback in context-dependent ways.”",
  "“Current designs do not yet support this form of sensemaking.”",
)

The difference is not cosmetic. It changes where the research looks for the problem. Instead of treating users as deficient, it asks how the interaction, representation, feedback, and context shape interpretation.

This is why the same critique often needs translation.

A systems-style sentence:

#blockquote[
“The design lacks a clear cost model.”
]

A more collaborative version:

#blockquote[
“The paper would be stronger if it made the operating conditions and tradeoffs explicit.”
]

A blunt sentence:

#blockquote[
“The evaluation is weak.”
]

A more precise version:

#blockquote[
“The evaluation supports the exploratory claim, but not yet the stronger claim about scalability, robustness, or generality.”
]

A blunt sentence:

#blockquote[
“There are too many assumptions.”
]

A more useful version:

#blockquote[
“The claim boundary would be clearer if the paper distinguished essential assumptions from prototype-specific design choices.”
]

Good translation should not remove the critique. It should make the critique actionable.

= How to read sentences from different fields

== Reading systems / architecture sentences

Systems and architecture writing can sound cold because it often names deficits directly.

#examples(
  "“X hides Y.”",
  "“X fails to exploit Y.”",
  "“X lacks Z.”",
  "“X introduces overhead.”",
  "“X does not scale.”",
)

But the usual meaning is more specific:

#blockquote[
“The abstraction does not represent some real resource structure, so a measurable cost appears under a particular workload, scale, or deployment condition.”
]

This is not usually a claim that the idea has no value. It is often a request for a sharper claim boundary.

The basic form of systems critique is:

#blockquote[
abstraction → hidden cost → bottleneck → measurement → redesign
]

So when a systems researcher asks, “Is this realistic?” the intended question is often:

#blockquote[
“Under what operating conditions does this idea survive?”
]

== Reading HCI / design sentences

HCI and design research can sound soft or under-specified from a systems perspective.

#examples(
  "“We explore...”",
  "“We surface...”",
  "“We unpack...”",
  "“We open up...”",
  "“This suggests design opportunities...”",
  "“The findings are situated...”",
)

But these phrases usually mean:

#blockquote[
“The field does not yet have a closed objective to optimize, so this work makes a phenomenon, practice, or design possibility visible.”
]

Here, “situated” does not mean “not rigorous.” It means:

#blockquote[
“The result should be read together with the context, practice, participants, artifact, and use conditions that give it meaning.”
]

The basic form of HCI critique is:

#blockquote[
artifact / interaction → human interpretation → situated behavior → design implication
]

So when an HCI researcher says an evaluation is “too narrow,” the point is often not that measurement is bad. It is that the chosen measurement may have removed the human variability that matters.

#blockquote[
“When the phenomenon is reduced to a convenient metric, the thing we cared about may disappear.”
]

== Reading theory / formal methods sentences

Theory and formal-methods writing can seem far from implementation.

#examples(
  "“Assume an oracle...”",
  "“Under mild regularity conditions...”",
  "“We prove a lower bound...”",
  "“This is impossible in the worst case...”",
)

But these phrases usually mean:

#blockquote[
“To make a general claim, we need to state the abstraction, the assumptions, and the proof obligations precisely.”
]

The basic form of theory critique is:

#blockquote[
definition → assumption → theorem → proof → counterexample / tightness
]

So when a theory researcher says “the claim is not formal,” the point is often:

#blockquote[
“The paper has not separated the conditions under which the claim is true from the conditions under which it breaks.”
]

== Reading graphics sentences

Graphics is often a translation-heavy field. Different parts of graphics inherit different standards of evidence.

Rendering systems are close to systems:

#examples(
  "“Can this run interactively?”",
  "“What is the memory/performance tradeoff?”",
  "“Does it scale to complex scenes?”",
)

Geometry processing is close to formalization:

#examples(
  "“Is the representation well-defined?”",
  "“Does the optimization converge?”",
  "“What invariants are preserved?”",
)

Interactive graphics and creative tools are close to HCI:

#examples(
  "“Does this enable new workflows?”",
  "“Can artists control the result?”",
  "“Does the representation support exploration?”",
)

In graphics, “works” can mean many things:

- it renders quickly;
- it is visually plausible;
- it has few artifacts;
- it preserves the right invariants;
- it gives users control;
- it satisfies physical constraints;
- it is robust across shapes, scenes, and materials;
- it enables a new creative workflow.

This is why graphics papers often combine theorem, optimization, engineering, perception, interaction, and aesthetic judgment. The field is used to asking several kinds of truth to coexist in one artifact.

= The triangle is not a taxonomy; it is a conversation map

The three orientations are easier to remember as a triangle.

#figure(
  html.frame(
    block(fill: rgb("eef2f6"), inset: 0pt, width: 460pt, radius: 4pt)[
      #box(width: 460pt, height: 6.2cm)[
        #polygon(
          fill: rgb("ffffff"),
          stroke: 1pt + rgb("9fb0c2"),
          (50%, 12%), (9%, 84%), (91%, 84%),
        )
        #place(center + top, dy: 10pt)[#align(center)[
          #text(weight: "bold", size: 10.5pt, fill: rgb("1d4e89"))[Principle-centered]\
          #text(size: 8.5pt, fill: rgb("5a6b7a"))[formalization · guarantee]
        ]]
        #place(left + bottom, dx: 8%, dy: -8pt)[#align(left)[
          #text(weight: "bold", size: 10.5pt, fill: rgb("1d4e89"))[Possibility-centered]\
          #text(size: 8.5pt, fill: rgb("5a6b7a"))[exploration · design space]
        ]]
        #place(right + bottom, dx: -8%, dy: -8pt)[#align(right)[
          #text(weight: "bold", size: 10.5pt, fill: rgb("1d4e89"))[Constraint-centered]\
          #text(size: 8.5pt, fill: rgb("5a6b7a"))[optimization · systems reality]
        ]]
      ]
    ]
  ),
  caption: [A conversation map for research orientations. The corners are not boxes. They are questions that fields tend to ask first.],
)

Possibility-centered research asks:

#blockquote[
“What becomes possible?”
]

Constraint-centered research asks:

#blockquote[
“What survives real conditions?”
]

Principle-centered research asks:

#blockquote[
“What can be stated generally, proved, bounded, or falsified?”
]

These questions do not replace one another. Strong research often moves through them.

It may start by showing a possibility:

#blockquote[
“This interaction is possible.”
]

Then it meets constraints:

#blockquote[
“How does this behave under latency, cost, failure, robustness, and deployment constraints?”
]

Then it becomes more principled:

#blockquote[
“What is the mechanism? When does it fail? What is the falsifiable hypothesis? Under which assumptions can we guarantee something?”
]

Many research areas follow this cycle: AI, graphics, robotics, programming systems, and HCI tools all move between prototype, measurement, and principle.

= Why systems and HCI often collide

Systems and HCI collide often because they see different realities first.

Systems tends to see constraints and invariants:

- workload
- scalability
- tail behavior
- resource cost
- failure mode
- deployment condition
- measurement rigor

HCI tends to see possibility and human variability:

- situated context
- interpretation
- agency
- appropriation
- qualitative difference
- social meaning
- open-ended interaction

So the same sentence can land very differently.

When a systems researcher says:

#blockquote[
“The assumption is unrealistic.”
]

The intended meaning is often:

#blockquote[
“Let us state the operating conditions and claim boundary more clearly.”
]

But an HCI researcher may hear:

#blockquote[
“Are you saying the exploration itself is invalid?”
]

Conversely, when an HCI researcher says:

#blockquote[
“The findings are situated and open up a design space.”
]

The intended meaning is often:

#blockquote[
“We are articulating a phenomenon and a set of design possibilities before optimizing a closed objective.”
]

But a systems researcher may still ask:

#blockquote[
“What exactly improved, and under what conditions does it work?”
]

Both questions are legitimate. The conflict appears when each side treats its own first question as the only serious question.

= Fatal failures differ by field

Each field has things that are especially hard to recover from.

In possibility-centered research, the fatal failure is absence of novelty.

#blockquote[
If there is no new behavior, no new design space, no new phenomenon, and no change to the existing framing, the contribution is weak.
]

In constraint-centered research, the fatal failure is failing to meet the relevant constraint.

#blockquote[
If the bottleneck is unclear, the measurements are not convincing, the workload is mismatched, or the claim collapses at scale, the contribution is weak.
]

In principle-centered research, the fatal failure is a broken claim.

#blockquote[
If there is a counterexample, if the theorem does not support the claim, or if an assumption is missing, the contribution is weak.
]

In HCI, a fatal failure may be a mismatch between claim and evidence: a study that claims generality from a situated probe, or a design argument that ignores participant interpretation.

In graphics, a fatal failure may be a mismatch between the promised property and the artifact: a “real-time” method that does not feel interactive, a “physically plausible” model that breaks perceptually, or a representation that cannot support the edits users need.

So the useful cross-field question is not “which field is more rigorous?” The useful question is:

#blockquote[
What kind of rigor is this field protecting, and what kind of claim would break under that standard?
]

Systems rigor often lives in measurement, cost models, and constraints.

HCI rigor often lives in context, interpretation, construct validity, and careful claim scope.

Theory rigor often lives in definitions, assumptions, proofs, and counterexamples.

Graphics rigor often lives in the alignment between representation, computation, perception, control, and physical or visual plausibility.

= Collaboration does not require abandoning rigor

Interdisciplinary collaboration does not require people to soften their standards until nothing sharp remains. It requires the opposite: keep the standard, but translate it into a form the other field can use.

When a systems researcher reads an HCI paper, a useful question is:

#blockquote[
“This may not be a deployment claim yet. What possibility, behavior, or design space does it reveal?”
]

When an HCI researcher hears a systems critique, a useful interpretation is:

#blockquote[
“This may not be trying to close down exploration. It may be asking for the claim boundary, cost model, workload, and operating conditions.”
]

When a theory researcher reads an empirical paper, a useful question is:

#blockquote[
“This may not provide a formal guarantee. What phenomenon, invariant, or falsifiable hypothesis might be worth formalizing?”
]

When a graphics researcher reads across these fields, the translation often has to happen inside a single artifact:

- as HCI, the artifact opens an interaction or design space;
- as systems, it encounters latency, memory, scalability, and deployment constraints;
- as theory, it implies a representation, optimization problem, or guarantee;
- as graphics, it must also satisfy perceptual, physical, and interactive criteria.

One important skill in modern CS is therefore code-switching. The same idea may need to be described as *situated use* in HCI, as a *cost model* in systems, as *assumptions and guarantees* in theory, as *representation and perceptual quality* in graphics, and as *generalization under distribution shift* in AI/ML.

Cross-field conflict usually does not come from ignorance or bad faith. More often, it comes from different people seeing different parts of the problem first.

One side asks:

#blockquote[
“What does this make possible?”
]

Another asks:

#blockquote[
“Does this hold under real conditions?”
]

Another asks:

#blockquote[
“Can we state this generally?”
]

Good collaboration does not begin by forcing one question to win. It begins by knowing which question is needed now.

= A cross-field translation table

#table(
  columns: (1.1fr, 1.6fr, 2.4fr, 2.1fr),
  inset: 6pt,
  stroke: 0.5pt + luma(210),
  table.header[*Field*, *Common expression*, *Actual meaning*, *How it may be misunderstood*],

  [Systems / OS], [“X lacks a mechanism for Y”], [There is no structure that handles Y, so cost or failure appears.], [Sounds like a rejection of the whole idea.],
  [Systems / Arch], [“X hides locality”], [The abstraction hides hardware or resource structure, causing performance loss.], [Sounds like an overly low-level criticism.],
  [Systems], [“Does it scale?”], [Does the claim hold as workload, size, contention, or concurrency grows?], [Sounds like a way to shut down early exploration.],
  [HCI], [“We explore a design space”], [The work reveals a structure of possibilities before there is a closed objective.], [Sounds like the contribution is unclear.],
  [HCI], [“The findings are situated”], [The result should be read with its context, practice, and use conditions.], [Sounds like the work cannot generalize.],
  [HCI], [“We surface tensions”], [The work reveals real conflicts in interpretation, use, value, or practice.], [Sounds like there is no problem-solving contribution.],
  [Theory], [“Under these assumptions...”], [The paper states the conditions under which the claim holds.], [Sounds like reality is being oversimplified.],
  [Theory], [“Counterexample”], [A case that breaks a universal claim.], [Sounds like a trivial edge case.],
  [Theory / Empirical], [“Falsifiable hypothesis”], [A claim stated precisely enough that evidence could support or break it.], [Sounds too narrow for early exploratory work.],
  [Graphics], [“Visually plausible”], [Not physically exact, but perceptually convincing for the intended setting.], [Sounds like “inaccurate.”],
  [Graphics], [“Interactive”], [Responsive enough for human-in-the-loop exploration and control.], [Gets reduced to merely “fast.”],
  [AI/ML], [“Emergent behavior”], [An unexpected capability appears as scale, model, data, or training changes.], [Sounds like an unexplained anecdote.],
  [AI/ML Systems], [“Scaling bottleneck”], [Infrastructure, memory, communication, or cost becomes the limiting factor.], [Sounds like a mere engineering detail.],
)

= Useful collaborative rewrites

A systems-style expression that may sound too blunt:

#blockquote[
“This lacks a cost model.”
]

A clearer collaborative version:

#blockquote[
“The paper would be stronger if it made the operating conditions, workload, and tradeoffs explicit.”
]

#hr

A phrase that may sound too blunt:

#blockquote[
“The assumptions are unrealistic.”
]

A clearer collaborative version:

#blockquote[
“The assumptions seem reasonable for an exploratory prototype, but the claim boundary should distinguish prototype conditions from deployment conditions.”
]

#hr

A phrase that may sound too blunt:

#blockquote[
“The evaluation is weak.”
]

A clearer collaborative version:

#blockquote[
“The evaluation supports the exploratory contribution. Additional evidence would be needed for stronger claims about scalability, robustness, generality, or deployment.”
]

#hr

A phrase that may sound too blunt:

#blockquote[
“Users do not understand the system.”
]

A more HCI-appropriate version:

#blockquote[
“The interface does not yet make the system state sufficiently legible for users to form stable mental models.”
]

#hr

A phrase that may sound too blunt:

#blockquote[
“This is just a design probe.”
]

A more precise version:

#blockquote[
“The contribution is primarily generative: it reveals a design space and motivates future systematization, operationalization, or deployment-oriented evaluation.”
]

#hr

A phrase that may sound too blunt:

#blockquote[
“There is no theory.”
]

A more precise version:

#blockquote[
“The current contribution is empirical and artifact-driven. A formal characterization could be a complementary next step rather than a prerequisite for the paper’s main claim.”
]

#hr

A phrase that may sound too vague:

#blockquote[
“This works well.”
]

A more falsifiable version:

#blockquote[
“Under the stated workload and interaction context, the system improves the target metric while preserving the required level of user control.”
]

= The takeaway

The same paper can be read through different standards of truth.

Possibility asks whether the work makes something newly visible or newly doable.

Constraint asks whether the work survives the machine, the workload, the resource budget, and the deployment environment.

Principle asks whether the work states a claim precisely enough to prove, bound, falsify, or break.

None of these questions is more mature than the others. They do different jobs. The mistake is to treat one field’s first question as the only legitimate question.

A better habit is to ask:

#blockquote[
Which kind of claim is this paper making right now? What evidence would support that claim? What would break it? And what would the next corner of the triangle ask?
]

That is the real skill: not flattening every field into the same standard, but making claims crisp enough that different fields can understand what is being claimed, what is not being claimed, and what would count as progress.
