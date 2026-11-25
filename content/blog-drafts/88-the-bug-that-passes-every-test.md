# The Bug That Passes Every Test

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

Suppose a program that manages appointments passes every test its developers have written. A customer then cancels an appointment while another operation is changing its time. The program leaves the customer with an appointment that neither operation intended to create.

The tests were useful. They established particular properties of the program under particular conditions. The problem arose in a relationship that had not been represented in the tests. Two individually correct operations could be combined in a way that violated an important expectation.

Automated programming makes this distinction worth keeping in mind. An agent can search for implementations that pass a test suite. A stronger agent can generate additional tests, inspect unusual inputs, and try to identify missing assumptions. These are powerful ways to improve the program. Their success depends partly on the relationship between the tests and the behavior people expect.

Sometimes the expected behavior can be specified rigorously. Other times, the important rule becomes apparent only when we examine how the program is used. A cancellation may carry obligations to several people, and the relevant meaning of cancellation may differ between organizations. A test can encode a decision once the people responsible for that decision have made it.

The interesting question is how we move between what has been specified, what has been tested, and what the system is expected to do in its setting. More tests can be an excellent investment. We should know which expectation each of them gives us reason to trust.

## Editorial source notes

Reading leads: property-based testing, concurrent program verification, and requirements engineering. The appointment scenario is hypothetical; use a reproducible concurrency example if developing a technical demonstration. Distinct from 05: focus on a mismatch between specifications and actual obligations.
