# The Module That Outlives Its Original Purpose

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, history-of-science

The value of a software abstraction can become apparent when it is used for a purpose its designer did not anticipate. A library originally developed for one project may contain a distinction that remains useful after the conditions of that project have changed. Its interface gives another person a way to recognize and use that distinction.

The history of a module gives us a way to examine the scope of its abstraction. A useful abstraction captures a relationship that can survive changes in the activities around it. A poor one may expose assumptions that only made sense in the project where it was first used.

It can be difficult to know the difference in advance. A programmer might design a general interface before understanding which variation will matter. Another programmer might solve a narrow problem and later discover that the underlying operation is useful elsewhere. The history of use gives both of them opportunities to learn.

A module that exposes a particular way of storing a result may become awkward when another application uses a different form of storage. An interface that describes the operation in terms of the relevant relation can survive that change. We can investigate the distinction by examining what a new user has to understand about the original application in order to use the module.

Agents will make the construction and adaptation of software components easier. That may reduce the value of some reusable implementations because generating a new one is inexpensive. Reuse can still carry a different advantage: people and other systems can depend on a common meaning that has survived several uses.

A common abstraction can let several projects rely on the same relationship without sharing a particular implementation. Its durability depends on whether that relationship continues to make sense as the applications change. The unfamiliar project can therefore reveal something about the quality of the abstraction that the project for which it was designed could not.

## Editorial source notes

Reading leads: David Parnas, On the Criteria To Be Used in Decomposing Systems into Modules (1972); information hiding and library evolution. Trace one actual module across distinct applications; avoid equating a stable API with universal applicability.
