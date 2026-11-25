# The Work Done by an Undo Button

**Status:** English working draft | **Theme:** K. Interaction, delegation, and responsibility | **Candidate tags:** computer-science, participatory-design

I can try a different color in a drawing program because I know I can usually return to the previous one. The undo button changes what I am willing to do before I ever press it. It makes a small experiment less expensive.

Creative tools depend on this relationship between action and recovery. A person can explore several possibilities without deciding in advance which one should survive. But undo becomes more difficult when an operation affects something beyond the tool. A file may have been shared, a message may have reached another person, or a physical object may have been changed.

Agents make these distinctions especially important because they can perform many operations in response to one request. The person might want to keep some of those operations and reverse others. A conventional history of commands may be insufficient if the user cannot tell which consequences arose from each command.

One approach is to make changes inspectable before committing them. Another is to preserve intermediate versions and distinguish reversible local changes from actions that have already affected other people. These methods involve different costs, and there are situations in which a complete reversal is impossible.

I think a useful agent interface should make the cost of an experiment understandable. People can give a system more freedom to explore when they know what they will be able to recover afterward. The quality of a creative tool depends partly on how easily its users can abandon an idea without losing everything they learned while pursuing it.

## Editorial source notes

Reading leads: undo histories, version control for creative tools, reversible interaction, and compensating transactions. Distinguish the restoration of a file from compensation for an external action. Related to 17, but concerned with recovery after an action.
