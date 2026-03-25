# Discovery Progress

**Status:** IN PROGRESS

**Started:** [YYYY-MM-DD]

**Codebase:** [Name or path of the system being analysed]

**Domain:** [Software / Design / Process / Other - determines behaviour file format]

---

## Phase Status

| Phase                                   | Status      | Output                              |
| --------------------------------------- | ----------- | ----------------------------------- |
| 1. Inventory                            | Not started | This file (master checklist)        |
| 2. Architecture                         | Not started | `docs/planning/architecture.md`     |
| 3. Features                             | Not started | `docs/planning/features.md`         |
| 4. Data Model                           | Not started | `docs/reference/schema.md`          |
| 5. Technologies                         | Not started | `docs/planning/technologies.md`     |
| 6. Requirements                         | Not started | `docs/planning/requirements.md`     |
| 7. Behaviour & Completeness Audit       | Not started | `docs/behaviour/` + final checklist |

---

## Feedback Summary

> Populated before Phase 1 if `work-existing/feedback/` contains data.

[Summary of known issues, complaints, or user feedback - or note that directory
was empty]

---

## Phase 1: Inventory

**Status:** Not started

### Directory Structure

[Top-level map of the existing work]

### Languages and Frameworks

[Identified from file extensions, lock files, and dependency manifests]

### Entry Points

[Main files, app bootstraps, routers, CLI commands, scheduled jobs]

### Third-Party Integrations

[Services and APIs identified from dependencies and config]

### Master File Checklist

Every source file, categorised by type. All phases draw from this list.
Add a `[x]` when a file has been read and its substance documented.

> Replace the examples below with the actual files found during Phase 1.

#### [Category: e.g. Controllers / Route Handlers / API Endpoints]

- [ ] `path/to/file.ext`
- [ ] `path/to/file.ext`

#### [Category: e.g. Services / Business Logic]

- [ ] `path/to/file.ext`
- [ ] `path/to/file.ext`

#### [Category: e.g. Data Models / Schema / Migrations]

- [ ] `path/to/file.ext`
- [ ] `path/to/file.ext`

#### [Category: e.g. UI Pages / Components / Screens]

- [ ] `path/to/file.ext`
- [ ] `path/to/file.ext`

#### [Category: e.g. Tests / Scenarios / Specs]

- [ ] `path/to/file.ext`
- [ ] `path/to/file.ext`

#### [Category: e.g. Config / Infrastructure / Deployment]

- [ ] `path/to/file.ext`
- [ ] `path/to/file.ext`

#### [Other categories as needed]

### Open Questions

- [None yet]

---

## Phase 2: Architecture

**Status:** Not started

**Files to read this phase:** [list from master checklist - routing, middleware,
deployment, config, cross-cutting concerns]

**Progress:** 0 / [N] files read

### Architectural Pattern

[e.g. MVC, layered, hexagonal, microservices, event-driven]

### Component Map

[How the major parts of the system connect]

### Request / Event Flow

[How a typical request or event moves through every layer]

### Deployment Topology

[From docker-compose, CI config, manifests, or infrastructure-as-code]

### Cross-Cutting Concerns

[Auth, logging, error handling, caching, background jobs]

### Open Questions

- [None yet]

---

## Phase 3: Features

**Status:** Not started

**Files to read this phase:** [list from master checklist - route handlers, API
endpoints, UI pages, CLI commands, existing tests/specs]

**Progress:** 0 / [N] files read

### Functional Areas

[Group user-facing capabilities by area; link to individual feature detail below]

### User Roles

[What each role can do - every permission mapped]

### Notable Workflows

[Multi-step processes or flows, documented in full]

### Stated Behaviour Files Created

[List any `docs/behaviour/*.stated.*` files created from existing tests]

- [None yet]

### Open Questions

- [None yet]

---

## Phase 4: Data Model

**Status:** Not started

**Files to read this phase:** [list from master checklist - schema files,
migrations, ORM models, seed data]

**Progress:** 0 / [N] files read

### Entities

| Entity | Description | Documented |
| ------ | ----------- | ---------- |
| [Name] | [Brief]     | [ ]        |

### Key Relationships

[Notable FK relationships and cardinalities]

### Constraints and Invariants

[CHECK constraints, unique indexes, business rules enforced at DB level]

### Enums and Lookups

[Fixed value sets]

### Open Questions

- [None yet]

---

## Phase 5: Technologies

**Status:** Not started

**Files to read this phase:** [list from master checklist - lock files, CI
config, runtime config, infrastructure definitions]

**Progress:** 0 / [N] files read

### Languages

[With versions where identifiable]

### Frameworks and Key Libraries

[With versions where identifiable]

### External Services

[APIs, SaaS tools, cloud services - connection details only, no secrets]

### Infrastructure

[Databases, queues, caches, object storage]

### Tooling

[Build, test, lint, deploy]

### Open Questions

- [None yet]

---

## Phase 6: Requirements

**Status:** Not started

**Files to read this phase:** [list from master checklist - services, domain
objects, validators, business logic, all test files]

**Progress:** 0 / [N] files read

### Business Rules

[Rules extracted from validation logic, domain services, tests]

### Non-Functional Requirements

[Performance assumptions, scale targets, SLAs, security requirements]

### System Invariants

[Things the system always or never does]

### Known Issues from Feedback

[Items from `work-existing/feedback/`, each cross-referenced to a feature or
requirement]

- [None yet]

### Unclear or Inconsistent Areas

[Parts of the existing work that are ambiguous, contradictory, or contradicted
by feedback data]

### Open Questions

- [None yet]

---

## Phase 7: Behaviour Documentation & Completeness Audit

**Status:** Not started

### Behaviour Files

| Functional Area | Stated file | Actual file | Divergences noted |
| --------------- | ----------- | ----------- | ----------------- |
| [Area name]     | [ ]         | [ ]         | [None / list]     |

### Completeness Audit

Files remaining from master checklist: [N]

- [ ] All files ticked off
- [ ] All `[UNCERTAIN]` items resolved or escalated
- [ ] All `[MISSING]` items escalated to questions.md
- [ ] Behaviour files exist for every functional area

### Open Questions

- [None yet]

---

## Gaps and Uncertainties

Items marked `[UNCERTAIN]` or `[MISSING]` across all phases that require human
review before the next mode begins:

- [None yet]
