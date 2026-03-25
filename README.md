# AI Project Template

This template is for anyone working on projects in collaboration with AI agents.
Feel free to fork it and customise it for your own purposes.

## What this is

AI agents are capable collaborators, but their effective context is limited for
larger, longer-running projects. Without structure, they drift - re-doing work,
forgetting earlier decisions, and losing sight of the original goals.

Structuring a repository like this seems to help them work on bigger projects:
an AGENTS.md file gives them operating instructions, rich documentation gives
them context, and a dedicated folder for planning and memory lets them pick up
exactly where they left off.

## Who this is for

This template is intentionally domain-agnostic. It is designed to be useful
to anyone working on a substantial project with an AI agent - not just software
developers. A researcher documenting a study, an engineer designing a physical
system, a gardener planning a large garden, an architect proposing a building,
or an enterprise team rebuilding a business process can all use this template.

The modes, phases, and file structures are written to apply broadly. Where
domain-specific guidance is relevant (for example, Gherkin `.feature` files for
software projects with test runners), it is clearly marked as such alongside a
generic equivalent.

## Quick start

This template supports three modes forming a pipeline. Check
[`context/MODE.md`](context/MODE.md) and set the one that matches your
situation.

| Starting point                               | Recommended pipeline                |
| -------------------------------------------- | ----------------------------------- |
| New project with a specification             | `BUILD`                             |
| Existing work, straightforward rebuild       | `DISCOVER` -> `BUILD`               |
| Existing work, modernisation needed          | `DISCOVER` -> `REDESIGN` -> `BUILD` |
| Existing docs, modernisation needed          | `REDESIGN` -> `BUILD`               |

### BUILD - build from a specification

1. Fork this repository (or use it as a GitHub template), then clone it.
2. Write your project constraints and intent in:
   - [architecture.md](/docs/planning/architecture.md)
   - [features.md](/docs/planning/features.md)
   - [requirements.md](/docs/planning/requirements.md)
   - [technologies.md](/docs/planning/technologies.md)
3. Set `context/MODE.md` to `BUILD` (the default).
4. Point your AI agent at the repository. It will read `AGENTS.md` and follow
   the BUILD workflow.
5. Put your project output in `work`.

### DISCOVER - generate documentation from existing work

1. Fork this repository (or use it as a GitHub template), then clone it.
2. Copy or clone the existing work into `work-existing`.
3. Optionally, add any bug reports, user feedback, or known issues to
   `work-existing/feedback/` - this significantly improves output quality.
4. Set `context/MODE.md` to `DISCOVER`.
5. Point your AI agent at the repository. It will work through seven discovery
   phases, reading every file in depth, and produce populated planning documents
   in `docs/planning/` and behaviour files in `docs/behaviour/`.
6. Review the output, address any flagged gaps, then switch to `REDESIGN` or
   `BUILD`.

### REDESIGN - modernise before building

1. Ensure planning documents exist in `docs/planning/` (from a DISCOVER run or
   written by hand).
2. Set `context/MODE.md` to `REDESIGN`.
3. Point your AI agent at the repository. It will assess the existing design
   across several areas (data architecture, frontend, API, infrastructure,
   security, developer experience) and produce concrete, prioritised proposals.
4. Review each proposal and indicate whether to accept, reject, or defer it.
5. The agent will revise the planning documents to reflect the agreed target
   state, then switch to `BUILD`.

In all modes:

- Agents ask questions in [questions.md](/context/user/questions.md).
- Humans answer in [answers.md](/context/user/answers.md).

## Where to find things

### `.github`

If you've not used GitHub features before, this is where GitHub looks for
actions, workflows, PR templates, and so on; you'll see it in most repositories
that make use of GitHub's features.

### `.vscode`

I use Visual Studio Code for a lot of my front end and infrastructure
development (though I leave C# to big daddy Visual Studio) and these config
files allow me to configure its behaviour.

- [extensions.json](/.vscode/extensions.json) suggests extensions I've not
  installed
- [settings.json](/.vscode/settings.json) is a workspace-specific configuration
  file

For more information, have a look at [.vscode/README.md](.vscode/README.md).

### `work`

This is where your project output goes - application code, generated assets,
design files, or whatever the BUILD mode produces for your domain.

- If you are building a software project and use Docker Compose, start with
  `work/docker-compose.yml`.
- If you don't need it, delete it.

### `work-existing`

If you have an existing system for which you want to reverse-engineer the design
and specification, put it in this folder.

### `docs`

The second-most important folder. If all you're doing is using AI to edit a few
files at a time then you won't need this, but if you want entire features built
then this is the way to do it.

This folder is intended to store information about architecture, design,
features, requirements, technologies, etc. and should be treated as a source of
truth for the entire repository.

This is also where you can (and I would argue should) keep all your source
material:

- digitised diagrams
- images (screenshots, sketches, whiteboard photos)
- references (books, letters, example data)
- notes from early ideation conversations
- anything else you can think of

If you are starting from an idea rather than a specification, use
`docs/reference/` to capture notes as you discuss and develop the idea with the
AI. These notes give both you and the agent a shared memory to work from across
sessions, and feed into the planning documents in `docs/planning/` once the
direction is clear.

### `context`

The **most important folder**.

This is basically the AI's memory. It serves as a place for the agent to write
out its context, meaning it only has to focus on one area of the project at a
time while retaining access to everything that came before.

Right now the only contents are template files, simply so that the AI has some
idea of what content each file should have and how it should be structured.

For more information, look at [README.md](context/README.md).

### `scripts`

If you (or the AI) produce any helper scripts during the project which aren't
related to the application itself, they can go here.

I've included two sets of scripts I've used in the past as examples.

- **`code-insights`** shows you how many files of each type there are in the
  repository
- **`extensions`** installs a standard set of Visual Studio extensions for
  consistency across development teams

## Where to go next

- **Using this repository**
  - [Current mode / switching modes](context/MODE.md)
  - [How AI agents use this repo](/AGENTS.md)
  - [BUILD mode agent guidance](/AGENTS-BUILD.md)
  - [REDESIGN mode agent guidance](/AGENTS-REDESIGN.md)
  - [DISCOVER mode agent guidance](/AGENTS-DISCOVER.md)
  - [How to contribute](/CONTRIBUTING.md)
- **Planning documents**
  - [Architecture notes](docs/planning/architecture.md)
  - [Features](docs/planning/features.md)
  - [Requirements](docs/planning/requirements.md)
  - [Technologies](docs/planning/technologies.md)
- **AI working memory/context setup**
  - [Implementation workflow](/context/README.md)
