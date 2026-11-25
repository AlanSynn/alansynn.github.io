# When an Optimization Becomes an Interface

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

Suppose a system improves throughput by waiting until it has collected several requests and processing them together. The method is effective. Over time, other components begin to depend on the way the system groups and returns those requests.

The optimization has acquired a new role. It influences what other people and programs expect from the service. Removing it may now change the behavior of the surrounding system even if the new implementation offers better performance in isolation.

This is one way implementation choices become part of an interface. A particular ordering, delay, or error response may begin as an accidental property. Once clients rely on it, the property can be difficult to change. An engineer needs to distinguish the promises the system deliberately makes from behavior that its users have learned to expect.

Agents that optimize existing systems will encounter this history. A change may improve the intended benchmark and disrupt a behavior that was never documented as part of the interface. Discovering and testing those dependencies will be an important part of the improvement process.

One response is to define contracts more precisely. Another is to change interfaces gradually and help clients move to a new arrangement. Each requires a way to learn what the system has become in practice.

I think this is why a system's performance cannot be understood independently of its development over time. A useful optimization can become an obligation. The next engineer inherits both its benefit and the relationships that formed around it.

## Editorial source notes

Reading leads: Hyrum's Law, API compatibility, batching and queueing, and dependency management. Use a documented example of clients relying on unintended behavior; the batching example is hypothetical.
