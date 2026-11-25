# The Cost of Knowing Where to Look

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, ai

A system reports that a request took two seconds. That is enough information to tell an engineer that something may be wrong. It is not enough to tell the engineer where the two seconds went.

The next useful observation depends on the structure of the system. The engineer may examine a trace, look at which component was waiting, or compare the behavior of several requests. Some of the expertise involved in performance diagnosis consists of knowing which observation would distinguish among plausible explanations.

An agent can automate much of this work when the relevant information is available. It can read traces, form hypotheses, and test changes. It may also help decide what additional measurements to collect. The bottleneck can then move to the system's ability to produce observations that make those hypotheses testable.

Suppose a service provides aggregate timings but no way to connect them to the underlying operations. Collecting more aggregate timings may not help. Adding a particular form of tracing could make several explanations distinguishable. The cost of building and maintaining that instrumentation belongs in the engineering decision.

Observability is thus a property of what we can learn about a running system, under constraints on the cost of observation. More instrumentation can add overhead or expose sensitive information. A useful arrangement lets the engineer or agent obtain the evidence needed for an investigation without assuming that every detail should be retained forever.

I expect automated systems research to increase the value of well-designed instruments. A strong investigator is most useful when the system gives it something through which to investigate.

## Editorial source notes

Reading leads: distributed tracing, observability, performance profiling, and instrumentation overhead. Compare a specific aggregate metric with an end-to-end trace. Distinct from 09: focus on information available within a system, not ownership of experimental infrastructure.
