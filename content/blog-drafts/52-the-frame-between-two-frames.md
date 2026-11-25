# The Frame Between Two Frames

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, philosophy-of-science

A video can preserve the positions of an object at several moments while leaving its movement between those moments uncertain. A wheel that appears to rotate backward in a recording illustrates the problem: the observed sequence is compatible with more than one actual motion.

The ambiguity extends to generated and reconstructed motion. A sequence of accurate frames does not always tell us how the world moved between the frames. A method may match all the observations while assuming a different trajectory, contact event, or velocity profile from the one that produced them.

The ambiguity becomes relevant when an animation is used as more than a video. Suppose someone wants to slow it down, render it at a different frame rate, or design a mechanism that realizes the depicted movement. The intermediate states now matter. A representation that only supports a sequence of attractive observations may not provide enough structure for these operations.

The ability to render additional frames is not by itself evidence of a recovered trajectory. Several continuous motions can agree with the observed samples. More observations, known constraints, or a prior about plausible movement can reduce that ambiguity. Each provides a different reason for accepting the resulting interpolation.

There are several ways to address this problem. We can sample more frequently, introduce knowledge about possible motion, observe additional signals, or allow several explanations of the observed sequence. Each changes what we can reasonably claim about the result. A plausible interpolation should remain distinguishable from a recovered physical trajectory.

For a fixed playback rate, a plausible sequence of frames may be all that a project requires. A designer who wants to change the rate, model the mechanism, or inspect a contact event has another reason to care about what happened between frames. The representation is useful to the extent that it supports that later inquiry.

## Editorial source notes

Reading leads: temporal sampling and aliasing, motion blur, optical flow, and continuous-time scene representations. Demonstrate the ambiguity with a synthetic rotating pattern rather than a fabricated experimental result.
