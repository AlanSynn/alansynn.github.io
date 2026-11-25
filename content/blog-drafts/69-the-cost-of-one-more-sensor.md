# The Cost of One More Sensor

**Status:** English working draft | **Theme:** J. Robotics, control, and situated intelligence | **Candidate tags:** robotics, computer-science

When a robot cannot distinguish two situations, adding a sensor can be an appealing solution. A camera can provide another view. A force sensor can reveal contact. In the laboratory, the extra information may make the problem much easier.

An installed sensor also becomes part of the system someone has to operate. Its observations need to remain aligned with the robot. It may introduce calibration work, extra cables, fragile connections, or new failure modes. In a shared space, it may collect information that people would prefer not to provide. The design choice extends beyond the accuracy obtained in the original experiment.

The interesting question is how much knowledge the new sensor makes available, and when that knowledge is necessary. Suppose a robot occasionally needs to know the precise position of an object. It might carry another sensor everywhere. It might also move to a better observation point when the information is needed. These approaches distribute complexity differently between the hardware and the behavior of the robot.

This suggests a useful kind of comparison. We could examine what the robot must observe, which situations make the current observations insufficient, and what each proposed sensing arrangement requires to remain useful over time.

As automated design makes it easier to optimize perception, I expect more of these trade-offs to become explicit. A sensor can be an excellent addition even when it introduces substantial cost. But we should understand the system that needs the information, rather than equating more information with a better machine.

## Editorial source notes

Reading leads: sensor fusion, active perception, observability, calibration and sensor maintenance, privacy in HRI. Compare actual sensor arrangements and lifecycle obligations rather than claiming a universal preference for fewer sensors.
