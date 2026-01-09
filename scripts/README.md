# VS Code Setup Scripts

This is my personal VS Code configuration and extension management setup. I like it, and you might
too!

## What's Here

### Extension Management

**[vscode-extensions.yaml](vscode-extensions.yaml)** - Central configuration file defining all
extensions organized by category (Core/UX, Git, AI, Languages, etc.)

- **[vscode-extensions.yaml](vscode-extensions.yaml)** contains other extensions I've used in the
  past which can be added into the vscode-extensions file if desired.

**[vscode-extensions.bash](vscode-extensions.bash)** - Bash script for managing extensions

- Reads from the YAML configuration
- Installs missing extensions
- Optionally removes non-allowlisted extensions
- Supports interactive confirmation (per-group or per-extension)

**[vscode-extensions.ps1](vscode-extensions.ps1)** - PowerShell version with identical functionality

- Same features as the bash script
- Native PowerShell parameters and help

**Usage:**

```bash
# Bash - install missing extensions (default)
./vscode-extensions.bash

# Bash - remove unlisted extensions and confirm by group
./vscode-extensions.bash --remove --confirm-groups

# Bash - confirm each extension individually
./vscode-extensions.bash --confirm-each
```

```powershell
# PowerShell - install missing extensions (default)
.\vscode-extensions.ps1

# PowerShell - remove unlisted extensions and confirm by group
.\vscode-extensions.ps1 -Remove -ConfirmGroups

# PowerShell - confirm each extension individually
.\vscode-extensions.ps1 -ConfirmEach
```

## Configuration Files

### Extensions

All extensions are defined in [vscode-extensions.yaml](vscode-extensions.yaml), organized into
groups:

- **Core / UX** - Essential editor enhancements
- **Git / Collaboration** - Version control and team tools
- **AI assistance** - GitHub Copilot and AI tools
- **JS / TS / Web** - JavaScript/TypeScript ecosystem
- **.NET / C#** - .NET development tools
- **Python / Jupyter** - Python and notebook support
- **Containers / Remote dev** - Docker and remote development
- **IaC / Config** - Infrastructure as Code tools
- **GraphQL** - GraphQL language support
- **API / Data / DB** - API testing and database tools
- **BDD / Testing** - Testing frameworks
- **Ops / Shell** - PowerShell and shell scripting
- **Fonts** - Custom fonts (Fira Code)

There's also [vscode-extensions-additional.yaml](vscode-extensions-additional.yaml) for experimental
or optional extensions not yet promoted to the main list.

## Why This Setup?

This is my opinionated but well-tested configuration that I use across multiple machines. It
includes:

- ✅ Automatic extension management with version control
- ✅ Easy onboarding for new developers
- ✅ Interactive mode for selective installation
- ✅ Cross-platform scripts (Bash + PowerShell)
- ✅ No manual clicking through the extensions marketplace

Feel free to fork and customize to your preferences!

## Environment Variables

Both extension scripts support:

- `CODE_BIN` - Specify VS Code binary (default: `code`)
  - Example: `CODE_BIN=code-insiders`
  - Useful for VS Code Insiders or custom installations

## Tips

- Use `--confirm-groups` when you want to review extensions by category
- Use `--remove` periodically to clean up extensions you no longer need
- Keep the YAML file in version control to track your extension preferences over time
- The scripts work with both stable VS Code and VS Code Insiders
