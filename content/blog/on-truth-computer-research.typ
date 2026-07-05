#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude: *

#show: main.with(
  title: "Same Computer Science, Different Senses of Reality",
  desc: "Computer-science subfields differ less in method than in what each treats as real, new, and fatal. A three-corner map for talking across fields.",
  date: "2026-07-04",
  tags: ("research", "essay"),
  show-outline: false,
)

#let blockquote(body) = block(
  fill: luma(248),
  inset: (left: 1em, right: 1em, top: 0.75em, bottom: 0.75em),
  stroke: (left: 3pt + rgb("d7dee8")),
  radius: 2pt,
  body,
)

= Same Computer Science, Different Senses of Reality

The many subfields of computer science appear, from the outside, to live under the same name. But once you actually do research, the criteria for what feels like “good research” can differ substantially across fields. Some communities care most about opening up new possibilities. Others care most about building systems that work reliably under real constraints. Others care most about defining problems precisely and organizing them around principles that can be guaranteed.

This is not merely a difference in methodology. At a deeper level, it is closer to a difference in *what each field treats as reality, what it accepts as new knowledge, and what it regards as a fatal failure*.

In this essay, I roughly divide these orientations into three directions.

- *Possibility-centered research*: research that discovers new interactions, behaviors, capabilities, or design spaces.
- *Constraint-centered research*: research that improves performance and reliability under real hardware, runtime, workload, and deployment constraints.
- *Principle-centered research*: research that formalizes problems and provides guarantees such as correctness, optimality, impossibility, or convergence.

These three directions are not meant to be a precise taxonomy. They are closer to a map for understanding conversations across fields. A field does not have to belong to only one corner. Still, each field tends to look at some things first, and those differences often create misunderstandings in collaboration.

== 1. Possibility-centered research: “What becomes possible?”

Parts of HCI, design tools, creative AI, visualization, and interactive graphics are close to possibility-centered research. In this culture, phenomena that have not yet been clearly organized, new forms of use, unexpected interactions, and emergent behaviors can themselves become important research objects.

Sentences in this area often sound like this.

#blockquote[
“We explore a new interaction paradigm.” “This system opens up a new design space.” “We surface tensions in how people use AI tools.” “The behavior cannot be fully explained by existing framings.”
]

Important words here include *explore, open up, surface, situated, design space, interpretation,* and *appropriation*.

In this culture, ambiguity is not necessarily noise that must be eliminated. Ambiguity itself can be the subject of research. How people interpret something differently, how they appropriate a tool for their own context, and how unexpected workflows emerge can all be contributions.

So the important questions in possibility-centered research are:

#blockquote[
“Does this work reveal a possibility that was previously hard to see?” “Does it show a new interaction or behavior?” “Does it capture a phenomenon that existing framings cannot explain well?” “Does it open a design space that future research can explore?”
]

Failure in this area is usually not that something is “slow” or “not optimal.” More fatal failures are:

#blockquote[
“There is nothing new to see.” “It repeats an already known phenomenon in different words.” “It oversimplifies the complexity of people and context.”
]

== 2. Constraint-centered research: “Where is the real bottleneck?”

Systems, operating systems, architecture, databases, and networking are close to constraint-centered research. In this culture, reality appears primarily as resources, hardware, workloads, runtimes, failure modes, and deployment constraints.

Sentences in this area often sound like this.

#blockquote[
“The abstraction hides locality.” “The system lacks a mechanism for efficient scheduling.” “This design fails to expose parallelism.” “Tail latency is dominated by coordination overhead.” “The assumption does not hold at scale.”
]

Important words here include *lack, hide, expose, overhead, bottleneck, locality, throughput, latency, scalability, robustness, utilization,* and *failure mode*.

In systems and architecture, the word *lack* is very natural. For example:

#blockquote[
“The design lacks locality awareness.”
]

This is usually not a moral criticism or a humanistic deficit framing. Its meaning is more technical:

#blockquote[
“This abstraction does not sufficiently expose the underlying hardware or resource structure, so cost surfaces when the system scales.”
]

In other words, when systems researchers say “lack,” they often mean a *missing mechanism, a hidden cost, an unspecified assumption, or a structural issue that will surface as a bottleneck*.

The basic intuition in this culture is:

#blockquote[
Hidden complexity eventually surfaces. Ignored costs return at scale. An abstraction cannot completely erase real constraints.
]

So systems researchers naturally ask questions like:

#blockquote[
“Is this assumption realistic?” “What is the cost model?” “Under which workloads does it hold?” “What does the tail behavior look like?” “Does it survive deployment?” “What are the failure modes?” “Was the bottleneck actually removed, or merely moved somewhere else?”
]

Failure in constraint-centered research is usually:

#blockquote[
“It does not address the real constraint.” “The bottleneck is not clear.” “The measurements do not support the claim.” “The claim collapses when scale or workload changes.”
]

== 3. Principle-centered research: “What can be guaranteed?”

Algorithms, complexity, cryptography, formal methods, and programming language theory are close to principle-centered research. In this culture, the abstraction structure itself is an important part of reality, often more important than any particular implementation. The central questions are whether a problem is precisely defined, under which conditions guarantees are possible, and in which cases something is impossible.

Sentences in this area often sound like this.

#blockquote[
“We prove a lower bound.” “We show correctness under the following assumptions.” “We characterize the identifiability condition.” “This problem admits no polynomial-time approximation unless...” “We provide a convergence guarantee.”
]

Important words here include *proof, correctness, optimality, lower bound, impossibility, convergence, identifiability,* and *formal characterization*.

In this culture, the most fatal failure is a counterexample. It is not enough for a system to work on several benchmarks. If a theoretical claim is written universally, one counterexample can break the claim.

So principle-centered researchers tend to look first at questions such as:

#blockquote[
“Is the problem precisely defined?” “What are the quantifiers in the claim?” “Are the assumptions sufficient?” “Is the guarantee actually proved?” “Is there a counterexample?” “Is the result tight?”
]

Failure in this area is usually:

#blockquote[
“The definition is vague.” “The claim is stronger than the proof.” “An assumption is missing.” “There is a counterexample.” “The formal result does not line up with the actual claim.”
]

= Same word, different meaning: performance

One of the words that most often causes cross-field misunderstanding is *performance*. Every field talks about performance, but the actual meaning can differ dramatically.

In systems and architecture, performance usually means things like:

- throughput
- latency
- tail latency
- memory footprint
- bandwidth
- cache behavior
- utilization
- energy efficiency
- scalability

That is, performance is about *how efficiently resources are used*.

In HCI, performance is broader. Task completion time and error rate can certainly be performance metrics. But in many HCI studies, performance is also connected to:

- user control
- learnability
- cognitive load
- trust calibration
- expressiveness
- agency
- workflow fit
- interpretability
- collaboration quality
- the possibility of appropriation

So in HCI, performance is often not simply “did the user finish faster?” It is closer to whether people can better understand, adjust, express, and carry out their own goals.

In graphics, performance means something different again.

- frame rate
- interactivity
- convergence speed
- visual fidelity
- perceptual plausibility
- artifact reduction
- controllability
- physical plausibility
- robustness across shapes and scenes

These concerns often become entangled.

In theory, performance is usually expressed less in terms of empirical runtime and more in terms such as:

- asymptotic complexity
- approximation ratio
- sample complexity
- regret bound
- convergence rate
- optimality gap

In AI/ML, performance is used differently again.

- accuracy
- generalization
- robustness
- sample efficiency
- scaling behavior
- benchmark score
- inference cost
- alignment with human preference
- capability under distribution shift

All of these can count as performance.

Therefore, in interdisciplinary discussion, saying “the performance is good” is not enough. One must always ask:

#blockquote[
Performance by whose standard? For what task, workload, context, and metric? Is it speed, quality, control, reliability, or a human outcome?
]

= Why the word “lack” sounds different across fields

In systems and architecture, “lack” is a very natural word.

For example:

#blockquote[
“This abstraction lacks locality awareness.” “The scheduler lacks a mechanism for handling heterogeneous workloads.” “The system lacks backpressure.”
]

These sentences usually point to a concrete technical gap. A mechanism is missing, and that missing mechanism leads to overhead, bottlenecks, instability, or underutilization.

But in HCI and design-oriented writing, “lack” has to be used carefully. In particular, when it is applied to people, users, communities, or practices, it can sound like deficit framing.

For example:

#blockquote[
“Users lack understanding.”
]

In HCI, this often sounds undesirable because it frames users as deficient. Instead, one might write:

#blockquote[
“Users developed different mental models.” “The interface did not make the system state legible.” “Participants interpreted the feedback in context-dependent ways.” “Current designs do not yet support this form of sensemaking.”
]

In other words, HCI often reframes the issue away from individual deficiency and toward the relationships among *interaction, context, representation,* and *interpretation*.

The same critique can sound much less adversarial when translated into the language of the target field.

A systems-style sentence:

#blockquote[
“The design lacks a clear cost model.”
]

A softer version for HCI or AI tools:

#blockquote[
“The current framing would benefit from making the operating conditions and tradeoffs more explicit.”
]

A systems-style sentence:

#blockquote[
“The evaluation is weak.”
]

A more appropriate version for HCI:

#blockquote[
“The evaluation currently supports the exploratory claim, but not yet a stronger claim about generality or deployment robustness.”
]

A systems-style sentence:

#blockquote[
“There are too many assumptions.”
]

A more collaborative version:

#blockquote[
“The claim boundary could be clearer: it would help to specify which assumptions are essential and which are design choices for this prototype.”
]

= How to read sentences from different fields

== Reading systems / architecture sentences

Systems and architecture sentences can often sound cold and deficiency-centered.

#blockquote[
“X hides Y.” “X fails to exploit Y.” “X lacks Z.” “X introduces overhead.” “X does not scale.”
]

But these sentences usually mean:

#blockquote[
“Because the real resource structure is not sufficiently represented inside this abstraction, some cost appears under a particular workload or scale.”
]

So this does not usually mean “the idea has no value.” More often, it means “the paper should make clearer how the claim meets real constraints.”

The basic form of systems critique is:

#blockquote[
abstraction → hidden cost → bottleneck → measurement → redesign
]

So when a systems person asks, “Is this realistic?” they are usually not saying “you lack imagination.” They are closer to saying:

#blockquote[
“I want to understand under which conditions this idea survives.”
]

== Reading HCI / design sentences

HCI and design research sentences can sometimes sound weak from a systems perspective.

#blockquote[
“We explore...” “We surface...” “We unpack...” “We open up...” “This suggests design opportunities...” “The findings are situated...”
]

But these sentences usually mean:

#blockquote[
“This work reveals phenomena, interpretations, practices, and design possibilities before the field has agreed on a single objective to optimize.”
]

Here, “situated” is not an admission that the work cannot generalize. More precisely, it means:

#blockquote[
“This result becomes meaningful within a particular context and practice, so those conditions must be read together with the result.”
]

The basic form of HCI critique is:

#blockquote[
artifact / interaction → human interpretation → situated behavior → design implication
]

So when an HCI researcher looks at a systems-style evaluation and says “too narrow,” it usually does not mean they dislike measurement itself. The meaning is closer to:

#blockquote[
“The moment we reduce this to measurable variables, important human variability may disappear.”
]

== Reading theory / formal methods sentences

Theory sentences can sometimes seem distant from reality.

#blockquote[
“Assume an oracle...” “Under mild regularity conditions...” “We prove a lower bound...” “This is impossible in the worst case...”
]

But these sentences usually mean:

#blockquote[
“To treat this phenomenon as a general principle, we need to specify the abstraction, and then determine what is possible or impossible within that abstraction.”
]

The basic form of theory critique is:

#blockquote[
definition → assumption → theorem → proof → counterexample / tightness
]

So when a theory person says “the claim is not formal,” it usually does not mean the implementation is useless. It is closer to:

#blockquote[
“The claim has not yet separated the conditions under which it is true from the conditions under which it breaks.”
]

== Reading graphics sentences

Graphics is interesting because it often sits between these three directions. Multiple epistemologies coexist inside graphics.

Rendering systems are close to systems.

#blockquote[
“Can this run interactively?” “What is the memory/performance tradeoff?” “Does it scale to complex scenes?”
]

Geometry processing is close to formalization.

#blockquote[
“Is the representation well-defined?” “Does the optimization converge?” “What invariants are preserved?”
]

Interactive graphics and creative tools are close to HCI.

#blockquote[
“Does this enable new workflows?” “Can artists control the result?” “Does the representation support exploration?”
]

In graphics, the word “works” is not simple. Depending on the paper, “works” may mean one of the following:

- it renders quickly;
- it is visually plausible;
- it has few artifacts;
- users can control it;
- it satisfies physical constraints;
- it is robust across diverse shapes or scenes;
- it enables a new creative workflow.

This is why graphics is often relatively accustomed to cross-field translation. A single SIGGRAPH-style paper may contain a theorem, optimization, engineering, perception, interaction, and aesthetic judgment at the same time.

= The triangle is not a taxonomy; it is a map for conversation

These three directions can be understood as follows.

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
  caption: [A conversational map of three research orientations. Each corner is a question a field asks first — most fields move between them.],
)

Possibility-centered research asks:

#blockquote[
“What becomes newly possible?”
]

Constraint-centered research asks:

#blockquote[
“How does this hold up under real conditions?”
]

Principle-centered research asks:

#blockquote[
“What can we say in general?”
]

These three questions do not replace one another. Good research often starts in one direction and later moves toward another.

At first, it may reveal a new possibility.

#blockquote[
“This interaction is possible.”
]

Then it encounters real constraints.

#blockquote[
“How do we maintain this under latency, cost, robustness, and deployment constraints?”
]

Over time, it may become principled.

#blockquote[
“Why does it work? When does it fail? Under which conditions can we guarantee it?”
]

Much of modern CS research follows this cycle. This is true of AI, graphics, and robotics as well.

= Why systems and HCI often collide

Systems and HCI often come into tension because they tend to see different realities first.

Systems usually sees constraints and invariants first.

- workload
- scalability
- tail behavior
- resource cost
- failure mode
- deployment condition
- measurement rigor

HCI usually sees possibility and human variability first.

- situated context
- interpretation
- agency
- appropriation
- qualitative difference
- social meaning
- open-ended interaction

This is why the same sentence can sound different across fields.

When a systems researcher says:

#blockquote[
“The assumption is unrealistic.”
]

Their intent is often:

#blockquote[
“Let us make the claim boundary clearer.”
]

But from an HCI perspective, this can sound like:

#blockquote[
“Are you saying the exploration itself is invalid?”
]

Conversely, when an HCI researcher says:

#blockquote[
“The findings are situated and open up a design space.”
]

Their intent is:

#blockquote[
“We are not yet optimizing a closed objective. We are articulating a new phenomenon and a new set of design possibilities.”
]

But from a systems perspective, this can leave behind the question:

#blockquote[
“So what exactly improved, and under what conditions does it work?”
]

This conflict is not a matter of personality. It is a structural issue created by the fact that different fields use different failure criteria.

= Fatal failures differ by field

In possibility-centered research, the fatal failure is lack of novelty.

#blockquote[
If there is no new behavior, no new design space, and no change to the existing framing, the work is weak.
]

In constraint-centered research, the fatal failure is failing to address real constraints.

#blockquote[
If the bottleneck is unclear, the measurements are weak, or the claim collapses at scale, the work is weak.
]

In principle-centered research, the fatal failure is a broken claim.

#blockquote[
If there is a counterexample, if the theorem does not support the claim, or if an assumption is missing, the work is weak.
]

So in cross-field collaboration, the important question is not “who is more rigorous?” It is to understand that each field protects a different kind of rigor.

Systems rigor lies in measurement and constraints.

HCI rigor lies in context and interpretation.

Theory rigor lies in definitions and proof.

Graphics rigor often lies in the entanglement of representation, perceptual quality, controllability, and efficiency.

= Collaboration does not require abandoning rigor

The important ability in interdisciplinary collaboration is not to abandon the rigor of one’s own field. It is to preserve that rigor while understanding how it sounds in another field’s language.

When a systems researcher reads an HCI paper, they can ask:

#blockquote[
“This work may not be making a deployment claim yet. What possibility or human behavior does it newly reveal?”
]

When an HCI researcher hears a systems critique, they can interpret it as:

#blockquote[
“This question may not be trying to close down exploration. It may be asking us to clarify the claim boundary and operating conditions.”
]

When a theory researcher reads an empirical paper, they can see it as:

#blockquote[
“Even without a formal guarantee, this paper may show a phenomenon worth formalizing.”
]

Graphics researchers often play the role of translator between these cultures because a single artifact can simultaneously:

- open a new interaction;
- encounter computational constraints;
- create a representation or optimization problem;
- require perceptual or physical criteria.

One of the important abilities in modern CS is therefore code-switching: the ability to translate the same idea into HCI language as possibility and situated use, into systems language as cost models and bottlenecks, into theory language as assumptions and guarantees, and into graphics language as representation and perceptual/interactive quality.

Conflicts across fields usually do not arise from ignorance or bad faith. More often, they arise because different people see different realities first.

One side asks:

#blockquote[
“What does this make possible?”
]

Another asks:

#blockquote[
“Does this hold up under real conditions?”
]

Still another asks:

#blockquote[
“Can we say this in general?”
]

Good collaboration does not begin by forcing one of these questions to win. It begins by knowing when each question is needed.

= A cross-field translation table

#table(
  columns: (1.1fr, 1.6fr, 2.3fr, 2.2fr),
  inset: 6pt,
  stroke: 0.5pt + luma(210),
  table.header[*Field*, *Common expression*, *Actual meaning*, *How it may be misunderstood in another field*],

  [Systems / OS], [“X lacks a mechanism for Y”], [There is no structure for handling Y, which creates cost or failure.], [Sounds like a rejection of the whole idea.],
  [Systems / Arch], [“X hides locality”], [The abstraction hides hardware or resource structure, causing performance loss.], [Sounds like an overly low-level criticism.],
  [Systems], [“Does it scale?”], [Does the claim hold as workload, size, or concurrency grows?], [Sounds like a question that shuts down early exploration.],
  [HCI], [“We explore a design space”], [The work reveals the structure of possibilities before there is a closed objective.], [Sounds like the contribution is unclear.],
  [HCI], [“The findings are situated”], [The result must be read together with its context and practice.], [Sounds like an admission that the work cannot generalize.],
  [HCI], [“We surface tensions”], [The work reveals real conflicts in interpretation, use, and value.], [Sounds like there is no problem-solving contribution.],
  [Theory], [“Under these assumptions...”], [The work states the precise conditions under which the claim holds.], [Sounds like reality is being oversimplified.],
  [Theory], [“Counterexample”], [A case that breaks a universal claim.], [Sounds like a trivial edge case.],
  [Graphics], [“Visually plausible”], [Not necessarily physically exact, but perceptually convincing.], [Sounds like it is merely inaccurate.],
  [Graphics], [“Interactive”], [Fast and responsive enough for human-in-the-loop exploration.], [Gets reduced to merely “fast.”],
  [AI/ML], [“Emergent behavior”], [An unexpected capability appears as scale, model, or data changes.], [Sounds like an unexplained observation.],
  [AI/ML Systems], [“Scaling bottleneck”], [Infrastructure or resources, rather than model capability, become the limiting factor.], [Sounds like a mere engineering problem.],
)

= Useful collaborative rewrites

A systems-style expression that may sound too blunt:

#blockquote[
“This lacks a cost model.”
]

A softer version:

#blockquote[
“The paper would be stronger if it made the operating conditions and tradeoffs explicit.”
]

---

A phrase that may sound too blunt:

#blockquote[
“The assumptions are unrealistic.”
]

A softer version:

#blockquote[
“The current assumptions seem appropriate for an exploratory prototype, but the claim boundary should distinguish prototype conditions from deployment conditions.”
]

---

A phrase that may sound too blunt:

#blockquote[
“The evaluation is weak.”
]

A softer version:

#blockquote[
“The evaluation supports the exploratory contribution, but additional evidence would be needed for claims about scalability, robustness, or generality.”
]

---

A phrase that may sound too blunt:

#blockquote[
“Users do not understand the system.”
]

A more HCI-appropriate version:

#blockquote[
“The interface does not yet make the system state sufficiently legible for users to form stable mental models.”
]

---

A phrase that may sound too blunt:

#blockquote[
“This is just a design probe.”
]

A more appropriate version:

#blockquote[
“The contribution is primarily generative: it reveals a design space and motivates future systematization or deployment-oriented evaluation.”
]

---

A phrase that may sound too blunt:

#blockquote[
“There is no theory.”
]

A more appropriate version:

#blockquote[
“The current contribution is empirical and artifact-driven; a formal characterization would be a complementary next step rather than a prerequisite for the paper’s main claim.”
]
