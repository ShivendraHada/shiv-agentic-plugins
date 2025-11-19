#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

prompt_continue() {
    echo -e "\n${YELLOW}Press Enter to continue or Ctrl+C to exit...${NC}"
    read -r
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only"
        exit 1
    fi
    print_success "Running on macOS"
}

# Check if Homebrew is installed
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew is not installed"
        print_info "Install Homebrew from https://brew.sh"
        print_info "Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    print_success "Homebrew is installed: $(brew --version | head -n1)"
}

# Install bd (beads)
install_bd() {
    print_header "Installing bd (Beads)"

    if command -v bd &> /dev/null; then
        local current_version=$(bd --version 2>&1 || echo "unknown")
        print_info "bd is already installed: $current_version"
        echo -e "${YELLOW}Do you want to upgrade bd? (y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            brew upgrade bd
            print_success "bd upgraded to: $(bd --version)"
        fi
    else
        brew install bd
        print_success "bd installed: $(bd --version)"
    fi
}

# Check if Python 3 is installed
check_python() {
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed"
        print_info "Install Python 3 via Homebrew: brew install python3"
        exit 1
    fi
    print_success "Python 3 is installed: $(python3 --version)"
}

# Install beads MCP server
install_beads_mcp() {
    print_header "Installing beads MCP Server"

    if python3 -c "import beads_mcp" 2>/dev/null; then
        print_info "beads-mcp is already installed"
        echo -e "${YELLOW}Do you want to upgrade beads-mcp? (y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            pip3 install --upgrade beads-mcp
            print_success "beads-mcp upgraded"
        fi
    else
        pip3 install beads-mcp
        print_success "beads-mcp installed"
    fi
}

# Configure Claude Code MCP
configure_claude_mcp() {
    print_header "Configuring Claude Code MCP Server"

    local claude_config_dir="$HOME/.config/claude"
    local claude_config_file="$claude_config_dir/config.json"

    # Create config directory if it doesn't exist
    mkdir -p "$claude_config_dir"

    # Check if config file exists
    if [[ ! -f "$claude_config_file" ]]; then
        # Create new config file
        cat > "$claude_config_file" <<'EOF'
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
EOF
        print_success "Created Claude Code MCP config: $claude_config_file"
    else
        # Check if beads MCP is already configured
        if grep -q '"beads"' "$claude_config_file"; then
            print_info "beads MCP already configured in Claude Code"
        else
            print_warning "Claude Code config exists but beads MCP not configured"
            print_info "Please manually add the following to $claude_config_file:"
            echo -e "${YELLOW}"
            cat <<'EOF'
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
EOF
            echo -e "${NC}"
            print_info "Note: Merge with existing mcpServers if present"
        fi
    fi

    print_warning "MANUAL STEP: Restart Claude Code to load the MCP server"
}

# Configure Windsurf MCP
configure_windsurf_mcp() {
    print_header "Configuring Windsurf MCP Server"

    local windsurf_config_dir="$HOME/.codeium/windsurf"
    local windsurf_config_file="$windsurf_config_dir/mcp_settings.json"

    # Create config directory if it doesn't exist
    mkdir -p "$windsurf_config_dir"

    # Check if config file exists
    if [[ ! -f "$windsurf_config_file" ]]; then
        # Create new config file
        cat > "$windsurf_config_file" <<'EOF'
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
EOF
        print_success "Created Windsurf MCP config: $windsurf_config_file"
    else
        # Check if beads MCP is already configured
        if grep -q '"beads"' "$windsurf_config_file"; then
            print_info "beads MCP already configured in Windsurf"
        else
            print_warning "Windsurf config exists but beads MCP not configured"
            print_info "Please manually add the following to $windsurf_config_file:"
            echo -e "${YELLOW}"
            cat <<'EOF'
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
EOF
            echo -e "${NC}"
            print_info "Note: Merge with existing mcpServers if present"
        fi
    fi

    print_warning "MANUAL STEP: Restart Windsurf to load the MCP server"
}

# Check if uv is installed
check_uv() {
    if ! command -v uv &> /dev/null; then
        print_warning "uv is not installed"
        print_info "Installing uv via Homebrew..."
        brew install uv
        print_success "uv installed: $(uv --version)"
    else
        print_success "uv is installed: $(uv --version)"
    fi
}

# Install Spec Kit (Specify CLI)
install_speckit() {
    print_header "Installing Spec Kit (Specify CLI)"

    if command -v specify &> /dev/null; then
        print_info "Specify CLI is already installed"
        echo -e "${YELLOW}Do you want to reinstall/upgrade Specify CLI? (y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            uv tool install --force specify-cli --from git+https://github.com/github/spec-kit.git
            print_success "Specify CLI reinstalled"
        fi
    else
        uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
        print_success "Specify CLI installed"
    fi

    # Verify installation
    if command -v specify &> /dev/null; then
        print_success "Specify CLI is available: $(specify --version 2>&1 || echo 'installed')"
    else
        print_error "Specify CLI installation failed or not in PATH"
        print_info "You may need to add uv's bin directory to your PATH"
        print_info "Add this to your ~/.zshrc or ~/.bashrc:"
        print_info "export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
}

# Initialize bd in repository
init_bd_repo() {
    print_header "Initializing bd in Repository"

    if [[ ! -d ".git" ]]; then
        print_error "Not in a git repository. Please run this from your repository root."
        return 1
    fi

    if [[ -d ".beads" ]]; then
        print_info "bd already initialized in this repository"
    else
        bd init
        print_success "bd initialized in repository"
        print_info "Created .beads/ directory"

        # Check if .beads is in .gitignore
        if [[ -f ".gitignore" ]] && grep -q "^\.beads/$" .gitignore; then
            print_warning ".beads/ is in .gitignore - you should remove it to track issues in git"
        fi
    fi

    print_info "Verify bd status:"
    bd --version
}

# Initialize Spec Kit for Claude Code and Windsurf
init_speckit() {
    print_header "Initializing Spec Kit for AI Assistants"

    if [[ ! -d ".git" ]]; then
        print_error "Not in a git repository. Please run this from your repository root."
        return 1
    fi

    # Check if already initialized
    local already_init=false
    if [[ -d ".specify" ]]; then
        print_info "Spec Kit already initialized (.specify/ exists)"
        already_init=true
    fi

    if [[ -d ".windsurf/workflows" ]] && ls .windsurf/workflows/speckit.*.md 1> /dev/null 2>&1; then
        print_info "Spec Kit already initialized for Windsurf"
        already_init=true
    fi

    if [[ "$already_init" == "true" ]]; then
        echo -e "${YELLOW}Do you want to reinitialize Spec Kit? (y/N)${NC}"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            print_info "Skipping Spec Kit initialization"
            return 0
        fi
    fi

    # Initialize for Claude Code
    print_info "Initializing Spec Kit for Claude Code..."
    specify init --here --ai claude
    print_success "Spec Kit initialized for Claude Code"

    # Initialize for Windsurf
    print_info "Initializing Spec Kit for Windsurf..."
    specify init --here --ai windsurf
    print_success "Spec Kit initialized for Windsurf"

    print_info "Verify Spec Kit initialization:"
    specify check
}

# Update CLAUDE.md
update_claude_md() {
    print_header "Updating CLAUDE.md"

    if [[ ! -f "CLAUDE.md" ]]; then
        print_info "Creating CLAUDE.md with bd instructions..."
        cat > CLAUDE.md <<'EOF'
# Claude Code Project Instructions

## Issue Tracking: Use bd (Beads) - NOT TodoWrite

**CRITICAL**: This project uses **[bd (beads)](https://github.com/steveyegge/beads)** for ALL issue tracking.

### What This Means for You

1. **DO NOT use TodoWrite tool** - Never create, update, or manage todos via TodoWrite
2. **DO use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all task tracking
3. **DO NOT create markdown TODOs** - No TODO.md, task lists, or checklists in markdown

### Required Workflow

Before starting any work:

```
1. Check for ready work:
   mcp__plugin_beads_beads__ready()

2. Pick a task and claim it:
   mcp__plugin_beads_beads__update(issue_id="bd-XXX", status="in_progress")

3. Work on the task (code, tests, docs)

4. When done, close it:
   mcp__plugin_beads_beads__close(issue_id="bd-XXX", reason="Completed")
```

### Creating New Issues

If you discover new work while implementing:

```
mcp__plugin_beads_beads__create(
  title="Issue title",
  issue_type="task|bug|feature",
  priority=1,
  deps=["parent-issue-id"]  # if related to current work
)
```

### Why bd Instead of TodoWrite?

- **Persistent**: Issues survive across chat sessions
- **Dependency-aware**: Track blockers and relationships
- **Git-synced**: Auto-syncs to `.beads/issues.jsonl`
- **AI-optimized**: JSON output, ready work detection, discovered-from links
- **Multi-assistant safe**: Multiple assistants can work without conflicts

### Available bd MCP Functions

You have access to these MCP functions:
- `mcp__plugin_beads_beads__ready()` - Find tasks ready to work on
- `mcp__plugin_beads_beads__list()` - List all issues with filters
- `mcp__plugin_beads_beads__show(issue_id)` - Show detailed issue info
- `mcp__plugin_beads_beads__create()` - Create new issue
- `mcp__plugin_beads_beads__update()` - Update issue status/priority
- `mcp__plugin_beads_beads__close()` - Close completed issue
- `mcp__plugin_beads_beads__dep()` - Add dependencies between issues

### Important Rules

- ✅ **ALWAYS check `mcp__plugin_beads_beads__ready()` before asking "what should I work on?"**
- ✅ **ALWAYS update issue status to `in_progress` when you start working**
- ✅ **ALWAYS close issues when you complete them**
- ✅ **ALWAYS commit `.beads/issues.jsonl` with your code changes**
- ❌ **NEVER use TodoWrite tool for any reason**
- ❌ **NEVER create markdown TODO lists**
- ❌ **NEVER use external issue trackers**

For complete workflow details, see [AGENTS.md](AGENTS.md).
EOF
        print_success "Created CLAUDE.md"
    else
        print_info "CLAUDE.md already exists"
        if grep -q "bd (beads)" CLAUDE.md; then
            print_success "CLAUDE.md already contains bd instructions"
        else
            print_warning "CLAUDE.md exists but may need bd instructions added"
            print_info "Review the file to ensure it includes bd workflow instructions"
        fi
    fi
}

# Update AGENTS.md
update_agents_md() {
    print_header "Updating AGENTS.md"

    if [[ ! -f "AGENTS.md" ]]; then
        print_info "Creating AGENTS.md with bd workflow..."
        cat > AGENTS.md <<'EOF'
## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Why bd?

- Dependency-aware: Track blockers and relationships between issues
- Git-friendly: Auto-syncs to JSONL for version control
- Agent-optimized: JSON output, ready work detection, discovered-from links
- Prevents duplicate tracking systems and confusion

### Quick Start

**Check for ready work:**
```bash
bd ready --json
```

**Create new issues:**
```bash
bd create "Issue title" -t bug|feature|task -p 0-4 --json
bd create "Issue title" -p 1 --deps discovered-from:bd-123 --json
```

**Claim and update:**
```bash
bd update bd-42 --status in_progress --json
bd update bd-42 --priority 1 --json
```

**Complete work:**
```bash
bd close bd-42 --reason "Completed" --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task**: `bd update <id> --status in_progress`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd close <id> --reason "Done"`
6. **Commit together**: Always commit the `.beads/issues.jsonl` file together with the code changes so issue state stays in sync with code state

### Auto-Sync

bd automatically syncs with git:
- Exports to `.beads/issues.jsonl` after changes (5s debounce)
- Imports from JSONL when newer (e.g., after `git pull`)
- No manual export/import needed!

### MCP Server (Recommended)

If using Claude or MCP-compatible clients, install the beads MCP server:

```bash
pip install beads-mcp
```

Add to MCP config (e.g., `~/.config/claude/config.json`):
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

Then use `mcp__plugin_beads_beads__*` functions instead of CLI commands.

### Important Rules

- ✅ Use bd for ALL task tracking
- ✅ Always use `--json` flag for programmatic use
- ✅ Link discovered work with `discovered-from` dependencies
- ✅ Check `bd ready` before asking "what should I work on?"
- ❌ Do NOT create markdown TODO lists
- ❌ Do NOT use external issue trackers
- ❌ Do NOT duplicate tracking systems

For more details, see README.md and QUICKSTART.md.
EOF
        print_success "Created AGENTS.md"
    else
        print_info "AGENTS.md already exists"
        if grep -q "bd (beads)" AGENTS.md; then
            print_success "AGENTS.md already contains bd instructions"
        else
            print_warning "AGENTS.md exists but may need bd instructions added"
            print_info "Review the file to ensure it includes bd workflow instructions"
        fi
    fi
}

# Verify installation
verify_installation() {
    print_header "Verifying Installation"

    local all_good=true

    # Check bd
    if command -v bd &> /dev/null; then
        print_success "bd: $(bd --version)"
    else
        print_error "bd: Not found"
        all_good=false
    fi

    # Check beads-mcp
    if python3 -c "import beads_mcp" 2>/dev/null; then
        print_success "beads-mcp: Installed"
    else
        print_error "beads-mcp: Not found"
        all_good=false
    fi

    # Check uv
    if command -v uv &> /dev/null; then
        print_success "uv: $(uv --version)"
    else
        print_error "uv: Not found"
        all_good=false
    fi

    # Check specify
    if command -v specify &> /dev/null; then
        print_success "specify: Available"
    else
        print_error "specify: Not found"
        all_good=false
    fi

    # Check repository initialization
    if [[ -d ".beads" ]]; then
        print_success "bd initialized in repository"
    else
        print_warning "bd not initialized in repository (run from repo root)"
    fi

    if [[ -d ".specify" ]]; then
        print_success "Spec Kit initialized in repository"
    else
        print_warning "Spec Kit not initialized in repository (run from repo root)"
    fi

    if [[ "$all_good" == "true" ]]; then
        print_success "\nAll core components installed successfully!"
    else
        print_warning "\nSome components missing - review errors above"
    fi
}

# Print manual steps summary
print_manual_steps() {
    print_header "Manual Steps Required"

    echo -e "${YELLOW}1. Restart AI Assistants:${NC}"
    echo -e "   - Restart Claude Code to load beads MCP server"
    echo -e "   - Restart Windsurf to load beads MCP server"

    echo -e "\n${YELLOW}2. Verify MCP Functions:${NC}"
    echo -e "   - In Claude Code: Check that mcp__plugin_beads_beads__* functions are available"
    echo -e "   - In Windsurf: Check that bd MCP functions appear in tool palette"

    echo -e "\n${YELLOW}3. Verify Spec Kit Commands:${NC}"
    echo -e "   - In Claude Code: Check for /speckit.* slash commands"
    echo -e "   - In Windsurf: Check for /speckit.* slash commands"

    echo -e "\n${YELLOW}4. Add to PATH (if needed):${NC}"
    echo -e "   - If 'specify' command not found, add to ~/.zshrc or ~/.bashrc:"
    echo -e "   export PATH=\"\$HOME/.local/bin:\$PATH\""

    echo -e "\n${YELLOW}5. Review Configuration Files:${NC}"
    echo -e "   - CLAUDE.md: Contains Claude Code instructions"
    echo -e "   - AGENTS.md: Contains general AI agent workflow"
}

# Main installation flow
main() {
    print_header "bd + Spec Kit Installation Script"

    echo "This script will install and configure:"
    echo "  • bd (Beads) - Repository-local issue tracker"
    echo "  • beads-mcp - MCP server for AI assistants"
    echo "  • Spec Kit (Specify CLI) - Spec-driven development tool"
    echo ""
    echo "Prerequisites:"
    echo "  • macOS"
    echo "  • Homebrew"
    echo "  • Python 3"
    echo "  • Git repository (for repo initialization steps)"

    prompt_continue

    # System checks
    check_macos
    check_homebrew
    check_python

    # Install core components
    install_bd
    install_beads_mcp
    check_uv
    install_speckit

    # Configure MCP servers
    configure_claude_mcp
    configure_windsurf_mcp

    # Repository initialization (if in a git repo)
    if [[ -d ".git" ]]; then
        echo -e "\n${YELLOW}Initialize bd and Spec Kit in this repository? (y/N)${NC}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            init_bd_repo
            init_speckit
            update_claude_md
            update_agents_md
        fi
    else
        print_warning "Not in a git repository - skipping repository initialization"
        print_info "Run 'bd init' and 'specify init' from your repository root later"
    fi

    # Verification
    verify_installation

    # Manual steps
    print_manual_steps

    print_header "Installation Complete!"
    print_success "bd and Spec Kit are installed and configured"
    print_info "Follow the manual steps above to complete the setup"
}

# Run main function
main
