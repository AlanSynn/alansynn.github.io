# When Evaluation Becomes an Algorithm

**Status:** extended working draft | **Theme:** Evidence after the scoreboard | **Candidate tags:** philosophy-of-science, ai, sociology-of-science

*Part 2 of a proposed two-part essay on qualitative evaluation.*

Consider a researcher who has spent years learning to make an algorithm better. There is a test suite, a way to run the algorithm, and a score that tells her whether a change helped. Her skill resides partly in choosing what to try next. If she can communicate enough of the process to an agent, the agent can propose a change, run it, inspect the result, and try something else. Eventually, the method for choosing changes can enter the same process.

This is becoming a practical research procedure. In [AlphaEvolve](https://deepmind.google/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/), language models propose programs and automated evaluators provide feedback for evolutionary search. The developers report improvements in mathematical and computing tasks, including infrastructure related to AI itself. This is evidence of a mechanism in particular settings. My prediction is broader: once the evaluation loop is accessible, a substantial part of the research organized around improving its output will become a machine activity.

What happens to evaluation after that?

## The evaluator moves inside the system

A conventional benchmark begins outside the method. A researcher makes a system and compares it with other systems under an agreed procedure. Its score helps readers decide whether a particular contribution is useful. As agents gain the ability to run that procedure, the benchmark becomes an input to the production of the next system. It no longer simply records progress. It guides the search for progress.

The change is particularly sharp when the criterion can be computed cheaply and reliably. More candidate systems can be evaluated. Failures can be retained as information about where not to search. Search strategies, training rules, reward functions, and sometimes parts of the evaluator itself can be improved. There will still be difficult problems, expensive experiments, and scores with weak validity. None of these are general guarantees of continued human superiority.

Suppose several people can now obtain similar improvements with comparable tools and resources. A higher score still tells us something about the resulting system. It has become a weaker certificate of the distinctive insight of the person who produced it. That is the beginning of the collapse of the familiar research bargain. The achievement may remain valuable; the competitive advantage of personally achieving it may disappear.

An evaluator that is an imperfect proxy creates another problem. In [Scaling Laws for Reward Model Overoptimization](https://proceedings.mlr.press/v202/gao23h.html), Gao, Schulman, and Hilton investigate how increasingly optimizing a learned proxy relates to a separate reference reward. Their synthetic setup uses a fixed gold reward model rather than repeated judgments from real humans. It shows why a stronger optimization process can make the relationship between a proxy and its intended target more consequential. An agent can improve its number while making a different account of its performance worse.

One reaction is to construct a more sophisticated evaluator. This is useful for many engineering purposes, and it may lead to another loop of automated improvement. But some domains contain differences whose value does not arise from agreement on a shared outcome. Moving all those differences into a better score would preserve an idea about research that deserves to be questioned.

## A gesture can succeed in one sense and fail in another

The [GENEA Challenge 2022](https://doi.org/10.1145/3656374) offers a concrete example. The organizers separated the perceived human-likeness of a generated co-speech gesture from how well that gesture matched the speech. Some synthesized conditions were rated more human-like than the natural motion-capture reference. The generated gestures as a group remained markedly worse at matching speech than the original recordings. Most automatic metrics considered in the study showed weak relationships with the human-likeness judgments; the Fréchet gesture distance showed a moderate relationship.

These results are from quantitative experiments with human observers, and the authors explicitly separate two dimensions of judgment. They do not establish that motion quality is unmeasurable. What they make visible is the difference between an attractive movement and an appropriate movement. The first can look successful while the second fails. There may also be many appropriate movements for an utterance, depending on the speaker, the listener, the situation, and the kind of relationship taking place.

Imagine two generated motions with a similar score. A character leans forward as another person speaks. To one observer, the motion suggests attentive listening. To another, it suggests impatience. A small change in timing or distance could alter the interpretation. A dataset can record those judgments. The meaning of the movement can also change when the same people encounter one another again.

An automated evaluation can approximate many aspects of that experience. It may even predict individual preferences accurately. My point is that a prediction of preference and a common account of what makes a movement valuable have different purposes. People can have incompatible reasons to want different movements. There is no requirement that those reasons be placed on a single universal scale.

## The territory hidden by a common evaluation

A [study of expectations for robotic guide dogs](https://arxiv.org/html/2501.04594v1) by Kim and colleagues involved 18 blind and low-vision participants and explored locomotion, navigation, communication, and explanations. Participants' comments revealed differences in how they wanted to receive information and control their interactions. Audible locomotion, for instance, can be a burden for some users and an informative cue for others. The study combines numerical ratings and qualitative feedback; its scope is the interactions and people investigated, not every guide-robot user.

A score can summarize a preference across that group. In doing so, it decides how a disagreement will appear in the final representation. The smaller group may matter less to the mean without caring any less about the outcome. As tools improve, producing more than one design may become cheaper. A disagreement that once looked like an obstacle to finding a best design may become an opportunity for distinct experiences.

Research through design and embodied inquiry help us imagine what research in that territory might look like. [Unpacking Non-Dualistic Design: The Soma Design Case](https://doi.org/10.1145/3462448) examines first-person engagement and its relation to other perspectives within a somaesthetic design workshop. [Gaver's account of research through design](https://doi.org/10.1145/2207676.2208538) takes the diversity of artifacts and design approaches seriously as a feature of generative inquiry. Neither asks us to accept arbitrary claims. Both suggest practices through which people can encounter and examine differences that standardized evaluation may overlook.

In this kind of inquiry, making and experiencing something can change the purpose of the inquiry. A prototype can make a person aware of a preference they had never articulated. Two alternatives can reveal that what seemed like one goal contains several incompatible goals. A community can discover a practice that was not present in the questions with which the research began. These are contributions even if there is no defensible way to rank them all.

I take the position that some qualities of experience cannot be fully transferred into shared language or numbers. This does not imply that a machine cannot learn a person's behavior or help realize that person's wishes. Indeed, [learning from human preferences](https://proceedings.neurips.cc/paper/2017/hash/d5e2c0adad503c91f91df240d0cd4e49-Abstract.html) already provides a route for turning some judgments into learned objectives. The boundary of automation is likely to move. What follows from the irreducibility of experience is a challenge to the expectation of one universal ranking, rather than a permanent list of jobs that machines cannot do.

## The qualitative future of research

I expect the range of qualitative inquiry to expand as the performance of machines becomes common infrastructure. A project may begin with a person, a material, a style of movement, or a relationship, and end with something that a particular group finds meaningful. Other groups may pursue equally defensible and incompatible directions. The cost of producing alternatives matters: abundant capabilities allow more of these directions to become actual artifacts rather than preferences that have no practical consequences.

There is no reason to promise a human researcher exclusive ownership of the resulting work. Models may assist with observation, interpretation, prototyping, and the generation of alternatives. Some parts will enter executable evaluation loops again. The important forecast is that research will increasingly organize itself around plural experiences rather than a single shared order of merit. Quantitative improvement can continue everywhere that it works. Its status as the general form of valuable research will diminish.

That future requires institutions to change as well. If publication committees continue to demand a score that orders every contribution, the newly available niches may remain hard to publish. If a handful of companies own the infrastructure for generating artifacts, the range of viable experiences may be shaped by their distribution mechanisms. A growing qualitative territory is not a guarantee of employment or fairness. It changes what can be investigated and what the old system of evaluation is able to justify.

The first essay in this pair asks why readers sometimes need to see the evidence. This essay asks what happens once a machine can run the established tests better than the researcher. I expect that the answer will be visible in the shape of research itself: fewer reasons to treat incremental victory on a common score as a distinctive personal accomplishment, and more research whose results can be explored, interpreted, contested, and lived with in several ways.

## Editorial checks before publication

- Preserve the forecast of machine dominance in quantified competition; treat conditions on evaluation and trial costs as explanations of timing, not reassurance.
- Do not confuse qualitative research with subjective numerical ratings, visual evidence, or any human presence in an experiment.
- The preference-learning counterexample is essential. Do not infer permanent human exclusivity from limits of shared representation.
- Test the institutional forecast against ongoing review and funding practices. If qualitative contributions still need a universal ranking to receive credit, the predicted change in authority is incomplete.
- This is about research evaluation after scores become inputs to search; avoid restating the entire social forecast in When the Score Stops Mattering.

## Source notes

Checked: [AlphaEvolve announcement](https://deepmind.google/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/); [Gao et al., ICML 2023](https://proceedings.mlr.press/v202/gao23h.html) (abstract and synthetic-study setup); [GENEA Challenge 2022 article](https://doi.org/10.1145/3656374); [guide-dog study](https://arxiv.org/html/2501.04594v1); [Höök et al., Soma Design](https://doi.org/10.1145/3462448) (abstract); [Gaver, 2012](https://doi.org/10.1145/2207676.2208538) (abstract); Christiano et al., Deep Reinforcement Learning from Human Preferences (2017), revisit original study before using numerical results.
