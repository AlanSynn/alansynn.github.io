# The Image Is Finished. The Artifact Is Not.

**Status:** editorial draft / argument development | **Theme:** Graphics, fabrication, and making | **Candidate tags:** computer-science, philosophy-of-science, ai

Two images can look identical on a screen while having completely different futures. One can be edited, animated, viewed from another direction, and placed into a new scene. The other can only be replaced by another image. An evaluation that compares the two finished images may conceal the difference that matters most to the person who will use them.

## Working argument

A representation gives its user a set of operations. A mesh may support geometric editing, a scene graph may support changes to spatial relationships, and a representation that separates lighting from material may support relighting. RoSE4D provides a concrete example of the importance of a generated asset's future uses: temporal state, viewpoint, and environmental lighting can be changed. Its visual output is one observation of that asset.

As generative models become more capable, the distinction between producing a result and producing the means to modify the result will become more significant. An artist may need to preserve the identity of one element while changing another. A designer may need to recover an earlier decision without disturbing later edits. Regenerating a visually comparable result can be cheaper than preserving a complicated representation, but it may break the relationships the user intended to retain.

The essay should compare artifacts by the operations and commitments they make available, rather than treating an image score as a complete account of the product. A generator may eventually create high-quality editable representations as easily as it generates pixels. That development would shift the problem again. It would not make the distinction between an output and a working artifact disappear.

## Challenge

Users sometimes want a disposable final output and have no reason to value editability. Regeneration and natural-language editing can be excellent alternatives. Ask which operations need stability in the intended workflow and how each representation supports them.

## Source plan

Checked: [Birth and Death of a Rose](https://arxiv.org/html/2412.05278v2), especially its task definition and relighting capability. Reading leads: editable scene representations, parametric CAD, image editing consistency, and non-destructive editing. Distinct from The Evidence You Have to See: the object of analysis here is the future of the artifact in an authoring workflow.
