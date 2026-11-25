# The Module That Outlives Its Original Purpose

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, history-of-science

A library is written for a particular project. Its author chooses an interface that makes sense within that project. A year later, someone uses the library to solve a problem the author never considered. The interface may now reveal a distinction that was more general than the original purpose.

I find this an interesting way to think about abstraction. A useful abstraction captures a relationship that can survive changes in the activities around it. A poor one may expose assumptions that only made sense in the project where it was first used.

It can be difficult to know the difference in advance. A programmer might design a general interface before understanding which variation will matter. Another programmer might solve a narrow problem and later discover that the underlying operation is useful elsewhere. The history of use gives both of them opportunities to learn.

Agents will make the construction and adaptation of software components easier. That may reduce the value of some reusable implementations because generating a new one is inexpensive. Reuse can still carry a different advantage: people and other systems can depend on a common meaning that has survived several uses.

The important question is what remains stable as the surrounding applications change. We can build a new implementation of an operation while preserving that meaning. We can also expose a new operation when the old interface has become too narrow. Abstraction is a way of making some knowledge portable. Its quality becomes apparent when someone carries it into a setting its designer did not foresee.

## Editorial source notes

Reading leads: David Parnas, On the Criteria To Be Used in Decomposing Systems into Modules (1972); information hiding and library evolution. Trace one actual module across distinct applications; avoid equating a stable API with universal applicability.
