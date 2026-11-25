# A Perfectly Smooth Motion Can Look Wrong

**Status:** English working draft | **Theme:** H. Graphics, vision, and perception | **Candidate tags:** computer-science, participatory-design

One tempting way to improve a hand-drawn movement is to smooth the path. The change can remove small errors introduced while drawing. But it can also remove a quality the maker wanted to keep.

In the final design sessions reported in [MotionSmith](https://doi.org/10.1145/3772318.3791545), the three artists used a smoothing control in different ways. Two used it to reduce irregularities in their sketches. One tried it and chose to keep some of the roughness, which suited the playful motion he was developing. This was a small study of expert makers. The observation is valuable because it shows that the same computational operation can serve or disrupt a creative intention.

The apparent technical problem is easy to describe. A sampled curve contains rapid changes that a filter can reduce. The design question is harder. Which changes belong to the noise of drawing, and which belong to the character of the motion? The maker may not know the answer until seeing the result.

This is a reason to make the effects of a computational operation available for inspection and revision. A useful tool can present a smoother path while retaining the original, or allow the person to decide which region to change. More capable automation may also learn to distinguish intentional irregularities from unwanted ones. A person should still be able to discover that they like an alternative they had not originally intended.

The difficult part of expressive motion often lies in deciding what an apparent defect means. A small jerk can look awkward in one movement and delightful in another. The same numerical improvement does not have the same value in both cases.

## Editorial source notes

Checked source: MotionSmith, Section 5.2.1, [paper](https://alansynn.com/motionsmith/static/pdfs/motionsmith-chi-2026.pdf). Avoid extending the three artists' choices to a population claim. Reading leads: animation timing, movement stylization, and non-destructive curve editing.
