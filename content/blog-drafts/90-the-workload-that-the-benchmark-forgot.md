# The Workload That the Benchmark Forgot

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

A benchmark can become less representative of a workload because the system it helped improve has become useful for something new. A storage system that makes an expensive operation inexpensive may encourage people to perform that operation much more frequently. Its success can change the distribution of work against which the original method was evaluated.

Workload selection is therefore one of the most consequential choices in systems research. It decides which patterns of activity the method will encounter and which improvements the evaluation can reveal. A useful benchmark is a representation of some work people want a system to perform.

The benchmark has to be reconsidered when the workload itself changes. An efficient operation can become common because the system makes it inexpensive. People may begin to perform activities that were once too costly to attempt. A benchmark based on older usage may no longer describe the work that the new system will support.

A system that reduces the cost of generating a temporary program could encourage a workload consisting of many short executions rather than a few long-lived applications. Optimizing for the original workload might then miss the cost of preparing and starting those programs. This is a conditional example of how a capability could change the importance of different system operations.

Software development with agents offers a useful case to investigate. Programs might be generated, executed, revised, and discarded much more often than before. The relative importance of initialization, execution, and storage could change. These are hypotheses about workloads, rather than conclusions we can draw from an existing benchmark.

An agent that optimizes a workload benchmark could be extremely effective at reproducing the improvements the benchmark rewards. I would also want to investigate how the resulting capability changes the activities that produce the workload. We may discover that the next important optimization concerns a kind of work that was too expensive to be common when the benchmark was designed.

## Editorial source notes

Reading leads: workload characterization, trace-driven evaluation, SPEC benchmark methodology, and studies of code-agent workloads. The change in workload is a forecast; verify it using traces if extending the article. Distinct from 04: focus on how workloads evolve after deployment.
