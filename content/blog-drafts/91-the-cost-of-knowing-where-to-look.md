# The Cost of Knowing Where to Look

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, ai

A report that a request took two seconds can establish the existence of a performance problem. It does not explain where the time was spent. A useful diagnosis often begins by deciding which measurement would help distinguish between plausible causes of the delay.

The next useful observation depends on the structure of the system. The engineer may examine a trace, look at which component was waiting, or compare the behavior of several requests. Some of the expertise involved in performance diagnosis consists of knowing which observation would distinguish among plausible explanations.

An agent can automate much of this work when the relevant information is available. It can read traces, form hypotheses, and test changes. It may also help decide what additional measurements to collect. The bottleneck can then move to the system's ability to produce observations that make those hypotheses testable.

Suppose a service provides aggregate timings but no way to connect them to the underlying operations. Collecting more aggregate timings may not help. Adding a particular form of tracing could make several explanations distinguishable. The cost of building and maintaining that instrumentation belongs in the engineering decision.

A trace can reveal that several requests waited at the same stage without telling us why that stage was slow. The next useful measurement might concern competition for a shared resource rather than another timing measurement. The value of instrumentation depends on whether it lets an investigator separate explanations that would otherwise produce similar observations.

For the engineer, observability concerns what can be learned about a running system under practical constraints on the cost of observation. More instrumentation can add overhead or expose sensitive information. A useful arrangement lets the engineer or agent obtain the evidence needed for an investigation without assuming that every detail should be retained forever.

If agents become unusually good at interpreting performance evidence, the system's ability to supply the relevant observations may become a more visible constraint on their usefulness. A carefully chosen instrument can turn several plausible explanations into claims we have a way to investigate. Providing that opportunity is part of engineering the system.

## Editorial source notes

Reading leads: distributed tracing, observability, performance profiling, and instrumentation overhead. Compare a specific aggregate metric with an end-to-end trace. Distinct from 09: focus on information available within a system, not ownership of experimental infrastructure.
