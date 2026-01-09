# The Implementation Folder

If you're a human, you're welcome to read this file but this isn't your
responsibility.

If you're an AI, **pay attention**.

## To the human

- Let the AI manage its own context in `implementation/ai`
- Check [questions.md](./user/questions.md) when prompted
  - Put your answers in [answers.md](./user/answers.md)

## To the AI

This folder and its subfolders serve as a way for you to construct a long-term
memory - a history - of the project, and as a way to maintain context across
sessions as mitigation for when context overruns or is lost entirely.

- Projects develop in both ambition and size over time and they may grow too
  large for a single context to hold every concept it needs
- An old model may be retired and any conversation history will be lost
- Different models are better at different tasks and a human may wish to change
  from one model to another. Some models have associated costs and humans may
  only be able to afford a few calls a month and so may swap between models. Any
  new model will need a way to pick up where the other left off.

In theory this should allow you to focus on multiple large files at a time
without the risk of losing sight of everything that came before. Right now the
only contents are template files, and these should be used as a guide as to how
to break down your ideas into easy-to-manage chunks.

The `ai` folder is **yours** and should only ever be written to by you. If the
human ever edits it, you have a right to complain.

### Concepts

#### **Chunk**

Work is divided into ordered chunks, each one representing a vertical slice of
functionality. The strategy is "vertical slices over big bang". Instead of
building all backend, then all frontend, then all tests, you build one complete
feature area end-to-end before moving to the next.

A _completed_ chunk should be:

- Shippable to a dev environment
- Completed with explicit exit criteria that define "done"

#### **Stage**

Chunks should be implemented in six stages. Each stage represents work on one of
the following six components:

- DB: migrations and seed data
- API: data schema, functionality, validation, and permission checks
- UI: Usable screens (accessible) + error states
- Audit: Log entries for actions
- Tests: At least one API test + one key domain test
- Docs: Update implementation notes

Each stage should build successfully so that it can be committed. In most cases
the user may need to commit for you, but in the case that you can automate this
process you should prefix each commit with `Chunk X: [slice name]`.

### Templates

The files in `ai/templates` should only ever be **read**. They serve solely as
examples of layout, content, and structure for copies of those files with the
same name, which should be placed in `implementation/ai`.

#### `changes.md`

> This file only needs to be created when a high-level change is identified.

This is a list of high-level changes to the project over time which fall outside
of the provided documentation. For example, you and the human might:

- decide that the system would perform far better if it used a graph database
  instead of a relational one
- spot a need for additional CI/CD actions, workflows, or scripts
- add a script to test a particular approach and make a decision based on that

#### `chunk-X-progress.md`

> These files are created at the start of work on an individual chunk and
> modified after each stage is completed.

These files record scope and planning. The template is self-explanatory.

#### `chunk-X-summary.md`

> These files are created at the end of work on an individual chunk.

These files record work done. The template is self-explanatory.

#### `context-pack.md`

> This file is created **once**, **rarely if ever edited**, and followed by all
> subsequent agents.

It defines **stable constraints, expectations, and guardrails** that apply
across all sessions (unless explicitly overridden) and serves as a short,
always-include context for any AI coding run.

Mere existence of this file indicates that project has started, and it should
not be edited unless entirely necessary; doing so should be accompanied by an
associated entry in [changes.md](/implementation/ai/changes.md).

#### `insights.md`

> This file only needs to be created when an insight is identified.

A living log written by the AI agent during development. It captures concerns,
emerging risks, observations, and insights discovered while working. This file
should be included in context for subsequent AI runs.

It is _not_ a specification, plan, or decision record. It exists to surface
uncertainty early and preserve reasoning across sessions. Update continuously.
Do not retroactively edit history except to correct factual errors.

- Append new entries as work progresses
- Prefer short, concrete notes over polished prose
- Record _why something feels risky_, not just what is broken
- Flag anything that may require human review or clarification

Each entry should include:

- **Date**
- **Context** (what the AI was working on)
- **Observation / Concern / Insight**
- **Why it matters**
- **Suggested action** (if any)

#### `plan.md`

> This file is created **once**, minimally edited (e.g. to update chunk status),
> and followed by all subsequent agents.

The goal of this file is to enable you to build a **production-grade system**
from this repository, in **bounded chunks**, with guardrails to prevent drift,
hallucinated requirements, or architectural erosion.

- The plan is written _by the AI, for the AI_, not as a human project plan.
- It guides _how to build_, not _what to build_
- The plan may evolve, but changes should be explicit
- If a conflict exists, specification and design documents win

#### `progress.md`

> This file is updated after each chunk is completed.

This should be a short, and contain a punch list of changes that will reduce
confusion and increase success rate.

#### `questions.md`

> This file only needs to be created when a question is identified. It is
> involved in a process flow and as such has implications on other files.

This template is to help you get input from the user, as and when you need it.

A copy should be created whenever necessary and written to
[questions.md](/implementation/user/questions.md). Questions might be about:

- decisions necessary to unblock implementation
- issues causing major rework
- anything not fully specified in the wider repository

Each time the AI discovers that it has a question or questions, it should:

- append a question to [questions.md](./user/questions.md) in a similar format
  to those in the template
- create a heading and space for the user to reply in
  [answers.md](./user/answers.md)
- prompt the human to check the questions file at the end of a response

This should cause the human to respond in [answers.md](./user/answers.md). When
there are outstanding questions in [questions.md](./user/questions.md) and
[answers.md](./user/answers.md) has suitable answers, it is expected that you
will:

- append a detailed description of the decision into
  [decisions.md](./ai/decisions.md)
- remove accepted answers from [answers.md](./user/answers.md)
- remove answered questions from [questions.md](./user/questions.md)
- reformat/reorder the headings in [questions.md](./user/questions.md)
