# Context pack (stable constraints for AI runs)

> **The below content is provided as an example of layout, content, and
> structure.**

---

## Canonical docs

These documents are the source of truth. If anything conflicts, **these win**.

- [Architecture/design decisions](../../../docs/planning/architecture.md)
- [Feature delivery roadmap (ordered)](../../../docs/planning/features.md)
- [Requirements specification](../../../docs/planning/requirements.md)
- [Technologies](../../../docs/planning/technologies.md)

## Hard constraints

These are **non-negotiable invariants**. Do not violate them unless explicitly
instructed to do so.

- [PLACEHOLDER: Core data integrity constraint]
- [PLACEHOLDER: Event / state mutation rules]
- [PLACEHOLDER: Audit / traceability requirements]
- [PLACEHOLDER: Accessibility or compliance targets]
- [PLACEHOLDER: Multi-tenancy or isolation rules]
- [PLACEHOLDER: Primary operational datastore choice]
- [PLACEHOLDER: Secondary / supporting datastore choice]
- [PLACEHOLDER: Authentication / identity provider strategy]

## Working style constraints

These define _how work should be approached_, not what to build.

> The following is an example from a previous project

- Implement work in chunks aligned to
  [features.md](../../../docs/planning/features.md)
- Each chunk should normally include (in order):
  - Data model changes / migrations
  - Backend logic
  - UI or interface changes (if applicable)
  - Tests
  - Documentation updates (decisions, config, assumptions)
- Prefer **vertical slices** (end-to-end features) over horizontal layers
- Maintain scratch-pad or context files as understanding evolves

## "Definition of done" per chunk

> The following is an example from a previous project

A chunk is considered complete only when:

- The feature works end-to-end in the local development environment
- Relevant permission / access checks are enforced
- Required audit / event / logging behaviour is implemented
- Critical logic is covered by tests
- Isolation / boundary rules are verified

## AI Assessment (YYYY-MM-DD)

**Feasibility: [YES / NO / CONDITIONAL]**

### System Scope Analysis

[PLACEHOLDER: High-level description of what the system is and does]

This typically includes:

- Primary domain responsibilities
- Key workflows or lifecycles
- Integration points
- Operational and non-functional concerns

### Complexity Level: [LOW / MEDIUM / HIGH]

This system involves complexity in areas such as:

- [PLACEHOLDER: Regulatory / compliance considerations]
- [PLACEHOLDER: Data integrity or audit requirements]
- [PLACEHOLDER: Performance or reliability expectations]
- [PLACEHOLDER: Security or identity complexity]
- [PLACEHOLDER: Domain modelling challenges]

### What Makes This Achievable

> The following is an example from a previous project

1. **Exceptional Documentation Quality**

   - Specification is normative and complete
   - Design decisions are explicit with rationale
   - Features are prioritized and implementation-ordered
   - Trade-offs are documented transparently
   - Cross-references are consistent

1. **Structured Delivery Approach**

   - Clear phasing (0-7) from foundations to advanced features
   - Vertical slicing strategy prevents "big bang" failures
   - Definition of Done per chunk ensures quality gates
   - Scratch pad system provides memory across context windows

1. **Smart Technical Choices**

   - Data storage choices fit the domain
   - Audit/event strategy matches requirements
   - Local dev environment mirrors production where feasible
   - Identity strategy avoids provider lock-in where needed

1. **Existing Scaffold**
   - Baseline API/UI skeleton exists
   - Some domain concepts prototyped
   - Local development environment foundations exist

### Key Success Factors

> The following is an example from a previous project

1. **Strict Adherence to Specification**

   - The normative requirements prevent drift
   - Design principles (audit-first, trust-agnostic) are guardrails
   - Feature list provides concrete implementation targets

1. **Incremental Validation**

   - Each chunk must be demonstrable
   - Tests must cover critical paths
   - Human review gates prevent accumulating technical debt

1. **Domain Complexity Management**

   - Event model is well-defined
   - Bounded contexts are clear (identity, inventory, audit, reporting)
   - Multi-tenancy enforced at every boundary

1. **Use of Scratch Pad System**
   - Track architectural decisions in insights.md
   - Document blockers/questions immediately
   - Maintain working context in context-pack.md
   - Use plan.md to sequence work and track progress

### Risks and Mitigations

**Risk:** [PLACEHOLDER: Major technical or organisational risk] ->
**Mitigation:** [PLACEHOLDER: How this risk is managed]

**Risk:** [PLACEHOLDER] → **Mitigation:** [PLACEHOLDER]

### Recommended Implementation Strategy

1. **Chunk A**: [PLACEHOLDER: Foundational work]

   - [PLACEHOLDER: Environment or tooling setup]
   - [PLACEHOLDER: Infrastructure or config work]
   - [PLACEHOLDER: Documentation updates]

1. **Chunk B**: [PLACEHOLDER: Core capability]

   - [PLACEHOLDER: Identity / permissions / core models]
   - [PLACEHOLDER: Supporting UI or APIs]

1. **Chunk C+**: [PLACEHOLDER: Progressive feature delivery]

   - Follow [features.md](/docs/planning/features.md) ordering strictly
   - Each chunk includes implementation + tests + audit + docs
   - Continuous validation and review

### Confidence Level: [PERCENTAGE OR QUALITATIVE]

**Can this be built to production-grade quality?** [YES / YES WITH CONDITIONS /
NO]

Conditions may include:

- Human review of security-critical code
- Domain expert validation
- Load / performance testing
- Penetration testing
- Regular checkpoint reviews

**Estimated effort:** [PLACEHOLDER: Time estimate with assumptions]

This document exists to stabilise context across AI runs. If assumptions change,
update this file explicitly.
