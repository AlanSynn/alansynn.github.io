# Contact Is an Observation

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, computer-science

Looking at a drawer can tell me where its handle is. A cautious pull can reveal whether it moves freely or offers resistance. The movement changes the information available to me. For a robot, deciding which action to take can be part of the process of finding out what is happening.

This is a useful way to think about robotic perception. A camera can help a robot choose where to grasp an object. A measurement obtained through contact can reveal properties that were difficult to infer from the image. A robot that actively investigates those properties may solve a problem that a system receiving a single observation cannot.

The distinction affects the structure of a task. Suppose a robot needs to open a drawer whose movement is unfamiliar. An initial action might be useful mainly because of what it reveals. A slight pull could help the robot choose the next movement. The information obtained from an unsuccessful attempt can become part of its understanding of the object.

The evidence obtained through a pull depends on the force applied and the other observations available. An object that does not move might be locked, obstructed, or simply more resistant than expected. A safe exploratory action can help narrow those explanations. Interpreting its result remains a separate part of perception.

Of course, gathering information through contact can also change or damage the thing being examined. A good exploratory action depends on what the robot is allowed to disturb. This matters when handling a delicate object or sharing space with a person.

A useful experiment in robotic perception could ask which actions allow a robot to distinguish between plausible accounts of an object. Its success would depend on acquiring enough evidence to choose an appropriate next action while respecting the limits of what it can safely disturb. A camera image would be one source of evidence within that inquiry.

## Editorial source notes

Reading leads: active perception (Ruzena Bajcsy), tactile exploration, and interactive object identification. Develop a safe drawer example with an explicit uncertainty and a bounded information-gathering action; no experimental success rate is claimed.
