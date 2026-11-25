# The Work Between Two Tools

**Status:** English working draft | **Theme:** I. Craft, mechanisms, and fabrication | **Candidate tags:** computer-science, participatory-design

When a design moves between two tools, the information the next tool receives may differ from the information the maker used to develop it. A file can preserve the shape of a part and lose the relation that was supposed to remain stable while the shape changes. The later stage of the work then depends on recovering something the earlier tool already knew.

A file export normally carries a representation of the design. It may not carry the intentions and relationships that were useful while the design was being edited. A fabrication program might receive a set of surfaces but lose the information that two holes were meant to stay aligned. The maker then has to remember that relationship while preparing the object.

Following a project across its transitions can reveal what is difficult about the overall workflow. What does the next tool need to know? What can the person reconstruct easily? Which decisions become difficult to revisit once they cross the boundary? These questions help explain why an apparently small export feature can matter so much in practice.

There are good reasons for tools to use different representations. A manufacturing machine does not need every feature of an artist's drawing program. A compact exchange format can make collaboration and reuse easier. The design problem is to preserve the relationships that matter to the next activity without requiring all tools to share the same internal model.

Consider a circular hole constrained to remain concentric with a shaft. A mesh can preserve the shape of the hole at the moment of export. It need not preserve the relationship as something the next tool can maintain when the shaft changes. A successful transfer for fabrication can therefore be an unsuccessful transfer for editing.

The right exchange format depends on what someone wants to do after the transfer. A description sufficient for cutting a part may be poor material for revising its design. A useful account of a fabrication workflow follows the decisions across those boundaries and identifies which relationships the next activity needs to retain.

## Editorial source notes

Reading leads: CAD interoperability, geometry exchange formats, provenance, and end-to-end fabrication workflows. Inspect a specific STEP/STL/SVG transition with known lost properties. Distinct from 25: focus on handoffs and continuity across tools.
