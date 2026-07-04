#import "/src/3rd_party/mathyml/lib.typ": *

_DoangJoo (Alan) Synn_

= Generative AI for Computational Design, Through the Lens of Automata

A maker sits down to build an automaton of an elephant that lifts its trunk. She can picture the motion, but to make it real she must choose a mechanism (a cam? a four-bar linkage?), size its links, and fabricate parts that fit together. Today's generative tools are little help here: they produce *images* of mechanisms, not working ones, and they pull her toward whatever the model finds easy to draw rather than toward what she set out to make. My research asks how we build generative systems that respect a maker's intent all the way from a sketch to a fabricable, moving object.

I work on this at the intersection of *computer graphics*, *motion synthesis*, and *computational design*, with mechanical automata as my primary testbed. Automata are an unusually demanding domain: the design has to be expressive (it moves the way the maker imagined), mechanically sound (it actually works), and fabricable (a hobbyist can make it). That triple constraint is exactly where current generative AI is weakest and where good tools would matter most.

== What I have built: MotionSmith

MotionSmith (CHI 2026) is a sketch-based design system for automata making, built with three expert makers over a year. A maker sketches the motion path she wants; MotionSmith generates candidate mechanisms (four-bar, cam-follower, gear), lets her compare and refine them on the canvas, and exports fabrication-ready files. The lesson I keep returning to is that generative AI helps most when it stays inside the maker's loop: proposing options, explaining trade-offs, and getting out of the way of judgment. It helps least when it tries to own the design.

That lesson drives the three problems I am working on next.

== Direction 1: Keeping human intent in the loop

When a maker asks for "an automaton whose trunk lifts slowly and pauses," a language model often returns something close-but-wrong, and the maker adapts her goal to the output instead of pushing back. Over a design session, intent drifts. I am building interaction models that keep the maker's original goal visible: surfacing what changed between her request and the result, and making it cheap to say "no, that is not what I meant" and steer back. The hard part is measuring intent and preserving it when the generative surface is seductive.

== Direction 2: Generative models for motion and mechanism design

Most generative work targets pixels and text; motion and mechanism design are under-served. I want models that generate not just an image of a mechanism but its *kinematics*: given a desired motion curve, propose linkages that produce it, and let the maker explore the space (faster or slower, simpler or stranger). This is a graphics-and-kinematics problem, and automata are a tractable sandbox before tackling full mechanical assemblies.

== Direction 3: Tools for non-expert makers

Prompting is a poor interface for mechanical design: it is brittle, it hides the relationship between input and output, and it asks the maker to speak the model's language. I want domain-specific interfaces that meet makers where they are: sketch-first, direct-manipulation, with the model steered by drawing rather than by rewording. Tangible-MakeCode (CHI 2025), which bridged physical coding blocks with a web interface for collaborative learning, informs this direction: the right physical-and-digital coupling can make computational ideas legible to people who would never write code.

== Why this matters

Generative AI is being sold as a way to bypass craft. I think the more interesting use is to support it: to help a maker get from an idea in her head to a working object in her hands, with her judgment intact at every step. Automata are where I am working that out, but the same loop (sketch to fabricable motion, under human intent) generalizes to robotics, animation, and design education.
