# What a Compiler Can Teach an AI Engineer

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, ai

A compiler can make a difficult transformation easier to reason about by representing a program in a form suited to that transformation. An intermediate representation gives the compiler a particular set of properties it can examine and operations it can apply. This provides a useful starting point for thinking about the architecture of an AI agent.

Consider how that choice of representation might matter to a language-model-based agent. Consider an agent that receives a request, interprets it, and produces an action. The entire process could occur within a model. It could also produce an intermediate description that another component can inspect or execute.

The value of such a description depends on what it preserves. A structured plan might make it easier to check whether certain operations are authorized. A geometric representation might support a test of whether a motion is feasible. A poorly chosen intermediate representation can make useful distinctions unavailable to the next component.

Consider a plan that separates the object a robot should move, the location it should reach, and the constraints that govern the movement. A geometric test could examine one part of the plan without having to resolve every ambiguity in the original request. If the person changes the purpose of the task, the representation must also support reconsidering the earlier interpretation.

We should not infer that agents must be designed like compilers. Language tasks, physical interaction, and creative activities often involve uncertainty and changing goals. The compiler analogy is useful because it encourages us to ask what information is needed at each stage and which properties should survive a transformation.

When a part of an agent's task requires verification, I would want to know which representation makes the relevant conditions available for examination. A learned representation may serve that purpose, or a more explicit structure may be useful. The design decision concerns what must survive the transformation for the next part of the system to do its work reliably.

## Editorial source notes

Reading leads: compiler intermediate representations and invariants; program synthesis and tool-using agents. Ground the analogy in one compiler transformation and one agent workflow. Do not claim learned internal representations have compiler-style formal guarantees.
