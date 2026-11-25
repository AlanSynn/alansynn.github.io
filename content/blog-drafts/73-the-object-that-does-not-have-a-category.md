# The Object That Does Not Have a Category

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, ai

A robot may recognize that a particular object can help lift a loose lid without knowing the object's name. The relevant evidence might be a thin edge, a rigid surface, or a shape that can be grasped safely. In this situation, the useful kind of recognition concerns a property that several differently named objects can share.

The example separates two useful functions of object recognition. A category can provide a useful starting point for understanding what an object might do. The actual task may depend on properties that cross categories: a thin edge, a rigid surface, a particular length, or a way of being held.

A system that relies too heavily on names could overlook a useful object. Another system might investigate its geometry and material but fail to recognize the purpose of the action. A capable agent needs to connect these descriptions rather than assume that one kind of recognition is enough.

There are limits to improvisation. A tool that looks appropriate may be fragile, sharp, or unsuitable for a particular load. The system needs enough evidence to determine whether using it is permissible. We should not reward a creative choice that ignores important physical or safety constraints.

An evaluation should make clear what the robot can safely establish about an unfamiliar object's suitability. It might recognize a promising geometric property and still need evidence about rigidity or grip. Selecting a plausible candidate is a useful intermediate result; successful and permissible use requires more.

To examine this capability, give the robot an unfamiliar object in a controlled, benign task and ask whether it can identify a usable property. Keep the physical and safety constraints explicit. A successful result would tell us something about how the robot relates visual and physical observations to a purpose, beyond the accuracy of its category labels.

## Editorial source notes

Reading leads: affordance-based tool use, open-vocabulary recognition, shape-based grasping, and functional object representations. Use benign and controlled tool-substitution tasks. Distinct from 68: the focus is discovering functions beyond an object's category.
