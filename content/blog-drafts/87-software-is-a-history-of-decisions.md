# Software Is a History of Decisions

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, history-of-science

An old implementation can contain a solution to a problem that the current engineer has never encountered. A complicated branch in a function may look unnecessary until we understand the condition that gave the earlier developer a reason to introduce it. Simplifying the code requires a judgment about whether that condition still matters.

Perhaps an earlier version failed under a particular workload. Perhaps the code compensates for behavior in another component. Perhaps the original author simply did not know a better way. The visible program is compatible with all three explanations. Understanding its history would lead to different decisions.

This gives software a history of decisions as well as a current implementation. A system contains choices made under conditions that may no longer exist. Some choices should be removed when those conditions change. Others should remain because the problem they addressed has been forgotten rather than solved.

An agent can help reconstruct that history from old commits, discussions, and tests. In an ideal case, it might identify the original problem and establish that the proposed simplification is safe. But the information it needs must exist somewhere. A record of the final implementation cannot always answer questions about alternatives that were considered and discarded.

A record of the reason for a decision can be particularly valuable when it names the condition that would allow the decision to be reversed. A workaround introduced for an earlier library version might no longer be needed after an upgrade. If we can identify that dependency and test whether it has disappeared, simplifying the code becomes a better-informed engineering decision.

A record of design decisions can make that history usable. Preserve the reasons for decisions at the places where those reasons are likely to matter again. We do not need a diary of every line of code. We need enough of the history to recognize when changing the system would reintroduce a problem someone had already understood.

A useful history of a system makes it possible to connect an implementation decision to the problem it addressed. When the surrounding conditions change, the next engineer has a reason to examine whether the decision should survive. The aim of preserving the history is to make better changes possible, including the decision to remove code that no longer serves a purpose.

## Editorial source notes

Reading leads: architectural decision records, software evolution, and design rationale. Develop a real code-history example from an accessible repository; do not invent an incident from the author's career.
