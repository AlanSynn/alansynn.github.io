# What the Sketch Was Trying to Say

**Status:** Long-form editorial manuscript | **Theme:** Craft, mechanisms, and fabrication | **Candidate tags:** participatory-design, computer-science

A motion sketch can be useful before a maker has decided exactly what they want the finished object to do. The sketch may express a clear desired path. It may also give the person a way to begin investigating a movement whose character becomes apparent only after watching a mechanism realize it.

The difference affects what a computational design tool should do. A fixed path can give a search algorithm a well-defined target. An evolving idea needs an arrangement in which the maker can reconsider the target as they examine possible results. I would like the tool to support both uses of the sketch.

## A maker begins with a possibility

Our research on [MotionSmith](https://doi.org/10.1145/3772318.3791545) involved working with three experienced makers of mechanical crafts. The system helps a maker sketch a motion, explore possible mechanisms, refine a candidate, and prepare parts for fabrication.

One of the concerns that informed its design was the relationship between the movement a person initially describes and the movement they ultimately make. A maker can discover a better way to express an idea while investigating the behavior of a physical mechanism. Treating the first motion as a fixed requirement can limit that process.

Consider the shy elephant in the published paper. The artist's idea developed through sketching and examining the figure's movements. A movement of the arm was part of an evolving conception that came to include the raising of a leg. The character of the motion emerged through working with the figure rather than through the computer's recovery of a completely determined target.

This is a useful observation because the motion sketch and the mechanism can affect one another. Someone may begin with a drawing of a hand moving along a path. After seeing a possible mechanism, they may decide that the hand should move differently. They may also discover that another part of the figure needs to move at the same time.

In a conventional optimization problem, a change to the target is a change to the problem being solved. In creative work, changing the target can be an important part of solving the problem. A system that expects the target to remain stable can make it difficult for the person to develop the design through the results they encounter.

## What does it mean to preserve an intention?

There is a tempting way to describe an ideal creative tool. We might say that it understands the person's intention and realizes it faithfully. The description is attractive, but it can conceal a difficult question. What is the person's intention at the moment they begin using the tool?

This account also changes what it means for a mechanism search to succeed. The search could return the closest feasible path and give the maker exactly the information needed to finish a specified design. It could also reveal an alternative that changes what the person wants to specify. A system designed for the second activity should preserve the possibility of returning from the search to the idea.

A person can have a clear reason to make something without having a clear idea of all its properties. An artist may want a figure to express hesitation. They might discover through trying several movements that a pause before a small movement is more interesting than the larger movement they initially imagined. A change in timing can help them understand what they wanted from the figure.

If the person had originally drawn only the spatial path, there may be little reason to expect the drawing to capture those possibilities. The drawing can be a useful representation even though it does not contain a complete specification of the experience.

I think a creative tool should help people maintain a productive relationship with such representations. It can support the parts of the intention that are clear, offer possibilities for the parts that are still open, and let the person change their understanding of both.

This does not require every input to remain negotiable. There may be a part of the object that needs to remain within a specified boundary, or a motion that needs to fit a particular physical arrangement. A person may also have a precise expressive reason to preserve one detail of a movement. A useful tool needs ways to distinguish those commitments from the things the maker wants to investigate.

## When a mechanism changes the idea

One interesting feature of the mechanism design process is that several physical arrangements can give a similar result. A linkage might produce a particular path. A cam could produce a related movement through a different relationship among its parts. The two arrangements can offer different possibilities for editing and making the object.

MotionSmith presents alternative mechanism families, along with a measure of how closely a candidate follows the sketched path. In the final sessions described in the paper, the artists paid comparatively little attention to the accuracy scores and examined the expressive behavior of the movement. They continued editing the mechanisms after selecting them.

The observation matters for how we interpret the purpose of candidate generation. A system could regard the best-scoring mechanism as the answer and present it alone. It could also make several candidates available because the person may learn something by examining their different behaviors.

There are circumstances in which presenting a single result is desirable. A person who has already specified the required behavior may be satisfied with a reliable realization. A large collection of alternatives can become tiring to examine. There is a design question about which alternatives are worth making visible and what information helps the person decide among them.

For automata making, the physical arrangement can matter as much as the appearance of the motion. A person may be able to understand and modify one mechanism more easily than another. Seeing how a mechanism works can give the maker a new idea about the movement. The result of the computational search becomes material for the next design decision.

This is why it can be useful to support movement between the stages of the workflow. If a person discovers a desirable property in a mechanism, they should have some way to bring that property into their evolving motion idea. If the desired movement changes, they should have a way to revise the mechanism without discarding everything they have already learned.

## A consequence for generative design

The same issue appears when people use more general generative tools. Someone describes a character, an object, or a scene in words. A system produces an interpretation. The person may recognize what they want only after encountering that interpretation.

Better models will become increasingly capable of inferring what someone is trying to express. That is an important improvement. I would also like those systems to support the occasions when the person has not yet formed a preference, or wants to reconsider the initial description.

Imagine an assistant that produces a mechanism exactly matching the first sketch. It may perform that task exceptionally well. Another assistant might also be able to show a few different realizations, let the person inspect their behavior, and help revise the sketch in response. The second arrangement can support a kind of inquiry the first arrangement does not require.

We need to study how those arrangements affect different people. A novice may benefit from suggestions that an expert considers unnecessary. A maker who understands the mechanism may want very specific control over the proposed alternatives. Someone with a precise goal may be frustrated by a system that keeps inviting them to reconsider it. The useful amount of exploration will depend on the person and the activity.

The useful amount of exploration depends on whether the maker has already established the motion they want, or is using the alternatives to discover it. A tool can satisfy a precise specification and make the specification itself available for reconsideration when that is what the work requires.

The sketch's first purpose may be to create a conversation between a maker and the possibilities the mechanism offers. Its success can become apparent when the maker knows something about the movement they want that they did not know when they drew it.

## Editorial source and claim notes

Checked MotionSmith, Section 4 (iterative workflow, candidate mechanism scores) and Section 5.2.1 (evolving elephant design, relative attention to scores and direct editing). [Public paper](https://alansynn.com/motionsmith/static/pdfs/motionsmith-chi-2026.pdf), [project page](https://alansynn.com/projects/motionsmith/). No invented artist quotations, personal observations beyond the published account, or new student-study details. Claims about future general-purpose systems are forecasts. Distinct from 51 (a specific filtering operation) and 19 (formation of a preference in a broader sense).

Editorial status: source-checked at the level stated above; author approval, independent human reading, and publication conversion remain pending.
