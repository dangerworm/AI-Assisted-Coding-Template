# /docs/behaviour

This directory contains behaviour files - descriptions of what the system does
or must do, written in a structured scenario format.

## Layers

There are three layers of behaviour documentation, each serving a different
purpose:

| Layer    | Suffix      | What it represents                                 | Produced by        |
| -------- | ----------- | -------------------------------------------------- | ------------------ |
| Stated   | `.stated`   | What existing tests or specs claim the system does | DISCOVER (Phase 3) |
| Actual   | `.actual`   | What the code demonstrably does                    | DISCOVER (Phase 7) |
| Required | `.required` | What the system must do going forward              | REDESIGN / BUILD   |

Each mode treats these layers differently:

- **DISCOVER** produces `stated` and `actual` files; flags divergences between
  them
- **REDESIGN** reads `actual` and `stated` as context (not hard requirements);
  produces `required` files driven by feedback and redesign decisions
- **BUILD** treats `required` as a hard requirement; reads `actual` for
  reference only

## File naming

Use the layer as a suffix before the file extension:

```txt
feature-name.stated.feature
feature-name.actual.feature
feature-name.required.feature

process-name.actual.md
process-name.required.md
```

This keeps related files adjacent and makes divergences easy to spot.

## Format

**Software projects with a test runner**: use Gherkin `.feature` files. These
can be consumed directly by test frameworks (Cucumber, SpecFlow, Behave, etc.)
and serve as living documentation.

**All other cases**: use `.md` files with Given/When/Then format. The structure
is the same; only the file extension and tooling assumption differ.

### Example (Gherkin)

```gherkin
Feature: User login

  Scenario: Successful login with valid credentials
    Given a registered user exists with email "user@example.com"
    When they submit the login form with correct credentials
    Then they are redirected to the dashboard
    And a session token is set
```

### Example (Markdown)

```markdown
## Scenario: Technician submits a site inspection report

Given a technician has completed a site visit When they submit the inspection
form with all required fields Then the report is saved against the site record
And the responsible manager receives a notification
```
