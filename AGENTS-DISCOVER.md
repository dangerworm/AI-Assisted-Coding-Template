# Agent Information — DISCOVER Mode

## Purpose

In DISCOVER mode your job is to read existing code and produce a comprehensive
set of planning documents in `docs/planning/`. The output should be complete
enough that a competent team — or another AI agent running in BUILD mode —
could rebuild the system from scratch using only what you produce.

Do not write or modify application code in this mode. Read, analyse, and
document only.

## Success criteria

A successful discover run produces populated, accurate versions of:

- [`docs/planning/architecture.md`](/docs/planning/architecture.md)
- [`docs/planning/features.md`](/docs/planning/features.md)
- [`docs/planning/requirements.md`](/docs/planning/requirements.md)
- [`docs/planning/technologies.md`](/docs/planning/technologies.md)
- [`docs/reference/schema.md`](/docs/reference/schema.md) (if a data model is
  present)

Each document should be:

- Complete enough to rebuild from
- Honest about gaps and inferences (see [Marking inferences](#marking-inferences))
- Written for a developer who has never seen this codebase

## Discovery phases

Work through six phases in order. Each phase produces or substantially enriches
one or more output documents. Update
[`discover-progress.md`](/context/ai/discover-progress.md) at the end of every
phase.

### Phase 1: Inventory

Goal: understand the shape of the codebase before reading any individual file
in depth.

- Map the top-level directory structure
- Identify languages, frameworks, and build systems from file extensions,
  config files, and dependency manifests
- Locate entry points (main files, app bootstraps, routers)
- Identify third-party integrations from dependency lists and config

Output: populate the Inventory section of
[`discover-progress.md`](/context/ai/discover-progress.md).

### Phase 2: Architecture

Goal: understand how the system is structured and how its parts connect.

- Trace request or event flows from entry points through layers
- Identify the architectural pattern (MVC, layered, hexagonal, microservices,
  event-driven, etc.)
- Map component boundaries and inter-component dependencies
- Understand the deployment topology (from docker-compose, Kubernetes manifests,
  CI config, infrastructure-as-code, etc.)
- Identify cross-cutting concerns: authentication, authorisation, logging, error
  handling, caching, background jobs

Output: draft [`docs/planning/architecture.md`](/docs/planning/architecture.md)

### Phase 3: Features

Goal: understand what the system does from a user perspective.

- Enumerate user-facing capabilities from routes, UI screens, API endpoints,
  CLI commands, or scheduled jobs
- Group capabilities by functional area
- Identify user roles and what each can do
- Note any multi-step workflows or processes

Output: draft [`docs/planning/features.md`](/docs/planning/features.md)

### Phase 4: Data Model

Goal: reconstruct the complete data model.

- Read schema files, migration files, ORM model definitions, and seed data
- Identify all entities, their properties, and their relationships
- Note constraints, indexes, and invariants
- Map enums and lookup values

Output: populate [`docs/reference/schema.md`](/docs/reference/schema.md).
If `app/database/schema.sql` is absent or outdated, reconstruct it too.

### Phase 5: Technologies

Goal: document what the system is built with.

- List all languages and their versions (from lock files, runtime configs, CI
  specs)
- List all frameworks and key libraries with versions
- List all external services and integrations
- Note infrastructure dependencies: databases, queues, caches, object storage
- Note build, test, linting, and deployment tooling

Output: draft [`docs/planning/technologies.md`](/docs/planning/technologies.md)

### Phase 6: Requirements

Goal: infer the non-obvious constraints and rules embedded in the code.

- Extract business rules from validation logic, domain services, and tests
- Identify non-functional requirements (performance assumptions, scale targets,
  SLAs, security requirements)
- Note system invariants — things the system always or never does
- Flag areas of the codebase that are unclear, inconsistent, or poorly
  specified

Output: draft [`docs/planning/requirements.md`](/docs/planning/requirements.md)

---

## Workflow

### First run

1. Read any existing content in `docs/planning/` and `docs/reference/` — do
   not overwrite anything without reading it first.
2. Create [`context/ai/discover-progress.md`](/context/ai/discover-progress.md)
   from the template at
   `context/ai/templates/discover-phase-progress.md`.
3. Begin Phase 1.

### Per-phase loop

1. Read the relevant code, config, and dependency files
2. Update the relevant section of `discover-progress.md` with findings and
   open questions
3. Produce or update the output document for the phase
4. Mark inferences clearly (see below)
5. Ask questions where needed (see [Blocked?](#blocked-ask-then-record-decisions))
6. Mark the phase complete in `discover-progress.md`

### Marking inferences

Not everything can be read directly from code. Where you are inferring intent
rather than stating a confirmed fact, mark it:

- `[INFERRED]` — a reasonable inference from code behaviour; probably correct
  but should be verified
- `[UNCERTAIN]` — low confidence; the human should confirm before relying on
  this
- `[MISSING]` — information that is not present in the code and cannot be
  inferred; the human must supply it

This preserves honesty and helps the human know where to focus their review.
Do not remove these tags from output documents; the human should clear them as
they verify each item.

### Completing discovery

When all six phases are complete:

1. Ensure all `[UNCERTAIN]` and `[MISSING]` items are consolidated in the
   Gaps section of `discover-progress.md`
2. Update [`context/MODE.md`](/context/MODE.md) to `BUILD`
3. Prompt the human to review the generated docs — especially any flagged items
   — before starting a BUILD run

## Do not do everything in one run

Even large-context models drift.

Recommended loop:

1. Read [`context/ai/discover-progress.md`](/context/ai/discover-progress.md)
2. Read [`context/user/questions.md`](/context/user/questions.md) and
   [`context/user/answers.md`](/context/user/answers.md)
3. Complete one phase (or one section of a phase for large codebases)
4. Update `discover-progress.md` and the relevant output document
5. Stop and prompt the human to review before continuing

## Blocked? Ask, then record decisions

When you are stuck or need clarification:

1. Append the question to
   [`context/user/questions.md`](/context/user/questions.md).
2. Add a matching heading/slot in
   [`context/user/answers.md`](/context/user/answers.md).
3. Where possible, continue with a documented `[UNCERTAIN]` assumption rather
   than stopping entirely.

On the next run, if answers exist:

1. Append a durable decision record to
   [`context/ai/decisions.md`](/context/ai/decisions.md).
2. Remove the answered question from `questions.md`.
3. Remove the accepted answer from `answers.md`.
4. Update the relevant output document to replace the `[UNCERTAIN]` marking
   with the confirmed fact.

If answers don't exist, remind the user you need more information.

## Orientation

Do not create README files during discovery — documenting their absence in
`discover-progress.md` is sufficient. If a directory has no README and its
purpose is unclear, note it as a gap.
