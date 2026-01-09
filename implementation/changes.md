# Repo changes (to be truly “press go” ready)

This is a punch list of changes that will reduce AI confusion and increase success rate.

> **The below content is provided purely as an example.**

## Documentation alignment

- Update [app/README.md](../app/README.md) to match reality:
  - Target frameworks
  - Data provider
  - Repo structure

## Local dev environment

- Add `docker-compose.yml` at repo root

  - List services here

- Add `.env.example` for:
  - API URL
  - OIDC issuer/audience
  - AWS/Azure/LocalStack endpoints
  - Storage bucket names
  - Other

## CI/CD

- Add a GitHub Actions workflow:
  - Build backend
  - Run unit tests
  - Build frontend
  - Run frontend lint

## Testing baseline

- List of test projects

## Frontend baseline

- How to lay out the front end

## Config hygiene

Set up guidance and templates for the relevant tech stack:

Examples:

- Add `appsettings.Development.json` template (without secrets).
- Add guidance for running HTTPS locally (dev cert).

## Data model hygiene

Examples:

- Standardize permission naming in `<project>`.
- Ensure every table row has `OrganisationId` if multi-org is planned.
