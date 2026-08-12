#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude: *

#show: main.with(
title: "When the Field Moves",
desc: "What happens to researchers when the problems, tools, and skills that shaped their field begin to change?",
date: "2026-08-12",
tags: ("research-methodology",),
)

I started my Ph.D. in the fall of 2022. ChatGPT was released before I finished my first semester.

A Ph.D. is supposed to be long enough for you to become an expert. I had not considered that it might also be long enough for the meaning of expertise to change underneath you.

Since then, I have watched people around me change fields, redefine old problems around foundation models, or see a technique they spent years learning become much cheaper to use. None of this means the old work was foolish. The world around the work changed.

This summer, that feeling became sharper. GPT-5.6 arrived, while frontier AI systems were also being reported to make real progress on open problems in mathematics and theoretical computer science. For some researchers, this was exciting. For others, it landed much closer to home.

The question was no longer only, *What can AI do?* It became, *What happens to us when it can do part of what made us researchers?*

== The same change looks different from different places

For a student, the first question may be about training.

If a model can now do something I expected to spend years learning, what exactly am I training for?

A Ph.D. has never been only about producing answers. Getting stuck on a proof, debugging code for days, finding that an idea fails, and starting again are also ways people learn to think. Some of that difficulty is waste. Some of it is education. We may not yet know which is which.

For an established researcher, the same tool can look very different. Someone who already has years of domain knowledge and a sense of which questions matter may see AI as leverage. A model can explore branches that there was never time to test or help attack a problem that had been sitting on a shelf for years.

The same tool can feel like acceleration to one researcher and displacement to another.

There is also a simpler case: some people simply liked doing the work.

Some people like making proofs. Some like writing low-level systems code. Some like working through geometry by hand. Telling them to "move up the abstraction stack" may be good career advice. It is not a complete answer.

Does something stop being worth learning because a machine becomes better at it?

== History is not reassurance

We often answer technological anxiety with history. Calculators did not kill mathematics. Computers did not kill programming. New jobs appeared. People adapted.

All of that is true. It is also too easy.

Before electronic computers, *computer* was a job title. People, often women, were hired to perform long calculations by hand. Electronic machines made much of that labor cheaper and faster. Some moved into programming and other new technical work. Some jobs really did disappear.

Calculation did not become meaningless. The scarcity around calculation changed. And new work did not appear for the same people, at the same time, or with the same status.

Research has also changed its mind about what counts as knowledge and expertise.

In 1976, Kenneth Appel and Wolfgang Haken used extensive computer calculation in their proof of the Four Color Theorem. The result did more than solve a famous problem. It made mathematicians argue about what it meant to trust a proof when no person could easily inspect every step in the old way.

In computer vision, AlexNet created a different shift in 2012. Researchers had spent years building carefully designed features and pipelines. Deep learning did not show that they had been foolish. More data, more compute, and better learning algorithms changed which approaches worked.

#blockquote[
Sometimes a field does not discover that its old questions were foolish. It discovers that the conditions that made them difficult have changed.
]

== What exactly became cheap?

When a new model makes an old task easy, several different things can be happening.

A method can become obsolete while the problem remains. A problem can become easier without becoming solved. A benchmark can become saturated while the real need behind it remains. Or a research question can genuinely end because the thing that made it interesting is gone.

I find it useful to separate three things.

A *field* is the community in which we talk. A *problem* is what we want to understand or make possible. A *method* is how we currently try to get there.

We often tie all three together. Then when a method collapses, it can feel as if the whole research identity collapses with it.

AI makes this especially visible because it can make parts of research dramatically cheaper. A recent systems paper, provocatively titled *Barbarians at the Gate*, points to one reason. Where a candidate solution can be generated, run, and scored by a reliable verifier, an AI system can repeat that loop again and again.

There is an uncomfortable irony here. One of the things that made a field rigorous -- a clear way to tell whether something works -- may also make parts of discovery easier to automate.

But even then, the useful question is more precise than "Can AI do this?"

What exactly became cheap? Producing an answer? Searching a space? Writing the implementation? Checking correctness? Understanding why something works? Deciding whether the question was worth asking?

#blockquote[
Cheap is not the same as solved. Solved is not the same as unimportant.
]

== I do not want adaptability to become another test

My first instinct was to make this an essay about adaptability.

There is good advice for that version of the story. Work on important problems. Do not defend a method just because you spent years on it. Change your mind when the evidence changes. Do not let sunk cost become research judgment.

I still believe all of that.

But I have become less comfortable with how easy the word *adapt* can sound when it is someone else's life that has to move.

A student near graduation, a professor on a tenure clock, a researcher tied to a grant, a person on a visa, or someone who has spent ten years building a rare skill does not experience a field change as an abstract optimization problem.

Adaptability is a virtue. It should not become a moral test.

Staying with an old problem is not always denial. Leaving it is not always courage. Sometimes the right response is to move. Sometimes it is to wait and see what has really changed. And sometimes a person may decide that a form of work is still worth doing even after it stops being scarce.

== What do we carry with us?

I do not know whether the problems I work on today will still look like research problems when I finish my Ph.D.

I also do not want to answer that uncertainty by inventing a permanent human advantage. It is tempting to say that AI will do the execution while people keep the taste, judgment, or problem formulation. Maybe that will be true for a while. Maybe those boundaries will move too.

What seems more durable is the question of what we believe is worth understanding, building, preserving, or teaching -- even as the cost of doing those things changes.

A field can move without making everything that came before it foolish.

We can move with it without pretending that nothing was lost.

And perhaps the question a changing field leaves us with is not only what we can still do, but what we still believe is worth doing.
