# The Experiment That Only Had to Fail Once

**Status:** editorial draft / argument development | **Theme:** Evidence after the scoreboard | **Candidate tags:** philosophy-of-science, robotics

A thousand successful trials and one failure can have very different meanings depending on the claim we made before running them. A paper that promises safety under every allowed condition has taken on a different obligation from a paper that reports how often a robot succeeds on a specified set of tasks.

Consider a hypothetical robot controller with a guarantee that it will keep a specified distance from a wall whenever its sensors and initial state satisfy stated assumptions. A reproducible trial in which those assumptions hold and the robot crosses the boundary would be a serious counterexample. We would need to examine the measurement and the implementation before deciding exactly what failed. But another thousand successful trials would not repair the universal claim.

Suppose instead that a paper reports a high success rate across a collection of sampled tasks. The same failure could belong to the remaining fraction of unsuccessful trials. We would need more evidence to estimate how often that kind of failure occurs, and whether the original sample represented the relevant conditions. A single observation can refute a universal statement. It cannot establish the frequency of an event in a population.

The reverse distinction matters for a working example. Demonstrating a motion under well-characterized conditions can establish feasibility, without establishing that a method can reliably produce it on a wider collection of inputs. These are legitimate but different kinds of knowledge.

The distinction also explains why one counterexample should sometimes change the language of a paper rather than discredit its entire contribution. A claim that holds under a narrower condition may remain scientifically useful. Specifying that condition is substantive progress if the explanation shows why it matters; simply excluding every failed case after the fact is not.

As agents become capable of searching for difficult cases, it may become inexpensive to find failures that a researcher would never have tried. The value of a discovered counterexample will depend on the claim it addresses. A robot operating outside its stated sensor range, for instance, does not contradict a theorem that explicitly assumes observations within that range. It might still reveal a serious practical limitation if the system will encounter those conditions in use.

I would like to see criticism organized around the promises a paper actually makes. A failure is scientifically consequential when it changes our reason to believe a claim or reveals the circumstances under which a result stops being useful. Its importance cannot be read directly from the number of times it happened.

## Source plan

Reading leads: falsification and counterexamples, software property-based testing, reachability and formal verification, and long-tail robot evaluation. Use a documented case of a falsified guarantee only after checking the guarantee and its scope; do not invent a real incident.
