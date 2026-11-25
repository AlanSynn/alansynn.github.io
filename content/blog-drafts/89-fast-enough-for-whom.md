# Fast Enough for Whom?

**Status:** Long-form editorial manuscript | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

What counts as a fast system depends partly on the work the system supports. A delay of one second can be almost irrelevant to someone waiting for a rendering that they do not need yet. The same delay can interrupt the movement of someone editing a curve, because the person is waiting to see the consequence of their action before deciding what to do next.

I find this distinction useful when thinking about the relationship between systems research and HCI. We can learn a great deal from a latency distribution. A claim that a system has improved someone's experience also requires us to understand where the measured operations occur within that experience.

## A slow request in a large system

Systems researchers have long been concerned with the tail of latency distributions. Suppose we measure the time it takes a service to respond to a large collection of requests. The median describes a typical position in that distribution. A high percentile tells us about the requests that take considerably longer. The difference between those measurements becomes important when the performance of one operation depends on many smaller operations.

In [The Tail at Scale](https://research.google/pubs/the-tail-at-scale/), Jeffrey Dean and Luiz André Barroso describe how occasional slow components can become a substantial problem for large online services. They discuss techniques for constructing a predictably responsive service out of components whose individual performance can vary.

A small hypothetical example makes the problem visible. Suppose a service receives a request that requires results from 100 workers. Assume that each worker independently has a one percent chance of taking longer than a chosen deadline. If the service must receive every result before proceeding, the probability that at least one worker misses that deadline is about 63.4 percent:

`1 - 0.99^100 ≈ 0.634`

This is a calculation under deliberately simplified assumptions, not a measurement of an existing service. Real workers can have correlated delays, and a system may be able to proceed without every result. The calculation illustrates why an operation involving many components can have a very different latency distribution from its components.

The useful object of evaluation in this case is the service that needs to assemble the results. Improving the typical worker's response time might have relatively little effect if the service often waits for one slow worker. A different technique may address the part of the distribution that determines when the larger operation can finish.

When the service supports an interactive activity, a further question is which person or operation encounters the delay. We want to understand what the delay does to the person who is waiting.

## Whose requests are slow?

Consider a hypothetical editor with two operations. One is used frequently and normally takes 20 milliseconds. Another is used less often and takes one second. If the second operation accounts for one percent of all requests, the arithmetic mean of the two response times is 29.8 milliseconds.

That average can be quite useful for a particular purpose. It tells us something about a request selected from the observed collection. It tells us little about a person whose work requires the second operation repeatedly.

The distribution across requests and the distribution across people are different things. The first gives a great deal of weight to the activities that generate many requests. Someone who performs a less common activity can experience poor performance almost every time they use the feature, while having little effect on the reported mean.

An aggregate high percentile may reveal the slow requests, depending on how the percentile is defined and how the distribution is constructed. It still does not tell us why a request was slow or which person encountered it. That requires some way to connect the measurement to the operation and the activity it supports.

The weighting problem becomes clearer if a small group repeatedly uses the slow operation. Counting requests gives that group little influence on the overall average even though the slow behavior may characterize nearly every session they have. A per-session account or an operation-specific distribution could make this visible without pretending that a single alternative statistic captures every relevant experience.

This is especially relevant when we report an improvement for a system used by several kinds of people. Suppose an optimization improves the frequent operation from 20 to 10 milliseconds but leaves the less frequent operation unchanged. The mean improves substantially. A person using the slow feature may experience exactly the same system as before.

There can be excellent reasons to prioritize the improvement that affects more requests. I would want to know that we have made that decision, rather than infer from the improved mean that every kind of work has become easier.

We can measure latency by operation, task, session, or another relevant unit, with care about privacy and the way the resulting data are used. These measurements let us examine different questions. Which one we need depends on the claim we want to make about the system.

## Where the delay occurs in an activity

Return to the person drawing a curve. The consequences of a delay depend partly on where it appears in the sequence of actions.

Suppose the person selects a control point, moves it, and sees a new curve. The display is part of a process through which the person decides how to move the point next. If a particular update arrives late, the person may be making their next movement on the basis of an earlier state of the drawing. They might stop, make a corrective movement, or alter the way they work.

In the rendering example, the result is needed at a different moment. The person may be able to spend the intervening time on another activity. If the rendering arrives before they need it, reducing the generation time might make little practical difference.

Neither activity has a universal latency threshold. The useful threshold would depend on the feedback available to the user, the predictability of the delay, the required precision, and the surrounding work. A system might provide a responsive preview while a more expensive computation takes place. Another system might make the eventual cost clear and let the person decide when to initiate the operation.

The important property is the relation between the event that is delayed and the next decision the person needs to make. The same one-second delay can occupy very different positions in two activities.

This gives us a reason to study the timing of the activity itself. Observe how a person interacts with a system, identify where feedback informs their next decision, and measure the behavior of the system at those points. We might discover that a delay in one part of a workflow deserves much more attention than a larger delay somewhere else.

## What I would ask an optimization agent to improve

An agent could be extraordinarily useful in addressing latency. Given a sufficiently reliable benchmark, it could investigate implementations, choose among caching strategies, examine a trace, and test whether a change improves the reported behavior.

The difficult part of the example is that there are several reasonable things to improve. We may want to reduce the total compute used by the service. We may want to reduce the slowest responses. We may want a particular interactive operation to remain available under load. We may want to ensure that people using a less common feature are not repeatedly exposed to a condition the aggregate benchmark barely represents.

All of these goals can admit technical evaluation. Some may require a different experimental workload or a more specific instrument for examining performance. They can also conflict. Reserving resources for a rare operation can affect throughput elsewhere. Predictable response times may require a trade-off involving cost or utilization.

More capable systems research gives us more ways to make those choices effective. It does not establish which choice is appropriate for every activity the system supports.

I would like performance evaluation to make the relationship between the optimization and the intended use more visible. Describe the workload, identify the people or downstream operations that encounter the relevant behavior, and explain the consequences of the measured delay. If the evaluation supports only a claim about a synthetic workload, that can be a valuable result in its own right. A claim about someone's experience should connect the performance measurement to their activity.

For the editor, an improvement worth examining is the person's ability to continue shaping a curve while receiving useful feedback about each movement. An optimization that produces that improvement may affect only a small fraction of the service's requests. It could be nearly invisible in the aggregate average and quite consequential to the person using it.

The distribution of response times helps explain how the implementation behaves. The organization of the activity tells us which parts of that distribution deserve our attention. Understanding both gives us a more useful reason to optimize the system.

## Editorial source and claim notes

- Dean and Barroso, The Tail at Scale, Communications of the ACM 56 (2013), pp. 74–80: [author/institution publication page and abstract](https://research.google/pubs/the-tail-at-scale/) inspected. Use for tail-tolerant service design and the effect of variable component latency at scale; no universal human latency threshold is asserted.
- Probability and average calculations are explicitly hypothetical. The first assumes independent workers, equal deadline-miss probability, and waiting for every worker; the second assumes 99% at 20 ms and 1% at 1000 ms. The arithmetic is 19.8 + 10 = 29.8 ms. No user-study outcome is claimed.
- Interaction examples are proposed analyses. A future empirical version could collect consented operation-level timings and task observations, but this manuscript does not report such a study.
- Distinct from 15 (control latency), 90 (workload change), and 91 (instrumentation). Author approval and independent human reading remain pending.
