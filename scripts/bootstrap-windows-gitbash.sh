#!/usr/bin/env bash
set -euo pipefail

# Bootstraps VS Code on Windows (run from Git Bash):
# - Installs VS Code (User scope) via winget if missing
# - Ensures the VS Code "code" CLI is available
# - Writes a curated settings.json (inline below)
# - Runs your extension allowlist script (expected alongside this file)
#
# Usage (Git Bash):
#   ./bootstrap-windows-gitbash.sh
#
# Optional:
#   CODE_BIN=code-insiders ./bootstrap-windows-gitbash.sh
#
# Assumptions:
# - You're running in Git Bash on Windows
# - winget is installed (Windows 10/11 typically has it)
# - Your extensions script and YAML config are in the same folder as this file:
#     vscode-extensions.bash
#     vscode-extensions.yaml

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODE_BIN="${CODE_BIN:-code}"
EXT_SCRIPT="${EXT_SCRIPT:-$SCRIPT_DIR/vscode-extensions.bash}"

log() { printf "\n[%s] %s\n" "$(date +%H:%M:%S)" "$*"; }

need_cmd() {
  local c="$1"
  if ! command -v "$c" >/dev/null 2>&1; then
    echo "Error: required command not found: $c"
    exit 1
  fi
}

# Convert e.g. /c/Users/name to C:\Users\name
to_win_path() {
  local p="$1"
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -w "$p"
  else
    # Best-effort fallback
    echo "$p" | sed -E 's|^/([a-zA-Z])/\s*|\1:/|; s|/|\\|g'
  fi
}

need_cmd powershell.exe

log "Checking for VS Code CLI: $CODE_BIN"
if ! command -v "$CODE_BIN" >/dev/null 2>&1; then
  log "'$CODE_BIN' not found on PATH. Attempting to install VS Code via winget (User scope)…"

  # Prefer stable VS Code unless CODE_BIN=code-insiders
  if [[ "$CODE_BIN" == "code-insiders" ]]; then
    WINGET_ID="Microsoft.VisualStudioCode.Insiders"
  else
    WINGET_ID="Microsoft.VisualStudioCode"
  fi

  # Install (User scope). This usually adds the bin stub under %LOCALAPPDATA%\Programs\Microsoft VS Code\bin
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \
    "winget install --id $WINGET_ID --source winget --scope user --accept-source-agreements --accept-package-agreements"

  log "Re-checking for '$CODE_BIN' after install…"
fi

# Try a few common locations if still not on PATH
if ! command -v "$CODE_BIN" >/dev/null 2>&1; then
  log "'$CODE_BIN' still not on PATH. Attempting to locate VS Code CLI in common install paths…"

  # Candidate paths for stable and insiders
  candidates=(
    "$LOCALAPPDATA/Programs/Microsoft VS Code/bin/code"
    "$LOCALAPPDATA/Programs/Microsoft VS Code Insiders/bin/code-insiders"
    "/c/Program Files/Microsoft VS Code/bin/code"
    "/c/Program Files/Microsoft VS Code Insiders/bin/code-insiders"
  )

  found=""
  for c in "${candidates[@]}"; do
    if [[ -x "$c" ]]; then
      found="$c"
      break
    fi
  done

  if [[ -z "$found" ]]; then
    echo "Error: Could not find VS Code CLI ('$CODE_BIN')."
    echo "Try launching VS Code once, then run: View → Command Palette → 'Shell Command: Install 'code' command in PATH'"
    echo "Or ensure VS Code is installed and its bin folder is on PATH."
    exit 1
  fi

  CODE_BIN="$found"
  log "Using VS Code CLI at: $CODE_BIN"
else
  log "Found VS Code CLI on PATH: $(command -v "$CODE_BIN")"
fi

# Create settings.json
APPDATA_WIN="$(powershell.exe -NoProfile -Command '[Environment]::GetFolderPath("ApplicationData")' | tr -d '\r')"
USER_DIR_WIN="${APPDATA_WIN}\\Code\\User"
SETTINGS_WIN="${USER_DIR_WIN}\\settings.json"

log "Ensuring VS Code user settings directory exists: $USER_DIR_WIN"
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \
  "New-Item -ItemType Directory -Force -Path '$USER_DIR_WIN' | Out-Null"

log "Writing settings.json"
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command @"
`$settingsPath = '$SETTINGS_WIN'
`$json = @'
{
  "editor.detectIndentation": false,
  "editor.tabSize": 2,
  "files.autoSave": "afterDelay",
  "workbench.iconTheme": "material-icon-theme",
  "editor.fontFamily": "Fira Code, Consolas, 'Courier New', monospace",
  "editor.fontLigatures": true,
  "editor.inlineSuggest.enabled": true,

  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.eol": "\n",
  "editor.rulers": [100],
  "editor.renderWhitespace": "boundary",

  "prettier.requireConfig": true,
  "prettier.useEditorConfig": true,

  "git.enableSmartCommit": true,
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.ignoreRebaseWarning": true,

  "terminal.integrated.defaultProfile.windows": "Git Bash",

  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "eslint.format.enable": false,
  "eslint.validate": ["javascript", "javascriptreact", "typescript", "typescriptreact"],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit",
    "source.organizeImports": "explicit"
  },

  "[javascript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[typescript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[typescriptreact]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[javascriptreact]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[json]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[jsonc]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[css]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[scss]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[html]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },

  "typescript.updateImportsOnFileMove.enabled": "always",

  "[yaml]": { "editor.defaultFormatter": "redhat.vscode-yaml" },
  "[xml]": { "editor.defaultFormatter": "redhat.vscode-xml" },
  "[github-actions-workflow]": { "editor.defaultFormatter": "redhat.vscode-yaml" },
  "[dockercompose]": {
    "editor.insertSpaces": true,
    "editor.tabSize": 2,
    "editor.autoIndent": "advanced",
    "editor.quickSuggestions": {
      "other": true,
      "comments": false,
      "strings": true
    },
    "editor.defaultFormatter": "redhat.vscode-yaml"
  },

  "yaml.schemas": {
    "file:///c%3A/Users/dange/.vscode/extensions/atlassian.atlascode-4.0.13/resources/schemas/pipelines-schema.json": "bitbucket-pipelines.yml"
  },

  "[sql]": { "editor.defaultFormatter": "inferrinizzard.prettier-sql-vscode" },

  "python.analysis.typeCheckingMode": "standard",
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.formatOnType": false
  },
  "ruff.lint.run": "onSave",

  "[terraform]": { "editor.defaultFormatter": "hashicorp.terraform" },
  "[terraform-vars]": { "editor.defaultFormatter": "hashicorp.terraform" },
  "terraform.format.enable": true,

  "dev.containers.copyGitConfig": true,

  "github.copilot.nextEditSuggestions.enabled": true,

  "pgsql.serverGroups": [
    {
      "name": "Servers",
      "id": "49FD576C-4492-4D76-A270-5C8897AB1C8C",
      "isDefault": true
    }
  ]
}
'@

# Write as UTF-8 without BOM
[System.IO.File]::WriteAllText(`$settingsPath, `$json, (New-Object System.Text.UTF8Encoding(`$false)))
Write-Host "Wrote settings to: `$settingsPath"
"@

# Run extension allowlist script
if [[ ! -f "$EXT_SCRIPT" ]]; then
  echo
  echo "Error: extensions script not found at:"
  echo "  $EXT_SCRIPT"
  echo
  echo "Expected it to be alongside this bootstrap script."
  echo "Either place it there, or run with:"
  echo "  EXT_SCRIPT=/path/to/vscode-extensions-master.bash ./bootstrap-windows-gitbash.sh"
  exit 1
fi

log "Running extension bootstrap: $EXT_SCRIPT"
chmod +x "$EXT_SCRIPT" || true

# If CODE_BIN is a full path, pass it through
export CODE_BIN
bash "$EXT_SCRIPT"

log "Bootstrap complete."
log "Tip: If VS Code is open, reload the window (Ctrl+Shift+P → 'Developer: Reload Window') to ensure everything takes effect."
