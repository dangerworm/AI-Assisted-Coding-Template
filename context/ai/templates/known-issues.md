# Known Issues

A registry of confirmed bugs and tech debt that have no current fix. Unlike
`insights.md` (which records observations and risks that may need
investigation), entries here are already understood - the problem is known, the
fix is not yet done or not yet prioritised.

## When to use this file vs `insights.md`

| Situation                                                   | File              |
| ----------------------------------------------------------- | ----------------- |
| You suspect something may be wrong but haven't confirmed it | `insights.md`     |
| You've identified a risk or emerging concern                | `insights.md`     |
| A bug is confirmed and reproducible but unfixed             | `known-issues.md` |
| Tech debt exists and is accepted for now                    | `known-issues.md` |

When an insight graduates to a confirmed issue, move it here and note it in
`insights.md` with a cross-reference.

## Issue log

### [YYYY-MM-DD] - [Short title]

- **Severity:** Critical / High / Medium / Low
- **Area:** Which part of the system is affected
- **Description:** What is broken or deficient, stated precisely
- **Reproduction:** Steps or conditions that trigger it (if applicable)
- **Workaround:** Any interim mitigation in place (or "None")
- **Fix required:** What needs to change to resolve it
- **Blocked by:** Any dependency that prevents fixing it now (or "Nothing -
  deprioritised")
- **References:** Links to related issues, PRs, or `insights.md` entries

---

## Guidance

- Keep entries here until the fix is merged and verified - then remove them
- If the issue is fixed, add a one-line note to `changes.md` and delete the
  entry
- Do not use this file to track speculative problems - that is what
  `insights.md` is for
- Severity is about impact to users or data integrity, not implementation effort
