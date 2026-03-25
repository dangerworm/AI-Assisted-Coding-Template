# /work-existing/feedback

Put qualitative data about the existing system here before running DISCOVER mode.

This directory is for information that lives **outside** the existing work itself
— things the code cannot tell you on its own:

- Bug reports and issue logs
- User complaints or support tickets
- User satisfaction surveys or NPS results
- Stakeholder interview notes
- Internal post-mortems or retrospective findings
- Known limitations or workarounds that users have accepted
- Anything the team knows is broken, slow, confusing, or missing

## Why this matters

Code tells you what a system does. Feedback tells you what it *fails* to do.
Both are essential for accurate discovery. Without this data, known problems
may go undocumented — and a rebuild that repeats the same mistakes is worse
than no rebuild at all.

## Format

There is no required format. Add files in whatever form you have them:

- Plain text exports from a bug tracker
- CSV exports from a survey tool
- Markdown notes from interviews
- Screenshots or PDFs of complaints

The AI agent will read whatever is here and incorporate it into the requirements
and feature documentation it produces.

## What the agent does with it

During Phase 6 (Requirements), the agent reads this directory and:

- Documents every known issue against the relevant feature or requirement
- Flags items that contradict what the code does
- Marks things the existing system cannot do but should

These items appear in `docs/planning/requirements.md` and inform the REDESIGN
phase if one follows.
