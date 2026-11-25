# When the Model and the Object Disagree

**Status:** English working draft | **Theme:** I. Craft, mechanisms, and fabrication | **Candidate tags:** computer-science, robotics

A person finishes a digital design, fabricates it, and makes a small adjustment with a file so that two pieces fit. There are now two versions of the object. One lives in the design file. The other is on the table.

Many design tools are organized around the assumption that the file remains the source of the object. That assumption is reasonable when production is repeatable and the physical result closely follows the specification. It becomes less useful when people continually revise things by hand. A modification can be important even if it never enters the file.

Suppose the person wants to fabricate a second copy or change the length of a nearby part. The old model may no longer describe the object with which the new component must work. A scan can help capture the geometry, but geometry alone may not explain why a change was made. The maker may need a way to record the reason alongside the new shape.

As more capable software connects design and fabrication, I expect this problem of keeping the two versions in relation to become easier to investigate. A tool could preserve the intended design, observations of the existing object, and the changes that link them. It could make clear which version a future operation will use.

The point is not to eliminate every discrepancy. A maker may want to maintain a general design while keeping each fabricated object a little different. What matters is that the difference remains intelligible when someone returns to the project.

## Editorial source notes

Reading leads: as-built modeling, reverse engineering, digital twins, design provenance, and mixed-reality fabrication. Distinct from 59: that essay concerns material-led discovery; this one concerns representation after a physical change.
