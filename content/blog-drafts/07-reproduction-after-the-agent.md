# Reproduction After the Agent

**Status:** editorial draft / argument development | **Theme:** The institutions of knowledge | **Candidate tags:** academia, philosophy-of-science, ai

There are several ways for another researcher to obtain the result of a published experiment. They can execute the original implementation, build a new implementation from the description, or investigate the proposed phenomenon in another setting. The procedures answer different questions even when their results agree.

Imagine an agent that reads a paper and successfully runs the associated code. The result establishes that the supplied procedure can still produce the reported outcome under the tested conditions. That can be valuable to someone who wants to use the method. If we want to understand whether the explanation in the paper is sufficient to recreate the mechanism, we would learn something different from an independently written implementation.

An agent can make both activities easier. It may infer details from software libraries, related implementations, or information about the original experiment. Those additional resources can make the reconstruction remarkably successful. They also complicate our interpretation of the agreement. Two agents might recover the same undocumented choice from the same source rather than independently determine that the choice follows from the paper.

Shared resources do not automatically invalidate an experiment. A common dataset can be the appropriate instrument for a carefully specified comparison. A reference implementation can be useful for understanding whether an observation is reproducible. Independence matters in relation to the possible errors or assumptions we want to investigate.

There is a practical difference between recovering a missing software version and recovering a missing scientific assumption. An agent that repairs an environment can make the original experiment accessible. If it fills in an unspecified model choice with a common convention, however, the resulting success may tell us more about that convention than about what the authors' description establishes.

For a stronger test of a claim about a mechanism, I might want the agent to reconstruct it using a description that excludes certain implementation details, or to test a different implementation under a condition that distinguishes competing explanations. For a claim about generalization, I would want to understand how the new task differs from the original one. The evidence would be informative because we know what has changed.

As reproduction becomes less expensive, I expect researchers to encounter many more agreements among experiments. Their significance will depend on which parts of the original inquiry were repeated and which parts were independently reconsidered. A program that runs again and an observation that survives a change in the way it was obtained are both useful scientific accomplishments. I would like reports of automated reproduction to make it possible to tell which one occurred.

## Source plan

Reading leads: ACM artifact review and badging terminology, National Academies' Reproducibility and Replicability in Science (2019), and case studies of artifact evaluation. Difference from the existing industry/academia essay: this one centers on epistemic independence in the presence of shared agents.
