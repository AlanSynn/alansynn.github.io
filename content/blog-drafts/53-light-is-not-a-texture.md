# Light Is Not a Texture

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, philosophy-of-science

Imagine a painted box photographed under a bright lamp. One side looks pale and the other looks dark. We might represent the difference as part of the box's texture, or we might represent a relatively uniform material under uneven lighting. A single image can make both accounts seem reasonable.

The choice becomes visible when the lamp moves. If the original shadow was encoded in the texture, it may remain where it was even though the new lighting should remove it. A representation that separates material and illumination supports a different set of operations.

This is one of the reasons I find the problem addressed by [Birth and Death of a Rose](https://arxiv.org/html/2412.05278v2) interesting. The work concerns evolving object properties, including material, rather than only the appearance of an object in a video. The possibility of changing the lighting while examining the evolving object is part of the intended capability.

A successful relighting demonstration does not guarantee that the recovered material is physically correct. Inverse rendering can admit several explanations of an observed image, and a generative system may supply a plausible explanation rather than identify a unique physical one. A method should be evaluated in relation to the property it claims to recover or generate.

The broader lesson is that a rendering is an observation of a representation. Two representations that produce nearly identical observations today can respond very differently to tomorrow's intervention. I expect the ability to separate and manipulate such properties to remain an important way of describing the usefulness of visual technology, even when rendering quality itself becomes abundant.

## Editorial source notes

Checked: [RoSE4D paper](https://arxiv.org/html/2412.05278v2) and [project](https://chen-geng.com/rose4d/); the essay uses the task definition, not a new performance claim. Reading leads: intrinsic images and inverse rendering under ambiguous illumination.
