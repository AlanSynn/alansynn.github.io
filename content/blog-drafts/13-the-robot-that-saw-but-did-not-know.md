# The Robot That Saw but Did Not Know

**Status:** Long-form editorial manuscript | **Theme:** Embodied intelligence | **Candidate tags:** robotics, ai, computer-science

Someone puts a cup into a drawer and closes it. I can no longer see the cup. I still know which drawer to open when I need it. If someone moves the cup while I am away, I may open the wrong drawer. The empty drawer gives me a reason to reconsider what I thought I knew about the world.

This is a fairly ordinary activity. For a robot, it brings together several abilities that are worth understanding separately. The robot needs to identify the cup, observe where it goes, retain information when the cup is no longer visible, and use that information to choose an action. When the result of the action differs from its expectation, it needs to change its account of the situation.

When I think about the development of vision-language models, I find it useful to distinguish the ability to answer questions about an observation from the ability to maintain an understanding of a world through which an agent moves. A description of the latest image can be extraordinarily accurate and still give the agent little idea of what happened to the cup.

## What does it mean for a model to see?

Language models with visual inputs can tell us a great deal about the contents of an image. One reason to use such a model in robotics is that the description can help connect an unfamiliar scene to the purpose of a task. A robot told to clean a table benefits from recognizing which objects might be dishes and which might need to be put elsewhere.

The capability has some interesting limitations. In [Vision language models are blind](https://arxiv.org/abs/2407.06581), Rahmanzadehgervi and colleagues investigated several simple visual questions involving counts, spatial relationships, and nearby or overlapping shapes. They documented failures among the models they tested, despite the models' strong performance on more general benchmarks. Their later version also reports probing experiments suggesting that the visual encoders retain information that the language models do not use effectively in producing the answers.

This last observation is important. It gives us reason to distinguish the presence of information in a representation from the use of that information by another part of the system. An incorrect description of an image could arise because important detail was lost in encoding. It could also arise because the information was available but did not enter the process that produced the answer in a useful way.

I would not take the paper's title as a permanent description of all vision-language models. The experiments concern particular models and visual tasks. New systems can improve at those tasks, and a representation that provides better access to visual relationships may change what is possible. There is nevertheless a useful distinction in the problem it reveals. Understanding a visual scene involves more than producing a fluent description of what it contains.

For robotics, the description is often only an intermediate product. The system needs to connect information about the scene to a decision about what its body can do. What it needs from the representation can be quite specific to that decision.

## The cup that is no longer in the image

Suppose a robot is placing several cups beneath a coffee machine. Each cup needs to be placed there once, then returned to another position on a table. After the second cup is returned, the scene can look much like an earlier scene in the task. A policy that only receives the current image may have difficulty deciding which cup still needs to be moved.

The necessary information belongs to the history of the task. The robot must maintain some account of which object it has acted upon. It may need to recognize that object after its location changes. A description such as there are three cups on the table is accurate in both situations and insufficient for choosing the next action.

A representation of memory can be organized in several ways. We could keep a record of everything the robot saw. We could record a smaller number of observations. We could maintain an account of the important objects and events. We could also retain several forms of memory for different purposes.

The choice becomes particularly interesting when the task requires both visual detail and an understanding of what has already happened. A robot reaching toward a small object may benefit from retaining recent visual observations at a useful level of detail, especially when the robot's own arm begins to obscure the object. A robot preparing a recipe may need to remember that it has already added a particular ingredient over a much longer period. A compact statement about the event may be quite sufficient for the second purpose.

In [Multi-Scale Embodied Memory for Vision Language Action Models](https://arxiv.org/html/2603.03596v1), Torne and colleagues propose an architecture that combines short-term visual memory with longer-term memory expressed through language. They evaluate the approach on tasks involving object memory and longer sequences of activity. One of their analysis tasks requires a robot to retrieve an object after seeing it placed in one of four drawers. They also report results on multistage tasks lasting up to approximately fifteen minutes.

I find this research interesting because it gives a constructive response to concerns about the relation between language and visual information. The representation that is useful depends partly on when and how the information will be needed. Language can compress an account of a completed event into a form that is economical to retain. Recent visual history can supply information about a movement or spatial relation that would be difficult to express with comparable precision in a sentence.

The paper does not tell us how many objects all future models will be able to remember. The four drawers belong to one experimental task. It does provide evidence that the organization of memory can make a substantial difference to the ability of a robot to carry out a task.

## A memory has to be revised

There is another problem that arises when a robot maintains information beyond the latest observation. The information can become wrong. A person might move the cup. A drawer might become unavailable. The robot itself might perform an action whose effect was different from what it expected.

A useful memory system needs a way to decide which parts of its account should continue to influence behavior. When the robot cannot find the cup, the observation should lead it to reconsider the relevant part of its account. It may need to acquire additional information rather than simply retain a new assertion about the world.

We can investigate this through relatively simple tasks. Suppose a robot observes an object placed in a drawer, then observes it being moved somewhere else. We could compare that situation with one in which the robot was unable to observe the second event. The appropriate action depends on what the robot has been able to learn. It might retrieve the object directly in one case and need to search in the other.

Such experiments can help us distinguish successful recall from successful revision of a remembered state. They can also tell us something about what the policy does with uncertainty. A robot that confidently acts on an old observation may fail in a different way from a robot that has forgotten the observation entirely.

The ability to decide how to acquire the next useful observation belongs here too. Opening a drawer can be a way to discover whether a remembered location remains correct. The result of the action becomes new evidence. The activity of knowing about the world is connected to the activity of moving through it.

## What I would look for next

I expect rapid improvement in visual perception and robotic memory. Much of this research can be organized around tests that distinguish useful from unsuccessful behavior. Strong agents will be able to investigate many candidate representations and learning procedures. A technical difficulty visible today offers little assurance that it will remain difficult for long.

The distinction I would like to preserve is between the kinds of capabilities those systems acquire. Detecting an object, identifying it through changes of view, remembering a relevant event, updating the memory, and using the resulting information to act are related but different accomplishments.

A model that scores well on questions about images may give us a useful component of such a system. A robot that maintains an actionable and revisable account of its surroundings may give us another kind of evidence about what the model can do. That evidence is particularly interesting when the task continues long enough for the world to change.

I hope we will develop more research that examines these relationships rather than treating visual understanding as a single quantity. The robot's next successful action may tell us something about what it has learned from the world. Sometimes its next unsuccessful action will tell us even more.

## Editorial source and claim notes

Checked Rahmanzadehgervi et al., arXiv:2407.06581v6 (March 2025 revision, abstract and probing claim); no present-day universal accuracy claim. Checked Torne et al., arXiv:2603.03596v1, introduction, evaluation scope, Appendix B (four-drawer task, cup-swapping task) and [project report](https://www.pi.website/research/memory). The time horizon is reported by authors; not a general memory limit. All proposed variations on the drawer task are hypothetical experimental designs, not results. Distinct from 67 (contact as evidence) and 71 (demonstration and transfer).

Editorial status: source-checked at the level stated above; author approval, independent human reading, and publication conversion remain pending.
