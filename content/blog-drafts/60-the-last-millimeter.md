# The Last Millimeter

**Status:** English working draft | **Theme:** I. Craft, mechanisms, and fabrication | **Candidate tags:** computer-science, robotics

A drawing of two parts can show that they fit together exactly. A physical object may need them to fit together with a little room to spare. The last millimeter can determine whether a mechanism moves at all.

A designer working in a digital environment can specify a hole and a shaft with precise dimensions. The fabricated hole may be slightly smaller than its digital counterpart. The shaft may change shape when it is cut or printed. If several parts introduce small deviations, the resulting assembly can behave quite differently from the one shown in simulation.

This makes tolerance an interesting part of a design representation. A nominal dimension describes the intended size. A tolerance describes some of the variation the design needs to accommodate. A maker may also have a local way of dealing with variation, such as sanding a joint until it moves smoothly. The design system should understand which of these practices it is supporting.

We can optimize for robust manufacturing, model variation, and generate parts with appropriate clearances. Those are exactly the sorts of technical problems that increasingly capable computation can address. The important question for a tool is how the maker encounters the remaining uncertainty. Can they see which joint is sensitive? Can they adjust it with the equipment they have? Do the suggested changes preserve the movement they wanted?

I think the difference between a beautiful mechanism on a screen and a reliable mechanism on a table often lives here. The digital representation is a beginning. The material object has to operate in a world where exact dimensions are an idealization.

## Editorial source notes

Reading leads: geometric dimensioning and tolerancing, tolerance stack-up, design for additive manufacturing, and practical linkage fabrication. No universal clearance value is implied; test actual material and process conditions.
