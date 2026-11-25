# The Simulator Has a Point of View

**Status:** editorial draft / argument development | **Theme:** Embodied intelligence | **Candidate tags:** robotics, philosophy-of-science, ai

A simulator is often described as a less expensive world in which a robot can learn. Its most consequential property may be that someone has already decided what kinds of things can happen inside it.

## Working argument

A simulator represents physical properties and their interactions. It selects which variables can change, which relationships are modeled, and which phenomena will remain outside the simulated world. This is a form of epistemic selection. Its assumptions determine what evidence a simulated experiment can produce.

Domain randomization illustrates why realism is not simply a matter of visual resemblance. Tobin and colleagues showed that deliberately varied simulated appearances could support object localization on real hardware. A simulator may be useful precisely because it represents a range of variation broader than a single realistic-looking scene. Yet randomizing a parameter presupposes that the parameter and its relevant consequences exist in the simulation.

A future agent may discover powerful policies in simulated worlds and help improve the simulators themselves. The claims that emerge from those worlds will still have boundaries. A simulator of a household can represent moving furniture and uncertain friction while omitting the fact that a family has disagreements about where an object should be placed. Better physics does not automatically settle the scope of the task.

I would like the essay to treat simulators as scientific instruments with explicit claims of adequacy. They can reveal mechanisms, permit interventions, and support generalization. They also organize ignorance by deciding what is representable.

## Challenge

High-fidelity and learned simulators can capture previously omitted phenomena, and transfer can be assessed empirically. The argument must remain about representational scope, rather than an assertion that simulation will always lag behind a fixed human capability.

## Source plan

Checked: [Tobin et al., Domain Randomization for Transferring Deep Neural Networks from Simulation to the Real World](https://arxiv.org/abs/1703.06907); [Muratore et al., Robot Learning from Randomized Simulations: A Review](https://arxiv.org/abs/2111.00956) (abstracts). Reading leads: models as scientific instruments and sim-to-real validation. Distinct from The World Cannot Always Be Reset: this concerns what can be represented, not what repeated trials cost.
