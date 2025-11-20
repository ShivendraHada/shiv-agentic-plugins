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

# Update constitution to enforce bd usage and TDD approach
update_constitution() {
    print_header "Updating Project Constitution"

    local constitution_file=".specify/memory/constitution.md"

    # Create directory if needed
    mkdir -p "$(dirname "$constitution_file")"

    # Check if constitution already has full bd enforcement
    if [[ -f "$constitution_file" ]] && grep -q "ABSOLUTE PROHIBITION - NO EXCEPTIONS" "$constitution_file" 2>/dev/null; then
        print_success "Constitution already has complete bd enforcement"
        return
    fi

    print_info "Installing complete constitution with bd enforcement and TDD approach..."

    # Backup existing constitution if present
    if [[ -f "$constitution_file" ]]; then
        cp "$constitution_file" "${constitution_file}.backup"
        print_info "Backed up existing constitution to ${constitution_file}.backup"
    fi

    # Write complete constitution with all sections
    cat > "$constitution_file" << 'CONSTITUTION_EOF'
<!--
Sync Impact Report
- Version change: 0.0.0 → 1.0.0
- Modified principles: initialized from template (no prior concrete principles)
- Added sections: Core Principles, Additional Constraints & Standards, Development Workflow & Quality Gates, Governance
- Removed sections: None (template placeholders fully materialized)
- Templates reviewed (no content changes required):
  - ✅ .specify/templates/plan-template.md
  - ✅ .specify/templates/spec-template.md
  - ✅ .specify/templates/tasks-template.md
  - ✅ .specify/templates/checklist-template.md
  - ✅ .specify/templates/agent-file-template.md
- Deferred TODOs: None (all placeholders resolved for this version)
-->

# Project Constitution

## Core Principles

### I. Spec‑Driven, Outcome‑First

All significant work starts from an explicit specification and clear
outcome metrics rather than ad‑hoc implementation.

- Every feature has a written spec and plan generated via Spec Kit
  (`/speckit.specify`, `/speckit.plan`, `/speckit.tasks`).
- Specs focus on user value, measurable success criteria, and constraints
  before selecting technologies.
- Implementation follows the spec and plan; deviations MUST be captured
  as explicit updates to those artifacts.

### II. Safety, Security, and Data Integrity by Default

Security and data integrity constraints are treated as first‑class
requirements, not afterthoughts.

- All changes are reviewed for injection risks (SQL, command, template),
  XSS, CSRF, and credential leakage.
- Input validation, output encoding, and least‑privilege access are
  mandatory in all layers.
- Data‑affecting changes MUST define recovery/rollback expectations and
  be testable in non‑production environments.

### III. Test‑First, Observable, and Reproducible

Work is driven by tests and observability signals that make failures
obvious and reproducible.

- For non‑trivial changes, tests or explicit verification steps are
  defined before implementation.
- Each feature aims to include fast, automated checks (unit, contract,
  or integration) appropriate to its risk.
- Instrumentation (logging, metrics, or traces) MUST be sufficient to
  diagnose production issues without re‑deploying debug builds.

### IV. Task and Workflow Discipline with bd

**bd (beads) is the single source of truth for ALL task tracking.**

All work is tracked and decomposed into explicit issues and tasks using
`bd` (beads); AI agents operate through those workflows.

**ABSOLUTE PROHIBITION - NO EXCEPTIONS**:
- **NEVER use TodoWrite tool** - Any use of TodoWrite is a VIOLATION
- **NEVER create TODO.md files** - Creating TODO.md is FORBIDDEN
- **NEVER create TODO lists in markdown** - Task lists, checklists, or any TODO-style lists in ANY markdown file are PROHIBITED
- **NEVER create task tracking in comments** - No TODO comments, no task lists in code
- **NEVER use any task tracking except bd** - bd is the ONLY permitted task tracking system

**CRITICAL ENFORCEMENT**:
- AI agents attempting to create TODO lists or use TodoWrite are in DIRECT VIOLATION of this constitution
- There are NO circumstances where TODO lists, TodoWrite, or alternative task tracking are acceptable
- Every task, subtask, work item, or action item MUST be tracked in bd exclusively
- DO NOT work around this requirement - it is MANDATORY

**Required Workflow**:
- Every meaningful change has an associated bd issue with clear
  acceptance criteria and priority.
- Dependencies between tasks and features are modeled using bd
  relationships (e.g., `blocks`, `discovered-from`).
- AI‑driven changes (via Windsurf, Claude Code, or other agents) MUST
  reference the governing bd issue and keep it in sync with code state.
- AI agents MUST use bd MCP functions (e.g., `mcp__plugin_beads_beads__*`)
  or bd CLI commands with `--json` flag.
- All issue state changes MUST be committed to git with code changes
  (`.beads/issues.jsonl` is the persistent record).

**Why bd is the Source of Truth**:
- **Persistent**: Issues survive across AI agent chat sessions
- **Dependency-aware**: Track blockers and relationships between work items
- **Git-synced**: Auto-syncs to `.beads/issues.jsonl` for version control
- **AI-optimized**: JSON output, ready work detection, discovered-from links
- **Multi-assistant safe**: Multiple team members and AI assistants work without conflicts
- **Context preservation**: Prevents context loss that occurs with ephemeral TODO lists

**Rationale**: bd provides persistent, dependency-aware, git-synced issue
tracking that survives across AI agent sessions and prevents context loss.
Unlike TodoWrite or markdown TODO lists, bd maintains state across sessions,
enables dependency tracking, and ensures all team members (human and AI) have
a shared, authoritative view of work status.

### V. Architecture: Intentional, Evolvable, and Minimal

Architecture follows domain needs and is kept as simple as possible
while supporting evolution.

- Prefer clear boundaries (DDD‑inspired, CQRS/event‑driven where
  justified) but avoid speculative abstraction.
- Cross‑service and cross‑boundary contracts MUST be explicit
  (interfaces, events, or APIs) and versioned deliberately.
- Complexity (frameworks, patterns, or infrastructure) MUST be
  justified in specs and plans, especially when it increases cognitive
  load for the team.

## Additional Constraints & Standards

This section captures global constraints that apply across all specs,
plans, and implementations.

- **Technology Baseline**: Modern, supported runtimes and libraries are
  required; end‑of‑life or unpatched dependencies MUST NOT be
  introduced.
- **Performance & Reliability**: Each feature spec defines success
  metrics where relevant (e.g., latency, throughput, error budgets).
  Changes MUST not violate established SLOs without an explicit, agreed
  trade‑off captured in the spec.
- **Security & Compliance**: All code paths that touch authentication,
  authorization, or sensitive data MUST include tests or explicit
  validation steps. Secrets must never be hard‑coded; configuration is
  provided via secure configuration mechanisms.
- **AI Agent Usage**: AI agents are assistants, not authorities. All
  generated code and configuration MUST be reviewed and validated
  against this constitution, project specs, and security constraints.

## Development Workflow & Quality Gates

The development workflow is driven by Spec Kit and bd.

- **Spec First**: `/speckit.specify` produces the feature spec; it MUST
  be understandable by humans and traceable to user or business value.
- **Plan Second**: `/speckit.plan` defines architecture, technology
  choices, and constraints; it MUST pass the Constitution Check section
  of the plan template.
- **Tasks Third**: `/speckit.tasks` generates an ordered task breakdown;
  tasks MUST be small, testable, and mapped to bd issues as
  appropriate.
- **Implementation**: `/speckit.implement` or equivalent manual work
  MUST follow the task breakdown and keep documentation in sync.
- **Quality Gates**: Before merging, feature work MUST have:
  - Updated specs/plans/tasks reflecting what was actually built.
  - Appropriate tests or documented verification steps.
  - bd issues moved to an appropriate terminal state with notes.

## Governance

This constitution governs how work is specified, planned, implemented,
and reviewed in this repository.

- This document supersedes informal conventions; conflicts are resolved
  in favor of the constitution.
- Amendments MUST be made via pull requests linked to bd issues that
  explain the motivation and impact.
- Version numbers follow semantic versioning:
  - **MAJOR**: Backwards‑incompatible changes to principles or
    governance.
  - **MINOR**: New principles or substantial expansions.
  - **PATCH**: Clarifications and non‑semantic edits.
- Every amendment MUST update the Sync Impact Report at the top of this
  file and review related templates for alignment.
- Compliance with this constitution is a required review gate for all
  changes; reviewers and AI agents should call out violations explicitly
  in review notes.

**Version**: 1.0.0 | **Ratified**: $(date +%Y-%m-%d) | **Last Amended**: $(date +%Y-%m-%d)
CONSTITUTION_EOF

    print_success "Installed complete constitution with:"
    print_success "  • Spec-driven development (Section I)"
    print_success "  • Security by default (Section II)"
    print_success "  • Test-first/TDD approach (Section III)"
    print_success "  • bd enforcement with absolute prohibition (Section IV)"
    print_success "  • Architecture principles (Section V)"
    print_success "  • Quality gates and governance"
}

# Inject bd instructions into workflow files
inject_bd_instructions() {
    print_header "Injecting bd Instructions into Workflow Files"

    # NOTE: This function injects bd enforcement headers into Spec Kit workflow files.
    # The actual workflow logic (especially speckit.tasks.md) has been updated to:
    # - Create bd child issues for each task using mcp__plugin_beads_beads__create()
    # - Link tasks to parent feature/epic using mcp__plugin_beads_beads__dep()
    # - Reference bd issue IDs in tasks.md instead of using markdown checkboxes
    # - Generate bd Issue Summary table mapping Task IDs to bd issue IDs

    # Update Claude Code workflow files
    if [[ -d ".claude/commands" ]]; then
        local claude_updated=0
        for file in .claude/commands/speckit.*.md; do
            [[ -f "$file" ]] || continue

            # Skip if already has bd instructions
            if grep -q "CRITICAL: This project uses bd" "$file" 2>/dev/null; then
                continue
            fi

            # Use awk to insert after frontmatter
            awk 'BEGIN{count=0; inserted=0}
            /^---$/{
                count++;
                print;
                if(count==2 && inserted==0) {
                    print ""
                    print "---"
                    print "**CRITICAL: This project uses bd (beads) for ALL task tracking**"
                    print ""
                    print "**ABSOLUTE PROHIBITION - NO EXCEPTIONS:**"
                    print "- **NEVER use TodoWrite tool** - Any use is a VIOLATION of the constitution"
                    print "- **NEVER create TODO.md files** - Creating TODO.md is FORBIDDEN"
                    print "- **NEVER create TODO lists in markdown** - Task lists in ANY markdown file are PROHIBITED"
                    print "- **NEVER work around this requirement** - There are NO exceptions"
                    print ""
                    print "**REQUIRED:**"
                    print "- **ALWAYS use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all tracking"
                    print "- **ALWAYS track ALL tasks in bd** - Every task, subtask, and work item MUST be in bd"
                    print ""
                    print "See CLAUDE.md and AGENTS.md for complete bd workflow instructions."
                    print "See .specify/memory/constitution.md Section IV for full requirements."
                    print "---"
                    print ""
                    inserted=1
                }
                next
            }
            {print}' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

            ((claude_updated++))
        done

        if [[ $claude_updated -gt 0 ]]; then
            print_success "Updated $claude_updated Claude Code workflow files"
        else
            print_info "Claude Code workflow files already have bd instructions"
        fi
    fi

    # Update Windsurf workflow files
    if [[ -d ".windsurf/workflows" ]]; then
        local windsurf_updated=0
        for file in .windsurf/workflows/speckit.*.md; do
            [[ -f "$file" ]] || continue

            # Skip if already has bd instructions
            if grep -q "CRITICAL: This project uses bd" "$file" 2>/dev/null; then
                continue
            fi

            # Use awk to insert after frontmatter
            awk 'BEGIN{count=0; inserted=0}
            /^---$/{
                count++;
                print;
                if(count==2 && inserted==0) {
                    print ""
                    print "---"
                    print "**CRITICAL: This project uses bd (beads) for ALL task tracking**"
                    print ""
                    print "**ABSOLUTE PROHIBITION - NO EXCEPTIONS:**"
                    print "- **NEVER use TodoWrite tool** - Any use is a VIOLATION of the constitution"
                    print "- **NEVER create TODO.md files** - Creating TODO.md is FORBIDDEN"
                    print "- **NEVER create TODO lists in markdown** - Task lists in ANY markdown file are PROHIBITED"
                    print "- **NEVER work around this requirement** - There are NO exceptions"
                    print ""
                    print "**REQUIRED:**"
                    print "- **ALWAYS use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all tracking"
                    print "- **ALWAYS track ALL tasks in bd** - Every task, subtask, and work item MUST be in bd"
                    print ""
                    print "See CLAUDE.md and AGENTS.md for complete bd workflow instructions."
                    print "See .specify/memory/constitution.md Section IV for full requirements."
                    print "---"
                    print ""
                    inserted=1
                }
                next
            }
            {print}' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

            ((windsurf_updated++))
        done

        if [[ $windsurf_updated -gt 0 ]]; then
            print_success "Updated $windsurf_updated Windsurf workflow files"
        else
            print_info "Windsurf workflow files already have bd instructions"
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
    echo "The script has two phases:"
    echo "  1. Global installation (tools available system-wide)"
    echo "  2. Repository initialization (set up THIS repository)"
    echo ""
    echo "If you already have tools installed, you can skip upgrades."
    echo "The script will still offer to initialize THIS repository."
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
    # This runs independently of whether tools were installed or skipped above
    if [[ -d ".git" ]]; then
        print_header "Repository Initialization"
        echo -e "${YELLOW}Would you like to initialize bd and Spec Kit in THIS repository?${NC}"
        echo -e "This will:"
        echo -e "  • Run 'bd init' (creates .beads/ directory)"
        echo -e "  • Run 'specify init' (creates .specify/ and slash commands)"
        echo -e "  • Create/update CLAUDE.md and AGENTS.md with bd workflow"
        echo -e "  • Update constitution to enforce bd usage (no TodoWrite)"
        echo -e "  • Inject bd instructions into all workflow files"
        echo -e ""
        echo -e "${YELLOW}Initialize now? (Y/n)${NC}"
        read -r response
        if [[ ! "$response" =~ ^[Nn]$ ]]; then
            init_bd_repo
            init_speckit
            update_claude_md
            update_agents_md
            update_constitution
            inject_bd_instructions
        else
            print_info "Skipping repository initialization"
            print_info "To initialize later, run from your repository root:"
            print_info "  bd init"
            print_info "  specify init --here --ai claude"
            print_info "  specify init --here --ai windsurf"
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
