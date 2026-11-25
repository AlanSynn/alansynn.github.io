# When the Camera Becomes Part of the Method

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, philosophy-of-science

Take a photograph of a small sculpture from one side. Now take a second photograph from the opposite side. A detail that seemed to belong to the surface in the first photograph may turn out to be a hole. The sculpture did not change. The opportunity to learn something about it did.

In graphics and computer vision, the camera often appears as an input to a method or a way to show its result. I think it is worth treating the camera as part of the scientific instrument. Its position, motion, field of view, and relation to the object determine which properties can be observed. Two methods that receive different views may be solving substantially different problems.

Imagine evaluating a method that reconstructs a three-dimensional object. A convincing rendering from the input view tells us something about the reconstruction. It tells us less about the back of the object. Moving to a new view changes the question from whether the image looks right to whether the inferred structure supports another observation. Moving the camera in a carefully chosen way can help distinguish two explanations of the same image.

This suggests a different use of demonstrations in graphics papers. Rather than selecting a camera path only to make the result attractive, we can choose paths that reveal the properties claimed by the method. The same idea applies when the user is allowed to move the camera. An exploratory view can reveal an assumption that a prepared sequence conceals.

A beautiful view has value in its own right when the task is to produce that view. The problem is to know when the view is also being used as evidence about a world beyond the frame.

## Editorial source notes

Reading leads: structure from motion, multi-view geometry, and novel-view synthesis evaluation. Compare a known input view with a withheld view in a specific reconstruction paper. This draft concerns acquisition and inspection geometry, not the general argument for visual evidence in draft 01.
