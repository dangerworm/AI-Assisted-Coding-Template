# /work-existing

Put the existing system here when running in DISCOVER mode.

This might be an existing codebase, a set of design files, a collection of
process documents — whatever you want the AI to analyse and reverse-engineer
into planning documents.

The agent will read from this folder but will never modify it.

## Subdirectories

### `feedback/`

Put qualitative data about the existing system here: bug reports, user
complaints, satisfaction surveys, stakeholder interview notes, known issues.
This data is read during Phase 6 and significantly improves the quality of
requirements documentation. See [`feedback/README.md`](feedback/README.md).
