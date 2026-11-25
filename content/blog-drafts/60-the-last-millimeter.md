# The Last Millimeter

**Status:** English working draft | **Theme:** I. Craft, mechanisms, and fabrication | **Candidate tags:** computer-science, robotics

Two parts can meet perfectly in a digital model and fail to move together after fabrication. The shaft may be slightly larger than expected or the hole smaller. When the operation depends on the clearance between the parts, small differences from the ideal geometry can change whether the mechanism works.

A designer working in a digital environment can specify a hole and a shaft with precise dimensions. The fabricated hole may be slightly smaller than its digital counterpart. The shaft may change shape when it is cut or printed. If several parts introduce small deviations, the resulting assembly can behave quite differently from the one shown in simulation.

This makes tolerance an interesting part of a design representation. A nominal dimension describes the intended size. A tolerance describes some of the variation the design needs to accommodate. A maker may also have a local way of dealing with variation, such as sanding a joint until it moves smoothly. The design system should understand which of these practices it is supporting.

For a simple shaft and hole, the smallest possible clearance depends on the largest shaft and smallest hole permitted by their dimensional ranges. A model containing only nominal dimensions cannot establish that clearance. The calculation can guide the design, but the relevant ranges need evidence about the actual material and fabrication process.

We can optimize for robust manufacturing, model variation, and generate parts with appropriate clearances. Those are exactly the sorts of technical problems that increasingly capable computation can address. The important question for a tool is how the maker encounters the remaining uncertainty. Can they see which joint is sensitive? Can they adjust it with the equipment they have? Do the suggested changes preserve the movement they wanted?

An account of the mechanism's geometry should give the maker a way to understand the variations the construction can tolerate and where an adjustment may be needed. The final millimeter is interesting because it connects a precise digital relationship with the capabilities of a physical process. A tool that helps people work with that relationship has contributed more than an accurate drawing.

## Editorial source notes

Reading leads: geometric dimensioning and tolerancing, tolerance stack-up, design for additive manufacturing, and practical linkage fabrication. No universal clearance value is implied; test actual material and process conditions.
