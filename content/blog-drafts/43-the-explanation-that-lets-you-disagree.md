# The Explanation That Lets You Disagree

**Status:** English working draft | **Theme:** G. Writing, explanation, and representation | **Candidate tags:** philosophy-of-science, computer-science

Suppose a program runs slowly, and someone tells us it is inefficient because its architecture does not scale. The explanation sounds reasonable. It leaves us with little idea of what to investigate. Would changing the number of workers help? Is the program waiting for memory? Are workers competing for a shared resource?

A stronger explanation identifies a relationship that we can examine. If workers wait on the same lock, increasing their number may increase waiting rather than throughput. We can inspect that possibility, change the locking behavior, and see what happens. The explanation gives us a way to discover that it was wrong.

This is a useful property of scientific writing. A reader should be able to follow an account far enough to identify where they disagree. Perhaps they accept the observations but think the mechanism is different. Perhaps the mechanism seems plausible but they think an assumption will fail in another setting. These disagreements can lead somewhere because the explanation has made its dependencies visible.

AI can help generate such explanations. It can also produce several plausible stories for the same observation. A polished rationale has limited value if all of those stories predict the same evidence and the author never investigates what distinguishes them.

I would like papers to be easier to argue with in this sense. A reader should know what the authors believe happened and why. The next useful experiment may come from a person who understood that explanation well enough to question one particular step.

## Editorial source notes

Reading leads: mechanistic explanation, interventionist accounts of causality, and performance diagnosis in systems. Expand with a concrete trace and two competing hypotheses; avoid claiming that all useful explanations must be causal.
