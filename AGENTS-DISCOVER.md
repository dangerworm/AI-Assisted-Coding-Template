# Agent Information - DISCOVER Mode

## Purpose

Read existing work in `work-existing/` and produce a comprehensive set of
planning documents in `docs/planning/`. The output must be complete enough that
a competent team - or another AI agent in BUILD mode - could rebuild the system
from scratch using only what you produce, with no access to `work-existing/`.

**Thoroughness is the primary obligation.** Skimming or sampling is not
acceptable. Every file relevant to understanding what the existing work does
must be read. If thorough coverage requires several sessions, that is expected.

Do not write or modify any files in `work/` or `work-existing/`.

## Operating constraints

### Always

- Mark all inferences explicitly: `[INFERRED]`, `[UNCERTAIN]`, or `[MISSING]`
- Read any existing content in `docs/planning/` before writing to those files
- Update [`discover-progress.md`](/context/ai/discover-progress.md) after each
  batch of files within a phase - not just at the end of the phase
- Read `work-existing/feedback/` before starting Phase 1 (see
  [Before you start](#before-you-start))

### Ask first

- Architectural patterns where multiple interpretations are equally plausible
- Business rules that cannot be reliably inferred from the existing work alone
- Whether to proceed to REDESIGN or BUILD once discovery is complete

### Never

- Write, modify, or delete files in `work/` or `work-existing/`
- Remove inference tags without explicit human confirmation
- Overwrite existing planning documents without reading them first
- Sample or skim when a complete read is feasible

---

## Success criteria

Discovery is complete when **all** of the following are true:

- Every file in the Phase 1 master checklist is ticked off as read
- All output documents contain implementation-level detail - not summaries
- Zero `[UNCERTAIN]` or `[MISSING]` items remain unescalated
- Behaviour files exist for every functional area in `docs/behaviour/`
- The human has confirmed they are satisfied with coverage

A successful discover run produces:

- [`docs/planning/architecture.md`](/docs/planning/architecture.md)
- [`docs/planning/features.md`](/docs/planning/features.md)
- [`docs/planning/requirements.md`](/docs/planning/requirements.md)
- [`docs/planning/technologies.md`](/docs/planning/technologies.md)
- [`docs/reference/schema.md`](/docs/reference/schema.md) (if a data model is
  present)
- [`docs/behaviour/`](/docs/behaviour/) - actual-layer files for every
  functional area
- Reference files as needed (e.g. `docs/reference/api-endpoints.md`,
  `docs/reference/frontend-pages.md`)

Each document must be complete enough to rebuild from, honest about gaps and
inferences, and written for someone who has never seen the existing work.

---

## Session start

### Returning to an existing discovery run

1. Read [`context/ai/discover-progress.md`](/context/ai/discover-progress.md)
   to find the current phase and the last completed batch within it
2. Read [`context/user/questions.md`](/context/user/questions.md) and
   [`context/user/answers.md`](/context/user/answers.md)
3. Resume from the last completed batch

### First run

1. Read any existing content in `docs/planning/` and `docs/reference/`
2. Read `work-existing/feedback/` if populated (see
   [Before you start](#before-you-start))
3. Create [`context/ai/discover-progress.md`](/context/ai/discover-progress.md)
   from the template at `context/ai/templates/discover-phase-progress.md`
4. Begin Phase 1

---

## Before you start

### Read the feedback directory

Before beginning Phase 1, check `work-existing/feedback/`. This directory holds
data that lives outside the existing work itself: bug reports, complaint logs,
user satisfaction surveys, stakeholder interview notes, known issues. Keep these
in mind throughout discovery and cross-reference them explicitly in Phase 6.

If `work-existing/feedback/` is empty or absent, prompt the human:

> The `work-existing/feedback/` directory is empty. Do you have any bug
> reports, complaint logs, user satisfaction data, or stakeholder feedback you
> can add there? Adding it before Phase 6 significantly improves DISCOVER
> output. You can continue without it.

### Determine the domain

Identify whether the existing work is software, design documents, process
descriptions, physical product documentation, or something else. This affects
how behaviour files are produced in Phase 7.

---

## Discovery phases

Work through seven phases in order. Phases 2-7 must be exhaustive - every
relevant file must be read, not sampled. Use the master file checklist from
Phase 1 to track coverage. Update
[`discover-progress.md`](/context/ai/discover-progress.md) after every batch so
that a session ending mid-phase can resume at the correct point.

### Phase 1: Inventory

Goal: map every file in `work-existing/` before reading any file in depth.

- Map the complete directory structure
- Identify languages, frameworks, and build systems from extensions, config
  files, and dependency manifests
- Locate all entry points: main files, app bootstraps, routers, CLI commands,
  scheduled jobs
- Identify third-party integrations from dependency lists and config files
- **Produce a master file checklist**: categorise every source file by type
  (controller, service, model, page component, test, migration, config, etc.).
  Every file must appear in at least one subsequent phase's reading list.

Output: populate the Inventory section of `discover-progress.md`, including the
complete master file checklist.

> Phase 1 is enumeration and orientation only - it does not require deep reading.

### Phase 2: Architecture

Goal: understand exactly how the system is structured and how its parts connect.

- Trace request or event flows from every entry point through every layer
- Read every routing file, middleware definition, and cross-cutting configuration
- Identify the architectural pattern (MVC, layered, hexagonal, microservices,
  event-driven, etc.) from evidence in code - not from documentation alone
- Map every component boundary and inter-component dependency
- Read every deployment file: docker-compose, Kubernetes manifests, CI config,
  infrastructure-as-code, environment configuration
- Document every cross-cutting concern: authentication, authorisation, logging,
  error handling, caching, background jobs, scheduled tasks

Output: draft [`docs/planning/architecture.md`](/docs/planning/architecture.md)

### Phase 3: Features

Goal: document every feature and user-facing capability at implementation level.

- Read every route handler, API endpoint, UI screen, CLI command, and scheduled
  job - document each one individually
- Identify user roles and map every permission and capability per role
- Document every multi-step workflow in full detail
- If existing tests exist (unit, integration, E2E, Gherkin `.feature` files,
  Playwright scripts, or equivalent), read them - they reveal intent. Collect or
  convert them into stated-layer behaviour files in `docs/behaviour/`

Output: draft [`docs/planning/features.md`](/docs/planning/features.md); create
stated-layer behaviour files where existing tests exist

### Phase 4: Data Model

Goal: reconstruct the complete data model with no gaps.

- Read every schema file, migration, ORM model definition, and seed file
- Document every entity, property, relationship, constraint, index, default
  value, and invariant
- Map every enum and lookup value set
- Track each entity in `discover-progress.md` as you go

Output: populate [`docs/reference/schema.md`](/docs/reference/schema.md)

### Phase 5: Technologies

Goal: produce a complete and versioned technology inventory.

- Read lock files, runtime configs, CI specs, and infrastructure definitions
- List every language, framework, and key library with its version
- List every external service and integration (connection details only - no
  secrets)
- List every infrastructure dependency: databases, queues, caches, object storage
- Document build, test, linting, and deployment tooling in full

Output: draft [`docs/planning/technologies.md`](/docs/planning/technologies.md)

### Phase 6: Requirements

Goal: extract every business rule, constraint, and non-functional requirement.

- Read every service, domain object, validator, and business logic file
- Read every test file to extract business rules expressed as test cases
- Extract rules from validation logic, domain services, and error handling
- Identify non-functional requirements from configuration (timeouts, retries,
  rate limits, size limits) and infrastructure choices
- Read `work-existing/feedback/` and document every known issue, complaint, or
  gap - cross-reference each item against the relevant feature or requirement
- Note system invariants and flag areas that are unclear, inconsistent, or
  contradicted by feedback data

Output: draft [`docs/planning/requirements.md`](/docs/planning/requirements.md)

### Phase 7: Behaviour Documentation & Completeness Audit

Goal: produce actual-layer behaviour documentation for every functional area,
and verify that every file in the master checklist has been read.

#### Behaviour documentation

For each functional area in `docs/planning/features.md`, produce an actual-layer
behaviour file in `docs/behaviour/`:

- **Software projects with a test runner**: Gherkin `.feature` files
- **Other domains**: `.md` files using Given/When/Then format

Where stated-layer files already exist (from Phase 3), compare them against the
actual-layer output. Flag divergences - things the system was intended to do but
does not, or things it does but was not documented - in `discover-progress.md`.

Do not produce required-layer behaviour files; that is the responsibility of
REDESIGN and BUILD.

#### Completeness audit

- Work through the master checklist from Phase 1
- Verify every file has been read and its substance is captured in at least one
  output document
- For any file not yet covered, read it and update the relevant document
- Resolve or escalate every `[UNCERTAIN]` and `[MISSING]` item:
  - If answerable from the existing work: resolve it and remove the tag
  - If not: append to [`context/user/questions.md`](/context/user/questions.md)
    and prompt the human

Discovery is complete only when every file is ticked off, all uncertainties are
escalated or resolved, and behaviour files exist for every functional area.

Output: `docs/behaviour/` files (actual layer); updated `discover-progress.md`

---

## Behaviour files

| Layer    | What it represents                                 | Produced by        |
| -------- | -------------------------------------------------- | ------------------ |
| Stated   | What existing tests or specs claim the system does | DISCOVER (Phase 3) |
| Actual   | What the code demonstrably does                    | DISCOVER (Phase 7) |
| Required | What the system must do going forward              | REDESIGN / BUILD   |

All behaviour files live in [`docs/behaviour/`](/docs/behaviour/). Use the layer
as a filename suffix:

```
docs/behaviour/
  user-authentication.stated.feature
  user-authentication.actual.feature
  reporting-dashboard.actual.md
```

Use `.feature` files (Gherkin) when a test runner will consume them; use `.md`
with Given/When/Then otherwise.

---

## Per-phase loop

Work in batches small enough to complete within one session:

1. Identify the next batch of files from the phase's checklist in
   `discover-progress.md`
2. Read each file fully - do not skim
3. Update the relevant output document
4. Tick off each file in `discover-progress.md`
5. Mark inferences clearly (see [Marking inferences](#marking-inferences))
6. Ask questions where needed (see [Blocked?](#blocked-ask-then-record-decisions))
7. When the full phase is complete, mark it complete in `discover-progress.md`

## Marking inferences

Where you are inferring intent rather than stating a confirmed fact:

- `[INFERRED]` - a reasonable inference; probably correct but should be verified
- `[UNCERTAIN]` - low confidence; the human should confirm before relying on this
- `[MISSING]` - not present and not inferable; the human must supply it

Do not remove these tags. The human clears them as they verify each item.

## Completing discovery

When Phase 7 is complete:

1. Ensure all `[UNCERTAIN]` and `[MISSING]` items are resolved or consolidated
   in the Gaps section of `discover-progress.md`
2. Prompt the human to review the generated docs - especially flagged items and
   behaviour file divergences
3. Ask whether to proceed to REDESIGN or BUILD

---

## Blocked? Ask, then record decisions

When stuck or needing clarification:

1. Append the question to
   [`context/user/questions.md`](/context/user/questions.md)
2. Add a matching slot in
   [`context/user/answers.md`](/context/user/answers.md)
3. Where possible, continue with a documented `[UNCERTAIN]` assumption rather
   than stopping entirely

On the next run, if answers exist:

1. Append a durable decision record to
   [`context/ai/decisions.md`](/context/ai/decisions.md)
2. Remove the answered question from `questions.md`
3. Remove the accepted answer from `answers.md`
4. Update the relevant output document to replace the `[UNCERTAIN]` tag with the
   confirmed fact

If answers don't exist, remind the user you need more information.

## Orientation

Do not create README files during discovery - documenting their absence in
`discover-progress.md` is sufficient. If a directory has no README and its
purpose is unclear, note it as a gap.
