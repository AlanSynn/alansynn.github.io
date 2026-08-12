#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude: *

#show: main.with(
title: "When the Field Moves",
desc: "What happens to researchers when the problems, tools, and skills that shaped their field begin to change?",
date: "2026-08-12",
tags: ("research-methodology",),
)

I started my Ph.D. in the fall of 2022.

On November 30 of that year, before I had finished my first semester, OpenAI #link("https://openai.com/index/chatgpt/")[released ChatGPT].

I had thought of a Ph.D. as a long period of training. Long enough to learn a field, find a problem, fail at it a few times, and eventually know enough to contribute something.

I had not thought about the other side of that timescale.

A Ph.D. is also long enough for a field to move underneath you.

Over the next few years, I watched people around me change research directions. Some moved toward new AI problems. Some kept their old problems but rebuilt them around foundation models. Some saw a technique they had spent years learning become much easier to reproduce with a model.

None of this means that their earlier work was foolish.

The world around the work changed.

In July 2026, OpenAI #link("https://openai.com/index/gpt-5-6/")[released GPT-5.6], with large gains in coding, scientific reasoning, and research-oriented tasks. A few weeks later, the company #link("https://openai.com/index/ten-advances-in-mathematics/")[reported ten results] from an internal model called Astra across mathematics and theoretical computer science. According to OpenAI, the model resolved or made substantial progress on long-standing problems in areas including geometry, coding theory, circuit complexity, quantum complexity, and combinatorics. Humans prepared the arguments into manuscripts with the model, and the model later formalized them as Lean certificates.

These are company-reported results, and their broader importance will still be judged by the communities that study those problems.

But something had clearly changed.

For parts of mathematics and computer science, the question was no longer only whether AI could write code, summarize papers, or solve benchmark problems.

It was getting closer to the intellectual center of research itself.

And that raises a harder question than *What can AI do?*

What happens to researchers when it can do part of what they spent years learning to do?

== The same change can mean different things

There is no single "researcher's reaction" to this moment.

That matters.

For a student, the first question may be about training.

If a model can now do something I expected to spend years learning, what exactly am I training for?

A Ph.D. has never been only about producing answers. Getting stuck on a proof, spending three days inside a bug, finding that an experiment failed for a reason you did not expect, and throwing away a beautiful idea are also part of how people learn to think.

Some of that difficulty is just friction. We should be happy to remove it.

But some of it may have been doing the teaching.

Which was which?

Mathematicians are already asking versions of this question. In #link("https://www.quantamagazine.org/the-ai-revolution-in-math-has-arrived-20260413/")[Quanta's reporting on AI and mathematics], Terence Tao describes enormous opportunities for new kinds of mathematical work while also worrying that students can now skip problems that once built basic mathematical skill. Ken Ono expresses optimism about AI accelerating research and, at the same time, deep concern about what it may do to training. Akshay Venkatesh worries about losing parts of mathematical practice that carry understanding and culture, not only correct answers.

The interesting thing is that these are not clean camps.

A person can be excited and worried at the same time.

For an established researcher, the same technology can look very different.

Someone who already has twenty years of domain knowledge, collaborators, and a strong sense of which questions matter may see AI mostly as leverage. A model can explore branches that there was never time to test. It can implement variations, search examples, check edge cases, or help reopen a problem that has been sitting on a shelf for a decade.

The same tool can feel like acceleration to one researcher and displacement to another.

And there is another position that is easy to forget.

The researcher who does not have the same tool.

The strongest research systems are not equally available. The Astra results, for example, came from an internal model that was not generally available when the results were announced. OpenAI has since announced a #link("https://openai.com/index/chatgpt-for-academic-researchers/")[program to provide frontier-model access to academic researchers]. That is useful. It also points to the underlying issue.

A new instrument can democratize one layer of research while concentrating another.

Compute matters. Model access matters. Institutional resources matter. The ability to run a thousand experiments instead of ten matters.

So when we say, "researchers can now do this," it is worth asking:

*Which researchers?*

Then there is a simpler case.

Some people simply liked doing the work.

Some people like making proofs. Some like writing a fast kernel by hand. Some like constructing geometric arguments, tuning a physical experiment, or spending a week understanding why a system behaves strangely.

If a machine becomes better at one of these things, the standard advice is to move upward.

Do the higher-level work. Ask the bigger question. Let the machine handle the rest.

That may be sensible career advice.

It is not a complete answer.

Does something stop being worth learning because a machine becomes better at it?

I do not think we can answer that with a benchmark.

== History is not reassurance

When people are anxious about new technology, history is often offered as comfort.

Calculators did not destroy mathematics. Computers did not destroy programming. Automation removed old jobs and created new ones. People adapted.

All of that is true.

It is also too easy.

History looks smooth from far away.

It does not feel smooth to the people inside it.

Before electronic computers, *computer* was a job. For centuries, human computers performed large calculations in teams. Many were #link("https://www.computerhistory.org/revolution/calculators/1/65")[low-paid clerks]; in several major scientific and government computing organizations, much of this work was done by women.

Electronic machines eventually took over much of that calculation.

The calculation itself did not become false or meaningless.

Its scarcity changed.

Some human computers moved into programming, engineering, and new technical roles. Some kinds of work disappeared. New opportunities emerged, but not necessarily for the same people, at the same moment, with the same status.

That distinction matters.

Technological progress can be good in the aggregate and still be painful in the transition.

Research has gone through other kinds of shifts too.

In 1976, Kenneth Appel and Wolfgang Haken proved the #link("https://las.illinois.edu/news/2017-10-18/celebrating-four-color-theorem")[Four Color Theorem] with extensive computer assistance. It was a famous mathematical problem, open since the nineteenth century. The proof required checking enough cases by computer that a mathematician could not simply sit down and inspect the entire argument in the traditional way.

The result did not only answer a question about coloring maps.

It disturbed a boundary.

What counts as a proof?

What does it mean to know that a theorem is true if part of the path to that truth is delegated to a machine?

Today, computer-assisted proof is an ordinary part of several areas of mathematics. Formal proof assistants can provide forms of verification that Appel and Haken did not have.

But the discomfort was not foolish. The technology had changed, and mathematics had to negotiate what kind of evidence it would accept.

Around the same time, Edsger Dijkstra was thinking about a different problem created by increasingly powerful computers.

His 1972 Turing Award lecture, #link("https://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html")[_The Humble Programmer_], was written during the software crisis, not the age of AI. We should not pretend that Dijkstra was predicting large language models.

But the tension he saw feels familiar.

Computers were becoming enormously powerful. That did not mean the human mind was expanding at the same rate. More machine power made it possible to build larger and more complicated systems, including systems that became harder for their creators to reason about.

Dijkstra ended by asking programmers to respect "the intrinsic limitations of the human mind."

That is a useful warning now.

AI can make code cheaper to write. It can make candidate proofs cheaper to generate. It can make hypotheses, designs, experiments, and explanations appear faster than we could have produced them ourselves.

But a stronger tool does not automatically make us better at understanding what the tool produces.

Sometimes the relationship may go in the other direction.

#blockquote[
A stronger tool can reduce the burden of production while increasing the burden of judgment.
]

Computer vision offers another version of the story.

Before the deep-learning shift, a great deal of computer-vision research depended on carefully designed representations and hand-crafted features. Researchers built substantial expertise around deciding which structures an algorithm should look for in an image.

Then, in 2012, Alex Krizhevsky, Ilya Sutskever, and Geoffrey Hinton published #link("https://papers.nips.cc/paper_files/paper/2012/hash/c399862d3b9d6b76c8436e924a68c45b-Abstract.html")[_ImageNet Classification with Deep Convolutional Neural Networks_]. AlexNet showed what could happen when large datasets, GPU computation, and learned representations came together at the right time.

The older researchers had not been stupid.

Their methods were answers to a world with different data, different hardware, and different algorithms.

Then some of those conditions changed.

#blockquote[
Sometimes a field does not discover that its old questions were foolish. It discovers that the conditions that made them difficult have changed.
]

These historical stories are not the same story.

That is exactly why they are useful.

Human computers show that technology can change which labor is scarce.

The Four Color Theorem shows that technology can change what a community is willing to count as evidence.

AlexNet shows that technology can change which forms of technical expertise are valuable.

Dijkstra reminds us that the power of our tools and our capacity to understand their outputs do not necessarily grow together.

AI is touching all of these at once.

That is one reason the present moment can feel unusually unstable.

== What exactly became cheap?

Richard Sutton's 2019 essay #link("https://www.incompleteideas.net/IncIdeas/BitterLesson.html")[_The Bitter Lesson_] describes a pattern that appeared repeatedly in the history of AI.

Researchers often built systems around carefully designed human knowledge. In the short run, those systems could work very well. Over longer periods, more general methods that could take advantage of increasing computation and search repeatedly became stronger.

It is easy to turn this into a slogan:

*Just scale. Human knowledge does not matter.*

I do not think that is the interesting lesson.

That would simply replace one dogma with another.

The more uncomfortable lesson is that a method we think expresses the deep structure of a problem may partly express the constraints of the time in which we invented it.

A representation may exist because data was scarce.

A clever approximation may exist because computation was expensive.

A hand-designed pipeline may exist because learning the whole thing was once impossible.

When those constraints move, the method can move with them.

But the *problem* may not.

This is where I find it useful to separate three things that are easy to mix together.

A *field* is the community in which we talk.

A *problem* is what we want to understand or make possible.

A *method* is how we currently try to get there.

The three become entangled because a research career is built through all of them at once. We publish in a field. We become known for a method. We spend years on a problem.

Then a technology changes the method, and it can feel as if everything changed at once.

Sometimes it did.

Often it did not.

Suppose I spend three years building an optimization method and a future model can produce the same result from a short description.

What happened?

Perhaps my method became obsolete.

Perhaps the underlying problem became easy.

Perhaps only one benchmark became easy.

Perhaps the model works in the clean setting that I had been studying but fails in the physical or social world that motivated the problem in the first place.

Perhaps the real bottleneck moved somewhere else.

These are very different scientific claims.

So I think one of the most useful questions right now is also one of the simplest:

*What exactly became cheap?*

The answer?

Search?

Implementation?

Verification?

Explanation?

Or the problem itself?

#blockquote[
Cheap is not the same as solved. Solved is not the same as unimportant.
]

A recent systems paper makes this distinction especially interesting.

In #link("https://arxiv.org/abs/2510.06189")[_Barbarians at the Gate: How AI is Upending Systems Research_], Audrey Cheng and colleagues argue that some systems problems are unusually well suited to AI-driven research because they have reliable verifiers.

Generate a candidate scheduler.

Run it.

Measure latency or cost.

Keep the better one.

Generate another.

Repeat.

The authors show case studies in which this kind of loop discovers solutions that outperform human-designed baselines.

The paper is not a proof that systems research can be automated. Its examples cover particular problems, objectives, and evaluators.

But the underlying idea is important.

One of the features that made a research problem rigorous -- a clear way to tell whether a proposed solution works -- can also make it easier to search automatically.

There is a strange inversion here.

For years, a strong verifier felt like protection against nonsense.

It still is.

Now it can also become an engine for automated discovery.

And once a machine can optimize against a verifier, another question becomes more important:

*Did we build the right verifier?*

A system can become very good at the objective we gave it.

That does not mean the objective captured the thing we actually cared about.

The faster optimization becomes, the more consequential that distinction becomes.

== Honesty without cruelty

When I first tried to write this essay, I thought it would be about adaptability.

There is a long tradition of good advice for researchers facing change.

Richard Feynman, in his 1974 Caltech commencement address #link("https://calteches.library.caltech.edu/51/2/CargoCult.htm")[_Cargo Cult Science_], argued for a kind of scientific honesty that goes beyond simply not lying. A researcher should actively look for the facts that might show an idea is wrong.

His famous version was simpler:

"You must not fool yourself."

That still matters.

If a model really has destroyed the premise of my research, I should not pretend otherwise because I already wrote two papers, because my dissertation depends on it, or because I became the person in the room who knows that method best.

A research identity cannot become a reason to ignore evidence.

But there is another truth that sits next to it.

"Adapt" is remarkably easy to say when it is someone else's life that has to move.

A third-year Ph.D. student may have spent most of their adult life becoming good at one thing. A professor may have students, grants, equipment, and a tenure case built around a research direction. An international researcher may not have the freedom to lose a year and start again. A person may have built not only expertise but a community around a field.

Those things are sometimes called sunk costs.

Economically, that can be useful language.

Humanly, it is incomplete.

They are also years of a life.

So I do not want adaptability to become another test of whether someone deserves to be called a good researcher.

Staying is not always denial.

Leaving is not always courage.

And being frightened by a real change does not mean that someone has failed to understand the future.

At the same time, care does not require us to pretend the change is smaller than it is.

Both things can be true.

We should be honest about what the technology can do.

We should also be honest about what changes in a field can cost the people inside it.

== What do we carry with us?

Richard Hamming asked a question that has survived many technological shifts.

In his 1986 Bellcore talk #link("https://www.cs.virginia.edu/~robins/YouAndYourResearch.html")[_You and Your Research_], he described walking around Bell Labs asking people:

"What are the important problems of your field?"

He was not saying that researchers should simply choose the biggest problem they could name. For Hamming, an important problem also needed some plausible way to attack it.

That part feels especially relevant now.

New tools change which problems have an attack.

A question that was impossible ten years ago can suddenly become approachable. Another question can disappear because the hard part has become routine.

Hamming himself spent time asking how computers would change science.

We should probably do the same with AI.

But I would add one question to his.

When a new method changes the list of problems we can attack, *why did we care about those problems in the first place?*

That reason may survive the method.

It may not.

There is a temptation at this point to end with a reassuring list of things humans will always do.

AI will execute; humans will have taste.

AI will search; humans will choose the problem.

AI will prove; humans will understand.

Maybe.

For now, some of those distinctions are useful descriptions of how research work can be divided.

I am less sure they are laws of nature.

Taste can change. Problem selection can be learned. Even judgment may become a place where machines become surprisingly useful.

I do not know what part of research will remain uniquely human.

I am not sure that uniqueness is the right standard.

We still play chess after machines became better at chess. We still calculate by hand when understanding the calculation matters. Mathematicians still value a beautiful proof even when a longer proof establishes the same theorem.

Scarcity and value are not the same thing.

A skill can stop being scarce without becoming meaningless.

A research problem can stop supporting a career while still being intellectually beautiful.

And a field can move forward while leaving behind practices that were worth something to the people who learned them.

I started my Ph.D. thinking that the challenge was to become an expert before I ran out of time.

Now I think there is another challenge.

What happens when expertise itself moves?

We will not all answer that question in the same way. We will not move at the same speed. Some people will find a new direction quickly. Some will keep working on an old problem for good reasons. Some will discover that what they really cared about was deeper than the method they had been using. Some will lose a form of work they genuinely loved.

There is no reason to pretend that nothing is lost.

There is also no reason to believe that everything is.

A field can move without making everything that came before it foolish.

We can change our minds without treating our former selves with contempt.

And perhaps that is the harder question a changing field leaves us with:

not only what we can still do,

but what we still believe is worth doing.

== Sources and further reading

- #link("https://openai.com/index/chatgpt/")[OpenAI — "Introducing ChatGPT"] (November 30, 2022). The original ChatGPT research-preview announcement.

- #link("https://openai.com/index/gpt-5-6/")[OpenAI — "GPT-5.6: Frontier intelligence that scales with your ambition"] (July 9, 2026). Release announcement and research/science evaluations for the GPT-5.6 family.

- #link("https://openai.com/index/ten-advances-in-mathematics/")[OpenAI — "Ten advances in mathematics and theoretical computer science"] (August 1, 2026). OpenAI's description of ten results produced by an internal version of Astra, including the distinction between model discovery, human manuscript preparation, and Lean formalization.

- #link("https://www.quantamagazine.org/the-ai-revolution-in-math-has-arrived-20260413/")[Konstantin Kakaes — "The AI Revolution in Math Has Arrived," Quanta Magazine] (April 13, 2026). A useful account of how mathematicians including Terence Tao, Ken Ono, and Akshay Venkatesh are thinking about research, training, and mathematical culture.

- #link("https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/")[Konstantin Kakaes — "Why the Legendary Erdős Problems Are Falling to AI," Quanta Magazine] (August 3, 2026). Reporting on recent AI progress on Erdős problems and the mathematical context around those results.

- #link("https://openai.com/index/chatgpt-for-academic-researchers/")[OpenAI — "Accelerating scientific discovery with ChatGPT for Academic Researchers"] (July 29, 2026; updated August 10). Relevant to the question of unequal access to frontier research models.

- #link("https://www.computerhistory.org/revolution/calculators/1/65")[Computer History Museum — "Human Computers"]. A short history of "computer" as a human occupation and the transition to computing machines.

- #link("https://womenshistory.si.edu/blog/computers-were-machines-they-were-women-here-are-six-places-where-human-computers-built-modern")[Smithsonian American Women's History Museum — "Before Computers Were Machines, They Were Women"] (2026). Examples of women working as human computers across scientific and technical institutions.

- #link("https://las.illinois.edu/news/2017-10-18/celebrating-four-color-theorem")[University of Illinois — "Celebrating the Four Color Theorem"]. Historical background on Appel and Haken's 1976 computer-assisted proof.

- #link("https://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html")[Edsger W. Dijkstra — "The Humble Programmer"] (ACM Turing Award Lecture, 1972). In particular, Dijkstra's argument for respecting the intrinsic limitations of the human mind as computers make increasingly complex systems possible.

- #link("https://papers.nips.cc/paper_files/paper/2012/hash/c399862d3b9d6b76c8436e924a68c45b-Abstract.html")[Alex Krizhevsky, Ilya Sutskever, and Geoffrey E. Hinton — "ImageNet Classification with Deep Convolutional Neural Networks"] (NIPS 2012).

- #link("https://www.incompleteideas.net/IncIdeas/BitterLesson.html")[Richard Sutton — "The Bitter Lesson"] (2019). Sutton's argument about the long-run advantage of general methods that can leverage increasing computation.

- #link("https://arxiv.org/abs/2510.06189")[Audrey Cheng et al. — "Barbarians at the Gate: How AI is Upending Systems Research"] (2025). The paper's central argument is that systems problems with reliable executable verifiers are especially amenable to iterative AI-driven solution discovery.

- #link("https://calteches.library.caltech.edu/51/2/CargoCult.htm")[Richard P. Feynman — "Cargo Cult Science"] (Caltech commencement address, 1974). Feynman's discussion of scientific integrity and the obligation to look for evidence that may undermine one's preferred explanation.

- #link("https://www.cs.virginia.edu/~robins/YouAndYourResearch.html")[Richard Hamming — "You and Your Research"] (Bell Communications Research Colloquium, March 7, 1986). Hamming's discussion of important problems, plausible attacks, and thinking deliberately about how computers would change science.
