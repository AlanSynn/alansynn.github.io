# Editorial philosophy and writing standard

**Simple enough to follow, precise enough to disagree with, and deep enough to think about afterward.**

The purpose of these English essays is to help a reader understand a consequential idea about computing, research, design, education, or society. The intended reader may be a researcher from another field or a serious undergraduate. Give them enough context to enter the inquiry without asking them to reconstruct the author's reasoning. A demanding argument can be written in ordinary language. Preserve necessary technical distinctions.

The standard is intellectually demanding, linguistically accessible, and argumentatively direct. Clarity is the quality of a developed explanation, not a count of short sentences. Depth comes from the claim, the mechanism, the evidence, the scope of the conclusion, and the consequences. A reader should know what the author believes, why the author believes it, and where they might reasonably disagree.

## A collection of examples, not a house template

The author's existing published blog is the principal reference for the author's voice and range. Use [What My Best Answer Could Not See](../blog/what-my-best-answer-could-not-see.typ) to consider how experience changes a prior belief; [Same Computer Science, Different Senses of Reality](../blog/on-truth-computer-research.typ) to consider how a distinction can organize a broad analysis; [When the Field Moves 2](../blog/when-the-field-moves-2-domain-specialty-value.typ) to consider a reflective framework for thinking about change; and the two robotics essays to consider how a technical premise develops into a prediction about a field. Each has a different reason for its structure.

[MotionSmith](https://doi.org/10.1145/3772318.3791545) is one additional example of clear technical and empirical explanation. Its account of making automata establishes the activity and its difficulties before describing the system; its discussion of the artists' choices ties interpretation to specific observations. It is useful when the subject warrants those kinds of explanation. It is neither the primary model for every essay nor a requirement to discuss design, creative intent, or the same study in unrelated articles. Select other public research examples that directly bear on the argument. Use only the observations that the relevant source supports. The earlier source review inspected the public MotionSmith text; PDF page-image retrieval failed.

## Readability: the work of understanding a relationship

Clark, Martin, and Mahowald, [Why is AI-generated language so hard to understand?](https://arxiv.org/html/2610.29162v1), investigate linguistic features associated with processing difficulty and a possible effect of length pressure. Cekini et al., [The Cognitive Cost of LLM Writing](https://arxiv.org/abs/2610.23715), report that predicted per-word reading cost increased for the generated rewrites in their paired-text analysis, while predicted total reading time was slightly lower. The latter uses a prediction model rather than a direct test of comprehension on the paired texts. Both are preprints and should be rechecked when cited in published work. They motivate attention to the effort we transfer to a reader, not a universal verdict about machine-written prose or a fixed readability score.

The practical question is whether the reader has enough knowledge to understand the next claim. Spend words establishing new relations; compress only after the relevant concepts are shared. Preserve specialist terminology when it does useful work.

## 1. Editorial dimensions

Review each manuscript along the following distinct dimensions. These are qualitative questions for editing, not scores, mandatory paragraph types, or a formula that every essay must visibly follow.

| Dimension | Question and editorial decision |
|---|---|
| Claim and force | What does the author actually assert? State it directly. Preserve an ambitious prediction when it is the author's position; make its conditions and warrant inspectable. |
| Intellectual contribution | What will a reader understand differently after reading? If the answer is a broad appeal to nuance or a claim already established in another post, find the actual new distinction. |
| Reasoning and structure | Which proposition leads to the next? Reorder, combine, split, or remove sections when they do not advance the argument. Do not merely group related topics under headings. |
| Concrete explanation | Can a reader reconstruct the relevant object, event, operation, or social arrangement? Develop a case far enough to demonstrate the relationship; avoid illustrative scenes that leave the central inference unstated. |
| Evidence and scope | Which statements are observations, findings, analytic inferences, normative judgments, or forecasts? Match each to the appropriate warrant. Keep sources close to their claims. |
| Serious alternative | What is the strongest reason the author's explanation might be incomplete or wrong? Examine that mechanism. A list of generic disclaimers is not a counterargument. |
| Authorial perspective | What does this particular researcher see, doubt, or care about? Use the author's documented experience and stated positions. Do not invent experiences or use habitual first-person phrases as a substitute for a point of view. |
| Language and continuity | Can the intended reader follow the subject, action, reference, and consequence? Introduce technical terms at the point where they become useful. Edit for continuity and natural rhythm rather than sentence-length uniformity. |
| Ending | What follows from the argument that a reader could not have understood in quite the same way at the start? End at that consequence, question, or judgment. Do not attach a generic optimistic forecast. |
| Collection independence | Does this essay contribute a different mechanism, question, or perspective from related manuscripts? Compare actual openings, examples, inferences, and endings, not just titles. |

Treat a specific failure in one dimension as a reason for a particular editorial intervention. For instance, if a prediction is plausible but its institutional mechanism is missing, add the mechanism. If the mechanism is already clear and the author repeats it three times, cut the repetition. If a term is necessary, define it rather than replace it with a vague synonym. Strength, depth, and readability are separate properties.

## 2. Build an argument before choosing a shape

Write a private outline that identifies the central claim, the necessary premises, the evidence for those premises, the most consequential objection, and the implication. Supporting claims should advance the central argument rather than act as a collection of independent observations. Use the [editorial roadmap](EDITORIAL-ROADMAP.md) to check that the essay has a distinct purpose.

Choose a route that fits the inquiry. The following are possibilities, not templates:

| Form | A possible route |
|---|---|
| Predictive or institutional analysis | State the forecast; describe the existing arrangement; identify what changes its conditions; follow the consequences and competing mechanisms; specify what could disconfirm the forecast. |
| Conceptual or technical analysis | Identify a confusion or concrete operation; establish the necessary distinctions; use a worked case to examine their consequences; consider a boundary; derive the new account. |
| Empirical case analysis | Explain the relevant activity; introduce a real study or artifact; report the particular observation and its conditions; develop its interpretation; test its limits; explain its wider significance. |
| Personal or historical reflection | Begin with a belief, event, or conflict that is grounded in the author's actual experience or historical evidence; develop how the account changed; explain what the change reveals beyond the anecdote. |
| Normative or philosophical inquiry | Establish a conflict between intelligible purposes; state the position; examine what follows under different arrangements; consider the interests of those affected; arrive at a defensible judgment. |

A direct assertion is often the strongest opening for a forecast. A particular observation can be more effective for an empirical essay. An experience can be the best entry to a reflective one. A question earns its place when the essay actually develops an answer. Avoid turning every opening into a hypothetical person doing something. A reader should recognize the problem and the purpose of the essay early, even if a more precise understanding of the claim develops later.

A section must perform an argumentative task. Choose headings that expose that task. A paragraph should move the reader's understanding through an inference, example, explanation, distinction, or objection. The next paragraph should have a reason to follow. A short paragraph is occasionally effective; repeated one-sentence declarations can make a careful argument feel artificially dramatic.

Do not require a counterargument section in every article. Introduce an alternative where it bears on the argument and follow it far enough to learn something. Do not require an AI-related final section in an essay about geometry, explanation, a practice, or an educational experience. A subject can have enduring value without a technological forecast.

A long article often needs 1,200–2,500 words or more. Its necessary length follows from the work its reasoning has to perform. A complex historical or speculative essay can require much more. A shorter argument may be complete without being long. Length should not be attained by repeating the thesis in different words or adding an unrelated literature survey.

## 3. Preserve strong claims and make their reasoning visible

The author's position in the essays about quantified competition is deliberately strong: **AI will dominate quantified competition.** The forecast concerns the recursive search for improvement wherever results can be evaluated, compared, and used to choose subsequent attempts. The social prediction is that the authority of scores to confer individual distinction and justify status will collapse as the capacity to produce those scores becomes abundant. Quantitative improvements can remain useful while the professional bargain and common value system built around them lose their force.

A practical evaluator must make useful search possible; a number alone does not guarantee tractability, an adequate budget, or reliable physical trials. Technical and institutional consequences can move at different rates. State these conditions as part of the mechanism and its possible failures. Do not reduce the central forecast to the safe observation that AI may help researchers or that qualitative work is also important. Do not turn the claim into an established theorem. Do not assume equal access, guaranteed employment, or a permanently human-only domain.

The author treats socially recognized objectivity in this discussion as a shared representation constructed and stabilized by multiple subjective judgments, procedures, and institutions. Language is a minimal representation in the author's philosophical sense, not a claim about shortest mathematical encoding. A shared word or score may communicate a property without reproducing a person's first-person experience. Some qualities of experience cannot be fully conveyed through common language or scores; the essay should retain that philosophical commitment rather than treating it merely as a temporary gap in instrumentation. Separate it from empirical claims about what a machine can learn, predict, or produce. A physical measurement's reliability is distinct from the social decision to use that measurement as a general ranking of people or purposes.

When common performance becomes infrastructure, previously suppressed or uneconomic niches can become distinct activities and research questions. Explain the mechanism through which that happens, and consider concentration of tools, distribution of benefits, and institutional inertia. The prediction of proliferating qualitative inquiry does not mean every niche will be profitable or every qualitative procedure immune to automation.

These commitments apply to essays that actually investigate them. They need not organize the entire collection.

### Example A: strong forecast with an explicit mechanism

**Weak:** Certain forms of quantitative research may gradually become less relevant as AI improves.

**Developed:** AI will dominate quantified competition. A benchmark that can be run repeatedly becomes part of the process that produces a better result. Once agents can generate candidates, run the benchmark, and revise their search using the outcome, increasingly capable systems can perform much of the improvement work themselves. I expect the authority attached to a better number to collapse as the ability to produce it becomes widely available.

The improved paragraph names both the mechanism and the threatened arrangement. Its next section needs to address evaluation cost, access, and attribution. Strength does not require pretending that these questions have already been settled.

### Example B: preserve the distinction, reduce reconstruction effort

**Compressed:** Preference-contingent motion representation enables iterative intent alignment through affordance-mediated exploration.

**Too thin:** The system helps people make better motions.

**Developed:** A maker may change their idea of a movement after seeing how a mechanism behaves. The system lets them return to the sketch, revise the movement, and explore another mechanism without starting the design again.

The technical relationship survives in the developed version. The reader has an actor, an action, and a reason for the operation before encountering a label for it.

### Example C: develop the example until the inference becomes clear

**Weak:** Visual quality cannot be fully captured by quantitative metrics.

**Developed:** Two animations of a character raising its hand can follow exactly the same spatial path. One pauses before completing the movement; the other moves continuously. An error measure that compares spatial paths alone treats them as identical. A viewer may nevertheless interpret one as hesitant and the other as decisive.

This is an illustrative case, not a result from a user study. It establishes a specific limitation of a spatial-path-only comparison and motivates an empirical question about interpretation. It does not establish that timing is inherently unmeasurable or that every viewer interprets the movement alike.

### Example D: separate observations from their explanation

**Weak:** A robot that asks for help is less autonomous.

**Developed:** A robot can know how to carry out an operation and need permission from the person who controls the shared space. A request for authorization can therefore be appropriate even when its physical capability is adequate. Counting the request as a failure of perception would conflate the robot's ability with its authority.

The example gives a reader a concrete reason to reconsider the definition and the proposed measure of autonomy.

### Example E: follow the causal step into the institution

**Weak:** Automation will make workers more productive, so work will become easier for everyone.

**Developed:** A team that produces the same output in less time has gained capacity. Its employer could use that capacity to serve additional demand, reduce working hours, or reduce staffing. The outcome depends on demand and who has authority over the resulting resources.

A claim about productivity does not settle a claim about workers' lives. Strong social forecasts need an account of that additional mechanism.

### Example F: finish with the implication, not a summary

**Weak:** AI will continue to advance, so qualitative research will become more important.

**Developed:** For much of computer science, progress has meant getting closer to a common answer. I expect a growing part of research to move in the opposite direction. As machines become better at reaching that answer, we may discover how many different questions we had placed underneath it.

The ending follows from the argument about automated competition and plural purposes. It would be inappropriate in an unrelated article merely because it sounds memorable.

### Sentence and paragraph editing

Prefer identifiable subjects, concrete nouns, precise verbs, and referents that have been established. Keep conceptual terms when they carry meaning. Avoid noun stacks, vague intensifiers, unnecessary nested clauses, boilerplate transitions, and repeated artificial contrasts such as "not X but Y". Vary sentence length and paragraph rhythm in response to the thought, rather than manufacturing variation.

Use first person where it establishes a judgment, an experience, a change of belief, or responsibility for a forecast. Avoid using "I find this interesting", "This suggests an important distinction", "I would like to see", and "I expect this to become increasingly important" as automatic transitions. They can be natural in a particular context; the collection should not acquire a voice made out of them. No invented first-person scenes, participant quotes, or unpublished findings. No em dashes.

Do not replace a difficult sentence with a vague easy sentence. Establish the relationships in the order the reader needs them. Read the passage in context to determine whether an explanation repeats something the reader already knows or introduces something that is not yet intelligible.

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


## 5. Apply the editorial review across levels

Work from argument to structure to paragraphs to sentences. Do not spend most of the revision polishing prose that will disappear when the argument changes.

**Argument and counterargument.** Write down the conclusion the author is prepared to defend. Determine whether the premises establish it and whether a competing explanation changes the inference. Make predictions vulnerable to relevant future observations. Where a premise is weak, repair the inference, supply evidence, or narrow the specific claim. Do not mechanically hedge the whole essay.

**Structure and continuity.** Trace each section's contribution to the conclusion. Inspect each paragraph's relation to the preceding one. Move necessary definitions before the inferences that depend on them. Cut a repetition rather than keep it as a polished transition. Integrate counterarguments where they matter.

**Evidence and technical precision.** Review actual primary sources or clearly identified available parts of them. Maintain the claim ledger, not just a bibliography. For technical examples, specify the variables, comparison, assumptions, and operation that reveals the distinction. Keep hypothetical examples separate from observed cases. Evidence for a limited claim can be strong; an impressive but irrelevant citation does not strengthen a broader claim.

**Reader and voice.** Read the manuscript as someone from another field. Ask what the reader must infer to make the next sentence meaningful. A good test is whether the reader can explain the example and carry the distinction to a new case. Do not claim a human-reader test occurred unless it did. Preserve the author's genuine point of view, including a forceful or uncomfortable conclusion, while removing artificial language and unsupported personal narration.

**Collection and publication.** Compare related essays for repeated claims, examples, research references, openings, and conclusions. Preserve their distinct questions. The [editorial review log](EDITORIAL-REVIEW.md) records one focused intervention in each numbered draft alongside the opening/ending and structural revision. It is a trace of actual edits rather than proof that every dimension has been independently validated. Use the existing roadmap and source ledger to identify remaining work. Keep published articles untouched unless explicitly asked to revise them.

## 6. Track completion honestly

| Status | What it means |
|---|---|
| Short editorial draft | Has a proposed argument or developed short prose. Requires expansion and claim-specific research. |
| Long-form editorial manuscript | Has standalone, developed prose and source/claim notes. Ready for author-level review, not automatically ready to publish. |
| Author-reviewed | Author has examined the voice, positions, examples and evidence. Record actual approval, not an inferred preference. |
| Publication candidate | Individual claim audit and copyedit complete; source links verified; neighboring posts checked; converted to the actual blog format and site build/preview passed. |
| Published | Explicit publication approval followed by deployment. |

The [baseline audit](BASELINE-AUDIT.md) records the pre-revision state of all 136 files. The [roadmap](EDITORIAL-ROADMAP.md) records the distinct argument, evidence plan, caveat and current manuscript status for every ID. The [revision report](REVISION-REPORT.md) records successive revisions; the [editorial review log](EDITORIAL-REVIEW.md) identifies the focused intervention in each of the 136 unpublished drafts. Updating those records does not substitute for actually editing the article.

After a manuscript is selected for publication, remove the editorial notes and internal state markers from the published body. Convert it to a single Typst file in `content/blog/` using the site's existing `/content/blog.typ` template. Use a stable slug, a specific title and description, an appropriate date, and two or three registered tags. Use `draft: true` for an intentionally unlisted preview only; it may be accessible by URL after deployment. Use `draft: false` only on explicit approval. Validate Typst compilation, the Astro content schema, internal and external links, rendered layout, and mobile reading experience. A build must actually run before recording that it passed.

The editorial library stays in `content/blog-drafts/` outside the site collection. An open draft PR in this public repository is not private. Do not put confidential personal information, unpublished participant data, or work under anonymous review in these files. No publication candidate or independent reader evaluation is claimed by this revision.

