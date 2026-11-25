# The Robot That Learned from a Human Correction

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai, participatory-design

When a person moves an object that a robot has just placed, the robot can record a new position. The movement may also express a lasting preference, a temporary need, or a constraint that applies to other objects. Learning from the correction requires some way to distinguish those possibilities.

Perhaps the object was placed too close to the edge. Perhaps it belonged beside another object. Perhaps the person needed space for an activity that had not begun yet. In all three cases, they might move the object to nearly the same place. A robot that treats the final position as the target could learn a useful behavior while missing the relation that led to the correction.

Correction is thus an interaction through which the intended scope of a change can become clearer. A person may communicate the reason through a gesture, a second example, a brief explanation, or another correction later. The robot may be able to infer a relevant constraint from the surrounding situation. Sometimes asking a small question could prevent the wrong generalization.

We should also allow for the possibility that a person does not want to teach the robot anything. They may simply want the object moved this once. A learning system that turns every correction into a lasting rule can make an ordinary interaction unexpectedly consequential.

The robot might respond to a correction by preserving the changed position for the current task while leaving the general placement policy unchanged. If a similar correction recurs, it could ask whether the person wants a new rule. This gives the user a way to introduce a temporary exception without having to explain every aspect of the preference in advance.

An effective learning interface would let the person correct today's behavior without accidentally establishing a rule for tomorrow. When a correction does imply a lasting change, the robot should make the relevant interpretation understandable and revisable. The quality of what the robot learns depends partly on the authority the person retains over what their actions will mean.

## Editorial source notes

Reading leads: interactive robot learning, learning from corrections, inverse reinforcement learning, and mixed-initiative clarification. Study correction scope in a documented interface; distinguish demonstrations of a task from one-off requests.
