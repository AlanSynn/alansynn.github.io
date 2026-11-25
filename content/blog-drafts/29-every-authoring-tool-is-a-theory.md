# Every Authoring Tool Is a Theory

**Status:** Long-form editorial manuscript | **Theme:** Graphics, fabrication, and making | **Candidate tags:** computer-science, philosophy-of-science, participatory-design

Open two programs for making an animation. In one, we select a joint and specify its angle at several moments in time. In another, we give a character a movement and adjust the timing of that movement relative to the rest of the scene. The programs may eventually produce very similar animations. The person using them has encountered the movement in two different forms.

In the first program, the angle of a joint has become something we can examine and change. In the second, an entire action has become an object of authoring. These are decisions about what the person needs to understand in order to make something. They give different kinds of knowledge a place in the interface.

I think every authoring tool contains a theory of the activity it supports. By theory here, I mean a set of assumptions about the things a person will find useful to distinguish and the operations they will want to perform on them. We can learn quite a lot about a tool by examining those assumptions.

## What has become an object of thought?

Consider a simple vector drawing. A person creates a circle and a rectangle and places them next to one another. Because the program represents them as separate objects, the person can move one of them without moving the other. They can change the color of the circle, or make another copy of it.

Someone working with an image consisting of pixels can produce an image that looks the same. The operations available to them are different. To move the circle independently, they may need to identify the pixels belonging to it and reconstruct the area it previously covered. The distinction between the two shapes is not part of the representation in the same way.

Neither form is generally superior. The vector representation is useful for operations that depend on identifiable shapes. A pixel-based representation supports kinds of painting and image manipulation that do not require the person to describe every part of an image as a separate object.

The important observation is that a representation can change the way a person thinks about what they are making. A drawing can become a collection of shapes, a surface on which marks are made, or a set of relationships that should be maintained when something changes. The person's next question can develop through the properties the tool makes visible.

In mechanical design, a similar difference appears between specifying a set of dimensions and specifying a relationship among parts. Suppose two holes need to remain aligned. A representation that makes the alignment explicit can help a designer preserve it while changing the surrounding geometry. In another representation, the designer may have to remember to update both holes.

In each of these cases, part of the design knowledge has become available through the form of the artifact. The person does not have to carry the entire relationship in their mind while working.

## What MotionSmith assumes about making an automaton

Our work on [MotionSmith](https://doi.org/10.1145/3772318.3791545) provides one example of such a theory. In automata making, someone may need to understand a desired movement, the mechanism that produces it, and the physical arrangement of the parts through which the mechanism will be realized.

A conventional mechanical design environment can give a user detailed control over the parts. That control is valuable. It may require the person to express a movement through a mechanical representation before they have found a mechanism capable of producing it.

MotionSmith offers another point of entry. A maker can sketch and edit the movement of a part of a character, examine generated mechanism candidates, and refine their design through simulation and direct editing. The system supports returning to earlier choices while the maker investigates what can be fabricated.

The theory of the activity expressed through this workflow is that a person's motion idea and their understanding of a mechanism can develop together. The tool gives both of those things a visible form. A person can investigate the motion through the mechanism, and investigate the mechanism through changes to the motion.

That does not mean the tool provides a complete account of automata making. Some arrangements of movement are outside the mechanism families and workflow the paper addresses. Other makers may prefer to begin with a physical mechanism and develop a character around it. The assumptions become clearer when we understand the situations in which the tool would be difficult to use.

A representation can be interesting partly because it makes its own limits recognizable. The person can see which operations the tool supports and, through trying them, discover what they might want to do differently.

## The prompt is a representation too

A generative system can let a person ask for an artifact in ordinary language. This can be an extraordinarily useful form of authoring. Someone who has never used a specialized program may be able to describe what they want and receive something they can use.

Language also organizes the activity in a particular way. A person can describe the appearance of a scene, the movement of a character, and the relation among several objects. Some of those descriptions will be easy to express. Others will be easier to communicate through a drawing, a manipulation of the scene, or an example of a movement.

Consider a person who has generated a figure with an interesting gesture. They want to change the direction of the gesture while preserving its timing and the shape of the character. They could try to describe all those conditions in language. They might benefit from having an editable object through which they can identify the parts of the result that should remain stable.

A more capable model may be able to infer the relevant conditions and preserve them. I expect substantial progress in that direction. The user may still want to inspect a relationship that the model has inferred, or discover that a different relationship would be more interesting.

The question for authoring research is therefore not simply whether language can provide a good interface to a generator. We can ask which representations help people develop a useful account of their own work, and how a system can make those representations available at the moments when people need them.

An assistant could generate a new representation for a particular activity. For example, it could offer a way to change a repeated movement as a unit because that operation has become important to a maker. The tool's model of the activity could develop through use. That is an interesting direction for research, provided the person can understand and revise the resulting arrangement.

## Evaluating the theory behind the tool

Beaudouin-Lafon, Bødker, and Mackay discuss how theories grounded in human activity can help researchers analyze, criticize, and construct interactive systems in [Generative Theories of Interaction](https://doi.org/10.1145/3468505). The concept is more formal than the sense in which I have called every authoring tool a theory. Their work gives us a useful way to consider how accounts of interaction can inform the creation of new technological possibilities.

For an authoring system, I would like an evaluation to examine the relation between the representation and the activity. What can a person recognize as a distinct part of the artifact? What can they change independently? Which relationships remain stable through a change? When an operation produces an unexpected result, can they develop an account of why it happened?

These are empirical questions about how the tool works and how people encounter it. They can also reveal useful directions for improving a representation. A person may need a different unit of manipulation, a way of preserving a relationship, or a way to move between several descriptions of the same object.

There is no reason to expose every possible distinction at once. An extensive technical representation can be difficult for someone to learn. Sometimes the best arrangement gives the person access to a small number of meaningful operations and lets the system handle the rest. What matters is whether those operations fit the activity the person is developing.

As generating finished artifacts becomes easier, I expect the way people encounter and understand their own creations to become an increasingly rich subject of research. An authoring tool can produce a good result. It can also give someone a vocabulary through which they develop an idea, inspect its consequences, and discover other things they can make.

The choice of vocabulary is part of the contribution. When we design a tool, we are making a particular way of thinking about the work available to another person.

## Editorial source and claim notes

Checked MotionSmith Sections 4.1–4.3 and 5.2.1, public paper and project. Checked Beaudouin-Lafon, Bødker and Mackay (TOCHI 2021), abstract/introduction and conclusion indexed from publication; their defined generative theory is not identical to the broad philosophical use of theory in this essay. Drawing and animation examples are conceptual illustrations. Distinguish draft 25 (operations over the life of an artifact), draft 57 (evolving motion intention), and draft 30 (value of deliberate constraint). No general superiority claim for symbolic interfaces over natural language.

Editorial status: source-checked at the level stated above; author approval, independent human reading, and publication conversion remain pending.
