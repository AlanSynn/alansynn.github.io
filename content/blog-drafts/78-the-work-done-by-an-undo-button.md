# The Work Done by an Undo Button

**Status:** English working draft | **Theme:** K. Interaction, delegation, and responsibility | **Candidate tags:** computer-science, participatory-design

The undo button changes the way I work even when I never press it. I can try another color or move a shape because I know I have a way back to the earlier result. Reversibility has made an experiment less costly before it has taken place.

Creative tools depend on this relationship between action and recovery. A person can explore several possibilities without deciding in advance which one should survive. But undo becomes more difficult when an operation affects something beyond the tool. A file may have been shared, a message may have reached another person, or a physical object may have been changed.

Agents make these distinctions especially important because they can perform many operations in response to one request. The person might want to keep some of those operations and reverse others. A conventional history of commands may be insufficient if the user cannot tell which consequences arose from each command.

One approach is to make changes inspectable before committing them. Another is to preserve intermediate versions and distinguish reversible local changes from actions that have already affected other people. These methods involve different costs, and there are situations in which a complete reversal is impossible.

It helps to distinguish restoring a previous state from compensating for an action. A drawing can often be restored exactly. A message that another person has read cannot be made unread by restoring a local record. An interface can offer a correction or another action in response, but the original consequence needs to remain intelligible.

An agent that helps me explore a design should make it possible to recognize which consequences I can recover from and which will extend beyond the current workspace. That knowledge can give me more room to try something unfamiliar. The usefulness of undo lies partly in the decisions a person becomes willing to make because recovery is available.

## Editorial source notes

Reading leads: undo histories, version control for creative tools, reversible interaction, and compensating transactions. Distinguish the restoration of a file from compensation for an external action. Related to 17, but concerned with recovery after an action.
