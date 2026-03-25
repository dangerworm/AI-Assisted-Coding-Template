# Questions / open decisions

> **The below content is provided as an example of layout, content, and
> structure.**

---

## Urgency levels

Each question should be prefixed with one of:

- **[BLOCKING]** - work cannot proceed until this is answered. Raise it
  immediately and pause the relevant implementation until resolved.
- **[CLARIFYING]** - useful but not urgent. Work can continue with a reasonable
  assumption; note the assumption in `decisions.md` until the human confirms.

---

## 1. [yyyy-mm-dd] [BLOCKING]: Identity provider (OIDC)

Describe the identity/authentication approach. Examples:

- OIDC provider (hosted or self-managed)
- SAML provider
- Username/password (only if you explicitly want this)

If applicable, provide values like:

- Issuer / authority URL
- Audience / client id
- Discovery / JWKS URL
- Allowed redirect URLs (frontend)
- Logout behaviour

## 2. [yyyy-mm-dd] [CLARIFYING]: Environments and secrets

Decide how you want to run dev:

- Local-only (native tools or Docker)
- Local + real cloud resources
- Local emulation (if your platform supports it)

For dev/staging/prod:

- Environments you need (dev/staging/prod)
- Secret management approach
- Naming conventions (if relevant)

## 3. [yyyy-mm-dd] [BLOCKING]: Operational database choice

Choose one:

- [PLACEHOLDER: Postgres / MySQL / SQL Server / SQLite / etc]

Provide connection string conventions and whether you want a dockerised database
for local development.
