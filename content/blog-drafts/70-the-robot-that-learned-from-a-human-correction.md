# The Robot That Learned from a Human Correction

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai, participatory-design

A person reaches over to correct a robot that has placed something in the wrong position. The new position is easy to record. The reason for the correction may be harder to recover.

Perhaps the object was placed too close to the edge. Perhaps it belonged beside another object. Perhaps the person needed space for an activity that had not begun yet. In all three cases, they might move the object to nearly the same place. A robot that treats the final position as the target could learn a useful behavior while missing the relation that led to the correction.

This is one reason to study correction as an interaction. A person may communicate the reason through a gesture, a second example, a brief explanation, or another correction later. The robot may be able to infer a relevant constraint from the surrounding situation. Sometimes asking a small question could prevent the wrong generalization.

We should also allow for the possibility that a person does not want to teach the robot anything. They may simply want the object moved this once. A learning system that turns every correction into a lasting rule can make an ordinary interaction unexpectedly consequential.

A good design would give a person some way to distinguish these cases. It could learn regularities without demanding an explanation every time, while allowing a person to review an inference that changes future behavior. The technical challenge is learning efficiently. The interaction challenge is making clear what the robot thinks it has learned and when that lesson will apply.

## Editorial source notes

Reading leads: interactive robot learning, learning from corrections, inverse reinforcement learning, and mixed-initiative clarification. Study correction scope in a documented interface; distinguish demonstrations of a task from one-off requests.
