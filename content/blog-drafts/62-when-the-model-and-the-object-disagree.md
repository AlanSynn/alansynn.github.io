# When the Model and the Object Disagree

**Status:** English working draft | **Theme:** I. Craft, mechanisms, and fabrication | **Candidate tags:** computer-science, robotics

A digital model and a physical artifact can cease to describe the same object after the first hand adjustment. Someone sands a part so it moves more freely. The change can be a successful contribution to the design while leaving the original file unable to describe an important relationship in the resulting mechanism.

Many design tools are organized around the assumption that the file remains the source of the object. That assumption is reasonable when production is repeatable and the physical result closely follows the specification. It becomes less useful when people continually revise things by hand. A modification can be important even if it never enters the file.

Suppose the person wants to fabricate a second copy or change the length of a nearby part. The old model may no longer describe the object with which the new component must work. A scan can help capture the geometry, but geometry alone may not explain why a change was made. The maker may need a way to record the reason alongside the new shape.

A useful update could preserve the nominal dimension and record the measured dimension of the actual part. The nominal dimension may still be appropriate for future copies made under different conditions. The measured one may be necessary for fitting a new component to this particular object. Replacing one value with the other would discard a distinction the maker needs.

As more capable software connects design and fabrication, I expect this problem of keeping the two versions in relation to become easier to investigate. A tool could preserve the intended design, observations of the existing object, and the changes that link them. It could make clear which version a future operation will use.

A useful representation of an ongoing fabrication project could preserve the intended dimensions, the observed object, and the reasons for particular changes. The maker would then have a way to decide which of those properties the next part should fit. Keeping the two versions intelligible is more valuable than assuming that one must always replace the other.

## Editorial source notes

Reading leads: as-built modeling, reverse engineering, digital twins, design provenance, and mixed-reality fabrication. Distinct from 59: that essay concerns material-led discovery; this one concerns representation after a physical change.
