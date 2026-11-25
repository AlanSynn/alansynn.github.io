# A Small System Can Be a Better System

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, ethics

An engineer can sometimes solve a problem by removing a component. The system may lose a capability that would have been useful under some conditions. It may become easier to understand, deploy, and recover when something goes wrong.

A simple example is a tool that runs on one person's computer. Moving it to a distributed service can make collaboration and remote access possible. It can also introduce network failures, account management, infrastructure maintenance, and dependence on a service provider. These are reasonable costs when the new capabilities matter. They are unnecessary costs when the activity needs none of them.

I think of system size in terms of the obligations it creates. How many components have to remain available? Which relationships need to be understood before making a change? Who can repair the system when its original author is no longer present? A smaller implementation may reduce those obligations, although small code alone does not guarantee simple behavior.

AI makes it easier to generate elaborate systems. That is useful when complexity helps solve the problem. It may also make an architecture appear inexpensive because much of its initial implementation was inexpensive. The future costs of operating it remain.

A strong system design can be deliberately limited. Someone may choose a local tool because they want control over when it is available and where its data lives. Another organization may need a larger shared service. The appropriate architecture follows the activity and its responsibilities. A system should not grow merely because the tools for building it have become more powerful.

## Editorial source notes

Reading leads: end-to-end arguments in system design, software complexity, operational simplicity, and local-first software. Compare actual lifecycle obligations rather than asserting that small or local systems are always preferable.
