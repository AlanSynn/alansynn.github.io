# The Test That Should Survive the Code

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, philosophy-of-science

A regression test can outlive the implementation it was written to test. If it establishes that a saved document can be recovered, it may remain useful through several different designs of the storage system. A test tied to an internal operation of the first implementation may have a different lifespan.

Some tests describe behavior that a user relies on. Others describe the internal arrangement of the old implementation. A change to that arrangement may be entirely appropriate. A test that treats it as a requirement can prevent useful changes.

Frequent software revision gives us more occasions to examine the distinction. A good regression test expresses a relationship the system should continue to satisfy, even when the mechanism used to produce it changes. If a program stores a user's work, a test of whether that work can be recovered matters across many implementations. A test of whether a particular helper function was called may matter only while the current architecture is in place.

There are also cases in which testing an internal property is essential. A security boundary or a real-time constraint may depend on how the program works, not only on the visible output. The question is which property the test is intended to establish.

A performance test, for example, may preserve a bound on allocation or response time that would disappear from a test of the visible output alone. Its usefulness comes from a consequential requirement, not from its knowledge of the current implementation. The engineer should be able to explain why a later implementation must satisfy that property.

If replacing a program and its tests becomes inexpensive, we should make a deliberate decision about which commitments the new program inherits. A useful test can preserve evidence about a behavior that another person depends on while leaving the implementation free to change. That makes the test part of the continuity of the system.

## Editorial source notes

Reading leads: behavioral testing, specification refinement, regression suites, and metamorphic testing. Provide a real example of an implementation-specific test and a behavioral contract. Distinct from 88: focus on preserving valid commitments across replacement.
