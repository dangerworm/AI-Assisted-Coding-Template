# Customising the agent files

When you fork this repository, the three mode files
([`AGENTS-BUILD.md`](/AGENTS-BUILD.md),
[`AGENTS-REDESIGN.md`](/AGENTS-REDESIGN.md),
[`AGENTS-DISCOVER.md`](/AGENTS-DISCOVER.md)) contain generic guidance that
works for most projects out of the box.

For best results, add project-specific context to the relevant mode file —
particularly `AGENTS-BUILD.md`, which is where the agent will spend most of
its time. `AGENTS.md` itself should remain a short router; do not add project
detail there.

---

## What to add to AGENTS-BUILD.md (and why)

Think of additions to AGENTS-BUILD.md as answers to the question: "What would
a new developer need to know on day one that isn't already obvious from the
code or the planning documents?"

AGENTS.md should be short enough that an agent can internalise it in one pass.
The research benchmark is roughly 150-200 distinct instructions; beyond that,
compliance degrades. Favour precision over completeness.

### Architectural boundaries and invariants

Tell the agent what must not be broken and what patterns are intentional. This
is the most important addition. Without it, agents are very good at improving
things locally and very bad at respecting invisible global constraints.

Examples:

- "This is event-sourced; do not introduce mutable state."
- "The database schema is append-only."
- "The API layer must not reference infrastructure concerns."
- "All monetary values are stored as integers (pence/cents); never use floats."

### Conventions that actually matter

Not every style rule — only the ones you would push back on in a review.

Examples:

- Formatting tools that must be run before committing
- Naming conventions that carry semantic meaning
- Patterns you deliberately repeat across the codebase

This prevents the agent from "helpfully" rewriting half the project into its
preferred idiom.

### An explicit "never do" list

Agents default to action. A short list of prohibitions gives them permission
to stop.

Examples:

- "Do not rename public types."
- "Do not change serialisation formats without explicit instruction."
- "Do not introduce new dependencies unless asked."

### Testing and verification expectations

Spell out what "done" means for this project. Agents will happily produce
output that passes a surface check and quietly breaks invariants.

Examples:

- What kinds of tests exist and where they live
- Whether tests are mandatory before marking a stage complete
- Any manual verification steps that are required

### Tone and collaboration hints

This sounds optional, but it works. Agents mirror explicit tone guidance
surprisingly well.

Examples:

- "Prefer clarity over cleverness."
- "Assume future readers are tired."
- "If unsure whether a change is in scope, ask before making it."

---

## What does NOT belong in agent files

- Long tutorials or onboarding guides (put those in `docs/`)
- Full API or schema documentation (put those in `docs/reference/`)
- Anything that changes frequently (it will drift out of date)
- Content already covered clearly in `README.md`
- Content that can be inferred directly from the code or planning documents
