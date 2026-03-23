# Decisions

This file records decisions that constrain implementation. Treat entries here as
binding until explicitly superseded.

## Seeding at project start

Do not leave this file empty. Before the first chunk begins, scan existing
design documents (`docs/planning/*`, `schema.md`, conversation transcripts, or
any reference material the human provides) and extract decisions that are already
implicitly made. Write them as decision records below.

A decision worth recording is any constraint that, if violated, would cause
significant rework — database engine, auth approach, deployment target, API
style, data ownership rules, etc.

When a human answers questions in [answers.md](/context/user/answers.md), the
agent should:

1. Append a decision record here.
2. Remove the answered question(s) from
   [questions.md](/context/user/questions.md).
3. Remove the accepted answer(s) from [answers.md](/context/user/answers.md).

## Decision log

No questions have been asked, and so no decisions have been made yet.

> **At project start:** replace the line above with decisions extracted from
> existing design documents. Remove this note once seeding is done.

---

## Template (copy/paste)

### YYYY-MM-DD — [short title]

- **Context:** Why this decision was needed / what it unblocks.
- **Decision:** The chosen option, stated as a constraint.
- **Rationale:** Why this option was chosen.
- **Consequences:** Follow-up work, trade-offs, or migrations required.
- **References:** Links to issues, PRs, `docs/planning/*`, or relevant files.
