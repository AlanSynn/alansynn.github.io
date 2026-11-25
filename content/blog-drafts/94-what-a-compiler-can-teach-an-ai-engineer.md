# What a Compiler Can Teach an AI Engineer

**Status:** English working draft | **Theme:** L. Software, systems, and engineering judgment | **Candidate tags:** computer-science, ai

A compiler translates a program into another form that a machine can execute. In the process, it often creates intermediate representations. Those representations give the compiler opportunities to examine relationships in the program and apply transformations without having to reason about every part of the source language at once.

There is a useful lesson here for people building systems with language models. Consider an agent that receives a request, interprets it, and produces an action. The entire process could occur within a model. It could also produce an intermediate description that another component can inspect or execute.

The value of such a description depends on what it preserves. A structured plan might make it easier to check whether certain operations are authorized. A geometric representation might support a test of whether a motion is feasible. A poorly chosen intermediate representation can make useful distinctions unavailable to the next component.

We should not infer that agents must be designed like compilers. Language tasks, physical interaction, and creative activities often involve uncertainty and changing goals. The compiler analogy is useful because it encourages us to ask what information is needed at each stage and which properties should survive a transformation.

More capable models may learn to generate, examine, and revise their own representations. I expect this to create opportunities for system design. A good architecture might allow the parts of an activity that can be verified or optimized to be handled through suitable representations, while leaving the other parts open to further interpretation. The choice of representation shapes what the system can reliably do next.

## Editorial source notes

Reading leads: compiler intermediate representations and invariants; program synthesis and tool-using agents. Ground the analogy in one compiler transformation and one agent workflow. Do not claim learned internal representations have compiler-style formal guarantees.
