# The Image Is Finished. The Artifact Is Not.

**Status:** Long-form editorial manuscript | **Theme:** Graphics, fabrication, and making | **Candidate tags:** computer-science, philosophy-of-science, ai

Two images of a chair can look identical while being useful for very different things. Suppose one was rendered from a model whose dimensions and geometric relationships are editable. The other was generated as an image. If we ask the designer to make the chair wider while preserving the proportions of the legs, the distinction becomes consequential.

In one workflow the designer can modify a dimension and inspect the effect on the connected parts. In another, the designer might request a new image and discover that some properties have changed unexpectedly. These are hypothetical workflows; a capable generative editor could eventually make the second operation very reliable as well. The comparison matters because the designer has another task to perform after obtaining the image.

Graphics research can create an excellent visual result. It can also produce an artifact that carries useful relationships forward into later work. To evaluate the latter contribution, we need to understand which changes the artifact supports.

## An image is an observation of something

A rendering is often the way we encounter the result of a graphics method. We see a scene, a character, or the surface of an object. The image allows us to examine properties of the result without having to work directly with the data structures that produced it.

Sometimes the image is exactly what we need. A person making a poster may only want a particular composition. If a generative system produces it, and the person has no intention of changing it, producing a more elaborate representation may have little value.

In another activity, the image is one observation of a working artifact. A person may need to turn an object around, change the material, move a part of it, or place it into a new environment. The artifact has value partly because of the observations and changes it makes available.

[Birth and Death of a Rose](https://arxiv.org/html/2412.05278v2) is a particularly interesting example. Geng and colleagues study the generation of dynamic object intrinsics, including geometry and appearance over time. The authors present evolving objects that can be examined under different views and lighting conditions. The time-dependent object supplies a representation for generating a family of observations rather than a single fixed animation.

The paper also evaluates visual results. Its comparison includes quantitative preference judgments and CLIP scores. These measurements give the authors evidence concerning the compared outputs. A separate part of the contribution is that the proposed representation supports operations that some comparison methods do not provide in the same form. A person can change the lighting in a scene while keeping the generated object at a particular point in its development.

For someone trying to use such an object in another scene, that distinction could be quite consequential. They may care about a render from a particular viewpoint. They may also care about what happens when they move the viewpoint or change the illumination. Evaluating the first image does not establish the answer to all those subsequent questions.

## What should remain the same?

Consider an animator who has designed a character and a small movement. They like the movement but want the character to be a different color. The change sounds simple. To understand what it means, we have to identify the properties that should remain unchanged.

The character should probably retain its shape. Its motion should still have the same timing. The color of another object should perhaps remain the same. The appearance of the scene may need to change in some respects because light interacts with the new material differently. The desired operation involves a collection of relationships among properties.

A representation can help make those relationships available. If the geometry, material, and motion are separately manipulable, the animator has a way to specify the intended change. The representation may also make it possible to reproduce the change, examine its consequences, and return to an earlier decision.

The relevant invariants may include decisions made by another person. A colleague who has already prepared a part for fabrication may need its mounting holes to remain compatible while the surrounding object changes. A representation that preserves the relationship gives the group a way to continue the same project. Producing a plausible replacement object may instead create a new project.

This does not mean that all relevant relationships are simple to encode. A person can have a particular idea about a character's identity that is difficult to describe in terms of geometry and material. They may want a movement to feel similar even when the underlying trajectory changes. The useful notion of sameness depends on the activity.

A generative editor might become exceptionally good at inferring the properties the person wants to keep. It may produce a revised image or scene that satisfies the request more conveniently than a traditional authoring tool. In many cases that is precisely the form of assistance the person needs.

The question remains useful even in that future. We need some way to understand which properties the editing process preserves, which ones it may change, and how the person can investigate the result. Whether the operation is implemented through explicit parameters or a learned system, the artifact is useful because of the changes a person can make to it.

## Work that has to survive the next decision

Imagine that two designers are collaborating on a mechanism. One is interested in the motion of a figure, and the other is preparing parts that can be fabricated. The first designer decides to change the motion. The second has already made a number of decisions about the placement of components.

A system that produces a new, plausible mechanism after each change may be very good at solving the individual generation problem. But if each generation discards the fabrication decisions the second designer has made, it will create work for the group. They need to understand how the next result relates to the object on which they have already worked.

A representation of the artifact can carry some of those earlier decisions forward. The mechanism's relationships may remain explicit while the motion changes. The person can see which parts are affected, and the system can help identify places where the new request conflicts with an existing constraint.

There will be situations where maintaining those relationships is more expensive than making a new artifact. If the original decisions are no longer useful, starting over may be a very good choice. A designer should be able to decide whether to preserve an earlier design, revise it, or discard it.

What I would like to investigate is the cost of preserving something through change. It matters when a representation is passed between people, when a project extends over several days, or when an object is incorporated into a larger design. These are ordinary conditions of creative work that may not be visible in an evaluation of the first generated result.

A useful authoring tool can make the relevant relationships accessible without forcing the person to understand every internal detail of the representation. An animator may not need to know how a motion is stored. They may need to understand that changing the length of a gesture will affect its relationship to another event. The design of the operation should make that distinction intelligible.

## Evaluating what happens afterward

Suppose we are comparing two systems that generate a three-dimensional object. We can examine the quality of their renderings and the efficiency with which they produce them. If the intended use involves further authoring, I would like the evaluation to continue beyond that point.

Give someone an object and a meaningful next task. Ask them to change the lighting, modify a part, alter the timing of a movement, or fit the object into a surrounding design. Observe which properties survive the operation, what the person has to specify again, and whether they can recover from an unsuccessful change.

For some tasks, the evaluation can have a precise numerical definition. We can test whether a dimension or a constraint is preserved, or measure the deviation of a trajectory. For others, people may need to examine the revised artifact and decide whether it retains an expressive quality they care about. The result of that inspection can guide the next decision.

A useful evaluation would describe why the selected operations matter. There is no general reason to require every generated image to support arbitrary geometric editing. Nor is there a reason to reject regeneration when a person can reliably obtain the result they want through another request. The intended activity should determine the meaning of the comparison.

The next request to change the chair provides evidence that was unavailable when we first looked at the images. It reveals whether the designer can revise one part of the object without having to recover decisions they have already made. In a continuing project, preserving those decisions can be as consequential as producing the first result.

A graphics method can contribute a new object to a scene. It can also contribute a useful way of continuing to work on that object. I would like evaluations to give readers a way to recognize the difference.

## Editorial source and claim notes

- Geng et al., Birth and Death of a Rose, CVPR 2025, arXiv:2412.05278v2, §3 and §6.2; paper and public CVF figure checked. Use the stated time/view/illumination operations and the actual comparison scope. No claim of physically unique intrinsics, general geometry-editing support, or a completed authoring study is made.
- All chair, animator and mechanism collaboration examples are hypothetical. The evaluation procedures are proposed experiments, not completed evaluations.
- Separate this artifact-lifecycle argument from 01 (evidence for a phenomenon), 29 (authoring vocabulary), 53 (lighting/material decomposition), 56 (geometric structure), and 63 (representation transfer). Author approval and independent human reading remain pending.
