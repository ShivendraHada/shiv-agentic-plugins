# bd + Spec Kit Installation Guide

This guide provides step-by-step instructions for installing and configuring bd (Beads) and Spec Kit for AI-assisted development with Claude Code and Windsurf.

## Quick Start: Automated Installation

We provide an automated installation script that handles most of the setup:

```bash
# From the repository root
./install-bd-speckit.sh
```

The script has two phases:

**Phase 1: Global Installation**
- ✅ Install bd (Beads) via Homebrew
- ✅ Install beads-mcp Python package
- ✅ Install uv (if not present)
- ✅ Install Spec Kit (Specify CLI)
- ✅ Configure MCP servers for Claude Code and Windsurf

**Phase 2: Repository Initialization** (runs regardless of whether tools were already installed)
- ✅ Initialize bd in the repository
- ✅ Initialize Spec Kit for Claude Code and Windsurf
- ✅ Create/update CLAUDE.md and AGENTS.md with bd workflow
- ✅ Update constitution to enforce bd usage (forbids TodoWrite)
- ✅ Inject bd instructions into all Spec Kit workflow files

**Note**: If you already have tools installed, you can skip/decline the upgrade prompts in Phase 1. The script will still offer to initialize your repository in Phase 2.

### What You'll Need to Do Manually

After running the script, you'll need to:

1. **Restart AI Assistants**
   - Restart Claude Code
   - Restart Windsurf

2. **Verify MCP Functions**
   - In Claude Code: Confirm `mcp__plugin_beads_beads__*` functions are available
   - In Windsurf: Confirm bd MCP functions appear in tool palette

3. **Verify Slash Commands**
   - Check for `/speckit.*` commands in both assistants

---

## Manual Installation (Step-by-Step)

If you prefer to install components manually or need to troubleshoot, follow these steps:

### Prerequisites

- **macOS** (required)
- **Homebrew** - [Install from brew.sh](https://brew.sh)
- **Python 3** - `brew install python3`
- **Git repository** - For repository-specific initialization

---

### Step 1: Install bd (Beads)

Install bd using Homebrew:

```bash
# Install bd
brew install bd

# Or upgrade if already installed
brew upgrade bd

# Verify installation
bd --version
```

**Expected output:** `bd version X.XX.X`

---

### Step 2: Install beads MCP Server

Install the beads MCP server for AI assistant integration:

```bash
# Install beads-mcp
pip3 install beads-mcp

# Verify installation
python3 -c "import beads_mcp; print('beads-mcp installed')"
```

---

### Step 3: Configure Claude Code MCP

Create or update Claude Code's MCP configuration:

```bash
# Create config directory
mkdir -p ~/.config/claude

# Edit config file
nano ~/.config/claude/config.json
```

Add the following configuration:

```json
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
```

**If you already have an MCP config**, merge the `beads` entry into your existing `mcpServers` object.

**Restart Claude Code** after updating the configuration.

---

### Step 4: Configure Windsurf MCP

Create or update Windsurf's MCP configuration:

```bash
# Create config directory
mkdir -p ~/.codeium/windsurf

# Edit config file
nano ~/.codeium/windsurf/mcp_settings.json
```

Add the following configuration:

```json
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
```

**If you already have an MCP config**, merge the `beads` entry into your existing `mcpServers` object.

**Restart Windsurf** after updating the configuration.

---

### Step 5: Install uv (Python Package Manager)

Spec Kit uses `uv` for installation. Install it via Homebrew:

```bash
# Install uv
brew install uv

# Verify installation
uv --version
```

---

### Step 6: Install Spec Kit (Specify CLI)

Install Spec Kit using uv:

```bash
# Install Specify CLI
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Verify installation
specify --version
specify check
```

**If `specify` command not found**, add uv's bin directory to your PATH:

```bash
# Add to ~/.zshrc or ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"

# Reload shell
source ~/.zshrc  # or source ~/.bashrc
```

---

### Step 7: Initialize bd in Your Repository

From your repository root:

```bash
# Initialize bd
bd init

# Verify initialization
ls -la .beads/

# Create a test issue
bd create "Test issue" -t task -p 2 --json

# Check ready work
bd ready --json
```

**Important:** Commit `.beads/` and `.beads/issues.jsonl` to git to share issues across the team.

---

### Step 8: Initialize Spec Kit in Your Repository

From your repository root:

```bash
# Initialize for Claude Code
specify init --here --ai claude

# Initialize for Windsurf
specify init --here --ai windsurf

# Verify initialization
ls -la .specify/
ls -la .windsurf/workflows/speckit.*.md
ls -la .claude/commands/speckit.*.md
```

---

### Step 9: Create/Update Project Documentation

Create `CLAUDE.md` with bd instructions for Claude Code:

```bash
cat > CLAUDE.md <<'EOF'
# Claude Code Project Instructions

## Issue Tracking: Use bd (Beads) - NOT TodoWrite

**CRITICAL**: This project uses **[bd (beads)](https://github.com/steveyegge/beads)** for ALL issue tracking.

### Required Workflow

1. Check for ready work: `mcp__plugin_beads_beads__ready()`
2. Pick a task and claim it: `mcp__plugin_beads_beads__update(issue_id="bd-XXX", status="in_progress")`
3. Work on the task (code, tests, docs)
4. When done, close it: `mcp__plugin_beads_beads__close(issue_id="bd-XXX", reason="Completed")`

For complete workflow details, see [AGENTS.md](AGENTS.md).
EOF
```

Create `AGENTS.md` with general workflow instructions:

```bash
cat > AGENTS.md <<'EOF'
## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking.

### Quick Start

- Check ready work: `bd ready --json`
- Create issue: `bd create "Issue title" -t feature -p 1 --json`
- Update status: `bd update bd-42 --status in_progress --json`
- Complete: `bd close bd-42 --reason "Completed" --json`

### MCP Server

Using Claude Code or Windsurf? Use MCP functions:
- `mcp__plugin_beads_beads__ready()`
- `mcp__plugin_beads_beads__create()`
- `mcp__plugin_beads_beads__update()`
- `mcp__plugin_beads_beads__close()`
EOF
```

---

### Step 10: Verify Installation

Run verification checks:

```bash
# Check bd
bd --version

# Check beads-mcp
python3 -c "import beads_mcp; print('✓ beads-mcp installed')"

# Check uv
uv --version

# Check specify
specify --version
specify check

# Check repository initialization
ls -la .beads/
ls -la .specify/

# Check MCP configs
cat ~/.config/claude/config.json
cat ~/.codeium/windsurf/mcp_settings.json
```

**Restart both Claude Code and Windsurf** before proceeding.

---

### Step 11: Test MCP Integration

**In Claude Code:**
- Start a new conversation
- Type: "Can you show me ready bd issues?"
- Claude should use `mcp__plugin_beads_beads__ready()` function

**In Windsurf:**
- Open the tool palette
- Look for bd MCP functions
- Try running `mcp__plugin_beads_beads__ready()`

**Test Spec Kit Commands:**
- In Claude Code: Try `/speckit.constitution`
- In Windsurf: Try `/speckit.constitution`

---

## Troubleshooting

### `specify` command not found

Add uv's bin directory to PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### MCP functions not available in Claude Code

1. Check config: `cat ~/.config/claude/config.json`
2. Ensure JSON is valid (no trailing commas)
3. Restart Claude Code completely
4. Check for errors in Claude Code's logs

### MCP functions not available in Windsurf

1. Check config: `cat ~/.codeium/windsurf/mcp_settings.json`
2. Ensure JSON is valid (no trailing commas)
3. Restart Windsurf completely
4. Check Windsurf's extension logs

### bd not syncing to git

1. Ensure `.beads/` is NOT in `.gitignore`
2. Commit both code and `.beads/issues.jsonl` together:
   ```bash
   git add . .beads/issues.jsonl
   git commit -m "Feature X with bd issue tracking"
   ```

### Spec Kit slash commands not showing

1. Verify initialization: `ls -la .specify/`
2. Check slash command files exist:
   - `.claude/commands/speckit.*.md` (Claude Code)
   - `.windsurf/workflows/speckit.*.md` (Windsurf)
3. Restart the AI assistant
4. Try typing `/` to see available commands

---

## Next Steps

After installation:

1. **Read the onboarding deck** - See `docs/beads-spec-kit-onboarding/slides.md`
2. **Create your first feature** - Use `/speckit.specify` to start
3. **Try the JIRA workflow** - See `docs/beads-spec-kit-onboarding/jira-to-speckit-workflow.md`
4. **Review examples** - See `specs/001-beads-speckit-onboarding/`

---

## Support

- **bd (Beads)**: https://github.com/steveyegge/beads
- **Spec Kit**: https://github.com/github/spec-kit
- **beads-mcp**: https://pypi.org/project/beads-mcp/

For project-specific questions, see `AGENTS.md` and `CLAUDE.md`.
