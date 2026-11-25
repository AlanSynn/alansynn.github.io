# Light Is Not a Texture

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, philosophy-of-science

A texture containing a dark patch can make an object look as though it is in shadow. A rendering of a uniformly colored object under a particular light can produce the same appearance. Moving the light gives us a useful way to distinguish the two accounts of the scene.

The choice becomes visible when the lamp moves. If the original shadow was encoded in the texture, it may remain where it was even though the new lighting should remove it. A representation that separates material and illumination supports a different set of operations.

This helps explain the problem addressed by [Birth and Death of a Rose](https://arxiv.org/html/2412.05278v2) interesting. The work concerns evolving object properties, including material, rather than only the appearance of an object in a video. The possibility of changing the lighting while examining the evolving object is part of the intended capability.

A successful relighting demonstration does not guarantee that the recovered material is physically correct. Inverse rendering can admit several explanations of an observed image, and a generative system may supply a plausible explanation rather than identify a unique physical one. A method should be evaluated in relation to the property it claims to recover or generate.

An informative intervention would change the illumination in a way that makes an appearance baked into the material difficult to conceal. For a generated object, the test can establish consistency with the chosen representation and renderer. A claim about the reflectance of an actual observed object requires additional evidence about that object.

An evaluation of relighting should examine the result under a change in illumination that makes the distinction consequential. The image under the original light may remain beautiful in either representation. The response to a new light reveals which relations the method has made available for further use, and whether they support the claim about the material.

## Editorial source notes

Checked: [RoSE4D paper](https://arxiv.org/html/2412.05278v2) and [project](https://chen-geng.com/rose4d/); the essay uses the task definition, not a new performance claim. Reading leads: intrinsic images and inverse rendering under ambiguous illumination.
