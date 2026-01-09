# AI Project Template

This template is for anyone developing code in collaboration with AI agents.
Feel free to fork it and customise it for your own purposes.

## What this is

I recently started coding with AI agents.

- It's quicker
- It allows me to use (and therefore learn) languages and technologies with
  which I'm unfamiliar
- It gives me an insight into their strengths and weaknesses.

My insights so far are that whilst AIs are perfectly capable of creating code,
their effective context is still limited for larger codebases.

Structuring a repository like this seems to help them collaborate on bigger
projects, i.e. with an AGENTS.md file, rich documentation, and somewhere to
store planning and context documents as they go, .

## Quick start (new project)

1. Fork this repository (or use it as a GitHub template), then clone it.
2. Write your project constraints and intent in:

   - [architecture.md](/docs/planning/architecture.md)
   - [features.md](/docs/planning/features.md)
   - [requirements.md](/docs/planning/requirements.md)
   - [technologies.md](/docs/planning/technologies.md)

3. Treat `implementation` as the working memory for AI-assisted development.

- Humans answer questions in [answers.md](/implementation/user/answers.md).
- Agents ask questions in [questions.md](/implementation/user/questions.md).

4. Put application code in `app`.

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

### `app`

This is where your application code should go.

- If you use Docker Compose, start with `app/docker-compose.yml`.
- If you don't, delete it.

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
- anything else you can think of

### `implementation`

The **most important folder**.

This is basically the AI's memory. It serves as a place for the agent to write
out its context, meaning it only has to focus on small areas of code at a time
while retaining access to everything that came before.

Right now the only contents are template files, simply so that the AI has some
idea of what content each file should have and how it should be structured.

For more information, look at [README.md](implementation/README.md).

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
  - [How AI agents use this repo](/AGENTS.md)
  - [How to contribute](/CONTRIBUTING.md)
- **App documentation**
  - [Architecture notes](docs/planning/architecture.md)
  - [Features](docs/planning/features.md)
  - [Requirements](docs/planning/requirements.md)
  - [Technologies](docs/planning/technologies.md)
- **AI working memory/context setup**
  - [Implementation workflow](/implementation/README.md)
