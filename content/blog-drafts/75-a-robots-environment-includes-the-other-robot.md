# A Robot's Environment Includes the Other Robot

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, computer-science

Two robots approach a narrow doorway from opposite sides. Each knows how to reach its destination. Each recognizes that the other robot is in the way. Both may be capable of following a good navigation policy and still have difficulty deciding how to pass.

The problem is not necessarily a failure to perceive the scene. Each robot's next action depends on what it expects the other robot to do. If both try to avoid the same side, or both wait for the other to go first, their decisions can continually recreate the difficulty.

A shared convention can make the problem easier. One robot might yield according to a rule, or the two might exchange enough information to arrange the passage. The convention does not need to describe the complete reasoning process of either machine. It only needs to establish a relationship that makes their actions compatible.

I expect this kind of issue to become more common as autonomous systems enter shared spaces. Evaluating a robot in an environment populated by passive objects may underestimate the difficulty of interacting with other systems that observe, plan, and adapt. The behavior of the environment partly depends on the robot's own behavior.

There is no reason to assume that centralized coordination is always best. Communication can fail, and shared infrastructure can be expensive or inappropriate. Local conventions and mechanisms for negotiating exceptions may be useful alternatives. What matters is the ability to study the collection of systems as a whole, rather than treating each policy's success as sufficient evidence that their combination will work.

## Editorial source notes

Reading leads: multi-robot coordination, reciprocal collision avoidance, deadlock, and distributed systems. Develop the doorway example with two specified policies; distinguish safety from progress guarantees.
