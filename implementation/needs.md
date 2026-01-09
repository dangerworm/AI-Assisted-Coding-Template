# Needs (inputs for an AI to build eCDR)

This file lists **inputs a coding agent will need** that are not fully specified in the repo.

## 1) Identity provider (OIDC)

Provide one of:

- **Azure AD / Entra ID** tenant + app registration details, or
- **Auth0** domain + client id/secret, or
- Another OIDC provider.

Needed values:

- Issuer URL
- Audience/client id
- JWKS discovery URL (usually from issuer)
- Allowed redirect URLs (frontend)
- Logout URL behavior

## 2) Environments and secrets

Decide how you want to run dev:

- Local-only (Docker + local secrets)
- Local + AWS (real DynamoDB/S3/SES)
- LocalStack for AWS emulation

For AWS-backed dev/staging/prod:

- AWS account id(s)
- Region(s)
- SES verified sender domain/address
- S3 bucket naming convention (signatures/templates)

## 3) Operational database choice

Choose one:

- **PostgreSQL** (recommended for parity with typical AWS deployments)
- **SQL Server** (the repo currently configures LocalDB in dev)

If PostgreSQL: provide connection string conventions and whether you want Dockerised Postgres for
local.

## 4) dm+d / medicine reference data

Decide:

- Do you want a **real dm+d import** (requires data source + update cadence), or
- A **curated starter dataset** for development.

If real import, provide:

- Source location (download URL, NHSBSA/TRUD access, or internal file drop)
- License constraints you want respected
- Update cadence (monthly?)

## 5) Roles, permissions, and default policies

The code has a `Permissions` list but it’s currently inconsistent.

Provide:

- The set of roles you want out of the box (e.g. Admin, AO/CDAO, OM, Pharmacy, Clinician, Auditor)
- Which permissions each role should have
- Any “must have witness” rules you already know (or confirm defaults)

## 6) Retention / archiving expectations

Provide:

- Minimum retention period you want to design for (even if configurable)
- Whether archived data must remain queryable in-app vs export-only

## 7) Incident workflow expectations

You already have exact WMAS A/B/C fields.

Clarify:

- Do you want the UI to **match the existing paper/PDF layout**, or just capture the same data?
- Attachment types/size limits
- Notification recipients rules

## 8) UI/UX constraints

Provide:

- Brand/logo (optional)
- Accessibility target confirmation (recommended: WCAG 2.2 AA)
- Target devices: desktop only vs tablet + mobile
- Any “must be fast” workflows (top 3)

## 9) Hosting target (when you get there)

Even if you’re not deploying yet, decide what the agent should optimize for:

- AWS Lambda/API Gateway
- Containerized (ECS/Fargate)
- Single VM

This affects auth, networking, and file/attachment handling.
