# Negative Results in an Age of Infinite Attempts

**Status:** editorial draft / argument development | **Theme:** Evidence after the scoreboard | **Candidate tags:** academia, sociology-of-science, ai

An unsuccessful experiment can save the next researcher a great deal of work. But a collection of unsuccessful experiments can also be almost impossible to use. The difference matters in a research environment where machines can attempt many more ideas than a person could investigate manually.

Suppose an agent evaluates a large family of mechanism designs. Most cannot realize the desired motion. Some fail because two parts intersect. Others fail because the search did not find a suitable configuration within the time budget. A third group may belong to a mechanism family that cannot produce a required property under the specified geometric constraints. A log containing the score of every attempt would make all three look like unsuccessful candidates.

These failures have different consequences for a later inquiry. Knowing that an implementation ran out of time may help someone improve the search. Knowing why a class of mechanisms cannot satisfy a constraint could let a researcher avoid an entire family of unproductive attempts. We should preserve enough of the investigation to distinguish those possibilities.

A useful record might identify the geometry that caused an intersection, the budget at which a search was stopped, and the assumptions used to establish a genuine limitation. These are different descriptions because the next researcher would use them differently. A timestamped list of low scores cannot, on its own, distinguish an inadequate search from an impossible design.

This also matters when reading a positive result. If an agent has searched a large number of variants, the winning one may have benefited from the specific conditions of the evaluator. Recording which alternatives were investigated, and under what conditions, helps another researcher decide what the result gives them reason to believe. A subsequent experiment may need to examine the discovered relation independently.

There is a practical limit to how much failed work can be reported. Recording every intermediate result can bury useful observations. Selective reporting can be misleading in the other direction. The useful level of detail depends on what the failure establishes, the range of alternatives actually explored, and the decisions a later researcher could reasonably make on the basis of it.

When experiments are abundant, an important scientific resource may be the understanding that organizes them. The failure of one candidate is a small event in a search. The discovery that many candidates failed for the same reason can tell us something new about the problem. That is the kind of negative result I would like the scientific record to retain.

## Source plan

Reading leads: publication bias, registered reports, experiment tracking, and research on adaptive data analysis. Use [AlphaEvolve](https://deepmind.google/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/) as a checked example of repeated automated candidate evaluation, not proof of publication bias. Contrast with essay 03: the question there is discovery history; here it is the informational value of discarded attempts.
