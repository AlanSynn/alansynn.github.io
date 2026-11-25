# Revision report: full-library editorial revision and prior audit

**Reviewed:** 2026-11-25. **Baseline:** `f80a771669c046ac2c714e68d3d6eca4c557392a`. All work remains in the unpublished draft library. No author approval, independent human-reader test, Typst build, site deployment, or complete claim-level audit of the 136 essays is represented as having occurred.

## Collection-wide editorial revision

Comparison base: `6a0bfa3767f7f36d4799f67e8520071edbb97882`. The current main blog collection was inspected before editing. Eight non-draft Typst posts were identified; no numbered draft matched their titles or slugs. The published files are outside the changed paths. The existing usage guide is a separate draft and was also left alone.

- All 136 numbered unpublished manuscripts received a body edit: revised openings and conclusions, fuller rewriting of the early short argument drafts where needed, and additional paragraph-level changes.
- A second focused pass changed a substantive aspect of each individual essay. The [review log](EDITORIAL-REVIEW.md) records all 136 interventions: technical distinctions, evidential boundaries, examples, causal mechanisms, alternative explanations, scope, or explanatory continuity.
- The [style guide](STYLE.md) now establishes ten editorial dimensions, several possible argument structures, and worked examples from multiple areas. MotionSmith is one optional reference, not a universal template. The guide requires strong claims where warranted, direct argument, and appropriate evidence rather than systematic softening.
- The [roadmap](EDITORIAL-ROADMAP.md) and indexes retain stable IDs and distinguish manuscript states. The previous count of 20 long-form editorial manuscripts and 116 shorter working drafts remains the completion classification. This pass does not claim to have completed the long-form expansion of all 116, a fresh claim-level literature audit, or an independent human-reader evaluation.
- The previous source and claim notes have been retained as the basis for future verification. New illustrations are analytic or hypothetical, not new empirical results. A substantive editorial intervention is not certification that an essay is ready to publish.

The word counts in the prior revision section below refer to that earlier snapshot, not the current prose. Publication and build checks remain pending; all work stays outside the website's published collection.

## Previous revision inventory (historical snapshot)

- 136 numbered drafts retained, with no change to their filenames or IDs.
- 20 developed long-form editorial manuscripts, approximately 29,947 words of revised prose (rough word count excluding title, status line and editorial notes).
- 116 earlier short drafts retained. Their individual argument/evidence/counterpoint plans are in the roadmap. They are not long-form finished essays.
- All 136 baseline Markdown contents were reconstructed from complete added-file patches in the original PR and checked for presence, word count, paragraph blocks, editorial notes, explicit source URLs, and em dashes. The baseline contains 134 essays under 500 prose words, median 265; all 136 have source notes, 100 have no explicit URL, and the 34 unique explicit URLs were reviewed at the levels in SOURCE-AUDIT. These are mechanical and source-level checks, not verification of every factual assertion.
- The 20 revised source files were individually retrieved from the new Git tree, checked for the long-form status and editorial source/claim-note section, and counted. No em dashes were found in those files. The exact passages or limited source-access levels are in the individual editorial notes. Examples are marked as hypothetical where they are not empirical reports.

## Long-form manuscripts

| ID | Manuscript | Approx. words |
|---|---|---:|
| 01 | [the evidence you have to see](01-the-evidence-you-have-to-see.md) | 1,735 |
| 02 | [when evaluation becomes an algorithm](02-when-evaluation-becomes-an-algorithm.md) | 1,860 |
| 09 | [who owns the experiment](09-who-owns-the-experiment.md) | 1,352 |
| 10 | [when the reviewer has an agent](10-when-the-reviewer-has-an-agent.md) | 1,525 |
| 13 | [the robot that saw but did not know](13-the-robot-that-saw-but-did-not-know.md) | 1,489 |
| 19 | [preferences that do not exist yet](19-preferences-that-do-not-exist-yet.md) | 1,492 |
| 20 | [the cost of a perfect default](20-the-cost-of-a-perfect-default.md) | 1,540 |
| 24 | [the user who should not become a requirement](24-the-user-who-should-not-become-a-requirement.md) | 1,439 |
| 25 | [the image is finished the artifact is not](25-the-image-is-finished-the-artifact-is-not.md) | 1,482 |
| 29 | [every authoring tool is a theory](29-every-authoring-tool-is-a-theory.md) | 1,439 |
| 31 | [the teacher after the tutor](31-the-teacher-after-the-tutor.md) | 1,524 |
| 32 | [the exercise that should stay difficult](32-the-exercise-that-should-stay-difficult.md) | 1,349 |
| 36 | [who gets to be a beginner](36-who-gets-to-be-a-beginner.md) | 1,499 |
| 37 | [the reader has no context window](37-the-reader-has-no-context-window.md) | 1,503 |
| 42 | [the introduction is a route](42-the-introduction-is-a-route.md) | 1,319 |
| 51 | [a perfectly smooth motion can look wrong](51-a-perfectly-smooth-motion-can-look-wrong.md) | 1,310 |
| 57 | [what the sketch was trying to say](57-what-the-sketch-was-trying-to-say.md) | 1,379 |
| 89 | [fast enough for whom](89-fast-enough-for-whom.md) | 1,461 |
| 98 | [the most difficult part of an ablation](98-the-most-difficult-part-of-an-ablation.md) | 1,558 |
| 134 | [the right to remain unmeasured](134-the-right-to-remain-unmeasured.md) | 1,692 |

## What the collection-wide review found

The original short drafts are useful as seeds, but their uniform length and repeated hypothetical opening/forecast structures can make independent questions sound like variants of a single article. The audit found 45 drafts using the phrase "I expect" and 21 opening with "Imagine", "Suppose", or "Consider". These are diagnostic observations, not defects automatically inferred from word counts. The expanded articles develop different explanatory routes; further revisions should avoid replicating their structures mechanically.

The current most consequential risks are (1) presenting a source lead as an inspected finding, (2) conflating visual evidence, subjective quantitative evaluation and qualitative inquiry, (3) turning a technical forecast about optimization into an unqualified social or economic conclusion, (4) repeatedly using MotionSmith for the same argument, and (5) inventing first-person or participant details to make prose sound personal. The revised guide addresses these directly. The 136-entry roadmap includes a concrete case, a distinct claim, and a counterpoint for each draft, plus clusters of related topics that require separation.

## Publication and verification boundary

All 136 drafts are in `content/blog-drafts/`, outside the blog collection. The PR remains open as a draft. The updated guide defines the steps for moving from editorial manuscript to publication candidate. This revision does not claim that the remaining 116 have been expanded, that every named reading lead has been retrieved, that every DOI could be resolved, or that the author's voice and human readability have been independently evaluated. These distinctions are intentional and should remain visible in the repository.

See [STYLE](STYLE.md), [EDITORIAL-ROADMAP](EDITORIAL-ROADMAP.md), [SOURCE-AUDIT](SOURCE-AUDIT.md), [BASELINE-AUDIT](BASELINE-AUDIT.md), and the original indexes. Do not use the baseline counts as the post-revision counts.
