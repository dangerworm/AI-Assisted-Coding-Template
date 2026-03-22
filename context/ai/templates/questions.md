# Questions / open decisions

> **The below content is provided as an example of layout, content, and
> structure.**

---

## 1. [yyyy-mm-dd]: Identity provider (OIDC)

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

## 2. [yyyy-mm-dd]: Environments and secrets

Decide how you want to run dev:

- Local-only (native tools or Docker)
- Local + real cloud resources
- Local emulation (if your platform supports it)

For dev/staging/prod:

- Environments you need (dev/staging/prod)
- Secret management approach
- Naming conventions (if relevant)

## 3. [yyyy-mm-dd]: Operational database choice

Choose one:

- [PLACEHOLDER: Postgres / MySQL / SQL Server / SQLite / etc]

Provide connection string conventions and whether you want a dockerised database
for local development.
