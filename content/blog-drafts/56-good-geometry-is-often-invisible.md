# Good Geometry Is Often Invisible

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, robotics

Two models of a character can produce almost the same rendering. One deforms cleanly when its arm bends. The other develops a crease or a gap. Until we ask the models to move, we may have little reason to notice the difference.

Some of the most important properties of geometry become apparent through operations on it. A surface may have edges arranged in ways that support deformation. A mesh may contain a small hole that becomes a problem when it is sent to a fabrication tool. A geometric model may permit efficient collision checks even though those properties make little difference to its appearance.

This suggests a way of thinking about representation in graphics. We can judge a representation by what it depicts and by the operations it makes possible. Those judgments can be related, but one does not replace the other. If a model is meant to become part of an animation, evidence about its behavior under animation belongs in the evaluation.

The increasing ability to generate beautiful three-dimensional assets makes this distinction practical. Many users will need only a particular rendering. Others will need models that support editing, simulation, or manufacture. A generator may learn to produce representations that satisfy all of these conditions, in which case the relevant engineering problem will become easier.

I expect research on representations to continue to uncover different combinations of properties that matter for particular uses. The contribution may be difficult to see in the initial image. It may become clear only when someone tries to bend, assemble, or compute with the geometry.

## Editorial source notes

Reading leads: mesh topology, subdivision surfaces, deformation and rigging, mesh repair for fabrication, and collision representations. Use one concrete operation and a documented failure rather than implying a universal best topology.
