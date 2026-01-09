# Contributing

This repository is a template intended to be forked and customised.
Contributions should keep the template broadly useful and avoid locking users
into a particular stack without a clear reason.

## What we welcome

- Fixes to documentation: clarity, spelling/grammar, broken links
- Improvements to the human <-> AI workflow (AGENTS guidance, implementation
  folder flow)
- Small quality-of-life improvements that are broadly applicable

## What we generally avoid

- Adding a full application framework or opinionated starter app
- Introducing heavyweight dependencies without strong justification
- Large restructuring that breaks existing forks without a migration path

## How to propose changes

1. Open an issue (or start a discussion) describing:
   - What problem you’re trying to solve
   - Who it helps (humans, agents, or both)>
   - The smallest change that would solve it
2. Submit a PR.

## PR expectations

- Keep PRs focused and small when possible.
- Prefer improving existing files over adding many new ones.
- If you change the workflow (files/paths/structure), update:
  - [README.md](/README.md)
  - [AGENTS.md](/AGENTS.md)
  - [README.md](/implementation/README.md)

## Validation

Contributions should:

- Keep markdown readable (headings, lists, links)
- Avoid broken internal links
- Avoid platform-specific assumptions (Windows/macOS/Linux)

## Notes for people forking this repo

If you’re using this as a starting point for an application:

- Replace the planning docs in `docs/planning` with your real requirements.
- Treat `implementation` as the AI collaboration workspace.
- Feel free to delete anything you don’t need (for example, scripts or compose).
