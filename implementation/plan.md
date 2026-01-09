# Implementation Plan (AI-led build)

Goal: enable an AI coding agent (Claude/Codex/etc.) to build a **production-grade**, fully-featured
eCDR system from this repo, in **bounded chunks**, with strong guardrails so it doesn’t drift.

This plan assumes:

- The planning set is the source of truth:
  - [docs/planning/specification.md](../docs/planning/specification.md) (normative requirements)
  - [docs/planning/design-document.md](../docs/planning/design-document.md) (architecture/decisions)
  - [docs/planning/features.md](../docs/planning/features.md) (implementation-ordered roadmap +
    provenance)
- You (human) will review, test, and audit before production.

---

## 0) Definition of “ready to press go”

The repo is “press go” ready when an AI agent can:

1. Run backend + frontend locally with 1 command each.
2. Have a clear target architecture and _one_ operational DB choice.
3. Know what secrets/config are required (via `.env.example`/docs), with safe defaults for dev.
4. Run tests + linting in CI.
5. Deliver in small increments with a clear Definition of Done per increment.

This repo currently has a good backend skeleton (GraphQL + services) but:

- The frontend is still the Vite template.
- Docs have a few “stack drift” items (README mentions PostgreSQL/.NET 9 but code targets net8.0 and
  SQL Server localdb).

We fix that by (a) documenting the decision points and (b) setting up repeatable local dev + CI.

---

## 1) Delivery strategy: vertical slices over “big bang”

AI will get stuck if asked to “build everything” in one pass.

Instead, deliver **vertical slices** where each slice includes:

- API: schema + validation + permission checks
- DB: migrations + seed data
- UI: usable screens (accessible) + error states
- Audit: log entries for actions
- Tests: at least one API test + one key domain test
- Docs: update implementation notes

Each slice must be shippable to a dev environment.

---

## 2) Chunking plan (matches docs/planning/features.md)

Use this chunk order. Each chunk should be its own PR/branch.

### Chunk A — Repo readiness + dev environment (blocking)

- Decide operational DB provider (see Questions).
- Add local dev stack:
  - DB container (or localdb if sticking to Windows-only)
  - Redis container
  - Optional local AWS emulation (LocalStack) OR well-factored “dev stubs”
- Add `.env.example` / `appsettings.Development.json` guidance.
- Add CI pipeline: build + test + lint (backend + frontend).
- Add a minimal “developer runbook”.

Exit criteria:

- `dotnet test` passes (or at least runs with one baseline test project).
- `npm test`/`npm run lint`/`npm run build` passes.
- One documented way to run everything.

### Chunk B — Identity + RBAC primitives (Phase 0)

- Implement authentication wiring (OIDC/JWT validation). Provide a dev IdP option.
- Implement user context (`IUserContext`) and permission checking end-to-end.
- Standardise permission naming (currently mixed human-readable strings + `x:y` + `snake_case`).
- Add admin UI: users, roles, role assignments.

Exit criteria:

- Login works in dev.
- A protected mutation fails without permission.
- Admin can assign roles; hierarchy constraints enforced.

### Chunk C — Audit/event model baseline (Phase 1)

- Define canonical event schema(s): ReceiptEvent, TransferEvent, AdministrationEvent, etc.
- Implement append-only event store:
  - In production: DynamoDB (per infra)
  - In dev: LocalStack or a local substitute (file/in-memory) with same interface
- Implement cryptographic hash linking (tamper-evidence) at least at the event level.
- Add audit browsing UI + export.

Exit criteria:

- Every write operation emits an event.
- Events are immutable.
- Hash chain validation can run in tests.

### Chunk D — Catalogue + configuration (Phase 2)

- Implement medicinal product/catalogue model.
- Add import/update strategy for dm+d mapping (see Needs).
- Implement location-specific drug availability.
- Add admin UI.

Exit criteria:

- Can create products and map location availability.
- Can’t transact with unavailable products.

### Chunk E — Core workflows v1 (Phase 3)

Implement “minimum complete” versions of:

- Receipt
- Movement/transit (multi-step)
- Containers/pouches (global uniqueness + rules)
- Administration/use (including 0mg warning)
- Returns and destruction

Exit criteria:

- Running balance changes correctly.
- All actions audited.
- “Happy path” UX exists for each workflow.

### Chunk F — Inventory control (Phase 4) ✅ COMPLETE

**Completed:** January 7, 2026 **Tests:** 9/9 passing (100%) **Summary:**
[CHUNK-F-SUMMARY.md](CHUNK-F-SUMMARY.md)

- Stock count workflows (single-drug, delivery-scoped, full) ✅
- Discrepancy workflows (case management, severity, resolution) ✅
- Replenishment (par/min/max, auto-recommendations) ✅
- Frontend components (DiscrepancyCaseList, ReplenishmentDashboard, StockCountForm) ✅

### Chunk G — Temperature/storage compliance (Phase 5)

- Sensors, readings, excursion detection, alarms

### Chunk H — Reporting + inspection packs (Phase 6)

- AO dashboards
- Exports (Excel/CSV + human-readable register view)
- Inspection mode

### Chunk I — Offline + sync (Phase 7)

- Offline capture (queue), sync, conflict handling
- This is technically hard; treat as its own workstream

### Chunk J — Incidents (Phase 8)

- A/B/C forms with exact field sets
- Attachments, notifications
- Search

### Chunk K — Integrations (Phase 9)

- Outbox
- External references (Datix etc.)
- Cabinet integration hooks

### Chunk L — Retention/archiving (Phase 10)

- Configurable retention
- Archive access mode

### Chunk M - Code Review

- Review all summaries (`CHUNK-<letter>-SUMMARY.md` files) for
  - known issues
  - technical debt
  - remaining work
- Create a new file in this directory (`implementation/`) called 'code-review.md'
- Populate the code-review.md file with a plan to remediate the tech debt

### Chunk N - Tech Debt Payoff

- Address technical debt

---

## 3) Where AI will likely get stuck

1. **Ambiguous policy decisions** (what is configurable vs hard requirement).
2. **Offline sync semantics** (conflict resolution that preserves audit truth).
3. **Event model boundaries** (what constitutes an event; how projections are derived).
4. **Permissions** (granularity, naming, enforcing role hierarchy).
5. **Reporting/export fidelity** (inspection-ready outputs are picky).
6. **Operational UX** (fast flows + safe prompts + accessibility).

Mitigations:

- Maintain a short, explicit “Decisions” doc (see implementation/questions.md).
- Force vertical slices with tests.
- Keep a stable interface per subsystem (EventStore, AuditLog, Auth).

---

## 4) AI operating instructions (how to run the agent)

### Don’t do it in one run

Even large-context models will drift. Use **multiple passes**.

Recommended loop per chunk:

1. Re-read: features phase + relevant spec/design sections.
2. Implement minimal vertical slice.
3. Add tests.
4. Run locally + CI.
5. Summarise decisions + update docs.

### Context management

Give the agent a small “context pack” each run:

- `docs/planning/features.md` (and only the phase being implemented)
- `docs/planning/specification.md` (relevant sections)
- `docs/planning/design-document.md` (relevant sections)
- `implementation/context-pack.md` (short, stable constraints)
- `implementation/questions.md` (unresolved decisions)

---

## 5) Non-negotiables (quality gates)

- Accessibility: target WCAG 2.2 AA (keyboard nav, focus states, readable errors).
- Audit immutability: no destructive edits of CD history.
- Every state change emits an event.
- Security: least privilege; no shared logins.
- Tests exist for: balances, event immutability, permission gates.
