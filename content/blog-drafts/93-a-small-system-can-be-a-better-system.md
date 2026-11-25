# A Small System Can Be a Better System

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, ethics

Removing a component can be a substantial improvement to a system when the people using it have no need for the capability the component provides. They may gain a simpler way to operate and recover the system. The architecture should be evaluated in relation to the obligations its components create, as well as the operations they make available.

A simple example is a tool that runs on one person's computer. Moving it to a distributed service can make collaboration and remote access possible. It can also introduce network failures, account management, infrastructure maintenance, and dependence on a service provider. These are reasonable costs when the new capabilities matter. They are unnecessary costs when the activity needs none of them.

We can examine the size of a system through the obligations it creates. How many components have to remain available? Which relationships need to be understood before making a change? Who can repair the system when its original author is no longer present? A smaller implementation may reduce those obligations, although small code alone does not guarantee simple behavior.

AI makes it easier to generate elaborate systems. That is useful when complexity helps solve the problem. It may also make an architecture appear inexpensive because much of its initial implementation was inexpensive. The future costs of operating it remain.

We can sometimes compare two architectures by asking what needs to happen when a component becomes unavailable. A local program may let a person continue working without a network connection, while a shared service may make it easier for another person to recover their work. The relevant failure conditions follow from the activities each arrangement supports.

The appropriate size of a system follows from what needs to remain possible and who will be responsible for making it possible. A distributed service may be essential to one activity and unnecessary for another. When generating an elaborate architecture becomes cheap, those obligations remain a useful basis on which to decide whether the architecture deserves to exist.

## Editorial source notes

Reading leads: end-to-end arguments in system design, software complexity, operational simplicity, and local-first software. Compare actual lifecycle obligations rather than asserting that small or local systems are always preferable.
