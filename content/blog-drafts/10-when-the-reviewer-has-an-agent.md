# When the Reviewer Has an Agent

**Status:** Long-form editorial manuscript | **Theme:** The institutions of knowledge | **Candidate tags:** academia, sociology-of-science, ai

A reviewer reads a paper about a new method for generating motion. The authors report better performance on several tasks and explain why they believe the method works. There is a public implementation of the method, but reproducing the experiments would require more time than the reviewer has available. The reviewer reads the tables carefully, checks that the comparison appears reasonable, and writes a few questions about the proposed explanation.

Now imagine that the reviewer can ask an agent to inspect the implementation, run a small experiment, and look for a case where the method behaves differently from the account in the paper. The agent returns a result that the reviewer can examine. The reviewer might have discovered something that was previously too expensive to investigate.

Much of the discussion about AI and peer review concerns the quality of the review that an AI can write. I am interested in a different possibility. An agent could change what it is practical for a reviewer to know before making a judgment. That change could matter more than whether the prose of the review improves.

## A criticism that can be inspected

Consider two ways to challenge a method. In the first, a reviewer writes that the method might be sensitive to the initial configuration. In the second, the reviewer provides two configurations that satisfy the stated conditions, describes the experiment, and shows that the result changes substantially between them.

The first criticism can be useful. It suggests a concern that the authors may not have considered. The second provides something with which both parties can work. The authors can inspect the configurations, determine whether they belong to the intended task, and try to explain the difference. The reviewer can reconsider the criticism if there is a mistake in the experiment. Other researchers can eventually learn something from the exchange.

Doing this kind of work has a cost. A reviewer needs to understand the method, find the materials, set up the environment, choose an intervention, and interpret the result. For many submissions, carrying out even a small part of the work would take a considerable amount of time. It is reasonable for a reviewing institution to limit how much it expects from a reviewer.

An agent may reduce some of those costs. It might locate the relevant code and help construct the configurations. It might inspect whether two implementations differ in their treatment of a variable, or help locate the evidence behind a claim about a previous paper. What it discovers could make the review more specific.

The result would still need interpretation. Suppose an agent finds a motion that the implementation cannot generate. Is the motion outside the method's stated domain? Was the implementation configured correctly? Is the behavior a failure of the proposed method or of a dependency? The existence of an executable criticism does not settle these questions. It makes them possible to discuss.

That distinction is important. Generating a plausible objection is relatively easy. Producing a criticism that somebody else can inspect, and establishing its relevance to the claim, are different achievements.

## What the available evidence tells us

There is already evidence that language models can play a role in reviewing. Liang and colleagues' [study of language-model feedback on research papers](https://arxiv.org/abs/2310.01783), for example, investigates whether feedback produced by GPT-4 overlaps with feedback provided by human reviewers and whether researchers find it helpful. The study concerns a useful form of feedback. It does not establish that a model can independently verify the scientific claims in the papers.

A more direct intervention in an actual review process was studied by Thakkar and colleagues in [A Large-Scale Randomized Study of Large Language Model Feedback in Peer Review](https://doi.org/10.1038/s42256-026-01188-x), published in 2026. The experiment involved over 20,000 reviews at ICLR 2025. A system provided feedback to reviewers about problems in their reviews, including vagueness and misunderstandings of the submission. The authors report that 27 percent of the reviewers who received feedback revised their reviews, and that revised reviews receiving the feedback were judged more informative in a blinded evaluation.

I find this result interesting partly because of the role assigned to the system. The intervention supported people who were already writing reviews. It did not give an autonomous system the authority to determine the scientific merit of the submission. Nor should an improvement in informativeness be read as proof that every additional criticism was correct.

It is possible to imagine another layer of assistance. A reviewer asks for evidence that would distinguish two explanations offered in a paper. The agent identifies an existing experiment that addresses the distinction, or proposes a small test and helps perform it where doing so is authorized. The reviewer learns something that can change their own assessment.

This is a direction I would like reviewing tools to explore. Instead of optimizing the apparent thoroughness of a review, they could help reviewers become better informed about the specific questions they are responsible for evaluating.

## The paper as a place where evidence meets

The traditional paper has several functions. It communicates a contribution, describes evidence, and gives other researchers enough information to understand and contest a result. The materials needed for that last function may exist somewhere other than the document itself.

A reviewer may need the original data, the exact configuration of an experiment, or a record of a particular case. For a graphics contribution, they may need to examine a generated object from a different viewpoint. For a systems contribution, they may need to inspect the distribution of behavior that has been summarized in a table.

These are reasons to make a paper's claims easier to connect to its materials. An agent could help locate the particular evidence on which a claim depends. It could also reveal places where the connection is missing.

A convenient artifact is not necessarily an adequate one. An implementation that runs may still conceal assumptions shared with the data or evaluation. A demonstration that looks convincing may not establish the stated range of conditions. Authors should be able to describe the boundary of the evidence rather than make every possible use of the artifact a part of the contribution.

Reviewers need the same discipline. If a criticism concerns a claim the paper does not make, asking for another experiment may add work without improving the evaluation. When agents make it cheap to identify possible experiments, it will become especially important to explain why a proposed experiment is relevant.

## Who decides what must be answered?

Suppose every reviewer receives a hundred reasonable-looking criticisms from an agent. It would be easy to produce a detailed review by combining them. It would be much harder for an author to determine which criticisms actually threaten the contribution.

The asymmetry could become severe. Writing a new question about a model may take seconds. Collecting new data, recruiting participants, or conducting a physical experiment can take weeks. An institution that permits unlimited demands because those demands are cheap to generate would transfer a large part of the reviewing cost to authors.

There are other issues. Several agents may rely on similar training data, assumptions, or sources. Apparent agreement among their criticisms need not be independent corroboration. A reviewer may find a persuasive claim in an agent's response and repeat it without checking the original evidence. Confidential submissions cannot simply be transmitted to whichever external system seems convenient. Venues would need clear policies about authorized access, artifact execution, confidentiality, and the responsibility for resulting judgments.

These problems do not make assistance undesirable. A well-designed tool could be particularly valuable to someone who lacks the time or resources to inspect every claim in a paper. But the purpose of review should constrain the use of that assistance.

A useful review would distinguish a finding from a proposed investigation, identify the claim it addresses, and explain why the finding matters. Authors should be able to contest the evidence and scope of a criticism. The reviewing institution should decide which unresolved questions are material to the contribution, rather than treating the number of machine-generated objections as another measure of quality.

## A better-informed disagreement

I would like peer review to become an occasion for more specific disagreements about evidence. A reviewer may think a result has been interpreted too broadly. An author may show that the criticized behavior lies outside the stated claim. Both may discover an interesting condition that deserves a later investigation.

Agents could help make these exchanges more practical. The resulting process would still require decisions about the kinds of contributions a field recognizes and the evidence those contributions require. An executable test is particularly useful for some claims. For others, understanding the circumstances of an observation or the interpretation of an experience may matter more.

The interesting future of machine-assisted review may be the one in which a reviewer has more opportunities to investigate a paper before judging it. A review is valuable when the questions it raises help people understand what the paper establishes. Producing a longer list of reasons to accept or reject the paper is a much less ambitious goal.

## Editorial source and claim notes

- Liang et al., arXiv:2310.01783: abstract and study description support the bounded feedback claim. No artifact-verification result is attributed to it.
- Thakkar et al., Nature Machine Intelligence 8, 326–336 (2026), DOI 10.1038/s42256-026-01188-x: publisher abstract and study description checked. The 27 percent denominator is reviewers who received feedback; informativeness applies to the evaluated revised reviews. The paper does not demonstrate autonomous correctness or acceptance decisions.
- Motion and reviewer scenarios are hypothetical. Artifact inspection, institutional consequences, and governance recommendations are prospective reasoning.
- Keep this essay separate from 07 (independence of replication), 11 (citation), and 12 (literature synthesis). Author approval and independent human reading remain pending.
