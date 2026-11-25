# The Robot That Can Explain Its Failure

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, computer-science, ai

When a robot drops an object, an explanation such as “I failed to maintain a stable grasp” is usually easy to accept. It may also tell us very little. Was the object more slippery than expected? Did the gripper close on the wrong surface? Did the robot move too quickly?

These explanations suggest different repairs. One might change the grasp position, another the force, and another the trajectory. If the robot can identify which repair would address the problem, its explanation becomes useful to the next attempt.

Language models make it possible for a system to describe a failure fluently. The difficult part is connecting the description to evidence from the event. A useful account could point to an observation, indicate an uncertain part of the state, and propose a way to distinguish among plausible causes. Sometimes there will be too little information to settle the explanation.

This is an important distinction when we study explainable robots. A convincing sentence and a reliable diagnosis can look similar in a transcript. Their difference becomes visible when someone uses the explanation to change the system. The explanation should help that person understand what happened and what could be tried next.

Automated diagnosis is itself a task that agents may become exceptionally good at. That makes it worth developing better accounts of the evidence they use. I would like a robot to be able to say what it observed, what it inferred, and what remains uncertain about a failure. Such an explanation makes the next investigation possible rather than giving the impression that the investigation is already over.

## Editorial source notes

Reading leads: fault diagnosis, causal attribution, robot explanations, and uncertainty calibration. Compare two plausible failure diagnoses against recorded observations and a controlled intervention; avoid confusing explanation fluency with causal validity.
