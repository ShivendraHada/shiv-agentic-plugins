# Quickstart: Beads + Spec Kit Setup

This quickstart assumes a macOS developer machine.

## Prerequisites

- macOS with a terminal and git installed
- **Homebrew** installed (`brew --version`)
- **Python** and **uv** installed (for Spec Kit / Specify CLI)
- **bd (Beads)** CLI available on PATH
- **Spec Kit** (`specify` CLI) installed via uv
- Access to at least one AI assistant:
  - Windsurf (for IDE-based workflows), and/or
  - Claude Code

## Install bd via Homebrew (see slides section 5)

```bash
brew install bd
# or, if already installed
brew upgrade bd
bd --version
```

## Install Spec Kit (Specify CLI) via uv (see slides section 7)

```bash
uv tool install specify-cli \
  --from git+https://github.com/github/spec-kit.git

specify --help
specify check
```

## Initialize Spec Kit for this repo (see slides section 9)

From the repository root:

```bash
specify init --here --ai claude
specify init --here --ai windsurf
```

If the directory is not empty, answer the prompt to allow merging the template.

## Verify AI Integration (see slides section 10)

- Open this repo in **Windsurf** and **Claude Code**.
- Confirm that the following slash commands are available:
  - `/speckit.constitution`
  - `/speckit.specify`
  - `/speckit.plan`
  - `/speckit.tasks`
  - `/speckit.implement`

## Enable bd Integration for Spec Kit Tasks (see slides section 11)

- Ensure `bd` is installed and initialized in the repo:

  ```bash
  bd init
  ```

- Make sure the bd-aware Spec Kit workflows from this project are present:
  - `.windsurf/workflows/speckit.tasks.md`
  - `.windsurf/workflows/speckit.implement.md`

- When you run `/speckit.tasks` and `/speckit.implement` in a feature directory:
  - A bd feature issue and per-task bd issues are created (or reused).
  - Task execution status is reflected directly in bd.

You are now ready to drive features using bd issues and Spec Kit workflows.
