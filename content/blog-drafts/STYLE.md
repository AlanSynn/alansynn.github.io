# Editorial standard for the long-form research essay library

## Purpose and reader

These essays should make a particular idea about computing, research, design, or education easier to understand and harder to dismiss. They are English research essays for a technically literate reader who may come from another subfield, including a serious undergraduate. They need not resemble papers submitted to a conference. They should preserve the intellectual specificity and reflective tone of the author's published blog and the explanatory clarity of MotionSmith.

The reader can follow a difficult argument when the objects, activities, and relations needed to reason about it are introduced in a useful order. Depth comes from the quality of the distinction, the evidence, the mechanism, and the consequences. It does not come from density of terms, length of sentences, or the amount of background an author can compress into a paragraph.

A good essay here has a recognizable point of view. It makes a claim the reader could disagree with. It gives the reader a reason to care, lets them inspect the basis for the claim, considers a serious limit or alternative account, and arrives at a judgment that follows from what has been discussed.

## Primary style references

Read the author's [What My Best Answer Could Not See](../blog/what-my-best-answer-could-not-see.typ) and [When the Field Moves 2](../blog/when-the-field-moves-2-domain-specialty-value.typ) as essays. Their reflective first-person voice, use of concrete situations, and willingness to distinguish several kinds of value are important. Do not imitate isolated rhetorical constructions until they become a house formula.

Read [MotionSmith: A Sketch-Based Design System for Automata Making](https://alansynn.com/motionsmith/static/pdfs/motionsmith-chi-2026.pdf) (Synn et al., CHI 2026, DOI [10.1145/3772318.3791545](https://doi.org/10.1145/3772318.3791545)) for a second model:

- The introduction describes automata making as an activity and gives the reader a concrete difficulty before establishing the technical contribution.
- The workflow explains what the maker does, what the system does, and how the two activities interact. A term gains meaning through what it allows someone to do.
- Section 5.2.1 moves from observations of particular artists to an interpretation of authoring. For instance, different decisions about smoothing have different expressive purposes. The discussion about attention to mechanism-matching scores concerns those artists and their tasks. It is not a universal claim about how designers evaluate motion.
- Use the public paper's actual observations. Do not invent participant quotations, studio experiences, or unpublished study outcomes. The available paper text was inspected in this revision; page-image retrieval failed.

## Readability research and what it permits us to conclude

Clark, Martin, and Mahowald, [Why is AI-generated language so hard to understand?](https://arxiv.org/html/2610.29162v1), examine linguistic features associated with reading difficulty and a possible effect of pressure to produce shorter text. The measured features and the length-penalty experiment motivate attention to sentence structure and compressed expressions. They do not establish that every generated document is difficult, that every human document is easy, or that all models were trained with the same objective.

Cekini et al., [The Cognitive Cost of LLM Writing: A Reading-Time Comparison with Human Text](https://arxiv.org/abs/2610.23715), compare 496 pairs of articles and rewrites. In their analysis, predicted reading time per word increases for rewrites while predicted total reading time is slightly lower. These are estimates from a reading-time model rather than direct measurements of comprehension for the paired articles. Both works are preprints; preserve their scope and check updated versions before publication.

The editorial implication is concrete: avoid saving tokens by transferring the work of reconstructing the relations to the reader. Spend words where the reader needs to form a new concept. Do not replace readability with a numerical threshold, or infer a causal explanation for difficult prose from a correlation alone.

## 1. Choose an argument worth developing

For each manuscript, consult the [editorial roadmap](EDITORIAL-ROADMAP.md). Before writing, identify:

1. The specific observation or difficulty the essay examines.
2. The main claim in one or two sentences. Name the relationship, mechanism, or distinction that makes the claim different from an existing essay.
3. The concrete case or worked example that makes the claim inspectable.
4. The strongest reasonable alternative explanation, counterexample, or boundary condition.
5. The consequence for how a researcher, builder, teacher, or community would think or act differently.

These five items are working notes, not the required visible structure of the article. An essay about visual evidence, a technical design, and an institution can make use of very different forms of argument. Do not make all 136 articles recapitulate the same thesis about AI or human labor.

An important position in this library is that reliably evaluable, repeatable competition can enter automated improvement loops, and that widespread access to capable systems can weaken the use of scores as evidence of distinctive personal merit. The technical prediction and its social consequences are separate claims. Difficulty and resource constraints influence the rate and scope of the change; unequal ownership and access may alter its social outcome. Do not replace the position with a generic reassurance that people will always be important.

The expansion of qualitative inquiry and plural purposes is another prediction. It is compatible with capable automated research, interpretation, and preference learning. It is not a claim that an entire method belongs exclusively to humans. Distinguish the ability to measure, learn, or optimize an operational property from the normative decision that the property should govern everyone's activity.

## 2. Select the right explanatory structure

Use a structure fitted to the argument. Four useful shapes are:

| Essay type | A reader's route through the argument |
|---|---|
| Technical distinction | Concrete operation or failure; define the two things that are being conflated; show what changes in a worked example; specify assumptions and implications. |
| Empirical case | Introduce the activity; describe the actual study or artifact and the relevant conditions; report the bounded observation; interpret it; test alternative interpretations; explain why the distinction matters. |
| Institutional forecast | Begin with the current practice; identify a mechanism through which technology changes costs or authority; follow the consequences under different arrangements; state which observations would support or weaken the forecast. |
| Reflective or normative essay | Establish a recognizable conflict between worthwhile purposes; develop a defensible position; consider the other people affected and legitimate counterclaims; arrive at a bounded judgment. |

The opening should be enough to establish the topic and the main tension. A reader should not have to reach the final section before discovering the point of the essay. Use one central example when it can carry the argument. Add another only if it establishes a different mechanism, a counterexample, or a useful boundary.

A long-form article will often be 1,200–2,500 words with a few meaningful sections. Some arguments require more or less. Treat the range as a practical planning aid, not a target score. A 1,300-word article with a developed argument is stronger than a 2,000-word article with several repeated conclusions. Do not inflate a short draft by mechanically expanding every sentence.

Headings should advance the argument. For example, "Whose requests are slow?" is more informative in a systems essay than "A New Perspective." Do not use the same heading sequence in every manuscript. The final section should draw a consequence, clarify what remains uncertain, or leave the reader with a precise question. Avoid a generic optimistic conclusion unrelated to the argument.

## 3. Write sentences that carry thought rather than conceal it

Give the reader a person, object, operation, or relation before asking them to interpret a dense abstraction. When a term has already been established, use it consistently rather than paraphrasing it each time. Keep technical terminology when it lets us make a precise distinction. Introduce it at the point where it has a job to do.

The following edits illustrate the standard. They are illustrative editorial examples, not quotations from a paper.

**Compressed:** "Preference-contingent motion representation enables iterative intent alignment through affordance-mediated exploration."

**Developed:** "A maker may begin with a motion sketch and change the idea after seeing what a mechanism can do. The tool should let the maker return to the sketch without losing the useful parts of the mechanism. In that way, the representation can support the development of an intention rather than treating the initial sketch as a fixed target."

The second version is longer because it establishes the actor, the sequence of events, the consequence for the tool, and the distinction the essay wants to examine. It does not require the reader to infer the process from a noun phrase.

**Unsupported:** "The human qualities of an artwork can never be quantified."

**Developed:** "A viewer can rate the smoothness of a movement. That rating can be useful evidence about how the viewer experienced the movement. If an artist is interested in a deliberately hesitant gesture, however, a higher smoothness rating need not identify the movement the artist wants. The question is which property matters to the work."

The second version has a stronger argumentative boundary. It remains true even if a model can predict the viewer's judgment or the artist's choice.

**Vague forecast:** "AI will transform how research is conducted."

**Developed:** "A reviewer could use an agent to inspect a method's implementation and run a small, authorized counterexample search. That would reduce the cost of some criticisms. If authors are expected to respond to every newly available criticism, the reviewing institution could shift a large part of that cost to them."

The improved version identifies a mechanism and an institutional consequence that can be investigated. It does not claim that the future has already arrived.

Use complete paragraphs with a coherent purpose. A paragraph can introduce a claim, examine an example, explain a relation, or consider a limit. The paragraph should give the reader enough context to understand why the next one follows. Remove paragraphs that merely rephrase an established point.

Prefer simple subjects and active, precise verbs. Avoid long noun stacks, layered hedges, vague pronouns, artificial contrasts, rhetorical questions without answers, repetitive opening phrases, and overuse of "I expect." A reflective first-person judgment is welcome when it represents the author's position. Never invent an event from the author's life or imply that a hypothetical study occurred. Use no em dashes.

## 4. Establish evidence before stating a result

The [source verification ledger](SOURCE-AUDIT.md) distinguishes inspected passages, abstracts or records, project reports, and unresolved links. A source is not verified simply because it has a plausible title, DOI, or URL. Neither a source-level check nor a fluent summary certifies every claim that might be made from that source.

For each important factual assertion record the following in the file's editorial notes:

| Field | Requirement |
|---|---|
| Claim | The actual assertion made in the manuscript. |
| Source | Primary paper, official documentation, original artifact, or other appropriate evidence. |
| Locator | Section, figure, table, page, paragraph, or explicitly identified abstract. |
| What it establishes | Population, experimental conditions, task, intervention, measurement, and reported result when applicable. |
| What it does not establish | Generalization, causal interpretation, mechanism, future condition, or normative claim beyond the evidence. |
| State | Passage checked, abstract/record only, project report, unresolved, or hypothetical/analytic. |

A named reading lead is not a citation until checked. Prefer original sources for specific findings and numerical results. Cite a review for the synthesis it actually provides. Attribute developer-reported outcomes to their authors. Recheck preprints, technical capabilities, dates, and institutional policies when preparing a post for publication.

Separate evidence, inference, and speculation in the prose itself. "The study found" should introduce the reported finding. "This suggests" requires a reasoned inference. "I expect" introduces a forecast, which should name a mechanism and conditions that would weaken it. A hypothetical example can explain an argument without a citation when its hypothetical status is clear. It must not be represented as observed data.

Quantitative illustrations require transparent assumptions, units, and checked arithmetic. No invented empirical scores, participants, papers, quotations, or personal experiences. Avoid giving an exact number if its denominator or conditions have not been inspected.

For the qualitative/evaluation articles, preserve these distinctions:

- A visual comparison or demonstration gives access to a phenomenon under the depicted conditions. It does not estimate a population preference or prove broad generalization.
- A numerical human preference study is quantitative evidence about the questions asked, even if the stimuli are visual and the judgment is subjective. RoSE4D's 95-participant evaluation and GENEA's comparative ratings should be described accordingly.
- A qualitative study interprets situated actions, accounts, or experiences using an appropriate method. Describe what was observed and the basis of the interpretation. Do not treat an anecdote or a pleasing picture as a qualitative study.
- An interpretive or normative claim can be worth making without assigning a common score to the activity. Give the reader a way to understand the claim and its limits. Do not assert that the claim cannot ever be computationally studied.

## 5. Apply a substantive review, not a cosmetic polish

Before calling a manuscript long-form, inspect the whole argument in order:

**Argument review:** Is there a specific claim that is not just a restatement of the title? Does each major section establish something needed for that claim? Could the main objection change the conclusion? Identify what would need to be different in the world for the claim to fail.

**Evidence review:** Inspect every source used to support a consequential factual assertion. Check counts, definitions, dates, comparison conditions, and whether causal language is warranted. Remove or narrow unsupported claims. Check that references are close enough to the relevant statements that a reader can inspect them.

**Reader review:** Read the whole essay as someone who understands computing but does not know the specialized area. At each transition, ask what the reader needs to remember or infer. Can they reconstruct the key example, explain the central distinction, and say what would count as a counterexample? Edit the order of ideas before shortening sentences. A script can flag dense sentences or repeated phrases, but cannot establish that a person understood the article.

**Voice review:** Is the judgment consistent with the author's positions and uncertainty? Does it use a concrete case rather than generic claims about an AI future? Is the first-person voice grounded in public work or explicitly presented as an editorial position for the author's review? Avoid patronizing advice, exaggerated certainty, and self-congratulatory prose.

**Collection review:** Compare adjacent and conceptually related manuscripts using the cross-essay map in the roadmap. A paper can appear in more than one essay when each uses a different result or makes a different argument. Repeated explanations should be linked or abbreviated. Compare opening situations, examples, transitions, and conclusions, not merely titles.

## 6. Track completion honestly

| Status | What it means |
|---|---|
| Short editorial draft | Has a proposed argument or developed short prose. Requires expansion and claim-specific research. |
| Long-form editorial manuscript | Has standalone, developed prose and source/claim notes. Ready for author-level review, not automatically ready to publish. |
| Author-reviewed | Author has examined the voice, positions, examples and evidence. Record actual approval, not an inferred preference. |
| Publication candidate | Individual claim audit and copyedit complete; source links verified; neighboring posts checked; converted to the actual blog format and site build/preview passed. |
| Published | Explicit publication approval followed by deployment. |

The [baseline audit](BASELINE-AUDIT.md) records the pre-revision state of all 136 files. The [roadmap](EDITORIAL-ROADMAP.md) records the distinct argument, evidence plan, caveat and current manuscript status for every ID. The [revision report](REVISION-REPORT.md) records what changed in this revision. Updating those records does not substitute for actually editing the article.

After a manuscript is selected for publication, remove the editorial notes and internal state markers from the published body. Convert it to a single Typst file in `content/blog/` using the site's existing `/content/blog.typ` template. Use a stable slug, a specific title and description, an appropriate date, and two or three registered tags. Use `draft: true` for an intentionally unlisted preview only; it may be accessible by URL after deployment. Use `draft: false` only on explicit approval. Validate Typst compilation, the Astro content schema, internal and external links, rendered layout, and mobile reading experience. A build must actually run before recording that it passed.

The editorial library stays in `content/blog-drafts/` outside the site collection. An open draft PR in this public repository is not private. Do not put confidential personal information, unpublished participant data, or work under anonymous review in these files. No publication candidate or independent reader evaluation is claimed by this revision.
