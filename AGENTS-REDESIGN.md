# Agent Information - REDESIGN Mode

## Purpose

Critically assess the existing system (or its documentation), propose specific
modernisation improvements, and collaborate with the human to produce a revised
set of planning documents representing the target state - the system as it
_should_ be built.

This is an opinionated, conversational mode. Make concrete recommendations,
justify them clearly, acknowledge trade-offs honestly, and then listen. Do not
hedge everything into a list of options; if you have a clear recommendation,
make it.

REDESIGN is optional. If the discovered system is reasonably modern and
well-structured, tell the human they can proceed directly to BUILD.

Do not write application code in this mode.

## Operating constraints

### Always

- Tag every proposal with `[MUST]`, `[SHOULD]`, `[COULD]`, or `[KEEP]`
- Read all planning documents before forming any opinions
- Record every decision - accepted, rejected, or deferred - in both
  `redesign-notes.md` and `decisions.md`

### Ask first

- Any `[MUST]` item the human wants to challenge or defer
- The scope of the redesign - what is in and what is out
- Constraints on the human's side (budget, team skills, timeline, regulation)
  before finalising recommendations

### Never

- Write project output or application code
- Delete or overwrite original planning documents without archiving them to
  `docs/planning/legacy/` first
- Switch mode to BUILD without the human explicitly confirming the revised
  planning documents are ready

---

## Success criteria

A successful REDESIGN run produces:

- [`context/ai/redesign-notes.md`](/context/ai/redesign-notes.md) tracking all
  proposals, their status, and the reasoning behind each decision
- Revised planning documents in `docs/planning/` describing the system _to be
  built_, not the system _that exists_
- A clear record of what is being changed and why, so the BUILD agent
  understands the intent behind the new design

---

## Session start

### Returning to an existing redesign

1. Read [`context/ai/redesign-notes.md`](/context/ai/redesign-notes.md) to find
   which assessment areas have been completed and which proposals are pending
2. Read [`context/ai/decisions.md`](/context/ai/decisions.md)
3. Read [`context/user/questions.md`](/context/user/questions.md) and
   [`context/user/answers.md`](/context/user/answers.md)
4. Resume from the last incomplete assessment area or pending proposal

### First run

Read the existing planning documents before forming any opinions:

- [`docs/planning/architecture.md`](/docs/planning/architecture.md)
- [`docs/planning/features.md`](/docs/planning/features.md)
- [`docs/planning/requirements.md`](/docs/planning/requirements.md)
- [`docs/planning/technologies.md`](/docs/planning/technologies.md)
- [`docs/reference/schema.md`](/docs/reference/schema.md)
- [`context/ai/discover-progress.md`](/context/ai/discover-progress.md) (if a
  DISCOVER run was completed)
- [`docs/behaviour/`](/docs/behaviour/) - read any `actual` and `stated` layer
  files as context. These are **not hard requirements** in REDESIGN: the goal is
  to decide what the system _should_ do. Note divergences between stated and
  actual files as they may indicate bugs or undocumented behaviour.

Then create [`context/ai/redesign-notes.md`](/context/ai/redesign-notes.md)
from the template at `context/ai/templates/redesign-notes.md`.

---

## Assessment areas

Evaluate the existing system across these areas. For each, note what is already
good (`[KEEP]`) as well as what should change.

### Data architecture

- Is the data model normalised appropriately for its access patterns?
- Are the right storage technologies in use? (relational, document, key-value,
  graph, time-series, event store, or a combination)
- Is a single monolithic store being asked to do too many things?
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

- Is the UI framework modern, actively maintained, and appropriate for the
  level of interactivity required?
- Is server-rendered HTML being used where a component framework would
  significantly improve UX or developer productivity?
- Conversely, is a heavy client-side framework being used where server-rendered
  HTML would be simpler and faster?
- Is there appropriate separation between the API and the UI?

### API design

- Is the API style appropriate and applied consistently? (REST, GraphQL, gRPC,
  tRPC - pick one and use it)
- Are there inconsistencies in naming conventions, versioning, error shapes, or
  authentication patterns?
- Is the API designed for its actual consumers, or was it an afterthought?

### Infrastructure and deployment

- Is the deployment model appropriate for the expected scale and team size?
- Is there a credible path to horizontal scaling if traffic grows?
- Are secrets, configuration, and environment management handled correctly?
- Is there CI/CD? If not, should there be?
- Is infrastructure expressed as code, or is it manual and undocumented?

### Security

- Are authentication and authorisation handled at the correct layer and applied
  consistently?
- Are there obvious vulnerabilities? (SQL injection, XSS, CSRF, insecure direct
  object references, exposed secrets)
- Is input validated at the boundary? Is output encoded appropriately?
- Are dependencies audited for known vulnerabilities?

### Developer experience

- Are dependencies outdated, unsupported, or end-of-life?
- Is test coverage adequate? Are the tests testing the right things?
- Are there repetitive manual processes that should be automated?
- Is the local development setup documented and reproducible?

---

## Recommendation format

**Area:** [assessment area]

**Current approach:** [what the system does now, specifically]

**Recommended approach:** [what you propose - name the technology, pattern, or
approach]

**Why:** [concrete benefits: performance, maintainability, security, developer
experience, cost, operational complexity]

**Trade-offs:** [what the human gives up or takes on: migration effort,
learning curve, new dependencies]

**Migration complexity:** Low / Medium / High - with a brief rationale

**Priority:** `[MUST]` / `[SHOULD]` / `[COULD]` / `[KEEP]`

- `[MUST]` - critical: a security vulnerability, a deprecated or unsupported
  dependency, or a decision that blocks the rest of the redesign
- `[SHOULD]` - a clear improvement with a reasonable migration path
- `[COULD]` - worthwhile but not urgent; defer unless the team has capacity
- `[KEEP]` - already good; call it out so the BUILD agent knows to preserve it

---

## Workflow

Work in small steps. After every step, update
[`redesign-notes.md`](/context/ai/redesign-notes.md) so that a session ending
mid-phase can resume at the correct point. The redesign is conversation-heavy -
wherever discussion adds or changes your understanding of the design, update the
relevant files in `docs/reference/` and `redesign-notes.md` without waiting for
the human to ask.

Recommended loop:

1. Read `context/ai/redesign-notes.md` and the planning documents
2. Read `context/user/questions.md` and `context/user/answers.md`
3. Complete one assessment area, or one round of the design conversation
4. Update `redesign-notes.md` with findings or decisions
5. Stop and prompt the human to review before continuing

### Step 1: Assess and propose

Work through each assessment area. For each:

- Call out what is good with `[KEEP]`
- Produce concrete recommendations for what should change, tagged by priority
- Name specific technologies, patterns, and approaches, and say clearly why

### Step 2: Present to the human

Group your recommendations and present them in this order:

1. `[MUST]` items - non-negotiable; present first
2. `[SHOULD]` items - ask the human to Accept, Reject, or Defer each one
3. `[COULD]` items - ask whether the team has capacity
4. `[KEEP]` items - confirm these will be carried forward

Record the human's reasoning if they reject or defer.

### Step 3: Record decisions

For each proposal the human responds to:

1. Update its status in `redesign-notes.md`
2. Append a durable decision record to
   [`context/ai/decisions.md`](/context/ai/decisions.md)
3. Remove the corresponding question from `questions.md` and answer from
   `answers.md` if the Q&A flow was used

### Step 4: Revise the planning documents

Once all proposals have been reviewed:

- Update [`docs/planning/architecture.md`](/docs/planning/architecture.md),
  [`features.md`](/docs/planning/features.md),
  [`requirements.md`](/docs/planning/requirements.md),
  [`technologies.md`](/docs/planning/technologies.md), and
  [`docs/reference/schema.md`](/docs/reference/schema.md) to reflect the agreed
  target state
- If changes are substantial, preserve the originals in `docs/planning/legacy/`
- Remove hedging language and DISCOVER-mode inference tags where the redesign
  has superseded them
- Note significant departures from the original in
  [`context/ai/changes.md`](/context/ai/changes.md)
- For each functional area where behaviour is changing, produce a `required`
  layer behaviour file in [`docs/behaviour/`](/docs/behaviour/) describing what
  the rebuilt system must do. These become hard requirements for the BUILD agent.

### Step 5: Hand off to BUILD

When the planning documents reflect the agreed target state:

1. Mark the redesign as complete in `redesign-notes.md`
2. Update [`context/MODE.md`](/context/MODE.md) to `BUILD`
3. Prompt the human to do a final review of the revised docs before BUILD begins

---

## Blocked? Ask, then record decisions

When stuck or needing clarification:

1. Append the question to
   [`context/user/questions.md`](/context/user/questions.md)
2. Add a matching slot in [`context/user/answers.md`](/context/user/answers.md)
3. Continue where possible with a clearly stated assumption; stop if genuinely
   blocked

On the next run, process answers into
[`context/ai/decisions.md`](/context/ai/decisions.md) and remove the
corresponding entries from `questions.md` and `answers.md`.
