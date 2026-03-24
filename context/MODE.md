# Mode

**Current mode:** BUILD

## Available modes

| Mode       | Description                                                                              | Agent file                                  |
| ---------- | ---------------------------------------------------------------------------------------- | ------------------------------------------- |
| `BUILD`    | Start from planning documents in `docs/planning/` and build the application in `app/`    | [`AGENTS-BUILD.md`](/AGENTS-BUILD.md)       |
| `REDESIGN` | Review existing planning documents, propose modernisation changes, revise docs for BUILD | [`AGENTS-REDESIGN.md`](/AGENTS-REDESIGN.md) |
| `DISCOVER` | Analyse existing code in `app/` and generate planning documents in `docs/planning/`      | [`AGENTS-DISCOVER.md`](/AGENTS-DISCOVER.md) |

## Typical pipelines

- **New project:** `BUILD`
- **Rebuild existing system:** `DISCOVER` → `BUILD`
- **Rebuild with modernisation:** `DISCOVER` → `REDESIGN` → `BUILD`
- **Modernise before building from existing docs:** `REDESIGN` → `BUILD`

## Switching modes

Change the value in line 3 of this file, then follow the corresponding agent
file.
