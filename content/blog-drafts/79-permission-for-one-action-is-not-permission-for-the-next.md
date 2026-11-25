# Permission for One Action Is Not Permission for the Next

**Status:** English working draft | **Theme:** K. Interaction, delegation, and responsibility | **Candidate tags:** ethics, computer-science, participatory-design

Asking someone to retrieve a notebook from a drawer gives them a reason to open the drawer. It does not give them a reason to examine everything they find there. When an agent receives access to a collection of files, an equivalent distinction needs to survive the way its technical permissions are implemented.

An agent may need access to a collection of objects or files in order to perform a task. A technical permission might allow it to read the entire collection. The person's intention may concern only a small part of it. Access to a resource and a legitimate reason to use it are different conditions.

Suppose the agent finds something interesting while retrieving the notebook. Should it remember that information for future tasks? Should it use it to make an unrelated suggestion? The original request does not necessarily answer either question. A system that becomes more helpful by remembering everything may also become difficult for people to understand and govern.

Requiring confirmation for every small operation would make delegation exhausting. We need ways to express permissions that travel with a purpose, expire when that purpose is fulfilled, and can be changed when a new situation arises. How these arrangements work in practice is an HCI problem as well as a security problem.

The purpose of a request could remain attached to the operations through which the system carries it out. Retrieving a specified file may require reading a directory listing; retaining unrelated content for another task is a different operation. The design question is how to make the necessary scope practical without allowing technical access to determine the entire authority of the agent.

A useful delegation system can connect authorization to the activity for which it was given, and let people revise that authorization as the activity changes. It should be possible to complete a request without treating everything the system can access as information it is entitled to retain or use for another purpose.

## Editorial source notes

Reading leads: least privilege, capability security, contextual integrity, and authorization in agentic systems. Use a concrete workflow to separate purpose, access, retention, and onward disclosure. Do not propose a single policy for all environments.
