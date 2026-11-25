# A Dataset Has a History

**Status:** English working draft | **Theme:** M. Research as a practice | **Candidate tags:** computer-science, ethics

A dataset of people performing a task appears to contain information about how people perform that task. It also contains information about how someone asked them to perform it, which people were available, which recordings were kept, and how the activities were labeled.

Consider a dataset of objects being picked up from a table. Some people may have been instructed to use only one hand. Some objects may have been selected because the camera could observe them easily. Failed attempts may have been excluded to provide cleaner examples. All of these choices can be reasonable. They also affect what a learning system can infer from the data.

When datasets become widely reused, it is easy to forget the original activity through which they were produced. A model trained on demonstrations of successful grasps may encounter a person who expects it to recover from an unsuccessful grasp. The evidence it needs for that second task may have been removed during collection.

This is why the history of a dataset can be scientifically valuable. It helps another researcher identify what was observed, why it was observed that way, and which other situations remain open. It also helps people decide whether a new use of the data is appropriate for the people who provided it.

Larger datasets and better generation methods can address many gaps. They make it increasingly important to understand the origins of the examples that give a model its capabilities. The same label can refer to activities produced under very different circumstances.

## Editorial source notes

Reading leads: Gebru et al., Datasheets for Datasets; data documentation, dataset lineage, and collection protocols. The grasp dataset is hypothetical. Extend using an actual datasheet and one downstream task.
