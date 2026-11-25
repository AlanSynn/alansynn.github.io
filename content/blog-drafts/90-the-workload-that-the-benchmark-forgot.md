# The Workload That the Benchmark Forgot

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

A storage system might be designed for workloads in which many small files are read. Another organization might use the same system for a few enormous files, with long periods of inactivity between requests. A method that performs exceptionally well in the first setting may have different costs in the second.

Workload selection is therefore one of the most consequential choices in systems research. It decides which patterns of activity the method will encounter and which improvements the evaluation can reveal. A useful benchmark is a representation of some work people want a system to perform.

The problem becomes more interesting when the workload itself changes. An efficient operation can become common because the system makes it inexpensive. People may begin to perform activities that were once too costly to attempt. A benchmark based on older usage may no longer describe the work that the new system will support.

I expect this to happen in software development with agents. Programs might be generated, executed, revised, and discarded much more often than before. The relative importance of initialization, execution, and storage could change. These are hypotheses about workloads, rather than conclusions we can draw from an existing benchmark.

We should be prepared to investigate the effects of a capability on the activity it was designed to serve. A useful workload model does more than capture the past faithfully. It makes clear which patterns it represents and gives us a way to recognize when those patterns no longer describe the problem.

## Editorial source notes

Reading leads: workload characterization, trace-driven evaluation, SPEC benchmark methodology, and studies of code-agent workloads. The change in workload is a forecast; verify it using traces if extending the article. Distinct from 04: focus on how workloads evolve after deployment.
