# Software Is a History of Decisions

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, history-of-science

A programmer opens an old file and notices a piece of code that seems unnecessarily complicated. It could be replaced by a much shorter function. Before making the change, the programmer needs to know why the complication was introduced.

Perhaps an earlier version failed under a particular workload. Perhaps the code compensates for behavior in another component. Perhaps the original author simply did not know a better way. The visible program is compatible with all three explanations. Understanding its history would lead to different decisions.

I have long found this an important aspect of systems work. A system contains choices made under conditions that may no longer exist. Some choices should be removed when those conditions change. Others should remain because the problem they addressed has been forgotten rather than solved.

An agent can help reconstruct that history from old commits, discussions, and tests. In an ideal case, it might identify the original problem and establish that the proposed simplification is safe. But the information it needs must exist somewhere. A record of the final implementation cannot always answer questions about alternatives that were considered and discarded.

This suggests a useful goal for software tools. Preserve the reasons for decisions at the places where those reasons are likely to matter again. We do not need a diary of every line of code. We need enough of the history to recognize when changing the system would reintroduce a problem someone had already understood.

The ability to produce a cleaner implementation is valuable. The ability to tell when it is safe to replace the old one belongs to a different part of engineering.

## Editorial source notes

Reading leads: architectural decision records, software evolution, and design rationale. Develop a real code-history example from an accessible repository; do not invent an incident from the author's career.
