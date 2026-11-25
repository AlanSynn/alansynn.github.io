# Intelligence Arrives Too Late

**Status:** editorial draft / argument development | **Theme:** Embodied intelligence | **Candidate tags:** robotics, computer-science, ai

A robot can make a correct decision about an observation and still act incorrectly because the world has changed while it was deciding. For an embodied system, the time at which a result becomes available is part of what determines whether the result is useful.

Suppose a robot is handing someone an object. It needs to identify an appropriate position for the handover, move toward it, and respond to changes in the other person's grip. These activities can require decisions at different rates. A considered plan might help the robot approach an unfamiliar object. A response to a sudden loss of support needs to occur on a much shorter timescale.

This is a reason to distinguish the information required for a decision from the time available to use that information. A slow planning process can produce a useful trajectory if the relevant conditions remain stable. A local control process can adjust that trajectory as the situation develops. The system also needs a way to recognize when an earlier plan has ceased to be appropriate.

There are many possible architectures for achieving that organization. Separate planning and control modules can make the responsibilities explicit. A learned system may acquire effective behavior at several timescales without using those exact modules. What we should examine is the relationship between the decisions it makes, the observations on which they depend, and the time at which their consequences occur.

A policy that produces a new motion every few seconds might remain useful if a separate process can respond to a contact event in the meantime. Conversely, a very fast local response may need to be interrupted when the purpose of the task changes. The relevant property is the relation between the age of the information, the decision being made, and the dynamics of the next action.

The experience of a person interacting with the robot provides another reason to examine timing. Two robots can complete the same handover with similar success rates while responding quite differently to a person's movement. A delay can change whether the person feels able to influence what happens next. That quality belongs to the sequence of interactions, rather than the total duration of the task alone.

More capable inference can help the robot understand the purpose of a difficult action. It is also worth asking which decisions should not have to wait for that inference. A useful architecture can give an earlier decision enough continuity to guide action while giving the robot a way to recognize when the world has moved beyond it.

## Source plan

Checked examples: [Physical Intelligence, Teaching Robots to Listen and Think Harder](https://www.pi.website/research/hirobot) and [FAST action tokenization](https://www.pi.website/research/fast) (project accounts). Reading leads: real-time control, action chunking, temporal abstraction, and classic work on interaction latency. Avoid a neuroscience claim that a robot architecture duplicates the human mind.
