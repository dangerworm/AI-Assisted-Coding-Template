# Context pack (stable constraints for AI runs)

Use this as the short, always-include context for any AI coding run. This document defines **stable
constraints, expectations, and guardrails** that apply across all sessions unless explicitly
overridden.

---

## Canonical docs

These documents are the source of truth. If anything conflicts, **these win**.

- [Architecture/design decisions](../docs/planning/architecture.md)
- [Feature delivery roadmap (ordered)](../docs/planning/features.md)
- [Requirements specification](../docs/planning/specification.md)

---

## Hard constraints

These are **non-negotiable invariants**. Do not violate them unless explicitly instructed to do so.

- [PLACEHOLDER: Core data integrity constraint]
- [PLACEHOLDER: Event / state mutation rules]
- [PLACEHOLDER: Audit / traceability requirements]
- [PLACEHOLDER: Accessibility or compliance targets]
- [PLACEHOLDER: Multi-tenancy or isolation rules]
- [PLACEHOLDER: Primary operational datastore choice]
- [PLACEHOLDER: Secondary / supporting datastore choice]
- [PLACEHOLDER: Authentication / identity provider strategy]

---

## Working style constraints

These define _how work should be approached_, not what to build.

- Implement work in chunks aligned to `features.md`
- Each chunk should normally include:
  - Backend logic
  - Data model changes / migrations
  - UI or interface changes (if applicable)
  - Tests
  - Documentation updates (decisions, config, assumptions)
- Prefer **vertical slices** (end-to-end features) over horizontal layers
- Maintain scratch-pad or context files as understanding evolves

---

## “Definition of done” per chunk

A chunk is considered complete only when:

- The feature works end-to-end in the local development environment
- Relevant permission / access checks are enforced
- Required audit / event / logging behaviour is implemented
- Critical logic is covered by tests
- Isolation / boundary rules are verified

---

## AI Assessment (YYYY-MM-DD)

**Feasibility: [YES / NO / CONDITIONAL]**

### System Scope Analysis

[PLACEHOLDER: High-level description of what the system is and does]

This typically includes:

- Primary domain responsibilities
- Key workflows or lifecycles
- Integration points
- Operational and non-functional concerns

---

### Complexity Level: [LOW / MEDIUM / HIGH]

This system involves complexity in areas such as:

- [PLACEHOLDER: Regulatory / compliance considerations]
- [PLACEHOLDER: Data integrity or audit requirements]
- [PLACEHOLDER: Performance or reliability expectations]
- [PLACEHOLDER: Security or identity complexity]
- [PLACEHOLDER: Domain modelling challenges]

---

### What Makes This Achievable

1. **Documentation Quality**

   - Requirements are explicit and normative
   - Design decisions include rationale
   - Features are ordered and scoped
   - Trade-offs are documented
   - Cross-references are consistent

2. **Structured Delivery Approach**

   - Work is phased and incremental
   - Vertical slicing reduces risk
   - Definition of Done enforces quality
   - Scratch-pad system preserves context

3. **Technical Foundations**

   - Chosen architecture matches problem shape
   - Persistence strategy separates concerns appropriately
   - Local development environment mirrors production shape
   - Auth and integration boundaries are explicit

4. **Existing Scaffold (if applicable)**

   - Base infrastructure exists
   - Some domain concepts are prototyped
   - Development tooling is in place

---

### Key Success Factors

1. **Adherence to Specification**

   - Prevents scope drift
   - Preserves core invariants
   - Anchors implementation decisions

2. **Incremental Validation**

   - Each chunk is demonstrable
   - Tests cover critical paths
   - Human review gates exist where required

3. **Complexity Management**

   - Clear bounded contexts
   - Explicit contracts between components
   - Isolation enforced at boundaries

4. **Effective Use of Scratch Pads**

   - Track decisions and insights
   - Capture blockers and open questions
   - Maintain evolving working context
   - Sequence work explicitly

---

### Risks and Mitigations

**Risk:** [PLACEHOLDER: Major technical or organisational risk] → **Mitigation:** [PLACEHOLDER: How
this risk is managed]

**Risk:** [PLACEHOLDER] → **Mitigation:** [PLACEHOLDER]

---

### Recommended Implementation Strategy

1. **Chunk A**: [PLACEHOLDER: Foundational work]

   - [PLACEHOLDER: Environment or tooling setup]
   - [PLACEHOLDER: Infrastructure or config work]
   - [PLACEHOLDER: Documentation updates]

2. **Chunk B**: [PLACEHOLDER: Core capability]

   - [PLACEHOLDER: Identity / permissions / core models]
   - [PLACEHOLDER: Supporting UI or APIs]

3. **Chunk C+**: [PLACEHOLDER: Progressive feature delivery]

   - Follow `features.md` ordering strictly
   - Each chunk includes implementation + tests + audit + docs
   - Continuous validation and review

---

### Confidence Level: [PERCENTAGE OR QUALITATIVE]

**Can this be built to production-grade quality?** [YES / YES WITH CONDITIONS / NO]

Conditions may include:

- Human review of security-critical code
- Domain expert validation
- Load / performance testing
- Penetration testing
- Regular checkpoint reviews

**Estimated effort:** [PLACEHOLDER: Time estimate with assumptions]

---

This document exists to stabilise context across AI runs. If assumptions change, update this file
explicitly.
