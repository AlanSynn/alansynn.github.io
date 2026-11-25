# The Cost of a Perfect Default

**Status:** Long-form editorial manuscript | **Theme:** HCI, institutions, and value | **Candidate tags:** participatory-design, ethics, ai

A generative tool can improve every individual result in a collection and leave the collection less interesting. People may have good reasons to accept the results they receive. If the tool continually offers similar possibilities, however, some of the differences that could have emerged through their work may never become visible.

Take a tool that makes websites. Someone who needs a page for a small community can receive a well-composed design and use it immediately. That is a useful capability. It is worth asking another question about the experience: which alternatives would the community have found meaningful had the tool made them as easy to encounter as the first result?

An excellent default can help someone enter an activity. It can also shape the subsequent evidence about the kinds of work people appear to want.

## A good story among similar stories

In 2024, Anil Doshi and Oliver Hauser published [Generative AI Enhances Individual Creativity but Reduces the Collective Diversity of Novel Content](https://doi.org/10.1126/sciadv.adn5290). Participants in an online experiment wrote short stories. Some were offered ideas from a language model. Others wrote without that assistance. The researchers collected 293 stories and had other participants evaluate them.

Access to the generated ideas improved evaluations of individual stories, including evaluations of creativity and writing quality. The researchers also found greater similarity among stories written under the conditions that provided AI ideas, according to their embedding-based comparison. They investigated the relation between the stories and the generated ideas and found evidence consistent with writers being influenced by the suggestions they encountered.

There is an interesting distinction between the two results. A person can benefit from a suggestion and produce a better story. If many people encounter related suggestions, the collection of stories can become more similar at the same time.

The experiment concerns a particular short-story task and a particular kind of assistance. I would not use it to conclude that AI necessarily reduces the diversity of every kind of creative work. An AI system can produce many different ideas, and a person can use it specifically to investigate unfamiliar forms. It is possible to design a system that broadens the alternatives people encounter.

The finding nevertheless gives us a reason to pay attention to the relationship between a tool's suggestions and the work that becomes visible through it. The quality of each result and the range of things people make are different properties. Improving one does not tell us what happened to the other.

## What people accept is partly a record of what they were offered

Imagine a tool for generating an animation. It produces a character making a particular kind of gesture. Most people find the result satisfactory. The gesture becomes common among the animations created with the tool.

The company operating the tool may examine which animations people keep. It finds that this type of gesture is frequently accepted, and that relatively few people ask for something else. That is potentially useful information about the experience of using the tool. It also has a history: the tool has repeatedly offered this gesture as an appropriate solution.

We would need another kind of evidence to understand what people would have done if the system had made a different range of movements easy to explore. Someone may prefer a movement they have never encountered. Someone else may be satisfied with many different movements and have no reason to spend additional time changing the first one. Both people can produce an apparently positive signal about the default.

This is one reason to be careful about interpreting the frequency of a choice as evidence of a person's preference. The frequency depends on the available alternatives, the cost of encountering them, and what the person is trying to accomplish at the time.

The problem becomes more consequential if that record is used to determine what the system will offer in the future. Consider a hypothetical sequence in which a generated output is more likely to be accepted because it is convenient, and acceptance makes that kind of output more likely to be generated again. The system can become increasingly successful at producing the kinds of things its earlier choices made common.

To distinguish a popular default from a self-reinforcing one, we would need to observe how alternatives are presented and what happens to the feedback afterward. Comparing tools that offer different starting points but permit the same later edits could help isolate the effect of the starting point. Establishing a training feedback loop would require separate evidence about the training process.

Such a loop is possible, not a description of the training process of every current model. An actual investigation would need to establish which feedback is collected, how it enters the subsequent system, and what other sources of variation are present.

What interests me is the difficulty of discovering a lost possibility through the ordinary signals of use. A possibility that was never offered may produce neither a complaint nor a request. The tool can appear to be doing a wonderful job.

## The default that gives someone a place to begin

I would not like to remove defaults from creative tools. A person who is learning to make something often benefits from having a reasonable starting point. Consider a beginner who wants to design a moving mechanical figure. They may know very little about the mechanisms available to them. Showing a few familiar mechanisms and letting them inspect the movement can make the entire activity much easier to enter.

A good default can help people develop capabilities they did not previously have. It can reduce the cost of making an attempt and make differences among alternatives more intelligible. In this sense, it can broaden the possibilities of creative work.

There is a difference between offering someone a useful starting point and arranging the rest of the activity around the assumption that the first result expresses what they want. A person may need very little assistance to accept a result and considerable effort to examine another one. The system has made an important decision about which parts of creative activity will be easy.

We can imagine alternative arrangements. A tool could provide a complete initial design and allow the user to expose the choices that produced it. It could offer several realizations that differ along a meaningful dimension, such as the timing of a motion or the structure of a mechanism. It could make one choice easy to change without requiring the person to regenerate everything around it.

Each arrangement has a cost. Offering many alternatives may make a straightforward task unnecessarily difficult. Someone who only wants a serviceable website does not necessarily want a lesson in visual design. Another person might find the opportunity to examine those choices valuable.

I think the useful question is how a tool distinguishes these situations. It can support the person who wants to finish a task quickly while keeping a route available for the person who wants to investigate what else the task could become.

## A distribution of creative work is also an outcome

The design of a generative system affects more than a single person's experience. If many people use the same system to make objects, images, or descriptions, the system can become part of the environment in which other people encounter creative work.

A familiar type of object may become very easy to obtain. Its availability can encourage people to incorporate it into their own activities. A less familiar object may be difficult to encounter because relatively few people ask for it, and relatively few examples are made. In that environment, people can develop a sense of what a good result looks like from the kinds of results that the available tools make common.

This is not necessarily a bad outcome. Shared forms make it easier for people to understand one another, exchange knowledge, and participate in established practices. A common vocabulary is itself a useful part of culture.

The question is whether the available tools also make room for unfamiliar forms to develop. Someone interested in a particular kind of motion may need an opportunity to show it to other people. A small community may need a way to describe what it cares about in a vocabulary that a general-purpose system does not initially provide. A tool can give people a way to encounter differences without requiring those differences to become popular first.

Evaluating this part of a system will require more than a measure of the quality of its individual outputs. We could investigate what people explore, which alternatives become easy to discover, whether they can retain a deliberately unusual choice, and what kinds of work become possible for communities using the tool. A measure of output diversity could be useful, but it would not decide on its own which differences matter.

A system that provides a finished result and an accessible route to meaningful alternatives can serve people with different purposes. We can evaluate whether it supports those purposes by looking beyond acceptance of the first result to the alternatives people encounter, preserve, and develop.

The cost of a perfect default becomes apparent when a community wants to make something for which the established vocabulary has little room. A useful generative system should give that community a way to create and share an unfamiliar form before there is enough evidence of its popularity to make it a default.

## Editorial source and claim notes

- Doshi and Hauser, Science Advances 10(28), eadn5290 (2024), DOI 10.1126/sciadv.adn5290: publisher abstract, experimental design (Figure 1), and similarity analysis inspected. The 293 stories, improvement in ratings, and greater within-condition similarity apply to the study's short-fiction task and embedding metric. Do not generalize to all artistic media.
- The proposed acceptance/training loop is a conditional mechanism, not an empirical assertion about a specific service. The interface examples are hypothetical. The hidden technical debt paper remains a lead for a later verified technical example rather than a source of an asserted finding here.
- Distinct from 19 (formation of preference), 30 (deliberate constraint), and 44 (rhetorical variation). Author approval and independent human reading remain pending.
