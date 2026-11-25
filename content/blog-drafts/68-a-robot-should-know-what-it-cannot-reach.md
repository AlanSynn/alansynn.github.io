# A Robot Should Know What It Cannot Reach

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai

The same shelf offers different possibilities to two robots. One can reach an object on it; the other must move its base before doing so. A change in the shape or configuration of the robot can change which actions are possible even when its description of the scene remains accurate.

When a language model describes a scene, it can say that there is a chair nearby and suggest moving it. For the physical system, the usefulness of that suggestion depends on a relationship between the chair and the body that is supposed to move it. A good account of the scene must include something about that relationship.

Consider a shelf that is barely outside a robot's reach. The robot could learn to move its base before reaching for an object. If it cannot move its base into the appropriate position, another plan is needed. Recognizing the object correctly is insufficient to distinguish those cases.

Even a reachable object may be unavailable for a particular action. The robot might be able to touch it but unable to grasp it in an orientation that permits the intended movement. An evaluation can distinguish those conditions by changing the body or the required action while leaving the visual scene largely unchanged.

This is one practical meaning of embodiment in robotics. A robot needs to understand a world in terms of its possible actions, including actions that it cannot currently perform. The same environment offers a different set of possibilities to another robot, or to the same robot after an attachment has been changed.

A useful test of embodied understanding can keep the scene fixed and change the robot that is supposed to act in it. Does the system recognize that a previously possible action has become infeasible? Can it find another way to obtain the result? The ability to answer those questions reveals something about a world understood in relation to a particular body.

## Editorial source notes

Reading leads: James J. Gibson's concept of affordances, reachability analysis, task and motion planning, embodiment-conditioned policies. Choose two robots with demonstrably different reachable workspaces; do not equate a semantic action label with verified physical feasibility.
