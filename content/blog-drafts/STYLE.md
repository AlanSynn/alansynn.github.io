# Editorial writing and revision guide

The aim is a human-readable English research essay with the author's intellectual depth and the clarity of the published MotionSmith paper. The reader should be able to follow an argument without already sharing all of the author's knowledge. These are editorial decisions, not a new benchmark for prose.

## What to preserve from the existing writing

Read the author's published essays, especially [What My Best Answer Could Not See](../blog/what-my-best-answer-could-not-see.typ) and [When the Field Moves 2](../blog/when-the-field-moves-2-domain-specialty-value.typ). Their concrete situations make larger questions intelligible. The strongest paragraphs connect an activity or observation to a conceptual distinction and explain why it matters. Preserve the author's specific positions, technical interests, and willingness to examine competing values.

Use [MotionSmith: A Sketch-Based Design System for Automata Making](https://alansynn.com/motionsmith/static/pdfs/motionsmith-chi-2026.pdf) (Synn et al., CHI 2026, DOI [10.1145/3772318.3791545](https://doi.org/10.1145/3772318.3791545)) as a concrete writing reference. Its introduction establishes automata making as an activity before distinguishing the technical problem. Section 5.2.1 connects observable actions during authoring to the interpretation of agency and expressive intent. For example, the discussion of smoothing describes different artists' choices rather than assuming that the same operation has the same value for all of them. Section 5.2.1 reports that artists attended relatively little to the mechanism-matching scores. Do not extend that small expert study into a population claim. The paper is a model for the order and grounding of an explanation, not a requirement to give every essay the structure of a conference paper.

## Readability is not the same as brevity

Two relevant 2026 preprints are useful for this project:

- Clark, Martin, and Mahowald, [Why is AI-generated language so hard to understand?](https://arxiv.org/html/2610.29162v1). The authors examine linguistic features associated with processing difficulty and report differences between recent models and human text or controlled paraphrases. A length-penalty experiment provides evidence for a possible connection between compression pressure and linguistic choices. These results do not establish that every model or every generated essay is harder for people to read.
- Cekini et al., [The Cognitive Cost of LLM Writing: A Reading-Time Comparison with Human Text](https://arxiv.org/abs/2610.23715). In the paired-text analysis, the generated rewrites were shorter on average but had a higher predicted reading cost per word. The comparison uses a reading-time prediction model, rather than direct eye tracking of each of those paired articles. It is useful evidence for a possible distinction between compactness and reading effort.

The editorial response is to spend enough words to introduce relationships in a useful order. Do not optimize for a readability formula or a fixed sentence length. Those would be proxies for the reader's experience. They can help identify a problem, but should not decide what the explanation must contain.

## How to write the next version

Begin with an observation, problem, or direct claim that makes the topic worth entering. When possible, use a real public research result or an ordinary hypothetical scene. Do not invent an event from the author's life. Define a new concept after the reader understands what it is needed to describe. Keep the grammatical subject and action visible. Introduce a technical term when it has explanatory work to do, and then use it consistently.

Build paragraphs around distinct steps of the reasoning. A claim should have a reason; a case should have a consequence. Make the relationship between paragraphs clear rather than attaching generic transitions to unrelated ideas. Vary sentence length when it makes the argument easier to follow. Avoid unnecessary noun stacks, rare phrasing, nested clauses, and artificial contrasts. Keep precise scientific terms when they clarify the distinction. No em dashes.

Read the prose aloud and try to explain the argument to a reader from another research field. If the reader has to remember several undefined terms to understand the next paragraph, change the order. Remove repetition rather than compressing all of the remaining ideas into dense phrases. Preserve the author's uncertainty where the evidence is incomplete, and the strength of the author's judgment where it is supported.

Use concrete claims rather than decorative statements about the future of AI. Many of the essays in this library should work without an AI premise. For those making predictions, separate mechanisms, observed evidence, and future expectations. Do not turn the qualitative research argument into a claim that machines can never participate in it.

## Before a post moves to Typst

Each file is an editorial working draft. The new 100 entries include a developed prose body and separate source notes, but are intentionally short. Some topics merit substantial expansion; others may work as short essays. Verify the sources listed as leads before adding factual claims. The notes identify direct sources where they were examined and leads where further reading is required. Check the paper's actual scope, methods, evidence, counterexamples, and limitations. Retain citations near the relevant claims when preparing the finished article.

Remove editorial notes and internal status markers from the finished body. Compare neighboring essays for repetition in ideas, examples, openings, transitions, and conclusions. Revise the prose for the specific argument instead of imposing one template on all posts. Set the publication date and registered tags when promoting a selected essay to the existing Typst template. Keep the source in this editorial directory until the author explicitly selects it for promotion.

This directory is not part of the website's blog collection. Drafting here does not publish a post. The GitHub repository and its open draft pull requests are public, so this directory should not contain unpublished study results, private participant details, or confidential personal information.
