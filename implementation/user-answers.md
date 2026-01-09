# Answers (interpreted decisions)

This document captures the decisions made in response to `implementation/questions.md`, in a
form that an AI coding agent can treat as binding constraints.

## P0 (decided; implement immediately)

### Operational DB

- Use **PostgreSQL**.
- Do **not** run Postgres in Docker for local development.
- Prefer a Postgres instance running directly on the host OS.

Implications:

- Provide a local setup guide for Windows Postgres installation.
- Use EF Core Postgres provider (`Npgsql.EntityFrameworkCore.PostgreSQL`).
- Remove SQL Server LocalDB assumptions from config.

### AWS dependencies in dev

- Use **LocalStack** for local development.
- Implement AWS integrations behind interfaces/config so switching to real AWS later is a config
  change, not a rewrite.

Implications:

- No LocalStack-only code paths.
- All AWS clients must be configurable (service URLs/endpoints, credentials, region).

### Authentication / OIDC

Use a **Keycloak broker** pattern.

Local dev (fast workflow):

- Keycloak with a realm import that defines:
  - clients
  - roles/groups
  - a couple of local users (e.g. admin/admin, user/user)
- No upstream IdPs needed day-to-day.

Integration tests / pre-prod confidence:

- Keycloak + upstream IdPs started in CI:
  - Dex (Upstream A)
  - Dex (Upstream B) or `node-oidc-provider`
- Tests must exercise:
  - login via upstream A/B
  - claim mapping and role mapping
  - logout + refresh flows
  - JWKS rotation / key rollover behavior

Production:

- Keycloak upstreams point to real providers.
- Your apps keep the same issuer shape per environment (only config changes).

App-facing claims contract (standardised at the broker):

- Always emit: `sub`, `email`, `preferred_username`
- Emit your own roles/permissions claim (consistent across upstreams)

### Multi-tenancy

- This is **100% a tenanted system** from day one.
- Treat tenancy as a hard boundary.

Implications:

- Every operational row/event must carry a `TenantId`/`OrganisationId`.
- Every query and permission check must be tenant-scoped.

## P1 (decided; implement before core workflows)

### Event store (DynamoDB)

- Use a **single-table** DynamoDB design.
- Partition key is based on tenant + record category.

Your suggested direction:

- Partition by tenant ID and record type, e.g.
  - `tenantId:event`
  - `tenantId:alert`
  - `tenantId:notification`
- Sort key format such as:
  - `event-type:id`
  - `alert-type:id`
  - `notification-type:id`

Suggested refinement (keeps your intent, improves queryability):

- Use explicit prefixes and include time-ordering where needed.
- Example:
  - `PK = TENANT#{tenantId}#CAT#EVENT`
  - `SK = TS#{isoTimestamp}#TYPE#{eventType}#ID#{ulid}`

This makes “latest events” and “events in time range” efficient without extra GSIs.

### Attachments

- Store attachments in S3.
- Max size: **5MB**.
- Retention: **2 years**.
- Encrypted at rest.

Implications:

- Enforce size at API boundary.
- Apply lifecycle rules for retention.
- Use SSE (SSE-S3 or SSE-KMS depending on environment).

### Identity scope (global vs tenant)

Interpretation of your intent:

- Entities that are **tenant-specific** (pouches/containers, locations, policy groups) are scoped
  **per tenant**.
- Entities that correspond to recognised standards (e.g. medicines identified by dm+d) can be
  treated as **global** references.
- The **local IDs** used to identify/label global things in a tenant UI/config are still
  tenant-scoped.

Search behavior:

- Global entities: search behavior is consistent across tenants.
- Tenant entities: search is tenant-scoped.

Model assumption:

- Two levels only: **Global** and **Tenant**.
- If an organisation wants separation within itself, they should be advised to run multiple
  tenancies.

## P2 (partly decided; plan now)

### Reporting formats and data access

- Support **CSV**, **JSON**, and **PDF** outputs.
- Provide an API that tenants can call (with appropriate auth/permissions) to query their data for
  downstream systems.

Implications:

- Treat “tenant data export API” as a first-class feature with strong permissions, rate limits, and
  audit logging.

### Temperature ingestion

- Support both:
  - manual entry
  - external ingestion

Implications:

- Use a single ingestion API/service path so different entry points feed the same validation and
  event emission.

### Offline

- Choose **Offline-lite**.
- Implement a durable client outbox (IndexedDB) of commands with client-generated idempotency keys.
- Server validates commands against authoritative state and emits immutable events.
- Use DynamoDB as the append-only source of truth; Postgres is a projection/read model.
- Use per-tenant projection checkpoints with an authoritative cursor (not just timestamps) to replay
  events from “last processed” to “latest” and update Postgres.
- Clients periodically sample server UTC (e.g. `GET /time`) and store offset + uncertainty (half
  RTT). Offline commands carry this metadata for reconstruction; server ingest time remains
  authoritative.
