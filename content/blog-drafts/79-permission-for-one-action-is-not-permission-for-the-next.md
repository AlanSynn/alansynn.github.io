# Permission for One Action Is Not Permission for the Next

**Status:** English working draft | **Theme:** K. Interaction, delegation, and responsibility | **Candidate tags:** ethics, computer-science, participatory-design

If I ask someone to open a drawer and retrieve a notebook, I have given them a fairly specific permission. I have not necessarily invited them to read the other papers inside the drawer. The distinction is easy to understand in ordinary life and can be difficult to express in a general account of an agent's capabilities.

An agent may need access to a collection of objects or files in order to perform a task. A technical permission might allow it to read the entire collection. The person's intention may concern only a small part of it. Access to a resource and a legitimate reason to use it are different conditions.

Suppose the agent finds something interesting while retrieving the notebook. Should it remember that information for future tasks? Should it use it to make an unrelated suggestion? The original request does not necessarily answer either question. A system that becomes more helpful by remembering everything may also become difficult for people to understand and govern.

Requiring confirmation for every small operation would make delegation exhausting. We need ways to express permissions that travel with a purpose, expire when that purpose is fulfilled, and can be changed when a new situation arises. How these arrangements work in practice is an HCI problem as well as a security problem.

The important distinction is between a machine's ability to act and the authority under which it acts. The stronger the first becomes, the more carefully we will need to design the second.

## Editorial source notes

Reading leads: least privilege, capability security, contextual integrity, and authorization in agentic systems. Use a concrete workflow to separate purpose, access, retention, and onward disclosure. Do not propose a single policy for all environments.
