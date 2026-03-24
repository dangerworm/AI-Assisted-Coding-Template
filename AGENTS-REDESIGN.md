# Agent Information — REDESIGN Mode

## Purpose

In REDESIGN mode your job is to critically assess the existing system (or its
documentation), propose specific modernisation improvements, and collaborate
with the human to produce a revised set of planning documents representing the
target state — the system as it _should_ be built.

This is an opinionated, conversational mode. You are expected to make concrete
recommendations, justify them clearly, acknowledge trade-offs honestly, and then
listen. Do not hedge everything into a list of options; if you have a clear
recommendation, make it.

Do not write application code in this mode. Produce planning documents and
decision records only.

## Operating constraints

### Always

- Tag every proposal with `[MUST]`, `[SHOULD]`, `[COULD]`, or `[KEEP]`
- Read all planning documents before forming any opinions
- Record every decision — accepted, rejected, or deferred — in both
  `redesign-notes.md` and `decisions.md`

### Ask first

- Any `[MUST]` item the human wants to challenge or defer
- The scope of the redesign — what is in and what is out
- Constraints on the human's side (budget, team skills, timeline, regulation)
  before finalising recommendations

### Never

- Write project output or application code
- Delete or overwrite original planning documents without archiving them to
  `docs/planning/legacy/` first
- Switch mode to BUILD without the human explicitly confirming the revised
  planning documents are ready

---

## When to use this mode

- After a DISCOVER run, when the existing system is old, immature, or
  badly-architected
- When the human wants a second opinion on their current approach before
  committing to BUILD
- When significant technology choices need revisiting before development begins

REDESIGN is optional. If the discovered system is reasonably modern and
well-structured, tell the human that they can proceed directly from DISCOVER to
BUILD, but make sure they are given the choice.

## Success criteria

A successful REDESIGN run produces:

- [`context/ai/redesign-notes.md`](/context/ai/redesign-notes.md) tracking all
  proposals, their status, and the reasoning behind each decision
- Revised planning documents in `docs/planning/` that describe the system _to be
  built_, not the system _that exists_
- A clear record of what is being changed and why, so the BUILD agent
  understands the intent behind the new design

## Assessment areas

Evaluate the existing system across these areas. For each, note what is already
good as well as what should change.

### Data architecture

- Is the data model normalised appropriately for its access patterns?
- Are the right storage technologies in use? Consider whether a relational
  database, document store, key-value store, graph database, time-series store,
  or event store (or a combination) would be a better fit for each concern
- Is a single monolithic data store being asked to do too many things?
- Are events, audit trails, or read models stored in a way that supports
  querying and replay?

### Application architecture

- Is the layering clean, with no circular dependencies and appropriate
  separation of concerns?
- Is the system a monolith where bounded services would help, or over-split
  where consolidation would reduce operational complexity?
- Is there appropriate use of caching, queuing, and background processing?
- Are there synchronous calls where async patterns would be more resilient?
- Is business logic leaking into the wrong layers?

### Frontend

- Is the UI framework modern, actively maintained, and appropriate for the level
  of interactivity required?
- Is server-rendered HTML (MVC, Razor, Blade, ERB, etc.) being used in a context
  where a component framework (React, Vue, Svelte, etc.) would significantly
  improve user experience or developer productivity?
- Conversely, is a heavy client-side framework being used where server-rendered
  HTML would be simpler and faster?
- Is there appropriate separation between the API and the UI?

### API design

- Is the API style appropriate and applied consistently? (REST, GraphQL, gRPC,
  tRPC — pick one and use it)
- Are there inconsistencies in naming conventions, versioning, error shapes, or
  authentication patterns across endpoints?
- Is the API designed for the actual consumers, or was it an afterthought?

### Infrastructure and deployment

- Is the deployment model appropriate for the expected scale and team size?
- Is there a credible path to horizontal scaling if traffic grows?
- Are secrets, configuration, and environment management handled correctly? (No
  secrets in source control, proper use of environment variables or a secrets
  manager)
- Is there CI/CD? If not, should there be?
- Is the infrastructure expressed as code, or is it manual and undocumented?

### Security

- Are authentication and authorisation handled at the correct layer and applied
  consistently?
- Are there obvious vulnerabilities in the current approach? (SQL injection,
  XSS, CSRF, insecure direct object references, exposed secrets)
- Is input validated at the boundary? Is output encoded appropriately?
- Are dependencies audited for known vulnerabilities?

### Developer experience

- Are dependencies outdated, unsupported, or end-of-life?
- Is the test coverage adequate? Are the tests testing the right things?
- Are there repetitive manual processes that should be automated?
- Is the local development setup documented and reproducible?

## Recommendation format

Structure each recommendation as follows:

**Area:** [which assessment area this falls under]

**Current approach:** [what the system does now, specifically]

**Recommended approach:** [what you propose instead, specifically — name the
technology, pattern, or approach]

**Why:** [concrete benefits: performance, maintainability, security, developer
experience, cost reduction, reduced operational complexity, etc.]

**Trade-offs:** [what the human gives up or takes on by making this change —
migration effort, learning curve, new dependencies, etc.]

**Migration complexity:** Low / Medium / High — with a brief rationale

**Priority:**

Use one of:

- `[MUST]` — critical: a security vulnerability, a deprecated or unsupported
  dependency, or a decision that blocks the rest of the redesign. These should
  be adopted unless the human has a specific overriding reason.
- `[SHOULD]` — a clear improvement with a reasonable migration path; your
  primary recommendations.
- `[COULD]` — a worthwhile improvement but not urgent; defer unless the team has
  capacity.
- `[KEEP]` — something that is already good; call it out explicitly so the BUILD
  agent knows to preserve it.

## Workflow

### Step 1: Read

Read the existing planning documents before forming any opinions:

- [`docs/planning/architecture.md`](/docs/planning/architecture.md)
- [`docs/planning/features.md`](/docs/planning/features.md)
- [`docs/planning/requirements.md`](/docs/planning/requirements.md)
- [`docs/planning/technologies.md`](/docs/planning/technologies.md)
- [`docs/reference/schema.md`](/docs/reference/schema.md)
- [`context/ai/discover-progress.md`](/context/ai/discover-progress.md) (if a
  DISCOVER run was completed)

### Step 2: Assess and propose

Create [`context/ai/redesign-notes.md`](/context/ai/redesign-notes.md) from the
template at `context/ai/templates/redesign-notes.md`.

Work through each assessment area in turn. For each:

- Call out what is good with `[KEEP]`
- Produce concrete recommendations for what should change, tagged by priority
- Be direct: name the specific technologies, patterns, and approaches you
  recommend, and say clearly why

### Step 3: Present to the human

Group your recommendations and present them in this order:

1. `[MUST]` items — non-negotiable; present these first
2. `[SHOULD]` items — your primary recommendations; ask the human to accept,
   reject, or defer each one
3. `[COULD]` items — optional; ask the human whether they have capacity
4. `[KEEP]` items — confirm these will be carried forward

For each `[SHOULD]` and `[COULD]` item, the human should indicate: **Accept**,
**Reject**, or **Defer**. Record their reasoning if they reject or defer.

### Step 4: Record decisions

For each proposal the human responds to:

1. Update its status in `redesign-notes.md`
2. Append a durable decision record to
   [`context/ai/decisions.md`](/context/ai/decisions.md)
3. Remove the corresponding question from `questions.md` and answer from
   `answers.md` if the Q&A flow was used

### Step 5: Revise the planning documents

Once all proposals have been reviewed:

- Update `docs/planning/architecture.md`, `features.md`, `requirements.md`,
  `technologies.md`, and `docs/reference/schema.md` to reflect the agreed target
  state
- If the changes are substantial, preserve the originals as
  `docs/planning/legacy/` so the DISCOVER output is not lost
- The revised documents must describe the system _to be built_, not the system
  _that exists_ — remove hedging language and DISCOVER-mode inference tags where
  the redesign has superseded them
- Note significant departures from the original in
  [`context/ai/changes.md`](/context/ai/changes.md)

### Step 6: Hand off to BUILD

When the planning documents reflect the agreed target state:

1. Mark the redesign as complete in `redesign-notes.md`
2. Update [`context/MODE.md`](/context/MODE.md) to `BUILD`
3. Prompt the human to do a final review of the revised docs before the BUILD
   agent begins

## Do not do everything in one run

Even large-context models drift.

Recommended loop:

1. Read `context/ai/redesign-notes.md` and the planning documents
2. Read `context/user/questions.md` and `context/user/answers.md`
3. Complete one assessment area, or one round of the design conversation
4. Update `redesign-notes.md` with findings or decisions
5. Stop and prompt the human to review before continuing

## Blocked? Ask, then record decisions

Same process as other modes:

1. Append the question to
   [`context/user/questions.md`](/context/user/questions.md)
2. Add a matching slot in [`context/user/answers.md`](/context/user/answers.md)
3. Continue where possible with a clearly stated assumption; stop if genuinely
   blocked

On the next run, process answers into
[`context/ai/decisions.md`](/context/ai/decisions.md) and remove the
corresponding entries from `questions.md` and `answers.md`.
