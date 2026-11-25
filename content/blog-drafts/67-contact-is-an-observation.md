# Contact Is an Observation

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, computer-science

There are things I learn about an object only when I touch it. I can look at a drawer and identify its handle. Pulling on the handle tells me whether the drawer is locked, whether it is heavy, and whether it moves as I expected. Some of that information becomes available only through an action.

This is a useful way to think about robotic perception. A camera can help a robot choose where to grasp an object. The experience of making contact can reveal properties that were difficult to infer from the image. A robot that actively investigates those properties may solve a problem that a system receiving a single observation cannot.

The distinction affects the structure of a task. Suppose a robot needs to open a drawer whose movement is unfamiliar. An initial action might be useful mainly because of what it reveals. A slight pull could help the robot choose the next movement. The information obtained from an unsuccessful attempt can become part of its understanding of the object.

Of course, gathering information through contact can also change or damage the thing being examined. A good exploratory action depends on what the robot is allowed to disturb. This matters when handling a delicate object or sharing space with a person.

As vision and language systems become better, I expect the relationship between observation and action to become a more visible part of what we call intelligence. Sometimes the relevant question is not whether a system can understand an image more thoroughly. It is whether the system knows how to acquire the next piece of evidence.

## Editorial source notes

Reading leads: active perception (Ruzena Bajcsy), tactile exploration, and interactive object identification. Develop a safe drawer example with an explicit uncertainty and a bounded information-gathering action; no experimental success rate is claimed.
