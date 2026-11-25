# Baselines Are Contracts

**Status:** editorial draft / argument development | **Theme:** Evidence after the scoreboard | **Candidate tags:** computer-science, philosophy-of-science

A baseline is often presented as a method against which another method should win. I would describe it as a contract: two methods agree to solve a certain problem with a certain set of resources, information, and allowable operations. Much confusion in research begins when that contract is implicit.

## Working argument

A graphics method that reconstructs a scene from a video and a method that synthesizes a scene from text have different information available. They can sometimes be compared on a common rendering, but a better rendering alone cannot establish that the method with more information solves the harder problem. Similarly, an interactive tool with expert-provided corrections may outperform a fully automatic tool because some difficult decisions were delegated to a person. The human effort belongs in the description of the comparison.

As foundation models become common components, the contract becomes harder to see. A method may use pretrained knowledge, external tools, more compute, longer search, or data its comparator never had. Each can be a legitimate engineering choice. The question is which difference the experiment supports. A comparison at equal inference cost, a comparison at equal final quality, and a comparison of available workflows answer different questions.

One useful change to paper reading would be to identify the exchange being evaluated before looking for the winner. What information goes in? What decisions remain with a user? What guarantees come out? What must another group purchase or maintain? The baseline is scientifically informative to the extent that these obligations are intelligible. If a new system changes the contract by introducing an affordance, that may itself be the contribution.

## Challenge

Identical resource budgets can be impractical and can favor older designs. A comparison under natural deployment conditions may answer a more useful question. Require transparency about the contract, not one rigid resource-matching rule.

## Source plan

Checked example: [RoSE4D, Section 6.2](https://arxiv.org/html/2412.05278v2), which compares shared renderings because the prior methods do not supply all the same intrinsics. Reading leads: ML benchmark contamination, compute-budget comparisons, and HCI comparisons with expert workflows. Avoid claiming every baseline must produce identical outputs.
