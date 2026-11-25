# The Reader Has No Context Window

**Status:** Long-form editorial manuscript | **Theme:** Writing, explanation, and representation | **Candidate tags:** philosophy-of-science, computer-science

I can sometimes understand every word in a sentence and have little idea what the sentence means. The difficulty is often that the author has compressed relationships I have not yet learned to recognize. A short account may ask more of me than a longer one.

Consider an interface for intent-preserving mechanism refinement. Someone familiar with computational design may understand the term immediately. Another reader needs to know what is being refined, whose intention matters, and what counts as preserving it. We could give them an account of a maker who sketches a movement, sees the motion of a mechanism, and revises the design while keeping it mechanically feasible. The reader now has an activity through which the term can acquire meaning.

Writing should give readers a way to develop the understanding that allows them to use a technical expression. The number of words needed to do that can differ considerably from the number of words required to state the expression.

## Shorter text, longer work for the reader

A recent paper by Thomas Hikaru Clark, Matias B. Martin, and Kyle Mahowald, [Why is AI-generated language so hard to understand?](https://arxiv.org/html/2610.29162v1), examines a concern I have had about language model writing. In addition to generating considerable amounts of text, some recent systems produce sentences that seem to pack several ideas into a small space.

The authors investigate linguistic properties that previous research has associated with difficulty in processing language. Among these are long distances between grammatically related words, uncommon sequences of words, and constructions that require a reader to determine which noun is doing what. They find differences between outputs of the models they examine and the human texts and paraphrases with which those outputs are compared. The differences vary with model and type of text.

The paper also explores a possible explanation. A system optimized in part for producing useful information under a cost for length may acquire a preference for compressed constructions. The authors' experiment with a length penalty produces changes in the model's linguistic choices consistent with that possibility. It is a proof of concept, rather than an account of the training history of every model.

Another preprint, Kamer Cekini and colleagues' [The Cognitive Cost of LLM Writing](https://arxiv.org/html/2610.23715v1), examines paired human-written articles and machine-generated rewrites. They use a model trained on eye-tracking data to estimate reading times. The machine rewrites tend to contain fewer words, while the predicted cost of reading an individual word is higher. Predicted total reading time is slightly lower on average. That distinction is important. The work does not show that readers actually spend more time on every machine-written article.

Both studies give us reasons to examine what happens when we make text shorter. They do not tell us how to write a particular essay well. To do that, I think we need to consider the work that a person performs while reading it.

## Give the reader something to think about

Imagine teaching someone the difference between the shape of a motion and its timing. We could begin by defining a spatial trajectory and a temporal parameterization. There is nothing wrong with those terms. But someone who has never thought about the distinction may have difficulty understanding why it matters.

I might begin instead with a figure that raises its hand. We draw the path that the hand should follow. Then we play the movement once quickly, and once with a pause at the top. The hand has passed through the same places. The movement has acquired a different character. We can now name the two properties we have been changing.

This is an important part of explaining technical work to me. The reader needs an object through which a new distinction can become intelligible. That object may be a drawing, a familiar activity, a mathematical example, or a result from a paper. Its purpose is to give the reader a place to put the concept.

Once the concept is understood, a precise technical term can become a shared resource. Specialists use terms economically because they know the activities and distinctions those terms represent. The problem arises when a writer borrows that economy before the reader has acquired the knowledge on which it depends. We can use the term to develop a more complicated argument once its meaning is available to the reader.

The problem with introducing the term too early is that the reader has to guess what resource it is supposed to provide. Introducing several terms in the same sentence compounds the problem. By the time a reader understands the last one, they may have forgotten how it was connected to the first.

This helps explain why writing that is appropriate for a specialist can be difficult for another reader. In systems research, I can use the word throughput without explaining the idea of completing many operations over time to another systems researcher. In an essay that also concerns the experience of a person using the system, I may need to show how that measurement relates to the activity before continuing.

## Where the paragraph is going

There is another difficulty that does not appear at the level of an individual sentence. I can read a paragraph whose sentences are clear and still find myself wondering why I am being told any of these things together.

A paragraph should help me make a particular step in understanding an argument. Its first few sentences can establish the object or problem. The rest can explain the relation that the writer wants me to notice. Sometimes an observation needs a qualification. Sometimes the paragraph needs to give a reason why another interpretation is less convincing.

The reader should not have to infer the entire argument from a collection of plausible statements. For example, an essay about AI in education might mention personalized learning, the changing role of teachers, the importance of community, and the danger of reducing education to scores. These are all interesting topics. Putting them in the same paragraph does not yet establish a relationship among them.

A more useful account might begin with a student who receives a good explanation from a tutoring system. We can understand that achievement. We can then ask what else happens to the student over the course of a school day, and why the quality of the explanation tells us relatively little about those other activities. The larger argument can grow from the distinction we have introduced.

This takes longer to write. It also takes some willingness to leave interesting related ideas for another place in the essay. I often find that the way to improve a dense paragraph is to remove one of its arguments rather than replace its sentences with shorter ones.

## The limits of a writing score

A number of linguistic measures can help us examine writing. We can count long sentences, identify uncommon words, and investigate the structure of clauses. Such observations can reveal habits that are worth reconsidering. The studies I mentioned earlier are good examples of why those habits deserve attention.

I would be reluctant to optimize an essay directly against one of these measures. A long sentence can be easy to understand when its relationships have been established. A short sentence can be difficult when it introduces an unfamiliar abstraction. A common word may be less useful than a technical term with a precise meaning. A document can score well on a readability formula while presenting its ideas in an order that makes little sense.

This is an interesting instance of the larger problem of evaluation. A measure of reading difficulty can tell us about some properties of the text. The activity we want to support is a person developing an understanding of an argument. The relation between the measure and that activity depends on the person, the subject, and the purpose of reading.

We should investigate actual reading experiences when we can. Ask a reader to explain the central claim after a section. Ask where they began to lose track of the argument. Find out whether they can apply a distinction to a new example. These are different questions from whether the sentences look simple.

A good explanation can give us a difficult question to think about. It can demand sustained attention, introduce unfamiliar ideas, and make us reconsider something we believed. The useful difficulty lies in thinking about the subject. I would prefer not to spend that attention recovering relationships that the author could have established more clearly.

The reader has come to the essay with a world of their own knowledge. Writing is the work of giving them a way to connect that world to the one the essay is trying to explain.

## Editorial source and claim notes

Checked Clark et al. (October 2026, arXiv:2610.29162v1), abstract, sections 3–4 and limitations heading; the observed features correlate with difficulty, not direct comprehension measurements. Checked Cekini et al. (October 2026, arXiv:2610.23715v1), abstract and analysis structure: 496 paired articles, predicted per-word time higher, total time slightly lower. Both are preprints. All proposed examples and reading exercises are original hypothetical illustrations; no actual reader test is claimed. Keep this article separate from draft 42, which concerns the structure of a research introduction.

Editorial status: source-checked at the level stated above; author approval, independent human reading, and publication conversion remain pending.
