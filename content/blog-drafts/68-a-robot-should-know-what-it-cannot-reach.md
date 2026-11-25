# A Robot Should Know What It Cannot Reach

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai

A chair is easy for a person to move and may be impossible for a particular robot to move. The properties of the chair are only part of the explanation. The robot has a particular shape, range of motion, strength, and way of making contact with the world.

When a language model describes a scene, it can say that there is a chair nearby and suggest moving it. For the physical system, the usefulness of that suggestion depends on a relationship between the chair and the body that is supposed to move it. A good account of the scene must include something about that relationship.

Consider a shelf that is barely outside a robot's reach. The robot could learn to move its base before reaching for an object. If it cannot move its base into the appropriate position, another plan is needed. Recognizing the object correctly is insufficient to distinguish those cases.

I find this a helpful interpretation of embodiment. A robot needs to understand a world in terms of its possible actions, including actions that it cannot currently perform. The same environment offers a different set of possibilities to another robot, or to the same robot after an attachment has been changed.

Better models may learn these relationships without the developer explicitly encoding each one. We would still need evidence that the learned capability applies to the actual body and setting. An evaluation that asks whether a robot recognizes the right object tells us relatively little about whether it understands what that object affords to it.

## Editorial source notes

Reading leads: James J. Gibson's concept of affordances, reachability analysis, task and motion planning, embodiment-conditioned policies. Choose two robots with demonstrably different reachable workspaces; do not equate a semantic action label with verified physical feasibility.
