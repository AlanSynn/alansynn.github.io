# The Simulator Has a Point of View

**Status:** editorial draft / argument development | **Theme:** Embodied intelligence | **Candidate tags:** robotics, philosophy-of-science, ai

A simulator gives a researcher a world in which certain things can happen. The range of events it supports determines which questions the researcher can investigate through it. I think this is an important part of understanding simulation as a research instrument.

Consider a simulator for a robot that picks up unfamiliar objects. We might vary the shapes, textures, lighting, and friction of the objects. These changes can provide useful experiences for learning a behavior that needs to work under different conditions. A visually unrealistic scene may even be helpful if the variation it provides encourages a policy to rely on properties that remain useful outside the simulator.

Tobin and colleagues' work on domain randomization is an example of this idea. Their research investigates the transfer of a visual localization capability from varied simulated scenes to real observations. The purpose of varying the simulated images was connected to the behavior the system needed to perform in the physical world.

A different issue arises when a property is missing from the representation entirely. If the simulator treats every object as rigid, changing the friction of an object will not expose the robot to the way a flexible object deforms when grasped. The researcher needs either a representation of that behavior or a reason to believe that it is irrelevant to the intended task.

A rigid-object simulator could still teach a robot a useful approach to a flexible object if the task never depends on the deformation. An omitted property becomes a limitation when the claim relies on behavior that the property would change. We should establish which part of the learned behavior is meant to transfer before deciding how much fidelity the simulation needs.

This is why I would like evaluations of simulation to make clear which properties of the task the simulated experiments are intended to investigate. Increasingly powerful learned simulators may include behaviors that were previously difficult to model. Improving their fidelity can also enter automated research loops. The important condition is whether the resulting representation supports the particular interventions and observations through which a claim is supposed to be established.

A simulator can be an excellent approximation for one purpose and a poor instrument for another. The fact that it produces a large number of trials tells us little about the possibilities it has omitted. Before drawing a conclusion from a simulated world, I would want to understand which parts of the real problem were allowed to vary inside it.

## Source plan

Checked: [Tobin et al., Domain Randomization for Transferring Deep Neural Networks from Simulation to the Real World](https://arxiv.org/abs/1703.06907); [Muratore et al., Robot Learning from Randomized Simulations: A Review](https://arxiv.org/abs/2111.00956) (abstracts). Reading leads: models as scientific instruments and sim-to-real validation. Distinct from The World Cannot Always Be Reset: this concerns what can be represented, not what repeated trials cost.
