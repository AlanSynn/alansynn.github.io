# The Evidence You Have to See

**Status:** Long-form editorial manuscript | **Theme:** Evidence after the scoreboard | **Candidate tags:** philosophy-of-science, computer-science

One thing I like about [Birth and Death of a Rose](https://openaccess.thecvf.com/content/CVPR2025/html/Geng_Birth_and_Death_of_a_Rose_CVPR_2025_paper.html), a paper by Chen Geng and colleagues at CVPR 2025, is the kind of object it gives us to examine. A rose opens and withers. I can inspect its shape at different moments, look at it from another direction, and change the lighting. Those operations let me investigate the changes in the flower rather than simply watch a particular recording of them.

The paper offers a useful example of a distinction in graphics research. Some contributions improve our ability to produce a familiar result. Others make something available for observation and manipulation that was difficult to study before. A comparison table can give us evidence about the quality of the result. To understand the second kind of contribution, we also need to examine what the researchers have made possible.

This distinction does not depend on whether the generated flower describes the actual growth of a particular rose. A synthetic object can support a new authoring operation without being a faithful biological model. The evidence needs to establish the operation and its consequences. A claim about the physical process of flowering would require observations of actual plants.

## What exactly did the paper make?

A video of a flower and a model of a flower that changes over time are different things. A video gives us observations from a camera. A model can support further observations. We can ask what the flower would look like under a different light or from another position.

RoSE4D addresses the generation of evolving object geometry and material properties. It uses pretrained two-dimensional image generation models to guide the construction of a four-dimensional representation. Here the fourth dimension is time. The representation supports rendering at different times and from different viewpoints and lighting conditions. The [project page](https://chen-geng.com/rose4d/) contains examples of the resulting visual assets.

It is worth taking the time to understand what kind of asset this is before looking at the comparison table. Suppose I am making a scene in which a candle melts beside a window. A video generator could provide a convincing clip of a melting candle. The clip might be entirely sufficient for my purpose. But if I need to move the window, change the position of the candle, or coordinate its melting with another event, I would benefit from having an object whose shape and appearance I can render under those new conditions.

In the paper, geometry, material, and time are parts of that object. Its value depends in part on the relations among them. An image can be one view of those relations. A sequence of images can reveal how they develop. The ability to change viewing conditions lets us examine the relations in another way.

The authors do report quantitative results. In Section 6.2 of the [paper](https://arxiv.org/html/2412.05278v2), they compare rendered results with competing dynamic generation methods. They report a study with 95 participants who chose preferred results according to three criteria, and they include CLIP scores. Because the dynamic comparison methods do not supply the complete set of evolving intrinsics, comparison on common renderings addresses only part of the new task.

That last detail interests me. A common evaluation requires the methods to share something that can be compared. A new representation may make something available that the previous methods did not provide. The common part of the evaluation can tell us whether the results have become more convincing on familiar terms. Another part of the contribution concerns what we can now do with the result.

## A new possibility is a different kind of claim

Consider two research papers about a drawing tool. The first makes a familiar drawing operation faster. The second gives a person a way to draw an object whose motion can be changed independently of its appearance. We might design an experiment in which users complete several tasks with both systems. Such an experiment could tell us something useful about the tools' performance on those tasks.

For the second paper, there is another question I would want to ask first. Can I understand the new object the person is able to make? What changes when they edit the motion? Which parts remain stable? Can I inspect a result from the system and recognize the relationships that the authors claim to have made editable?

A carefully presented example can answer some of those questions. It can establish that an operation is possible in a specified setting, or reveal an important distinction in the behavior of an artifact. That is a narrower claim than establishing that an operation works reliably across a population of users and inputs. The narrower claim can still be consequential.

Scientific evidence needs to match the claim. If a paper asserts that an algorithm succeeds on nearly every input from a defined population, a few impressive examples are weak evidence. If the paper introduces a new kind of operation, an example that clearly demonstrates the operation may be essential evidence. The reader can then understand what a broader evaluation would need to investigate.

I sometimes find that a newly introduced capability is treated as though the field already knew what all its important properties were. We ask for a large comparison before we have spent enough time looking at the new thing. This can be particularly limiting in graphics, where the work often produces a representation through which people can begin to ask questions that were previously difficult to formulate.

There is a parallel in research through design. In his [2012 essay](https://researchportal.northumbria.ac.uk/en/publications/what-should-we-expect-from-research-through-design/), William Gaver considers the diversity of design research a natural feature of an activity that generates new possibilities. He proposes that realized artifacts and accounts of them can play a central role in the development of design knowledge. The connection I see with graphics is the way a new artifact can give us something concrete through which to investigate an idea.

## Why a video can be evidence

Suppose a generated character looks convincing in a still image. When it moves, a viewer notices that its shoulder seems to detach from the rest of the body. The defect is understandable as a relation that appears over time. A number summarizing the quality of individual frames may capture some effects of the defect, but it may not help the viewer understand what actually went wrong.

A video gives the viewer access to the sequence. It lets them inspect how the parts move together and develop an account of the problem. Another viewer may notice something different. Someone who works with rigging might recognize a problem in the way the character deforms. An animator may be more concerned with the timing of the gesture.

The video does not give us an unmediated view of the system. Someone chose the inputs, the camera path, the playback speed, and the examples. The rendering itself is produced by a particular representation and renderer. A video can conceal a defect as easily as it can reveal one.

This is why I would like visual evidence to be designed around the claim it is meant to support. If a paper claims that a structure remains coherent as the camera moves, give the reader a view that makes the structure easy to examine. If it claims that lighting can be changed independently of the material, show the object under lighting that exposes the consequences of that separation. If a particular type of movement causes a failure, let the reader see the failure and understand the conditions under which it appears.

An interactive demonstration can provide another kind of evidence. A viewer can choose a position or a time that the authors did not choose for them. That gives the viewer a different opportunity to challenge the claim. It does not eliminate selection bias in the examples supplied, and it tells us little about instances that were never generated. But it makes some of the author's decisions about presentation less restrictive.

We should also distinguish the evidence a viewer obtains by examining a video from the evidence obtained through a study of people using a system. A study can investigate how people interpret a movement, how they develop a design, or how their activities change over time. These questions require observations of people in an appropriate setting. A rendered result cannot stand in for such a study.

## When new phenomena become easier to make

I expect machines to dominate much of the research organized around repeatable, executable comparisons. Once a test can guide a search, an agent can propose a change, run the test, and use the result to choose the next change. More capable systems can repeat the process and improve the search procedure. This is a powerful mechanism for improving methods. It will also change what it means for a researcher to present a better number.

Many visual problems will enter that process. An agent can learn to judge artifacts, generate them, and search for representations with desirable properties. There is no reason to assume that a quality visible to a human must remain inaccessible to a machine. A new visual capability may eventually become easy to reproduce.

The interesting consequence for graphics is the expansion of the things that people can make and investigate. A sufficiently capable generator might produce many different representations of aging objects. Some would be useful for animation. Others would matter to people studying materials, teaching a process, or making a particular kind of artwork. These purposes need not converge on one common notion of a good rose.

As optimization becomes routine, the set of phenomena we can construct and examine may expand much faster than our ability to agree on a ranking of them. An animator studying a flower's motion and a researcher studying its material can use the same representation to pursue different questions. Neither needs the other to accept a single definition of the best result.

A new research object has value in part because it admits observations that we have yet to make. For the rose, that could mean another view, another light, or another way of composing its changing shape into a scene. The question I would ask about the paper is what can I now investigate that I could not investigate before? Watching and manipulating the result helps me answer it.

## Editorial source and claim notes

Primary source checked: Geng et al., CVPR 2025, [paper](https://arxiv.org/html/2412.05278v2), Sections 3 and 6.2; [CVF record and PDF](https://openaccess.thecvf.com/content/CVPR2025/html/Geng_Birth_and_Death_of_a_Rose_CVPR_2025_paper.html), including first-page figure. Section 6.2 reports 95 participants, three preference criteria and CLIP scores. Comparisons concern shared renderings; no claim of biological accuracy or a qualitative ethnographic study is made. Gaver's institutional abstract was inspected; used for his methodological argument, not an empirical finding. Project page was inspected, but supplemental animations were not independently played or evaluated. All additional scenes are hypothetical. The prediction about automated evaluation is developed separately in draft 02.

Editorial status: source-checked at the level stated above; author approval, independent human reading, and publication conversion remain pending.
