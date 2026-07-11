# Mode

**Current mode:** BUILD

## Available modes

| Mode       | Description                                                                                   | Skill                                                                       |
| ---------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `BUILD`    | Start from planning documents in `docs/planning/` and build project output in `work/`         | [agents-build](.claude/skills/agents-build/SKILL.md)                       |
| `REDESIGN` | Review existing planning documents, propose modernisation changes, revise docs for BUILD      | [agents-redesign](.claude/skills/agents-redesign/SKILL.md)                 |
| `DISCOVER` | Analyse existing work in `work-existing/` and generate planning documents in `docs/planning/` | [agents-discover](.claude/skills/agents-discover/SKILL.md)                 |

## Typical pipelines

- **New project:** `BUILD`
- **Rebuild existing system:** `DISCOVER` -> `BUILD`
- **Rebuild with modernisation:** `DISCOVER` -> `REDESIGN` -> `BUILD`
- **Modernise before building from existing docs:** `REDESIGN` -> `BUILD`

## Switching modes

Change the value in line 3 of this file. Claude Code will pick up the new mode
automatically. Other agents: read the corresponding skill file listed above, or
tell your agent which mode is now active.
