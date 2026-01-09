# Agent Information

## Purpose of the repository

This repository is designed for human-AI collaboration. The system under
construction may be anything from a prototype to an enterprise-level
production-ready service. The context documents provided should you help you to
make sense of it all; if in doubt, ask a question in
[questions.md](implementation/user/questions.md).

Work **with** the human. Discuss changes, ask questions, suggest options, and
avoid making big product decisions unilaterally.

## Agent success criteria (what “good” looks like)

An effective agent run in this repo should:

- Prefer small, coherent stages over big-bang changes.
- Ask questions when blocked or when requirements are ambiguous.
- Convert answers into durable constraints in
  [decisions.md](/implementation/ai/decisions.md).
- Use chunk progress/summary files to maintain continuity across runs.

## Do not do everything in one run

Even large-context models drift.

Recommended loop:

1. Read relevant files in `implementation/ai`
2. Read [questions.md](/implementation/user/questions.md) and
   [answers.md](/implementation/user/answers.md)
3. Implement a small, coherent stage
4. Add or update tests where they exist
5. Run locally (or provide run commands if you cannot)
6. Update progress and insights in `implementation/ai`

## First-run bootstrap (new project)

If `docs/planning/*` has been populated, start by creating these (if missing):

- `implementation/ai/context-pack.md` (stable constraints you will follow)
- [plan.md](/implementation/ai/plan.md) (chunk plan aligned to
  [features.md](/docs/planning/features.md))
- [progress.md](/implementation/ai/progress.md) (short rolling status)

Use the examples in `implementation/ai/templates/`.

If planning docs are empty/unclear, propose minimal drafts in `docs/planning/`
and ask the human to confirm before writing significant code.

## Chunk workflow (required)

When starting work on a new chunk:

- Create `implementation/ai/chunk-X-progress.md` from the template.
- Update it after each stage (DB/API/UI/Audit/Tests/Docs).

When finishing a chunk:

- Create `implementation/ai/chunk-X-summary.md` from the template.
- Update [progress.md](/implementation/ai/progress.md) with what changed and
  what’s next.

## Blocked? Ask, then record decisions (required)

When you are stuck or a decision is needed:

1. Append the question to [questions.md](/implementation/user/questions.md).
2. Add a matching heading/slot in [answers.md](/implementation/user/answers.md).
3. Stop implementation and prompt the human to answer in `answers.md`.

On the next run:

- If answers exist in either their message to you or in `answers.md`:

  1. Append a durable decision record to
     [decisions.md](/implementation/ai/decisions.md).
  2. Remove the answered question(s) from
     [questions.md](/implementation/user/questions.md).
  3. If necessary, remove the accepted answer(s) from
     [answers.md](/implementation/user/answers.md).

- If answers don't exist:

  - Remind the user you need more information.

### Context management

You are given a set of planning documents, typically:

- [architecture.md](/docs/planning/architecture.md) (system architecture)
- [features.md](/docs/planning/features.md) (required features)
- [requirements.md](/docs/planning/requirements.md) (requirements specification)
- [technologies.md](/docs/planning/technologies.md) (technologies to be used)

If these planning docs are empty or unclear, propose minimal drafts and ask the
human to confirm before proceeding with large changes.

You should also read [README.md](implementation/README.md) and create or use the
files in `implementation/ai`. These include but are not limited to:

- `implementation/ai/context-pack.md` (the overall project context)
- `implementation/ai/chunk-X-progress.md` (where X is the current chunk)
- [plan.md](/implementation/ai/plan.md) (the overall plan)
- [progress.md](/implementation/ai/progress.md) (progress summary)
