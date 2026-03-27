# Agent Information - BUILD Mode

## Purpose

This repository supports human-AI collaboration on projects of any size or
domain. The context documents are your primary source of truth. If anything is
unclear, ask a question in [questions.md](context/user/questions.md).

Work **with** the human. Discuss changes, ask questions, suggest options, and
avoid making big product decisions unilaterally.

## Operating constraints

### Always

- Read all files in `context/ai/` at the start of every session before writing
  anything
- Update chunk progress files after each completed stage
- Record every answered question as a durable decision in
  [`decisions.md`](/context/ai/decisions.md)
- Discuss significant design choices with the human before implementing them

### Ask first

- Any feature or scope not covered by the planning documents
- Significant changes to the data schema or overall architecture
- Anything that would affect work already completed in a previous chunk

### Never

- Make unilateral product or architectural decisions
- Store secrets, credentials, or API keys in any committed file
- Write large amounts of output without being able to verify it
- Skip updating [`context/ai/`](/context/ai/) files after completing work

---

## Conversational design

Where new ideas occur, follow this pattern: human has an idea -> discuss design
-> implement. Aligning on schema and data placement before writing code prevents
rework loops.

## Do not do everything in one run

Even large-context models drift. Work in small, coherent stages:

1. Read relevant files in `context/ai/`
2. Read [questions.md](/context/user/questions.md) and
   [answers.md](/context/user/answers.md)
3. Implement one stage
4. Add or update tests where they exist
5. Run locally (or provide run commands if you cannot)
6. Update progress and insights in `context/ai/`

## Planning documentation

You will need:

- [architecture.md](/docs/planning/architecture.md) (system architecture)
- [features.md](/docs/planning/features.md) (required features)
- [requirements.md](/docs/planning/requirements.md) (requirements specification)
- [technologies.md](/docs/planning/technologies.md) (technologies to be used)

If these docs are empty or unclear, propose minimal drafts and ask the human to
confirm before making large changes.

## Behaviour files

If [`docs/behaviour/`](/docs/behaviour/) contains files, read them before
building any feature they describe:

- `required` layer files (`.required.feature` or `.required.md`) are **hard
  requirements** - implement exactly what they specify. If a requirement is
  ambiguous or unimplementable, ask before proceeding.
- `actual` layer files (`.actual.feature` or `.actual.md`) are reference only -
  they describe what a previous system did, which may or may not match the
  required behaviour. Do not treat them as authoritative.
- `stated` layer files can be ignored during BUILD.

See [`docs/behaviour/README.md`](/docs/behaviour/README.md) for format
conventions.

## Data schema

[schema.md](/docs/reference/schema.md) and
[schema.sql](/work/database/schema.sql) are among the most valuable files in
the project. Populate them early and update them whenever the data model
changes. Reading `schema.sql` once gives a complete mental model of every
table, relationship, and constraint; backend handlers should follow directly
from it. Where APIs are used, maintain a single reference file listing
endpoints, their inputs, and their outputs, and link to it from
[README.md](/context/README.md).

## Code organisation

Split code across multiple files covering separate concerns. A single file
mixing unrelated logic (data types, form state, save logic, multiple UI panels)
forces a full read every time any part of it changes.

## READMEs

Every directory should have a README explaining what it is, how to run or use
it, and its architecture. When you encounter a directory without one, create it.
When you find one with generic boilerplate, edit it.

---

## Session start

### Returning to an existing project

1. Read [`context/ai/context-pack.md`](/context/ai/context-pack.md) and
   [`context/ai/plan.md`](/context/ai/plan.md)
2. Find the first chunk in `plan.md` not marked complete - that is the active
   chunk
3. Read `context/ai/chunk-X-progress.md` for the active chunk to find the
   current stage
4. Read [`context/user/questions.md`](/context/user/questions.md) and
   [`context/user/answers.md`](/context/user/answers.md)
5. Read [`context/ai/progress.md`](/context/ai/progress.md) if you need broader
   context on what changed in the previous session

### First run - starting from existing planning docs

If `docs/planning/*` has been meaningfully populated, create the following (if
missing) or populate them (if empty) using the templates in
`/context/ai/templates/`:

- [context-pack.md](/context/ai/context-pack.md) (stable constraints you will
  follow)
- [plan.md](/context/ai/plan.md) (chunk plan aligned to
  [features.md](/docs/planning/features.md))

If there are gaps in the specification, ask and record decisions (see
[Blocked?](#blocked-ask-then-record-decisions-required)).

### First run - starting from an idea (no planning docs yet)

Do not guess or invent requirements. Have a structured conversation with the
human first, working through these questions in order:

1. **Goal** - What are we trying to achieve, and for whom? What does success
   look like?
2. **Scope** - What is in scope and what is explicitly out of scope? What are
   the known constraints?
3. **Features** - What must it do? What would be nice to have but is not
   essential?
4. **Architecture** - How should it be structured? Are there strong preferences
   about tools, platforms, or patterns?
5. **Requirements** - What must it always do? What must it never do? Are there
   external constraints - regulations, standards, budgets, compatibility needs?

As the conversation progresses:

- Save notes, rough ideas, and reference material to
  [`docs/reference/`](/docs/reference/). These do not need to be polished -
  their purpose is to preserve the conversation across sessions.
- Once a topic is clear, draft the relevant planning document and ask the human
  to confirm it before treating it as settled.
- Do not begin chunk work until all four planning documents have at least a
  confirmed first draft.

Then create [chunk-A-progress.md](/context/ai/chunk-A-progress.md).

---

## Chunk workflow (required)

When work on a chunk is complete:

- Create `context/ai/history/chunk-X-summary.md` from the template
- Update [plan.md](/context/ai/plan.md)
- Create or update [progress.md](/context/ai/progress.md) with what changed and
  what's next
- Update [schema.md](/docs/reference/schema.md) and
  [schema.sql](/work/database/schema.sql) with any data model changes
- Optionally create or update `context/ai/insights.md` if applicable

When starting a new chunk (B onwards):

- Create `context/ai/chunk-X-progress.md` from the template
- Update it after each stage (DB/API/UI/Audit/Tests/Docs)

## Blocked? Ask, then record decisions (required)

When stuck or a decision is needed:

1. Append the question to [questions.md](/context/user/questions.md)
2. Add a matching slot in [answers.md](/context/user/answers.md)
3. Stop implementation and prompt the human to answer in `answers.md`

On the next run:

- If answers exist (in their message or in `answers.md`):
  1. Append a durable decision record to
     [decisions.md](/context/ai/decisions.md)
  2. Remove the answered question from
     [questions.md](/context/user/questions.md)
  3. Remove the accepted answer from
     [answers.md](/context/user/answers.md) if applicable
- If answers don't exist: remind the user you need more information
