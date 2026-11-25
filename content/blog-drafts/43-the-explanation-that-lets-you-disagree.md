# The Explanation That Lets You Disagree

**Status:** English working draft | **Theme:** G. Writing, explanation, and representation | **Candidate tags:** philosophy-of-science, computer-science

An explanation of a slow program becomes useful to an engineer when it suggests something specific to investigate. Saying that the architecture does not scale leaves many possible causes open. A claim that workers contend for the same lock suggests an observable relationship between the number of workers and the time they spend waiting.

We can examine the proposed relationship through the behavior of the system. If workers wait on the same lock, increasing their number may increase waiting rather than throughput. We can inspect that possibility, change the locking behavior, and see what happens. The explanation gives us a way to discover that it was wrong.

If the worker's delay rises with the number of workers, contention remains a plausible explanation. If the delay is unchanged when the lock is removed in a controlled test, another account deserves attention. The observation becomes useful because the explanations lead us to expect different results from a particular intervention.

This is a useful property of scientific writing. A reader should be able to follow an account far enough to identify where they disagree. Perhaps they accept the observations but think the mechanism is different. Perhaps the mechanism seems plausible but they think an assumption will fail in another setting. These disagreements can lead somewhere because the explanation has made its dependencies visible.

AI can help generate such explanations. It can also produce several plausible stories for the same observation. A polished rationale has limited value if all of those stories predict the same evidence and the author never investigates what distinguishes them.

A reader can disagree with a useful explanation at a particular point. They can propose another account of the observations or identify a condition that would distinguish them. That is a quality I would like research papers to have: a good explanation makes the next meaningful disagreement possible.

## Editorial source notes

Reading leads: mechanistic explanation, interventionist accounts of causality, and performance diagnosis in systems. Expand with a concrete trace and two competing hypotheses; avoid claiming that all useful explanations must be causal.
