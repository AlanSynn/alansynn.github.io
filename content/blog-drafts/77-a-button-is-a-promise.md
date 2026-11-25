# A Button Is a Promise

**Status:** English working draft | **Theme:** K. Interaction, delegation, and responsibility | **Candidate tags:** participatory-design, computer-science

When I press Save, I want to be able to return to the work I have just done. The label is meaningful partly because of the future behavior I expect from the system. A reassuring acknowledgment that arrives before the work is stored can leave that expectation unjustified.

An interface becomes difficult to use when these two things come apart. A system may acknowledge that I pressed the button before my work has reached a reliable storage location. The animation may look reassuring even though a network connection is failing. A designer needs to decide what the visible response actually means.

This becomes more consequential with agents. A person can ask a system to arrange several things without seeing each operation. The response “Done” may cover actions that have succeeded, actions awaiting approval, and actions the system merely intends to perform. Fluency can obscure differences that a conventional interface would have exposed through separate states.

An acknowledgment of receipt, a report that a change was committed, and a statement that another service has confirmed the change can all be useful messages. They should not have the same implication. A person who will close the application or rely on the new state needs to know which condition the system has established.

A designer can begin by identifying the commitments represented by each response. What can the person expect after a particular response? Which changes are already in effect? What will the system do if an operation fails later? In some situations, a simple confirmation is enough. In others, the person needs access to the details.

When a person delegates several operations, the response should preserve the distinctions that matter to their next decision. They may need to know which changes have taken effect, which remain pending, and which failed. The interface should give them a reasonable account of the world the system has actually changed.

## Editorial source notes

Reading leads: distributed-system acknowledgment semantics, Norman's design of everyday things, feedback and system status in HCI. Compare specific interface responses to actual operation states; avoid requiring exhaustive status details for simple tasks.
