# Baselines Are Contracts

**Status:** editorial draft / argument development | **Theme:** Evidence after the scoreboard | **Candidate tags:** computer-science, philosophy-of-science

Before reading the performance columns in a comparison table, I want to know what each method was asked to do. A baseline comparison contains a set of agreements about the information available, the resources that can be used, and the result that counts as success. I think of those agreements as the comparison contract.

A graphics method that reconstructs a scene from several images has access to different evidence from a method that generates a scene from text. We could compare a rendering from each method and learn which image people prefer. The comparison would establish something about the resulting images. It would give us a weaker basis for concluding which method extracts more knowledge from its input.

The same issue appears when an authoring tool allows a person to correct an intermediate result. Including a knowledgeable person can improve what the system produces. For a study of a complete authoring workflow, that assistance may be precisely the capability the authors want to investigate. If the claim concerns fully automatic generation, however, the person's decisions are part of the information available to one method and need to be accounted for.

As AI systems become components of many methods, the contract becomes harder to see. One system might use a pretrained model, extra computation at inference time, or access to an external tool. Comparing at equal inference cost can answer a different question from comparing the best attainable result of each system. Both questions are reasonable. The choice should follow the contribution being evaluated.

Exact matching of resources can itself create an artificial comparison. A new architecture may use a resource differently, and its advantage may depend on being allowed to do so. An end-to-end comparison under actual deployment conditions can be more informative than forcing the systems to use an identical budget. The important step is to say what was allowed and why.

I would therefore describe the comparison before naming the winner. A faster method at a fixed quality, a higher-quality result at a fixed budget, and a workflow that lets a person obtain a previously inaccessible result are three different achievements. A paper can make more than one of these claims, provided it explains what each comparison holds fixed.

When a new method offers a representation or operation that the older methods cannot provide, there may be only a limited common task on which to compare them. A better score on that task is useful evidence. The new capability deserves its own account.

A comparison table becomes more interesting when we understand the conditions under which the numbers have acquired their meaning. I would read those conditions as carefully as I read the numbers.

## Source plan

Checked example: [RoSE4D, Section 6.2](https://arxiv.org/html/2412.05278v2), which compares shared renderings because the prior methods do not supply all the same intrinsics. Reading leads: ML benchmark contamination, compute-budget comparisons, and HCI comparisons with expert workflows. Avoid claiming every baseline must produce identical outputs.
