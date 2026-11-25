# The Part You Never See

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, philosophy-of-science

A person draws a chair with one leg hidden behind the seat. We have little difficulty imagining that the chair has another leg. A computer reconstructing the chair faces a more precise problem: where does that leg go, how thick is it, and what connects it to the seat? The drawing has left many possibilities open.

Generative graphics has become very good at supplying plausible answers to questions like these. That capability is valuable. It also changes the meaning of a reconstructed object. Some of its properties may be supported by observations. Others may come from the model's prior knowledge of what chairs usually look like.

The difference matters when we use the result. Someone who wants an illustration may be satisfied with a plausible unseen surface. Someone fabricating a replacement component needs to know which dimensions were observed and which were inferred. The same complete-looking model can be appropriate for one activity and misleading for another.

An interesting design question is whether a representation can preserve this distinction without making the artifact difficult to use. For example, a reconstruction tool could allow several plausible completions of an unobserved region, or indicate where acquiring another view would resolve an ambiguity. The aim would be to help the user decide when an inferred part of the object is sufficient.

A stronger generator may produce a very convincing hidden leg. It cannot make the original observation contain information that was never captured. Sometimes what we need from a visual system is a useful invention. Sometimes we need an account of what was actually there. Those tasks deserve to remain distinguishable even when the images look equally good.

## Editorial source notes

Reading leads: inverse graphics, visual hulls, uncertainty in single-view reconstruction, and shape completion. Use a specific example with known hidden geometry and multiple plausible completions; avoid conflating ambiguity with model error.
