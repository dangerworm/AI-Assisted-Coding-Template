# Insights (how to make an AI succeed on a large build)

## 1) The biggest risk is drift, not coding

For a system this size, the AI’s biggest failure mode is:

- implementing something plausible but not compliant with _your_ spec
- inventing UI/flows because UX isn’t explicitly described
- inconsistent domain semantics across modules

Mitigation: strict chunking + context packs + decision log.

## 2) Treat offline as its own product

Offline + conflict handling is a deep technical problem.

Do not let the AI “sprinkle offline” across features; implement it as a dedicated chunk once the
online semantics are stable.

## 3) Keep a stable interface boundary

Define these interfaces early and keep them stable:

- Event store (append-only)
- Audit log viewer/export
- Identity/permissions
- Attachment storage

This reduces rework and helps the AI reason locally.

## 4) Prefer end-to-end slices with tiny UI

A usable, ugly UI beats a perfect API with no UI.

Make every chunk produce a “workflow you can click through”.

## 5) Decide the operational DB early

Your current repo has Postgres vs SQL Server drift.

AI will waste a lot of time if this stays unresolved.
