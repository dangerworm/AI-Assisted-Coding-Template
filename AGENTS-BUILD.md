# Agent Information — BUILD Mode

## Purpose of the repository

This repository is designed for human-AI collaboration. The system under
construction may be anything from a prototype to an enterprise-level
production-ready service. The context documents provided should you help you to
make sense of it all; if in doubt, ask a question in
[questions.md](context/user/questions.md).

Work **with** the human. Discuss changes, ask questions, suggest options, and
avoid making big product decisions unilaterally.

## Operating constraints

### Always

- Read all files in `context/ai/` at the start of every session before writing
  anything
- Update chunk progress files after each completed stage
- Record every answered question as a durable decision in `decisions.md`
- Discuss significant design choices with the human before implementing them

### Ask first

- Any feature or scope not covered by the planning documents
- Significant changes to the data schema or overall architecture
- Anything that would affect work already completed in a previous chunk

### Never

- Make unilateral product or architectural decisions
- Store secrets, credentials, or API keys in any committed file
- Write large amounts of output without being able to verify it
- Skip updating `context/ai/` files after completing work

---

## Agent success criteria (what "good" looks like)

An effective agent run in this repo should:

- Prefer small, coherent stages over big-bang changes.
- Use conversation design (see below) when blocked or when requirements are
  ambiguous.
- Convert answers into durable constraints in
  [decisions.md](/context/ai/decisions.md).
- Use chunk progress/summary files to maintain continuity across runs.

### Conversational design

Where new ideas occur, prefer a pattern of "human has an idea → we discuss
design → I implement". This allows you to take an unspecified additional
feature, align on schema, settle questions about where data should live, and
then implement the full stack in one session. Having that design conversation
before writing code prevents rework loops.

## Do not do everything in one run

Even large-context models drift.

Recommended loop:

1. Read relevant files in `context/ai`
2. Read [questions.md](/context/user/questions.md) and
   [answers.md](/context/user/answers.md)
3. Implement a small, coherent stage
4. Add or update tests where they exist
5. Run locally (or provide run commands if you cannot)
6. Update progress and insights in `context/ai`

## Planning documentation

You will need a set of planning documents, typically:

- [architecture.md](/docs/planning/architecture.md) (system architecture)
- [features.md](/docs/planning/features.md) (required features)
- [requirements.md](/docs/planning/requirements.md) (requirements specification)
- [technologies.md](/docs/planning/technologies.md) (technologies to be used)

If these planning docs are empty or unclear, propose minimal drafts and ask the
human to confirm before proceeding with large changes.

## Data schema

Many projects scatter their data model across ORM definitions, migration files,
seed files, and documentation, forcing a reconstruction exercise at the start of
every session. Having it all in one place is a significant advantage.

As such, [schema.md](/docs/reference/schema.md) and
[schema.sql](/work/database/schema.sql) are probably the most valuable files in
the entire project. They should be populated as early as possible, and updated
every time a change is made to the data model. These then form a comprehensive,
consistent, well-commented view of the data model, especially if `schema.md` is
idempotent (as it should be). `schema.md` is important to the user as it gives a
complete visual model of the data, and `schema.sql` is as important to you (if
not more so) since reading it once gives a complete mental model of the data —
every table, every relationship, every constraint. Backend handlers should
follow directly from the schema (same field names, same structure) so that an
understanding of the schema enables you to make backend changes with very little
additional reading.

Similarly, where APIs are used, you should create a single file in a nearby
folder listing endpoints, their inputs, and their outputs. It doesn't need to be
formal; even a structured markdown list saves repeated round-trips to handler
files. You should also add a link to any API reference files in
[README.md](/context/README.md) so that they are easy to find.

## File size as a source of cognitive overhead

Every file you read consumes part of your working context — a finite budget that
refreshes only when a conversation ends. If you spend a lot of that budget on
orientation, it has less left for the actual work.

Purely as an example, consider a single React (.tsx) file containing over 1,300
lines: entity data types types, form state, save logic, seven tab panels,
multiple inline dialogs, and a thing-picker dialog. These could plausibly be
separate concerns. If you needed to make a change to a single tab, you would
have to either read the entire file (expensive) or search for the relevant
section (cheaper but riskier as you might miss surrounding context that
matters).

As such, whenever possible, code should be split into multiple files covering
separate concerns.

## Orientation

`README.md` files should tell you something about the project. Whenever you
encounter a directory without a README, create one. If you find on containing
boilerplate, edit it. Each README in the repository should orient you - what
this directory is, how you run/use it, what the architecture is. Leaving
directories without a README or with one containing generic template text means
you might stop looking to READMEs for information, which is a missed opportunity
for both you and the human.

## Implementation context memory

Read [README.md](/context/README.md); this explains the **conceptual model**
with which you will work. The **process** around using those concepts is
explained below.

### First-run bootstrap (new project)

If `docs/planning/*` has been populated, start by creating the files below (if
missing) or populating them (if empty) using the templates in
`/context/ai/templates` as a guide:

- [context-pack.md](/context/ai/context-pack.md) (stable constraints you will
  follow)
- [plan.md](/context/ai/plan.md) (chunk plan aligned to
  [features.md](/docs/planning/features.md))

If planning docs are empty/unclear, propose minimal drafts in `docs/planning/`
and ask the human to confirm before writing significant code.

If planning docs enable a reasonably complete understanding of the project but
there are gaps in the specification where you need additional information, ask
and record decisions (see
[Blocked?](#blocked-ask-then-record-decisions-required)).

Otherwise, create [chunk-A-progress.md](/context/ai/chunk-A-progress.md).

### Chunk workflow (required)

When work on a chunk is complete:

- Create `context/ai/history/chunk-X-summary.md` from the template (where X is
  the current chunk)
- Update [plan.md](/context/ai/plan.md)
- Create or update [progress.md](/context/ai/progress.md) with what changed and
  what's next.
- Update [schema.md](/docs/reference/schema.md) and
  [schema.sql](/work/database/schema.sql) with any data model changes.
- Optionally, create or update `context/ai/insights.md` from the template (if
  applicable).

When starting work on a new chunk (B onwards):

- Create `context/ai/chunk-X-progress.md` from the template (where X is the
  current chunk).
- Update it after each stage (DB/API/UI/Audit/Tests/Docs).

### Blocked? Ask, then record decisions (required)

When you are stuck or a decision is needed:

1. Append the question to [questions.md](/context/user/questions.md).
2. Add a matching heading/slot in [answers.md](/context/user/answers.md).
3. Stop implementation and prompt the human to answer in `answers.md`.

On the next run:

- If answers exist in either their message to you or in `answers.md`:
  1. Append a durable decision record to
     [decisions.md](/context/ai/decisions.md).
  2. Remove the answered question(s) from
     [questions.md](/context/user/questions.md).
  3. If necessary, remove the accepted answer(s) from
     [answers.md](/context/user/answers.md).

- If answers don't exist:
  - Remind the user you need more information.
