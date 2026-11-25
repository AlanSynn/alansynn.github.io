# A Demonstration Is Not a Recipe

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai

A recording of someone pouring water can describe the movement of the cup in great detail. It cannot by itself establish which properties of that movement are necessary to pour water successfully when the container, the obstacles, or the amount of water changes. A demonstration is evidence about a particular performance.

The person may have raised the cup to clear an obstacle. They may have tilted it slowly because it was full. Their fingers may have been positioned according to the shape of the handle. A demonstration shows us what someone did under those conditions. Several different accounts of the task can explain the same movement.

This is a familiar challenge in learning from demonstration. Observing more examples can help a system recognize which relations remain stable as the setting changes. For some tasks, learning to imitate the observed behavior is sufficient. For others, the robot has to respond to differences that never appeared in the examples.

A second demonstration can be useful because it changes a condition the first demonstration left ambiguous. If the person pours from a different position and still raises the cup to the same height, the robot has a reason to investigate whether that height serves a purpose. If the person omits the detour when an obstacle is absent, it has evidence about a different relation.

Different purposes for a demonstration call for different forms of evidence. It could show an exact motion, identify a sequence of steps, establish a constraint, or illustrate a quality that the person wants to preserve. A learner needs different forms of evidence for these purposes.

I would evaluate a robot that learns from demonstrations by changing a condition that makes the distinction consequential. If the cup has another shape, can the robot preserve the relevant relation between the cup and its destination? If an obstacle disappears, does it still reproduce the detour? Those observations help establish which parts of the demonstration became useful knowledge.

## Editorial source notes

Reading leads: Argall et al., A Survey of Robot Learning from Demonstration (2009); imitation learning, task representations, and counterfactual demonstrations. Locate an empirical case where similar demonstrations support different adaptations.
