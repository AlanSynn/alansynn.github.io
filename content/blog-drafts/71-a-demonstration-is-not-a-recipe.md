# A Demonstration Is Not a Recipe

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai

Watch someone pour water from a cup. Their hand follows a particular path, the cup turns, and the water enters another container. A robot could record the movement with great precision. It would still need to know which parts of the movement should be repeated in another situation.

The person may have raised the cup to clear an obstacle. They may have tilted it slowly because it was full. Their fingers may have been positioned according to the shape of the handle. A demonstration shows us what someone did under those conditions. Several different accounts of the task can explain the same movement.

This is a familiar challenge in learning from demonstration. Observing more examples can help a system recognize which relations remain stable as the setting changes. For some tasks, learning to imitate the observed behavior is sufficient. For others, the robot has to respond to differences that never appeared in the examples.

I find it useful to ask what the demonstration is intended to communicate. It could show an exact motion, identify a sequence of steps, establish a constraint, or illustrate a quality that the person wants to preserve. A learner needs different forms of evidence for these purposes.

A robot may eventually infer much of this information from a small number of examples. Even then, we should distinguish its ability to reproduce the demonstration from its ability to adapt the behavior while preserving what matters. The real test may arrive when the cup, the container, or the person asking for the task has changed.

## Editorial source notes

Reading leads: Argall et al., A Survey of Robot Learning from Demonstration (2009); imitation learning, task representations, and counterfactual demonstrations. Locate an empirical case where similar demonstrations support different adaptations.
