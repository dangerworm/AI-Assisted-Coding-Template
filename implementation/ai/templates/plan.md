# Implementation Plan (AI-led build)

> **The below content is provided as an example of layout, content, and
> structure.**

---

## Assumptions

This plan assumes:

- There is a canonical planning set that acts as source of truth:
  - [Architecture/design decisions](../../../docs/planning/architecture.md)
  - [Feature delivery roadmap (ordered)](../../../docs/planning/features.md)
  - [Requirements specification](../../../docs/planning/requirements.md)
  - [Technologies](../../../docs/planning/technologies.md)
- The AI delivers incrementally and documents as it goes
- A human reviewer exists and, before production use, will:
  - review summaries
  - manually test
  - validate security and compliance

## 0. Definition of "ready to begin feature development"

The repository is considered ready when an AI agent:

1. Can identify the target architecture and primary data stores
1. Has created a template backend and frontend locally (e.g. Vite template)
1. Can run backend and frontend locally with minimal setup
1. Knows what configuration/secrets are required (with safe dev defaults)
1. Can create and run tests
1. Can deliver work in small increments with clear exit criteria

If any of these are not true, they must be addressed before feature work begins.

## 1. Delivery strategy

The AI must **not** attempt a single end-to-end build.

Instead, work is delivered as **vertical slices**, where each slice includes:

- Data model changes (where applicable, this is migrations and seed data)
- API changes (schema + validation + permissions)
- UI or interface changes sufficient to exercise the workflow
- Audit/event emission
- Tests for critical paths
- Documentation updates

Each slice should be demonstrable in a local environment.

## 2. Chunking plan

### Chunk A — Repository readiness and development environment

Purpose:

- Stabilise tooling, environment, and documentation

Typical activities:

- Resolve stack drift
- Define local dev setup
  - e.g. add `.env.example` / `appsettings.Development.json` guidance
- Add CI pipeline
- Document how to run the system

Exit criteria:

- Code builds
- Tests pass
- One documented run path exists

### Chunk B+ — Feature delivery

Each subsequent chunk introduces a bounded capability.

For each chunk:

- Follow the order defined in features.md
- Implement minimal but complete workflows
- Update progress and summary documents

Exit criteria:

- Feature works end-to-end
- Tests pass
- Summary document written

#### Example chunk headings

- Chunk B — [PLACEHOLDER: slice name] ✅ COMPLETE
- Chunk C — [PLACEHOLDER: slice name] ⏳ REQUIRES USER INPUT
- Chunk D — [PLACEHOLDER: slice name]

## 3. Known risk areas

### AI

The AI is likely to struggle with:

- Ambiguous policy decisions
- Offline or sync semantics
- Event vs projection boundaries
- Permission granularity
- Reporting fidelity
- Operational UX details

Mitigations:

- Maintain a questions log in [questions.md](/implementation/user/questions.md)
- Force vertical slices
- Keep subsystem interfaces stable

## 4. Non-negotiables (quality gates)

- Accessibility targets must be met
- Audit history must be immutable
- Every state change emits an event
- Least-privilege security
- Tests exist for critical invariants
