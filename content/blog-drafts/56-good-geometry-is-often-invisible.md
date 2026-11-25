# Good Geometry Is Often Invisible

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, robotics

The quality of a geometric representation can remain invisible until someone performs an operation on it. Two meshes may produce nearly identical images, yet behave quite differently when an animator bends a joint or a maker sends the model to a fabrication tool. Those later activities reveal properties the initial image could not establish.

Some of the most important properties of geometry become apparent through operations on it. A surface may have edges arranged in ways that support deformation. A mesh may contain a small hole that becomes a problem when it is sent to a fabrication tool. A geometric model may permit efficient collision checks even though those properties make little difference to its appearance.

This suggests a way of thinking about representation in graphics. We can judge a representation by what it depicts and by the operations it makes possible. Those judgments can be related, but one does not replace the other. If a model is meant to become part of an animation, evidence about its behavior under animation belongs in the evaluation.

A mesh intended for deformation may need properties that a mesh intended for a fixed rendering does not. Similarly, a geometric defect that is harmless in an animation may be consequential in fabrication. There is little reason to require every representation to support every operation. We need to understand the operations to which a proposed geometric property contributes.

The increasing ability to generate beautiful three-dimensional assets makes this distinction practical. Many users will need only a particular rendering. Others will need models that support editing, simulation, or manufacture. A generator may learn to produce representations that satisfy all of these conditions, in which case the relevant engineering problem will become easier.

For a representation intended to support further work, I would ask what can be changed, computed, or fabricated from it and how the relevant relations survive those operations. This can reveal the value of a geometric construction that produces very little visible improvement in an initial comparison.

## Editorial source notes

Reading leads: mesh topology, subdivision surfaces, deformation and rigging, mesh repair for fabrication, and collision representations. Use one concrete operation and a documented failure rather than implying a universal best topology.
