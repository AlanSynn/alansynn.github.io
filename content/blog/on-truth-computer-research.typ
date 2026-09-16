#import "/content/blog.typ": *

#show: main.with(
  title: "Same Computer Science, Different Senses of Reality",
  desc: "Computer-science subfields often disagree not because one is more rigorous, but because they protect different kinds of rigor: possibility, constraint, and principle.",
  date: "2026-04-04",
  tags: ("research",),
  updatedDate: "2026-08-21",
)

Computer science looks like one field from far away.

Up close, it contains many research cultures.

A theory paper, a systems paper, a vision paper, an NLP paper, a graphics paper, and an HCI paper may all contain algorithms, experiments, datasets, and software. But they can disagree sharply about what makes a contribution convincing.

The difference is not simply that they use different methods.

They learn to see different things first.

A systems researcher may first see workload, latency, locality, resource cost, and failure modes. An HCI researcher may first see interpretation, context, agency, appropriation, and sensemaking. A theory researcher may first see definitions, assumptions, quantifiers, counterexamples, and proof obligations. A graphics researcher may have to see representation, optimization, perception, interaction, and speed at the same time.

Computer vision, NLP, machine learning, visualization, robotics, programming languages, and other areas develop their own versions of this research vocabulary.

So before asking which field is “more rigorous,” it helps to ask a simpler question:

#blockquote[
What does this field learn to notice first?
]

That question explains a surprising amount about how computer scientists write papers, evaluate evidence, criticize one another, and sometimes talk past one another.

= A rough map of computer science research cultures

This is not an official taxonomy.

Fields overlap. Individual papers move between communities. A single researcher may work in several modes.

The goal is simpler: recognize what different fields tend to treat as the important object, the important question, and the important failure.

Each field below is folded; open the ones you want to read.

#fold("Theory and algorithms")[
  Theory begins with a precisely stated problem.

  Typical sentences sound like:

  #examples(
    "“We prove a lower bound.”",
    "“We show correctness under the following assumptions.”",
    "“We characterize the identifiability condition.”",
    "“This problem admits no polynomial-time approximation unless...”",
    "“We provide a convergence guarantee.”",
  )

  The important words are *definition, assumption, proof, correctness, optimality, lower bound, impossibility, convergence, identifiability, tightness,* and *counterexample*.

  The first questions are often:

  #examples(
    "“What exactly is the problem?”",
    "“What are the quantifiers?”",
    "“Which assumptions are necessary?”",
    "“Is the theorem strong enough for the claim?”",
    "“Is there a counterexample?”",
    "“Is the bound tight?”",
  )

  Here, abstraction is not something that comes after the “real” problem.

  The abstraction is part of the real work.

  A theorem separates the conditions under which a statement is true from the conditions under which it is not. That is why one counterexample can matter so much. If the paper makes a universal claim, one valid counterexample can break it.

  The most serious failure is therefore a broken claim: an unstated assumption, a theorem that does not imply what the paper says it implies, or a counterexample that invalidates the statement.
]

#fold("Programming languages and formal methods")[
  Programming languages and formal methods share some of the culture of theory, but their central objects are often programs, languages, type systems, semantics, specifications, and verification procedures.

  Characteristic questions are:

  #examples(
    "“What property does the type system guarantee?”",
    "“Is the transformation semantics-preserving?”",
    "“Under which assumptions is the program correct?”",
    "“Can this invariant be maintained?”",
    "“What class of programs can the analysis verify?”",
  )

  Important words include *soundness, completeness, semantics, specification, invariant, type safety, correctness,* and *verification*.

  A working implementation can be useful evidence, but it is not the same as a guarantee.

  If a type system claims to rule out a class of errors, the important question is whether the formal result actually establishes that property.

  The field protects the relationship between specification and guarantee.
]

#fold("Systems, architecture, databases, and networking")[
  Systems research sees computation through resources and constraints.

  Typical sentences sound like:

  #examples(
    "“The abstraction hides locality.”",
    "“The system lacks a mechanism for efficient scheduling.”",
    "“This design fails to expose parallelism.”",
    "“Tail latency is dominated by coordination overhead.”",
    "“The assumption does not hold at scale.”",
  )

  Important words include *lack, hide, expose, overhead, bottleneck, locality, throughput, latency, tail latency, scalability, robustness, utilization, cost model,* and *failure mode*.

  The first questions are often:

  #examples(
    "“What is the cost model?”",
    "“Which workload is this claim about?”",
    "“What happens at the tail?”",
    "“What is the failure mode?”",
    "“Does the result survive scale, contention, heterogeneity, and deployment?”",
    "“Was the bottleneck removed, or moved somewhere else?”",
  )

  A systems critique tries to locate the missing mechanism, hidden cost, unstated assumption, or bottleneck.

  The instinct is simple:

  #blockquote[
  Hidden complexity returns. Ignored cost returns. A clean abstraction still has to meet the machine, the workload, and the deployment environment.
  ]

  This is also why the word *lack* sounds completely normal in systems writing.

  #blockquote[
  “The design lacks locality awareness.”
  ]

  The sentence is usually technical rather than moral. It means that the abstraction fails to expose some relevant resource structure, and that omission creates a cost under a particular workload or scale.

  The basic reasoning often looks like:

  #blockquote[
  abstraction → hidden cost → bottleneck → measurement → redesign
  ]

  A strong systems claim therefore tends to have a boundary.

  Under workload W, on system S, with metric M, the design improves X.

  Without the workload, machine, scale, and metric, “faster” or “more efficient” means very little.
]

#fold("Machine learning")[
  Machine learning usually studies a learned model rather than a completely hand-specified mechanism.

  That changes the language of the field.

  Important words include *accuracy, generalization, robustness, calibration, sample efficiency, benchmark score, inference cost, scaling behavior,* and *distribution shift*.

  Common questions include:

  #examples(
    "“Does the model generalize?”",
    "“How robust is the result?”",
    "“Does the improvement hold across datasets?”",
    "“What happens under distribution shift?”",
    "“How does performance change with data, model size, or compute?”",
  )

  A model can fit its training distribution extremely well and still fail to support a stronger claim about generalization.

  Likewise, a benchmark improvement is not automatically evidence that the model learned the structure researchers intended it to learn.

  The improvement might depend on dataset artifacts, optimization choices, scale, leakage, or a shortcut that happens to work on the benchmark.

  This gives machine learning an interesting position.

  Its evidence is often empirical, but many of its desired claims are broader:

  #blockquote[
  Does the learned behavior persist beyond the examples we happened to test?
  ]

  That question connects machine learning to both constraint-centered and principle-centered research.
]

#fold("Computer vision")[
  Computer vision inherits much of machine learning’s empirical culture, but its objects are specifically visual.

  Images, video, scenes, geometry, objects, motion, correspondence, reconstruction, and visual representation all matter.

  Different vision problems therefore develop different meanings of success.

  In recognition, researchers may ask whether a method correctly detects, classifies, or segments objects.

  In reconstruction and geometry, they may ask whether the recovered structure matches the observed scene.

  In tracking, they care about correspondence across time.

  In neural rendering, they may care about novel-view quality, geometry, speed, and robustness together.

  Characteristic questions sound like:

  #examples(
    "“Does the method generalize to unseen scenes?”",
    "“How robust is it to occlusion?”",
    "“What happens under viewpoint or illumination changes?”",
    "“Does the representation preserve fine geometric detail?”",
    "“How well does the reconstruction explain the observed images?”",
  )

  A single number rarely describes all of these properties.

  A method can score well on one benchmark while producing poor geometry.

  It can reconstruct the training views well while failing at novel views.

  It can work on carefully captured scenes while becoming unstable under motion, occlusion, or lighting changes.

  So computer vision repeatedly asks whether the representation captures the visual structure the paper claims it captures.
]

#fold("Natural language processing")[
  NLP inherits much of the model-centric culture of machine learning, but language introduces another layer of difficulty.

  The object may be classification, translation, retrieval, summarization, generation, factuality, reasoning, dialogue, or meaning itself.

  Those are not interchangeable objectives.

  Typical questions include:

  #examples(
    "“Does the improvement transfer across domains?”",
    "“Does the model preserve meaning?”",
    "“How factual are the generated responses?”",
    "“Does performance hold on out-of-distribution examples?”",
    "“Is the model actually using the intended linguistic information?”",
  )

  A response can be fluent but wrong.

  A model can obtain the correct answer while exploiting a shortcut.

  A benchmark score can improve while behavior on a different domain becomes worse.

  And two responses can communicate essentially the same information while differing substantially at the token level.

  NLP therefore often has to separate questions that initially look like one:

  #examples(
    "Is the language fluent?",
    "Is the content correct?",
    "Is the behavior robust?",
    "Is meaning preserved?",
    "Is the model using the evidence we think it is using?",
  )

  Large language models make these distinctions particularly visible, but the underlying tension is older than LLMs.

  Language quality is not a single variable.
]

#fold("Graphics")[
  Graphics is a particularly interesting case because several research cultures coexist inside one field.

  What counts as “working” depends heavily on what kind of graphics problem is being solved.

  === Rendering and graphics systems

  Rendering systems often sound like systems research:

  #examples(
    "“Can this run interactively?”",
    "“What is the memory/performance tradeoff?”",
    "“Does it scale to complex scenes?”",
  )

  Frame rate, latency, memory, bandwidth, approximation, image quality, and scene complexity can all matter.

  A method that produces an excellent image in ten minutes and one that produces a slightly worse image in sixteen milliseconds may be solving different problems.

  So raw visual quality is not enough.

  The operating regime matters.

  === Geometry processing

  Geometry processing often sounds closer to formalization:

  #examples(
    "“Is the representation well-defined?”",
    "“Does the optimization converge?”",
    "“What invariants are preserved?”",
  )

  Here, the representation itself may be the main contribution.

  Topology, discretization, numerical stability, deformation behavior, physical constraints, and robustness across shapes may all matter.

  A method can generate visually attractive examples while still failing because it does not preserve the property it claims to preserve.

  === Interactive and creative graphics

  Interactive graphics and creative tools often sound closer to HCI:

  #examples(
    "“Does this enable new workflows?”",
    "“Can artists control the result?”",
    "“Does the representation support exploration?”",
  )

  Now speed alone is insufficient.

  The method may need to expose the right parameters. It may need to respond quickly enough for human-in-the-loop exploration. The output may need to be editable rather than merely realistic.

  So in graphics, “works” can mean many things:

  - it renders quickly;
  - it is visually plausible;
  - it has few artifacts;
  - it preserves the right invariants;
  - it gives users control;
  - it satisfies physical constraints;
  - it is robust across shapes, scenes, and materials;
  - it enables a new creative workflow.

  Graphics is used to asking several kinds of truth to coexist in one artifact.
]

#fold("HCI and design research")[
  HCI begins from a different object.

  The system matters, but so do people, interpretation, practice, context, and use.

  Typical sentences sound like:

  #examples(
    "“We explore...”",
    "“We surface...”",
    "“We unpack...”",
    "“We open up...”",
    "“This suggests design opportunities...”",
    "“The findings are situated...”",
  )

  To someone trained in systems or theory, this language can initially sound vague.

  But it usually signals a different type of contribution.

  The field may not yet have a closed objective to optimize. The research may instead be trying to make a phenomenon, practice, tension, or design possibility visible.

  “Situated” is therefore an important word.

  It does not mean “not rigorous.”

  It means that the result should be read together with the participants, artifact, practice, context, and use conditions that give the observation meaning.

  The characteristic questions are closer to:

  #examples(
    "“What does this make possible?”",
    "“What new behavior or interaction does it reveal?”",
    "“What design space does it open?”",
    "“What phenomenon does the existing vocabulary fail to explain?”",
  )

  The serious failures also sound different.

  The problem may be that the work repeats a known framing in different words.

  The artifact may not actually reveal a new design space.

  The analysis may flatten the complexity of people, practice, or context.

  Or the evidence may support a situated observation while the paper makes a much broader claim.

  HCI rigor often lives in careful interpretation and careful claim scope.
]

#fold("Visualization")[
  Visualization sits between graphics, HCI, perception, and data analysis.

  Its central object is not simply an image.

  It is a representation intended to help someone see, compare, reason about, or interact with data.

  Characteristic questions include:

  #examples(
    "“Does the representation make the relevant structure visible?”",
    "“Can people accurately perform the intended analytical task?”",
    "“How does the visual encoding affect interpretation?”",
    "“Does the interaction support comparison and exploration?”",
  )

  A visualization can render perfectly and still fail.

  The encoding may make an important comparison difficult.

  The interaction may encourage the wrong interpretation.

  An evaluation may optimize task completion time while missing the reasoning process that motivated the visualization in the first place.

  Visualization therefore makes the difference between computational performance and human performance particularly obvious.
]

#fold("Robotics")[
  Robotics brings another kind of reality into computer science: the physical world.

  Its objects include perception, state estimation, planning, control, dynamics, contact, uncertainty, embodiment, and real-time execution.

  Characteristic questions include:

  #examples(
    "“Does the controller remain stable under perturbations?”",
    "“Does the policy transfer from simulation to the real robot?”",
    "“Can the system recover from perception or control errors?”",
    "“Does the planner satisfy the physical constraints?”",
    "“Can the robot repeat the task outside the demonstration environment?”",
  )

  Robotics combines several research cultures.

  Perception may look like computer vision.

  Learning may look like machine learning.

  Planning may look like algorithms.

  Control may rely on mathematical guarantees.

  Real-time execution looks like systems.

  Human-robot interaction can look like HCI.

  And eventually the physical robot gets a vote.

  A method can work perfectly in simulation and fail because of friction, sensing noise, calibration, latency, unmodeled contact, or a slightly different environment.

  So robustness in robotics is not an abstract preference.

  It is often the difference between a method that works in a figure and one that works in the world.
]

= Three recurring orientations

Once the fields are introduced separately, a broader pattern becomes visible.

Three questions appear again and again.

They are not fields.

They are orientations that different fields move between.

== Possibility-centered research

The first question is:

#blockquote[
“What becomes possible?”
]

This orientation appears strongly in HCI, design research, interactive graphics, visualization, creative tools, and exploratory AI work.

The research may reveal a new interaction, workflow, behavior, phenomenon, or design space.

Typical language includes:

#examples(
  "“We explore...”",
  "“We surface...”",
  "“We open up...”",
  "“This suggests design opportunities...”",
)

The contribution is generative.

It makes something newly visible or newly doable.

That does not mean anything goes.

A possibility-centered contribution still has to make clear what is newly visible, what evidence supports it, and where the claim ends.

But it does not always begin with a closed objective.

Sometimes the first contribution is making the phenomenon legible enough that later work can measure, formalize, optimize, or deploy it.

== Constraint-centered research

The second question is:

#blockquote[
“What survives real conditions?”
]

This orientation appears strongly in systems, architecture, networking, databases, robotics, rendering systems, and ML systems.

The relevant reality may be:

- hardware;
- runtime;
- workload;
- latency;
- memory;
- scale;
- noise;
- contention;
- failures;
- deployment;
- physical dynamics.

Typical language includes:

#examples(
  "“The abstraction hides locality.”",
  "“This design introduces overhead.”",
  "“The assumption does not hold at scale.”",
  "“What is the bottleneck?”",
  "“What happens at the tail?”",
)

The contribution has to survive the conditions it gestures toward.

An elegant mechanism that only works after excluding the dominant real-world cost may not support the claim being made.

== Principle-centered research

The third question is:

#blockquote[
“What can be stated generally, proved, bounded, or falsified?”
]

This orientation appears strongly in theory, algorithms, formal methods, programming languages, optimization, and parts of geometry and learning theory.

Typical language includes:

#examples(
  "“We prove...”",
  "“Under the following assumptions...”",
  "“We provide a guarantee...”",
  "“Is there a counterexample?”",
  "“Is the bound tight?”",
)

The contribution protects the relationship between claim and implication.

Definitions matter because changing the definition can change the theorem.

Assumptions matter because removing one may break the result.

Counterexamples matter because they reveal the boundary of a universal statement.

= The triangle is a conversation map, not a taxonomy

These orientations are easiest to remember as a triangle:

*Possibility*

#blockquote[
What becomes possible?
]

*Constraint*

#blockquote[
What survives real conditions?
]

*Principle*

#blockquote[
What can be stated generally, proved, bounded, or falsified?
]

But fields should not be placed permanently into corners.

A better description is that different fields often *start* closer to different questions.

Theory and formal methods often start near principle.

Systems and architecture often start near constraint.

HCI and design research often start near possibility.

But most interesting fields move.

Graphics moves constantly among representation, computation, perception, interaction, and constraints.

Robotics moves among learning, formal control, physical constraints, and human interaction.

Machine learning moves between empirical possibility, scaling constraints, and questions about generalization.

Vision moves between learned representations, geometry, perceptual evidence, robustness, and computational constraints.

NLP moves between empirical capability, linguistic interpretation, generalization, evaluation, and human use.

Visualization moves between representation, perception, interaction, and analytical goals.

The triangle is therefore not a taxonomy of computer science.

It is a map for understanding what question a piece of research is asking *right now*.

A project may begin by showing a possibility:

#blockquote[
“This interaction is possible.”
]

Then it encounters constraints:

#blockquote[
“How does it behave under latency, cost, failure, robustness, and deployment constraints?”
]

Then it may become more principled:

#blockquote[
“What is the mechanism? When does it fail? Under which assumptions can we guarantee something?”
]

The direction can also go the other way.

A theorem may suggest a representation.

A new representation may enable a system.

A system may make a new interaction possible.

Research moves around the triangle.

= The same word can mean different things

Once fields protect different kinds of claims, even ordinary technical words become unstable.

The easiest example is *performance*.

Everyone talks about performance.

They do not necessarily mean the same thing.

#fold("Performance in systems")[
  In systems and architecture, performance often means:

  - throughput;
  - latency;
  - tail latency;
  - memory footprint;
  - bandwidth;
  - cache behavior;
  - utilization;
  - energy efficiency;
  - scalability.

  The question is usually:

  #blockquote[
  How efficiently are resources used under a particular workload?
  ]

  The workload matters.

  The hardware matters.

  The operating conditions matter.

  A throughput number with no workload is barely a claim.
]

#fold("Performance in machine learning")[
  In machine learning, performance may mean:

  - accuracy;
  - loss;
  - generalization;
  - robustness;
  - calibration;
  - sample efficiency;
  - benchmark score;
  - inference cost;
  - scaling behavior;
  - capability under distribution shift.

  A high benchmark score may be useful, but the stronger question is often whether the behavior survives beyond that benchmark.
]

#fold("Performance in computer vision")[
  Vision adds visual and geometric criteria.

  Depending on the task, performance may refer to:

  - recognition accuracy;
  - detection quality;
  - segmentation quality;
  - reconstruction error;
  - geometric fidelity;
  - novel-view quality;
  - robustness to occlusion;
  - robustness to viewpoint or illumination;
  - runtime.

  A method can therefore improve one notion of performance while making another worse.
]

#fold("Performance in NLP")[
  NLP may care about:

  - task accuracy;
  - generation quality;
  - factuality;
  - calibration;
  - transfer;
  - robustness;
  - semantic preservation;
  - human preference;
  - inference cost.

  Fluency is one property.

  Correctness is another.

  Factuality is another.

  They should not be collapsed into a single notion of “good language.”
]

#fold("Performance in HCI")[
  HCI can include task completion time and error rate, but it often also cares about:

  - user control;
  - learnability;
  - cognitive load;
  - trust calibration;
  - expressiveness;
  - agency;
  - workflow fit;
  - interpretability;
  - collaboration quality;
  - appropriation.

  The relevant question may not be:

  #blockquote[
  Did the person finish faster?
  ]

  It may instead be:

  #blockquote[
  Did the system help people understand, decide, coordinate, express, and act in ways that matter for their goals?
  ]
]

#fold("Performance in visualization")[
  Visualization can inherit both computational and human criteria.

  A visualization may need to render quickly, but it may also need to help people compare values, detect structure, understand uncertainty, or maintain context during exploration.

  A faster visualization is not necessarily a better visualization if its representation makes the intended analytical task harder.
]

#fold("Performance in graphics")[
  Graphics often combines computational and perceptual criteria:

  - frame rate;
  - interactivity;
  - convergence speed;
  - visual fidelity;
  - perceptual plausibility;
  - artifact reduction;
  - controllability;
  - physical plausibility;
  - robustness across shapes, scenes, and materials.

  “Interactive” is particularly interesting.

  It is partly computational, but it is also human.

  Interactive means responsive enough for a person to remain in the loop.
]

#fold("Performance in robotics")[
  Robotics adds physical execution:

  - task success;
  - tracking or control error;
  - robustness;
  - stability;
  - planning time;
  - recovery from disturbances;
  - real-time execution;
  - transfer from simulation;
  - repeatability in the physical world.

  A policy with high success in simulation may still have poor real-world performance.
]

#fold("Performance in theory")[
  In theory, performance may instead be expressed as:

  - asymptotic complexity;
  - approximation ratio;
  - sample complexity;
  - regret bound;
  - convergence rate;
  - optimality gap.

  Here, “performance” may describe what can be guaranteed for an entire class of problems rather than what happened during one experimental run.
]

So the sentence

#blockquote[
“The performance is good.”
]

is almost content-free.

The useful question is:

#blockquote[
Performance by whose standard? On what task, workload, context, and metric? Is the claim about speed, quality, control, reliability, generalization, perception, or human outcome?
]

The same applies to words such as *robust, scalable, usable, interpretable, interactive, optimal, realistic,* and *general*.

These words need a claim boundary.

= Why “lack” sounds different across fields

Another useful example is the word *lack*.

In systems and architecture, *lack* is often a normal technical description.

#examples(
  "“This abstraction lacks locality awareness.”",
  "“The scheduler lacks a mechanism for heterogeneous workloads.”",
  "“The system lacks backpressure.”",
)

The sentence points to a missing mechanism.

The missing mechanism then explains a bottleneck, overhead, instability, or underutilization.

But consider:

#blockquote[
“Users lack understanding.”
]

In HCI, this sentence is much more delicate.

It puts the problem inside the user.

The analysis can often become more precise by moving from a deficit in the person to a relationship among the person, representation, interface, feedback, and context.

For example:

#examples(
  "“Users developed different mental models.”",
  "“The interface did not make the system state legible.”",
  "“Participants interpreted the feedback in context-dependent ways.”",
  "“Current designs do not yet support this form of sensemaking.”",
)

The difference is not cosmetic.

It changes where the research looks for the problem.

A systems researcher may look for the missing mechanism in an abstraction.

An HCI researcher may look for the relation among representation, interaction, interpretation, and context.

The same grammatical pattern can therefore imply very different theories of what went wrong.

= Why fields talk past one another

The difficulty becomes clearer if we compare what different researchers may notice first.

A systems researcher may first notice:

- workload;
- scalability;
- tail behavior;
- resource cost;
- failure mode;
- deployment condition;
- measurement rigor.

An HCI researcher may first notice:

- situated context;
- interpretation;
- agency;
- appropriation;
- qualitative difference;
- social meaning;
- open-ended interaction.

A theory researcher may first notice:

- definitions;
- assumptions;
- quantifiers;
- proof obligations;
- counterexamples;
- guarantees.

A vision researcher may first notice:

- representation;
- geometry;
- visual evidence;
- generalization;
- occlusion;
- viewpoint.

An NLP researcher may first notice:

- linguistic signal;
- semantic preservation;
- transfer;
- factuality;
- robustness;
- evaluation.

A robotics researcher may first notice:

- sensing;
- uncertainty;
- dynamics;
- closed-loop behavior;
- physical failure.

A graphics researcher may need to notice representation, optimization, perception, interaction, and speed all at once.

These are not merely different methods.

They are different senses of where a claim is most likely to break.

== A systems sentence heard by HCI

A systems researcher may say:

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

Those are different claims.

The systems researcher may be asking what conditions the idea survives.

The HCI researcher may think the exploratory contribution is being dismissed before deployment is even the point.

== An HCI sentence heard by systems

An HCI researcher may say:

#blockquote[
“The findings are situated and open up a design space.”
]

The intended meaning is often:

#blockquote[
“We are articulating a phenomenon and a set of design possibilities before optimizing a closed objective.”
]

A systems researcher may still ask:

#blockquote[
“What exactly improved, and under what conditions does it work?”
]

Again, both questions are legitimate.

They simply protect different parts of the claim.

The conflict appears when either side treats its own first question as the only serious one.

= What breaks a contribution also differs by field

Another way to understand research cultures is to ask what kind of failure is especially damaging.

#fold("Theory")[
  A counterexample can break a universal claim.

  A missing assumption can invalidate a theorem.

  A proof that establishes a weaker property than the paper claims is a central problem.

  The contribution lives or dies by the relationship among definition, assumption, theorem, and implication.
]

#fold("Programming languages and formal methods")[
  A claimed safety or correctness property that the formal system does not actually guarantee is a central failure.

  The implementation may look convincing, but it cannot substitute for the formal property if the contribution is stated as a guarantee.
]

#fold("Systems")[
  A systems claim becomes weak when the bottleneck is unclear, the workload does not match the claim, the measurements do not isolate the relevant mechanism, or the design removes one cost by hiding another.

  A system that “scales” only after excluding the difficult part of the workload has not necessarily supported a scalability claim.
]

#fold("Machine learning")[
  A benchmark gain becomes weak evidence when it disappears across seeds, datasets, distributions, or reasonable evaluation choices.

  A model may also support a prediction claim without supporting a stronger explanation about what it learned.

  The claim boundary matters.
]

#fold("Computer vision")[
  A method may perform well on a benchmark while failing under viewpoint changes, occlusion, unseen scenes, or different capture conditions.

  A visually appealing reconstruction may still have incorrect geometry.

  A representation that explains training views may fail at novel views.

  The important failure depends on what the paper promised.
]

#fold("NLP")[
  A fluent answer can be factually wrong.

  A model can solve a benchmark through a shortcut.

  A method can improve one metric without preserving meaning.

  An evaluation can therefore look convincing while missing the behavior the paper actually claims to improve.
]

#fold("Graphics")[
  A graphics contribution often breaks when the promised property and the artifact do not align.

  A “real-time” method that does not feel interactive has a problem.

  A “physically plausible” model that fails perceptually has a problem.

  A representation for editing that does not expose useful control has a problem.

  A visually impressive method that fails across ordinary shapes, materials, or scenes may have a robustness problem.

  Graphics papers often promise several properties simultaneously, which is why their evaluations can become unusually heterogeneous.
]

#fold("HCI")[
  A serious HCI problem is often a mismatch between claim and evidence.

  A situated probe cannot automatically support a universal claim.

  A design argument can become weak if it ignores how participants interpreted or appropriated the artifact.

  An exploratory system can also fail to reveal anything meaningfully new.

  The important question is not whether the study looks like a systems benchmark.

  It is whether the evidence actually supports the type of HCI claim being made.
]

#fold("Visualization")[
  A visualization can fail because its representation does not support the analytical task it claims to support.

  A controlled study can also be too narrow if the experimental task removes the reasoning behavior that motivated the design.

  The computational system may work perfectly while the representation fails as a tool for thinking.
]

#fold("Robotics")[
  Robotics exposes fragile claims quickly.

  A method that succeeds only in simulation may not support a real-world robotics claim.

  A controller that works only with precise initialization may not be robust.

  A system that cannot recover from small sensing or control errors may fail once it leaves a carefully prepared demonstration.

  The physical world continually tests the assumptions hidden in the model.
]

= Translating critique across fields

Interdisciplinary collaboration does not require people to weaken their standards.

It requires keeping the standard while translating the critique into a form that another field can use.

Consider:

#blockquote[
“This lacks a cost model.”
]

A more collaborative version is:

#blockquote[
“The paper would be stronger if it made the operating conditions, workload, and tradeoffs explicit.”
]

The criticism remains.

But now the missing evidence is clear.

Consider:

#blockquote[
“The assumptions are unrealistic.”
]

A more precise version is:

#blockquote[
“The assumptions seem reasonable for an exploratory prototype, but the claim boundary should distinguish prototype conditions from deployment conditions.”
]

Again, the critique remains.

It no longer confuses an exploratory claim with a deployment claim.

Consider:

#blockquote[
“The evaluation is weak.”
]

A more useful version is:

#blockquote[
“The evaluation supports the exploratory contribution. Additional evidence would be needed for stronger claims about scalability, robustness, generality, or deployment.”
]

Now the criticism says exactly which stronger claims are unsupported.

Consider:

#blockquote[
“Users do not understand the system.”
]

A more HCI-appropriate formulation is:

#blockquote[
“The interface does not yet make the system state sufficiently legible for users to form stable mental models.”
]

This changes the explanatory target from a deficit in the user to a property of the interaction between user and system.

Consider:

#blockquote[
“This is just a design probe.”
]

A more precise version is:

#blockquote[
“The contribution is primarily generative: it reveals a design space and motivates future systematization, operationalization, or deployment-oriented evaluation.”
]

And consider:

#blockquote[
“There is no theory.”
]

A more precise version is:

#blockquote[
“The current contribution is empirical and artifact-driven. A formal characterization could be a complementary next step rather than a prerequisite for the paper’s main claim.”
]

Good translation should not remove criticism.

It should reveal exactly which claim the criticism applies to.

= Research often moves from one question to another

The three orientations do not replace one another.

Strong research often moves among them.

A new HCI interaction may begin with:

#blockquote[
What does this make possible?
]

Once the interaction is useful, systems questions appear:

#blockquote[
Can it remain responsive at realistic scale?
]

Then a more principled question may emerge:

#blockquote[
What property of the representation actually makes the interaction work?
]

A robotics project may begin with a new learned behavior.

Then reality introduces noise, delay, contact, and hardware constraints.

Later, researchers may ask whether the behavior can be characterized or guaranteed under particular assumptions.

A graphics technique may begin as a new representation.

Then researchers optimize it until it becomes interactive.

Once artists use it, new questions about control and workflow appear.

A machine-learning capability may first be surprising.

Then the field asks whether it generalizes.

Then systems researchers ask what it costs to train and serve.

Then theory may ask which mechanism or scaling relation explains the behavior.

Research areas mature by moving among different questions, not by permanently graduating from one kind of rigor to another.

= The broader skill is knowing which question is needed now

The same paper can be read through several standards of truth.

*Possibility* asks whether the work makes something newly visible or newly doable.

*Constraint* asks whether the work survives the machine, workload, resource budget, physical world, or deployment environment.

*Principle* asks whether the work states a claim precisely enough to prove, bound, falsify, or break.

Different fields also add their own dimensions.

Vision asks whether the representation captures the relevant visual structure.

NLP asks whether linguistic behavior, meaning, and correctness survive changes in context and evaluation.

Graphics asks whether representation, computation, perception, physical plausibility, and control align.

HCI asks whether the interpretation of people and practices supports the claim.

Robotics asks whether the computation survives embodiment.

Visualization asks whether the representation actually supports reasoning.

None of these standards is automatically more mature than another.

They do different jobs.

The mistake is to take one field’s first question and treat it as the only legitimate question.

A better habit is to ask:

#examples(
  "Which kind of claim is this paper making right now?",
  "What evidence would support that claim?",
  "What would break it?",
  "Which research culture is this sentence speaking from?",
  "And what question would the next field ask?",
)

That is the real cross-field skill.

Not flattening every area of computer science into one standard.

Not pretending that every kind of contribution should be evaluated by the same metric.

But making the claim clear enough that researchers from different fields can understand what is being claimed, what is not being claimed, and what would count as progress.
