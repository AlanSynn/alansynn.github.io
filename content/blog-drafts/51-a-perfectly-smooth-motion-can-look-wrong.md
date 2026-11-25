# A Perfectly Smooth Motion Can Look Wrong

**Status:** Long-form editorial manuscript | **Theme:** Graphics, vision, and perception | **Candidate tags:** computer-science, participatory-design

In [MotionSmith](https://doi.org/10.1145/3772318.3791545), three experienced automata artists used a smoothing control while developing movements. Two used it to reduce irregularities in their drawings. The third tried it and chose to retain some of the roughness. The same operation had a different expressive purpose for each of them.

A smooth path can be easier to work with when synthesizing a mechanism. It can also produce a different kind of movement from the one a maker finds interesting. The observation gives us a reason to separate the technical effect of smoothing from the quality of the movement the artist is trying to create.

## When a filter becomes part of making a movement

MotionSmith lets a maker sketch a motion path for part of a character and see the movement on the canvas. The system offers a smoothing control. A maker can inspect the effect of reducing irregularities in the path and adjust the amount of smoothing.

For a person trying to describe a movement through a drawing, this is a useful operation. It can help the person obtain the path they wanted without having to draw it with great precision. It also gives the mechanism generation stage a more manageable representation of the intended motion.

In the final design sessions described in Section 5.2.1 of the paper, two of our three participating artists used smoothing to reduce irregularities. The third artist tried the control and chose to retain some roughness in the movement. The quality he was developing was better served by keeping some of the variation that smoothing would remove.

I do not want to generalize too much from three people. The interesting part of the observation is that it provides a specific example of a distinction that a conventional account of the operation would miss.

Imagine defining the amount of irregularity in a drawn path and asking how well a filter reduces it. We can evaluate many filters and obtain useful results. Under a defined model of unwanted variation, some filters may be much more effective than others. The evaluation does not tell us whether the artist wants that variation removed.

The distinction can be understood through the activity. Someone is creating a figure that makes a particular movement. The person uses the computational operation as part of investigating the movement. At one moment, the operation helps them express something they were unable to draw accurately. At another moment, its effect becomes something they choose to reject.

## Smoothness has several meanings

The word smooth is particularly interesting in this setting. A curve can be smooth according to its mathematical properties. A movement can have a velocity that changes gradually. A joint can move smoothly because there is little friction. A person watching the result can describe it as smooth because the movement looks continuous and feels easy to follow.

We can make the distinction concrete by comparing two paths with identical geometry but different timing. A pause in one of them changes the experienced gesture without changing the spatial curve. Likewise, removing a corner from a curve could alter a motion even when the average speed remains similar. The operation and the property it affects need to be specified separately.

These descriptions concern related properties. They are not interchangeable. If I smooth the shape of a curve without considering the speed at which a character moves along it, I may still produce a very abrupt movement. If I change the timing without changing the path, I can make the same movement feel hesitant or decisive.

For a physical automaton, the problem is more complicated. A maker needs a mechanism that can realize the chosen behavior. A change that is difficult to distinguish visually may make the mechanism easier to build. A path that looks good in the animation may require parts that the maker cannot easily fabricate.

All of these conditions deserve attention. A person might choose a mathematically simpler movement because it supports a useful physical construction. They might choose a different timing because it conveys something about the character. The purpose of the tool is to help them understand the consequences of those decisions while making the object.

It is easy to treat the desirable qualities of motion as if they formed a list of technical objectives to be maximized. Sometimes this is a reasonable description of the problem. We may have a motor that needs to operate within specified limits, or a mechanism that must avoid particular collisions. There can be excellent reasons to automate those decisions.

In the expressive part of a design, we may need a different arrangement. The system can offer changes that the maker can inspect and compare. The person can use their experience of the movement to decide which qualities are desirable.

## Looking at what a change does

Suppose I am building a system that automatically produces a smoother path. I could report how much the system reduces a measure of irregularity, and how closely the output follows the original path. That would be an understandable evaluation of the computational operation.

If I also want to claim that the system helps people create more expressive movements, I need to examine another relationship. I want to know what kinds of changes the people were trying to make, what the tool made visible to them, and how they responded to the results.

The two evaluations can complement one another. A numerical result can help explain the properties of the filter. Observing a person use the control can help us understand when those properties are useful and when a different change might be desirable.

It can be particularly valuable to preserve the original path and the proposed alternative so that the person can inspect the difference. This turns the operation into a small experiment. The maker can discover what the movement loses or gains through the change rather than merely accept the system's decision.

The idea extends beyond smoothing. An animation tool can produce a path with less deviation from an example, or adjust a movement to make it look more realistic. A fabrication tool can reduce the complexity of a physical part. In each case, it is useful to ask which qualities the change is expected to preserve and whether the maker has another reason to prefer the original.

We may eventually have models that are very good at predicting those reasons. They may learn from many examples of artists' choices and suggest appropriate variations. I welcome that possibility. I think some of the most interesting questions will remain around the experience of discovering what we want through the alternatives we encounter.

A maker may prefer something they did not expect to prefer. A tool can help make that discovery possible.

## The character of a movement

A good automaton needs to move. Once it can move, a person has many ways to make the movement interesting. The movement can feel like a little effort, a moment of surprise, or a repeated gesture with a particular rhythm. Different figures can invite entirely different choices.

The value of increasingly powerful motion tools may become particularly visible in the range of qualities a maker can investigate. They can use a smoother path when it helps express an idea, preserve some variation when it gives a movement its character, and discover a reason to prefer either through watching the result.

A useful evaluation of such a tool needs to account for both what its operations do and what people can make with them. Smoothness can be defined, measured, and optimized. Whether the resulting motion is worth making depends on a further question about the movement itself.

## Editorial source and claim notes

Checked MotionSmith Sections 4.1 and 5.2.1: smoothing and raw-path inspection, different use by LL/MH and TH, and expressive pacing. [Public paper](https://alansynn.com/motionsmith/static/pdfs/motionsmith-chi-2026.pdf). Three experienced artists, qualitative situated observation. No claim of measured population preference or superior smoothness algorithm. The distinction between geometric and temporal smoothness is a conceptual explanation, not a report of an additional experiment. Distinct from 57: this essay analyzes the meaning of a particular operation, not the evolving role of the target sketch.

Editorial status: source-checked at the level stated above; author approval, independent human reading, and publication conversion remain pending.
