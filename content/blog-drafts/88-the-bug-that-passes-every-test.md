# The Bug That Passes Every Test

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

A program can pass a collection of tests and violate an expectation that nobody thought to include in them. Consider an appointment system in which changing the time and canceling an appointment both work when tested separately. If the operations occur concurrently, the program might leave an appointment neither operation was intended to create.

The tests were useful. They established particular properties of the program under particular conditions. The problem arose in a relationship that had not been represented in the tests. Two individually correct operations could be combined in a way that violated an important expectation.

The missing property could be that a canceled appointment must remain canceled regardless of the order in which two permitted updates finish. Testing each operation individually establishes a narrower property. Testing their possible interleavings, or verifying a model of their interaction, would address the stronger claim. Whether the specification ought to require that property is another decision.

Automated programming can make the consequences of this distinction especially visible. An agent can search for implementations that pass a test suite. A stronger agent can generate additional tests, inspect unusual inputs, and try to identify missing assumptions. These are powerful ways to improve the program. Their success depends partly on the relationship between the tests and the behavior people expect.

Sometimes the expected behavior can be specified rigorously. Other times, the important rule becomes apparent only when we examine how the program is used. A cancellation may carry obligations to several people, and the relevant meaning of cancellation may differ between organizations. A test can encode a decision once the people responsible for that decision have made it.

A useful test suite gives engineers a way to examine the commitments they have established about the program. It can also become part of an inquiry into commitments that are missing. When the tests pass, we should be able to explain what has been established and which expectations we still need to investigate.

## Editorial source notes

Reading leads: property-based testing, concurrent program verification, and requirements engineering. The appointment scenario is hypothetical; use a reproducible concurrency example if developing a technical demonstration. Distinct from 05: focus on a mismatch between specifications and actual obligations.
