# Fast Enough for Whom?

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

A service responds quickly to most requests. One person waits for several seconds whenever they try to perform a particular operation. The average response time may describe the service accurately while saying very little about that person's experience.

Systems researchers have long cared about the tail of a latency distribution. A small fraction of slow requests can matter a great deal when a larger operation depends on many smaller ones. Dean and Barroso's essay on latency at scale is a useful starting point for understanding this problem. There is another distinction I would like to examine: who experiences those slow requests, and whether the delay happens at a consequential moment.

Consider a collaborative editor. A delayed operation that occurs while a document is being prepared in the background may be harmless. The same delay while someone is trying to move a drawing can disrupt their sense of control. A person who repeatedly uses a particular feature may encounter the slow behavior far more often than the overall distribution suggests.

This does not mean latency has become impossible to measure. We can measure more carefully and organize observations according to tasks, users, and interactions. The important part is choosing a description that corresponds to the experience we claim to improve.

An agent may become exceptionally good at optimizing the performance metrics available to it. That is a good reason for systems researchers and HCI researchers to understand one another's questions. The system needs to respond in time for the activity it supports. What counts as being in time can be quite specific to that activity.

## Editorial source notes

Reading leads: Dean and Barroso, The Tail at Scale (CACM, 2013); interaction latency and direct manipulation. Check the distinction between request-level percentiles and user-level experiences. No empirical response-time threshold is assumed.
