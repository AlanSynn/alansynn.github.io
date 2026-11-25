# A Dataset Has a History

**Status:** English working draft | **Theme:** M. Research as a practice | **Candidate tags:** computer-science, ethics

A collection of successful robot grasps contains evidence about the way the objects were grasped. It may also contain evidence of instructions that the people collecting the data gave to participants. To understand what a model can learn from a dataset, we need to know something about the activity through which the examples were produced.

Consider a dataset of objects being picked up from a table. Some people may have been instructed to use only one hand. Some objects may have been selected because the camera could observe them easily. Failed attempts may have been excluded to provide cleaner examples. All of these choices can be reasonable for collecting examples of successful grasping. A system learning to recover from mistakes may need observations that this procedure excluded.

When datasets become widely reused, it is easy to forget the original activity through which they were produced. A model trained on demonstrations of successful grasps may encounter a person who expects it to recover from an unsuccessful grasp. The evidence it needs for that second task may have been removed during collection.

This is why the history of a dataset can be scientifically valuable. It helps another researcher identify what was observed, why it was observed that way, and which other situations remain open. It also helps people decide whether a new use of the data is appropriate for the people who provided it.

For example, a dataset collected from successful grasps could be appropriate for learning a nominal trajectory. A researcher investigating recovery from a failed grasp would need to know whether unsuccessful attempts were excluded and how they were identified. The documentation becomes useful through the relationship between those choices and the new learning task.

The examples in a dataset can be useful to a learner long after the collection conditions have been forgotten. Good documentation gives another researcher a way to determine whether an apparent regularity belongs to the task, to the way the task was arranged, or to a decision about which examples were worth keeping. That distinction can change the next experiment.

## Editorial source notes

Reading leads: Gebru et al., Datasheets for Datasets; data documentation, dataset lineage, and collection protocols. The grasp dataset is hypothetical. Extend using an actual datasheet and one downstream task.
