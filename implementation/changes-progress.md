# Repo changes (to be truly "press go" ready) - Updated after each chunk

This is a punch list of changes that will reduce AI confusion and increase success rate.

> **The below content is provided purely as an example.**

## Status: [status]

### ✅ Completed Changes

#### Documentation alignment (Chunk A)

- ✅ README.md updated to match reality (net9.0, PostgreSQL)
- ✅ Repository structure documented

#### Local dev environment (Chunk A)

- ✅ docker-compose.dev.yml created with PostgreSQL, Redis, LocalStack
- ✅ .env.example not created yet (still needed)

#### CI/CD (Chunk A)

- ✅ GitHub Actions workflow added
- ✅ Backend build + test
- ✅ Frontend build + lint

#### Testing baseline (Chunks A, B, C)

- ✅ Test project exists with comprehensive coverage
- ✅ 55 tests passing (unit + integration)
- ✅ Domain invariants tested
- ✅ Auth + GraphQL integration tests
- ✅ Event publishing integration tests

#### Frontend baseline (Chunk B, C)

- ✅ App shell with navigation (Users/Audit Log tabs)
- ✅ Admin screens: UserList, UserForm, RoleAssignment
- ✅ Audit log browsing UI with export

#### Config hygiene (Chunks A, B, C)

- ✅ appsettings.Development.json exists
- ✅ JWT auth configuration documented
- ✅ DynamoDB table names configurable
- ⏳ HTTPS dev cert guidance still needed

#### Data model hygiene (Chunks B, C)

- ✅ Permission naming standardized (resource:action pattern)
- ✅ Multi-tenancy: TenantId on all entities
- ✅ Audit fields (CreatedBy, ModifiedAt) on key entities

### ⏳ Remaining Changes

#### Environment configuration

- [ ] Add `.env.example` for:
  - API URL
  - OIDC issuer/audience
  - AWS/LocalStack endpoints
  - S3 bucket names
  - DynamoDB table names

#### Developer experience

- [ ] Add HTTPS dev cert guidance to README
- [ ] Add troubleshooting section to README
- [ ] Document LocalStack setup process

#### Security

- [ ] Add appsettings.Production.json template (without secrets)
- [ ] Document secrets management strategy (Azure Key Vault, AWS Secrets Manager)

#### Monitoring

- [ ] Add health check endpoints
- [ ] Add application insights/telemetry hooks
