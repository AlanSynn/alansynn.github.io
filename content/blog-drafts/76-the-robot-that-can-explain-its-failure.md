# The Robot That Can Explain Its Failure

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, computer-science, ai

The explanation that a robot dropped an object because its grasp was unstable leaves several useful questions unanswered. Was the grasp poorly positioned? Was there less friction than anticipated? Did the motion place a larger load on the grasp than the robot expected? Each account suggests a different change to the system.

These explanations suggest different repairs. One might change the grasp position, another the force, and another the trajectory. If the robot can identify which repair would address the problem, its explanation becomes useful to the next attempt.

Language models make it possible for a system to describe a failure fluently. The difficult part is connecting the description to evidence from the event. A useful account could point to an observation, indicate an uncertain part of the state, and propose a way to distinguish among plausible causes. Sometimes there will be too little information to settle the explanation.

The distinction matters when an explanation is meant to support diagnosis. A convincing sentence and a reliable diagnosis can look similar in a transcript. Their difference becomes visible when someone uses the explanation to change the system. The explanation should help that person understand what happened and what could be tried next.

A report could distinguish the observed event from its explanation. For example, the gripper's measurement changed shortly before the object slipped. The robot might infer that contact was lost and suggest inspecting the grasp. If the evidence cannot distinguish a poorly positioned grasp from a change in friction, both explanations should remain open.

An explanation is particularly useful when it lets someone decide what to inspect next. The robot might point to a measurement, identify two plausible causes, and propose an observation that could distinguish them. We can then examine whether the account helps correct the failure, rather than assess only whether the account sounds convincing.

## Editorial source notes

Reading leads: fault diagnosis, causal attribution, robot explanations, and uncertainty calibration. Compare two plausible failure diagnoses against recorded observations and a controlled intervention; avoid confusing explanation fluency with causal validity.
