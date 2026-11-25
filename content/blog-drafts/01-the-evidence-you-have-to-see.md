# The Evidence You Have to See

**Status:** extended working draft | **Theme:** Evidence after the scoreboard | **Candidate tags:** philosophy-of-science, computer-science

*Part 1 of a proposed two-part essay on qualitative evaluation.*

A rose opens and withers. An image of it at the beginning and another at the end can show us two shapes. Watching the interval between them reveals something else: how the petals move in relation to one another, how the material changes, and whether the object seems to remain the same object throughout its life. The difference between those two forms of evidence is a good place to begin thinking about computer graphics research.

In [Birth and Death of a Rose](https://arxiv.org/html/2412.05278v2), Geng and colleagues study the generation of temporal object intrinsics. Their method generates evolving geometry, reflectance, and texture from guidance derived from pretrained 2D models. The resulting asset can be rendered at different times, from different viewpoints, and under different environmental lighting. The authors demonstrate several natural processes, including flowering, melting, and baking. The [project page](https://chen-geng.com/rose4d/) lets us examine the kind of object the paper describes.

There are numbers in the paper. Its comparison covers seven natural processes, reports preference judgments from 95 participants across three criteria, and includes a CLIP score. The paper's comparison methods could not generate the same full set of dynamic object intrinsics, so the shared comparison is limited to renderings. I find that asymmetry more interesting than the leaderboard. The new capability cannot be entirely described by the dimensions on which the old capabilities could be compared.

## Making something observable

A considerable part of graphics research concerns the construction of a new object of inquiry. Imagine asking for a material whose appearance changes with its age, or an animation whose internal state can be inspected and edited. Before a representation exists that supports such an operation, it may be hard to give a meaningful answer to a quantitative question about its quality. There may be no agreed benchmark because there is no established category of things to put in the benchmark.

A working artifact makes a possibility concrete. It can also change the vocabulary of the field. Someone who sees a controllable temporal asset may begin to distinguish geometry that changes, reflectance that changes, and a temporal state that can be manipulated independently of the camera. Those distinctions can be stated in a paper. Being able to examine the object makes it easier to understand how they relate.

This suggests a distinction between the discovery of a possibility and the estimation of a performance distribution. A carefully characterized working example can establish that a capability is realizable under the stated conditions. It cannot establish that a method reliably realizes the capability across an unknown population of inputs. A large evaluation can support the second claim once the population and outcomes are defined. It may tell us little about why the first capability matters.

Computer science has good reasons to ask both questions. But treating the second as the universal form of a scientific contribution places a new possibility at a disadvantage. It asks the new object to fit a comparison space built around its predecessors. The important change may be precisely the fact that the object admits a new kind of observation or intervention.

## Looking is a form of inquiry

A reader of a graphics paper can inspect a rendered sequence and form judgments that the caption did not anticipate. Does the flower retain its spatial structure when the camera moves? Does a surface appear to undergo a change in reflectance, or has a lighting effect been baked into its texture? Does the animation suggest a continuous process or a succession of attractive images? The reader is making observations through the representation the authors have supplied.

The video is therefore part of the evidence, rather than simply an attractive accompaniment to the table. It offers access to relationships that might have been lost when the work was summarized in a number. The table can tell us how participants voted within a defined study. The video lets us examine what they could have been responding to, notice other properties, and disagree with the description.

There is an important limit. What we see is a particular rendering produced by a particular process. It is mediated evidence. A camera angle can conceal a geometric failure, and a beautiful sequence can conceal a method that rarely succeeds. Watching an example cannot reveal an unobserved distribution of failures. Nor does visually plausible aging establish biological or physical accuracy. The strength of the example depends on the claim it is meant to support.

We should distinguish visual inspection, subjective quantitative assessment, and qualitative research. A panel of viewers assigning scores is a quantitative perceptual study. A video comparison may be an inspection of an artifact. An inquiry into how artists interpret and use the evolving asset might involve observation, interviews, and situated experimentation. These practices can be related, but each warrants a different inference.

## What rigor looks like when the result is an experience

The familiar criticism of qualitative results is that they are easy to select. It is a serious criticism. A demonstration can be chosen to show an effect that disappears elsewhere. An author can make a method look convincing by controlling the viewpoint or the pace at which the video is played. There is no reason to exempt visual evidence from scrutiny merely because numerical evidence is incomplete.

The appropriate response is to give other observers more ways to examine the claim. In the case of a dynamic material, let them change time, lighting, and viewpoint. Explain the intended behavior and distinguish it from appearance that is merely plausible. Give examples in which the representation fails. Document the inputs, selection process, and constraints. If the paper claims a mechanism, show what changes when that mechanism is removed. If it claims broad reliability, investigate the range of conditions in which it succeeds and fails.

This is not a proposal to replace every number with a video. The choice of evidence follows the kind of statement being made. A physical guarantee requires a different argument from a claim that an artist can create a new class of assets. An account of a person's experience requires something different again. In each case, the question is how another person can challenge the proposed knowledge.

The HCI literature on research through design offers a useful parallel. [William Gaver's 2012 essay](https://doi.org/10.1145/2207676.2208538) discusses how design research can particularize and diversify through conceptually rich artifacts and annotations of examples. The similarity is not that graphics papers and design studies use the same research method. Both can produce artifacts through which a previously hard-to-express possibility becomes available for inspection.

## After the scoreboard

I expect AI to become exceptionally good at the kinds of comparison that can be made into reliable automated evaluations. That expectation does not make it impossible for AI to generate new representations, interesting visual artifacts, or compelling demonstrations. It changes the relative authority of their scores. When many methods can reach a familiar standard, a graph of incremental improvement may tell us less about the nature of the contribution.

More interesting differences will become visible in the things that can be made and experienced. Some will be technically novel. Some will matter to only a small group. Some will be apparent to an expert who cares about materials and imperceptible to someone who cares about the motion. Those differences may never have a common ranking.

The rose is worth returning to because the research provides an object whose behavior a reader can explore. A future system may generate a more convincing rose without specialist effort. The old optimization challenge will then have lost much of its distinction. The possibility of watching, manipulating, and reasoning about the process will remain, and may give rise to many other forms of work. In a field increasingly supplied with good scores, I expect the evidence we have to see to occupy more of the conversation.

## Editorial checks before publication

- Compare the actual RoSE4D supplemental videos and comparison settings; discuss only properties that can be observed or that the paper explicitly claims.
- The paper does include quantitative evaluation. Do not portray it as an evaluation-free study or as proof of scientific realism.
- Keep the central claim about the epistemic role of a new representation, not the stronger unsupported claim that visual evidence guarantees generalization or cannot be processed by AI.
- Pair with Part 2, which examines the changing authority of an executable evaluation rather than the evidence for a new visual capability.

## Source notes

Checked: [RoSE4D paper, Sections 3 and 6](https://arxiv.org/html/2412.05278v2); [project and interactive examples](https://chen-geng.com/rose4d/); [Gaver, What should we expect from research through design?](https://doi.org/10.1145/2207676.2208538) (abstract). For further development, inspect representative graphics papers with video supplements and explicit failure cases; do not select examples based only on agreement with this essay.
