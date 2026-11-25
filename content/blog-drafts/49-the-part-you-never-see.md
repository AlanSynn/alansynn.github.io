# The Part You Never See

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, philosophy-of-science

A convincing reconstruction can contain parts of an object that nobody has observed. A drawing of a chair may hide one of its legs. We can infer a plausible shape for the missing leg, but several shapes would be consistent with the drawing. The distinction between observation and completion matters when someone needs to use the result.

Generative graphics has become very good at supplying plausible answers to questions like these. That capability is valuable. It also changes the meaning of a reconstructed object. Some of its properties may be supported by observations. Others may come from the model's prior knowledge of what chairs usually look like.

The difference becomes consequential in the next activity. Someone who wants an illustration may be satisfied with a plausible unseen surface. Someone fabricating a replacement component needs to know which dimensions were observed and which were inferred. The same complete-looking model can be appropriate for one activity and misleading for another.

A designer might use the generated shape as a starting point and accept responsibility for choosing the missing dimensions. A reconstruction intended to guide the replacement of an existing component would need another kind of evidence. The model's uncertainty becomes practically important because the consequences of a mistaken completion differ between those activities.

An interesting design question is whether a representation can preserve this distinction without making the artifact difficult to use. For example, a reconstruction tool could allow several plausible completions of an unobserved region, or indicate where acquiring another view would resolve an ambiguity. The aim would be to help the user decide when an inferred part of the object is sufficient.

A generator may eventually provide an extraordinarily plausible account of the unseen part of an object. We would still benefit from knowing whether the account was established through an observation or supplied as a reasonable completion. That information helps a user decide whether to proceed with the model or acquire another view.

## Editorial source notes

Reading leads: inverse graphics, visual hulls, uncertainty in single-view reconstruction, and shape completion. Use a specific example with known hidden geometry and multiple plausible completions; avoid conflating ambiguity with model error.
