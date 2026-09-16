#import "/content/blog.typ": *

#show: main.with(
  title: "Industry and Academia Ask Different Things of Research",
  desc: "The difference between research in industry and academia may lie less in what researchers study than in what their answers are expected to do, survive, and become.",
  date: "2026-09-14",
  tags: ("research-cultures", "academia"),
)

When people compare research in academia and industry, the differences arrive quickly. Industry moves faster. Academia has more freedom. Companies have more data and engineering resources. Universities publish papers. Companies build products. Academic researchers are supposed to ask fundamental questions, while industry researchers are supposed to solve practical ones.

I have repeated versions of this comparison myself. Most of them contain some truth, and in some places they may describe daily life very well. But one part of the story has always felt too clean to me: the idea that academia produces knowledge while industry mainly applies it.

Some of the industrial research I admire most does not fit that description. (It is difficult for me to think about Bell Labs, Xerox PARC, or Disney Research and still believe that "industry research is applied research" explains very much.) The reverse is also easy to find. Academic research can be deeply tied to a particular system, community, or practical problem.

So I have become less interested in asking which side is more fundamental, practical, fast, or free. Those differences matter, but they move too easily across institutions and projects to explain what I am trying to understand.

The question I keep returning to appears one step later:

#blockquote[
What does an answer have to become after we find it?
]

= What an answer is for

The institution still matters, but perhaps not because one institution owns one kind of research. It matters because different environments ask different things from an answer. Two teams may study similar problems with similar methods, yet the result may have to survive very different futures.

Two pressures seem especially important to me. Some answers need to leave the place where they were produced. Other answers need to change what happens in that place. Most serious research needs some mixture of both, but the balance changes what researchers write down, what they measure, when they stop, and what they consider a successful result.

== An answer that has to leave

Much of academic research is written for separation. Someone who did not design the study should be able to understand the claim. Someone who does not know the authors should be able to inspect the reasoning. Another researcher may try the method on a different dataset, in another laboratory, or years later under conditions the original authors never imagined.

That is one reason academic work spends so much effort making context explicit. Researchers state assumptions that everyone on the project already knew, describe methods that felt obvious while doing the work, distinguish what they observed from what they inferred, and explain where the claim should stop. The answer is being prepared to travel without the people who produced it.

#blockquote[
Some knowledge becomes valuable because it can leave.
]

Publication does not guarantee that an answer actually travels. A paper can depend on private data, fragile code, rare equipment, or tacit knowledge that never made it onto the page. Still, the aspiration matters. Academic knowledge is often judged partly by whether a stranger can understand what was learned, why it should be believed, and how far the claim can be carried.

== An answer that has to change something

Other research is organized around a more immediate destination. Should we ship this? Should we replace the current system? Did the change help enough to justify its cost? Is this failure serious enough to stop a launch? Should we keep investing in this direction?

These can be difficult research questions. They may require careful experiments, qualitative work, technical depth, and years of domain knowledge. But the answer can be valuable even if it never becomes a general statement about the world. It may be enough that the research changes a consequential decision.

#blockquote[
Some knowledge becomes valuable because it can act.
]

This pressure is not unique to companies, just as traveling knowledge is not unique to universities. The distinction is not a taxonomy of institutions. It is a distinction between what an answer is being asked to do.

Once I started thinking this way, another question followed naturally. If the destination of the answer changes, should the point at which we say "we know enough" change too?

= When is the answer enough?

Every researcher would prefer better evidence. More data can narrow uncertainty. Better controls can remove alternative explanations. Replication can show whether a result survives another setting. But research cannot continue forever, so every project eventually contains a stopping rule, whether we state it or not.

What interests me is that this stopping rule is not determined by evidence alone.

== A paper can end while the question stays open

A paper can make a bounded contribution without resolving the larger question. Another group can challenge an assumption, add a dataset, find a counterexample, or show that the result disappears under a different condition. In a healthy research culture, publication makes a claim available for further argument rather than making it untouchable.

This is why careful academic claims often sound narrower than the questions that motivated them. _Under these assumptions, with this population, on these tasks, we found this._ The project ends because this unit of work is ready to be exposed to others. The question itself can remain open.

Academia does not always live up to that ideal. Famous results can become difficult to challenge, and dominant benchmarks can quietly define what counts as progress. But the possibility of reopening the answer still matters. In principle, a stranger with better evidence can continue the argument.

== A decision creates another stopping rule

A decision cannot always remain open in the same way. Suppose an experiment suggests that a new system is probably better, but another month of data would make the estimate more precise. Whether to wait depends on more than the evidence. If the change is cheap to reverse, acting now may be reasonable. If it affects safety, privacy, or infrastructure that will be difficult to undo, the same uncertainty may be unacceptable.

The evidence is the same. The cost of being wrong is not.

This is why "industry moves faster" has started to feel like a surface description to me. Underneath speed is often a decision about uncertainty, reversibility, timing, and cost. A stronger answer is useful, but a stronger answer that arrives after the decision no longer matters may be less useful than a weaker answer available today.

That does not justify weak research whenever an organization wants to move quickly. Deadlines can be artificial. Urgency can become an excuse not to investigate uncomfortable evidence. But the reverse mistake is possible too. If a decision is reversible and delay is costly, waiting for the strongest imaginable evidence can also be irrational.

So the real question is more concrete than _How certain are we?_ It is _How much more do we need to know before acting, and what does waiting cost?_

= How large is the world our evidence describes?

Industry research can have an extraordinary empirical advantage. A product used by millions of people can reveal rare failures, support repeated experiments, and measure effects that would be impossible to estimate with a few dozen participants. When I first encountered this scale, it was easy to think that this kind of evidence must simply be closer to reality.

But scale answers one question while leaving another open.

== Sample size is not world size

A million people can all be inside the same product. They see choices defined by the same interface. Their attention is shaped by the same ranking system. Their actions occur inside the same technical constraints and incentives. The dataset can be enormous while the world that produced it remains unusually specific.

That specificity may be exactly what the research needs. If the question is _what happens when we change this system for people using this service?_, then the service is not a limitation to apologize for. It is the object of study. The problem begins only when certainty inside that world quietly becomes a claim about people outside it.

#blockquote[
Academia sometimes studies a small number of people to say something about a large world.

Industry can study a very large number of people inside a very small world.
]

The contrast is useful because neither side wins. A small academic study may be too narrow or artificial to support the general claim the paper wants to make. A giant industrial experiment may estimate a local effect with remarkable precision while telling us little about whether the same effect exists elsewhere.

The number of observations and the distance an answer can travel are different properties.

== Portability has a price

Academic research faces the inverse problem. To make a result move beyond one context, researchers simplify the context. They define a task, choose variables, recruit a population, build a prototype, create a benchmark, and hold some conditions fixed so that others become visible. This is not a defect. Leaving things out is what makes a model a model.

The harder question is what was left out. A controlled study can isolate a relationship that would be almost impossible to see in ordinary life, but it can also remove the pressures that gave the behavior its meaning. A benchmark can give a field common ground, but it can also make improvement on the benchmark easier to see than improvement on the larger problem that motivated it.

#blockquote[
Knowledge becomes easier to move partly because we remove the things that made it belong to one place.
]

The point is not that situated knowledge is better than general knowledge. Either can overreach. The question I want to keep asking is simpler: _Which parts of the world did we remove so that the answer could travel, and would the claim change if we put them back?_

= When research changes the world it observes

The problem becomes stranger when researchers can deploy the system they are studying. Research is often drawn as a sequence: understand the problem, build something, evaluate it, then perhaps deploy it. In practice, deployment can become part of how the next question is discovered.

A product is released. People use it in expected and unexpected ways. New failures appear. The system changes, behavior changes, and new evidence becomes visible. The product is no longer only an output of research. It becomes part of the apparatus through which the organization learns.

That can be enormously powerful. Questions that were impossible to answer in a controlled setting become observable under real use. But the instrument is not passive. A recommendation system changes what people see, which changes what they choose, which becomes data for the next system. An interface changes which actions are easy, and the resulting behavior may later be interpreted as evidence of what people prefer.

This loop exists outside industry too. Researchers in many settings intervene in the situations they study. What a large product organization may have is the ability to repeat the loop of deployment, measurement, and redesign at unusual scale and speed.

That capacity creates knowledge, but it also makes a simple causal story harder to tell. If behavior changes after the system changes, we have learned something about people interacting with that system. We should hesitate before turning that into a claim about how people simply are.

The research environment is no longer only where evidence is collected. It has become one of the causes of the evidence.

So another question appears:

#blockquote[
When our system changes the behavior we later measure, what have we learned about people, and what have we learned about the world we built around them?
]

= Who gets to reopen the answer?

Evidence has a social life after the original researchers finish. Someone may need to inspect the result, question it, or show that it no longer holds. At that point, access begins to determine who can keep the argument alive.

== Knowing and showing are different

Imagine an organization with years of interaction data, mature instrumentation, repeated experiments, and a system used by hundreds of millions of people. The effect is stable enough that several teams make expensive decisions around it. Inside the organization, this may be one of the best-supported facts anyone has about that particular system.

Now suppose the data cannot be released. The infrastructure is proprietary. An outside researcher cannot rerun the experiment because there is no external equivalent of the product or population.

The internal evidence did not become weak because it remained private. But two questions that often travel together have now come apart: _How well supported is this belief?_ and _How independently inspectable is the support?_

#blockquote[
Knowing something well and being able to show how it is known are not the same capacity.
]

Academic research usually places unusual value on the second capacity because a public claim is expected to survive beyond the authority of its author. Industrial research can sometimes have much stronger access to a phenomenon while giving the outside world much less ability to interrogate the evidence. Neither property can replace the other.

== Public does not mean reproducible

Academia has its own version of this problem. A public paper can depend on a dataset that cannot be shared, equipment that few laboratories possess, a closed model, undocumented preprocessing, or years of tacit expertise. An argument can be public while the experiment remains practically inaccessible.

So the useful distinction is not private industry versus public academia. It may be the default audience. Academic work is usually written for someone outside the project. Internal research can be written for people who already share the product, metrics, infrastructure, history, and vocabulary.

Shared context makes communication efficient. It also makes assumptions easier to leave unstated because everyone in the room already knows them.

#blockquote[
An answer that never has to meet a stranger can afford to leave more unsaid.
]

There is also a question of power here. A person outside an academic project can, at least in principle, challenge a public claim without joining the original institution. A person outside a company may be affected by a system while having little access to the evidence that justified its design.

The boundary is imperfect. Companies publish. Academic communities can be difficult to enter. Public papers can hide essential context. But the question remains useful: _Who gets to reopen the answer after the people who made it have moved on?_

= What remains after the researcher leaves?

Every research environment forgets. What interests me is that different environments may be better at preserving different parts of the work.

== When the explanation survives

A paper can remain readable decades after the original software stops compiling. The argument survives. The figures survive. The assumptions, if they were written carefully, survive. Someone can still understand what the researchers thought they had learned.

Meanwhile, the world that produced the result can disappear. Hardware is retired. Datasets become unavailable. A prototype depends on an obsolete library. The person who knew an undocumented calibration step moves on.

Academic research has developed many ways to resist this loss. Even so, there is a structural reason the explanation often receives special protection: the explanation is the part expected to remain legible after the project ends.

== When the system survives

A production system can have the opposite fate. The feature still runs. Dashboards still monitor it. New engineers learn how to keep it operating. The system becomes part of the ordinary infrastructure of the organization.

But the reason it became that way can fade. The experiment happened before the last reorganization. The researcher left. A threshold remains in the code, but nobody remembers why that number was chosen. A restriction that once responded to a real failure becomes an inherited rule whose evidence is difficult to find.

Good organizations resist this too. They keep experiment archives, decision records, design documents, and institutional histories. The point is not that one institution remembers while the other forgets. It is that preservation follows what future work is expected to need.

One environment may work hardest to keep the explanation legible. Another may work hardest to keep the system alive. What counts as the durable object of research is already shaping what the institution remembers.

That raises one last question before returning to the original comparison:

#blockquote[
What did we decide was worth preserving after the people who learned it were gone?
]

= Two pressures, not two boxes

I began with a question about the fundamental difference between academia and industry. I now think the boundary itself may be too coarse. The examples that refuse to fit neatly into either side are not exceptions we need to explain away. They are evidence that a different distinction may be more useful.

One kind of rigor appears when an answer has to survive leaving its context. Can someone else inspect the reasoning? Which assumptions travel with the result? Does the finding persist on another dataset, another population, another machine, or another year? Can the claim remain meaningful when the authors are no longer there to explain it?

This pressure favors explicit assumptions, public argument, generalization, reproducibility, and careful claim scope. Its characteristic risk is also clear: we can make an answer portable enough that we forget how much of the original world was removed to carry it.

Another kind of rigor appears when an answer has to survive entering context. Does the recommendation still make sense when technical constraints, incentives, maintenance, deadlines, users, and failure modes arrive together? Can the organization act on the result? Can it recognize when the result stops being true?

This pressure favors local evidence, operational detail, timeliness, reversibility, and attention to consequences. Its characteristic risk is different: we can know one world with extraordinary precision and forget how small that world is.

Neither pressure is sufficient by itself. A general claim can fail the moment it meets an actual system. A perfectly measured local effect can tell us almost nothing outside the system that produced it.

The research I admire most often moves between the two. It stays close enough to reality to be changed by what happens there, then explains what it learned clearly enough that the insight can leave.

= Where knowledge has to live

I no longer find the question _Is industry or academia better for research?_ very useful without another question attached: _Better for what kind of answer?_

Some answers need to become public claims that can survive strangers, criticism, reinterpretation, and time. Some need to become decisions that can survive implementation, constraints, and consequences. Many of the most interesting answers need to do both, even if no institution makes both equally easy.

The institutional differences we usually talk about still matter. Funding, publication incentives, intellectual property, career structures, access to data, engineering resources, time horizons, and responsibility for deployed systems all shape what researchers can do. But I increasingly see these as forces that change the future of an answer. They influence what must be written down, what can remain local, who needs to be convinced, how long we can wait, and who can return later to ask whether we were wrong.

When I look at a research environment now, those are the questions I want to ask. Where is this answer supposed to go? What must it survive when it gets there? And who will still be able to question it after the people who produced it have moved on?

Perhaps the deeper difference is not where the researcher works. It is what kind of life the institution expects an answer to have after the researcher is finished with it.
