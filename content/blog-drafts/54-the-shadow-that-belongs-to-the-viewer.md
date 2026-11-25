# The Shadow That Belongs to the Viewer

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, robotics

A virtual object can appear to float above a table even when the system places its geometry at the correct height. A shadow can help the viewer recognize where the object meets the surface. The information a renderer presents and the information its geometric representation contains are different parts of an interactive system.

This is an interesting property of visual cues. They can communicate a relationship that is already present in the numerical description of a scene. The computer may know the position of the object with great accuracy. The person looking at the scene needs evidence of that position through the image.

The distinction matters for interactive environments. Consider a system that lets someone place a virtual mechanism onto a physical workbench. It must estimate the location of the bench, render the mechanism, and present information that lets the user understand how the two are related. A small rendering choice can make an accurate estimate difficult to interpret or make an inaccurate estimate appear convincing.

There are two plausible reasons a person might make a correct placement: the estimated geometry may be accurate, or the visual cues may make the intended relation easy to infer despite uncertainty. A study could vary the cues while keeping the geometry fixed. That would help establish which contribution the renderer has made.

A useful visual representation must therefore be evaluated partly through the decisions people make with it. Do they recognize where contact occurs? Can they notice a misalignment? Does the cue remain useful when the lighting or viewpoint changes? Perceptual realism and correct physical registration both matter, but they are distinct achievements.

A useful rendering can help someone make a better spatial judgment, even when the change does not improve the underlying estimate of geometry. That is an opportunity for graphics research. It asks us to understand how a visual relationship becomes evidence to the person who needs to act on it.

## Editorial source notes

Reading leads: perceptual studies of cast shadows and depth, augmented reality registration, and visualization of spatial uncertainty. Use a controlled comparison of contact cues and distinguish visual plausibility from alignment accuracy.
