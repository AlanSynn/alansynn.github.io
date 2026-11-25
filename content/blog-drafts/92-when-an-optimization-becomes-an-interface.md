# When an Optimization Becomes an Interface

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

An optimization can become difficult to remove because other programs have learned to depend on the behavior it introduced. Suppose a service groups requests to improve throughput and its clients begin to rely on the resulting order of responses. A faster implementation that changes the order may break a relationship that was never intended to be part of the interface.

The optimization has become part of the behavior other programs encounter. Removing it may now change the behavior of the surrounding system even if the new implementation offers better performance in isolation.

A dependency of this kind can develop even when the behavior was never specified as part of the interface. A particular ordering, delay, or error response may begin as an accidental property. Once clients rely on it, the property can be difficult to change. An engineer needs to distinguish the promises the system deliberately makes from behavior that its users have learned to expect.

Agents that optimize existing systems will encounter this history. A change may improve the intended benchmark and disrupt a behavior that was never documented as part of the interface. Discovering and testing those dependencies will be an important part of the improvement process.

A useful migration test might exercise clients that relied on the previous ordering and examine whether the new implementation preserves the operations those clients need. If that ordering was accidental, the service might reasonably choose a different contract. It would still need a way to identify the dependencies and give the affected clients a supported transition.

One response is to define contracts more precisely. Another is to change interfaces gradually and help clients move to a new arrangement. Each requires a way to learn what the system has become in practice.

Before replacing the optimization, an engineer should understand which expectations have developed around it and which of them the service needs to preserve. Some can be made explicit in the interface; others may require a supported transition. The measured advantage of a new implementation becomes more informative when we know which commitments it can continue to honor.

## Editorial source notes

Reading leads: Hyrum's Law, API compatibility, batching and queueing, and dependency management. Use a documented example of clients relying on unintended behavior; the batching example is hypothetical.
