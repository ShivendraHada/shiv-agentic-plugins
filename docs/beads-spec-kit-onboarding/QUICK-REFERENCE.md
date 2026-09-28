# bd + Spec Kit Quick Reference

## Installation

```bash
# Automated installation (recommended)
./install-bd-speckit.sh

# Manual installation
brew install bd
pip3 install beads-mcp
brew install uv
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

## bd (Beads) Commands

### Basic Workflow

```bash
# Initialize repository
bd init

# Create issue
bd create "Issue title" -t feature -p 1 --json

# List issues
bd list --status open --json
bd list --priority 1 --json

# Show issue details
bd show bd-42 --json

# Update issue
bd update bd-42 --status in_progress --json
bd update bd-42 --priority 2 --json

# Close issue
bd close bd-42 --reason "Completed" --json

# Find ready work
bd ready --json

# Check blocked issues
bd blocked --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance

### Priorities

- `0` - Critical (security, data loss)
- `1` - High (major features, important bugs)
- `2` - Medium (default)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Dependencies

```bash
# Add dependency
bd dep bd-42 --depends-on bd-41 --type blocks

# Dependency types
# - blocks: Hard blocker
# - related: Soft link
# - parent-child: Epic/subtask
# - discovered-from: Found during work
```

### JIRA Integration

```bash
# Create issue linked to JIRA
bd create "USER-123: Feature title" \
  -t feature -p 1 \
  --external-ref "https://company.atlassian.net/browse/USER-123" \
  --json
```

## bd MCP Functions (Claude Code)

### Basic Operations

```python
# Find ready work
mcp__plugin_beads_beads__ready()

# List issues
mcp__plugin_beads_beads__list(status="open")

# Show issue
mcp__plugin_beads_beads__show(issue_id="bd-42")

# Create issue
mcp__plugin_beads_beads__create(
    title="Issue title",
    issue_type="feature",
    priority=1
)

# Update issue
mcp__plugin_beads_beads__update(
    issue_id="bd-42",
    status="in_progress"
)

# Close issue
mcp__plugin_beads_beads__close(
    issue_id="bd-42",
    reason="Completed"
)

# Add dependency
mcp__plugin_beads_beads__dep(
    issue_id="bd-42",
    depends_on_id="bd-41",
    dep_type="blocks"
)
```

## Spec Kit Commands

### CLI Usage

```bash
# Check prerequisites
specify check

# Initialize for AI assistants
specify init --here --ai claude
```

### Slash Commands (in AI Assistants)

```
# Create project constitution
/speckit-constitution

# Create feature specification
/speckit-specify <feature description>

# Create implementation plan
/speckit-plan

# Generate tasks from plan
/speckit-tasks

# Execute implementation
/speckit-implement

# Identify unclear requirements
/speckit-clarify

# Analyze consistency across artifacts
/speckit-analyze

# Convert tasks to GitHub issues
/speckit-taskstoissues
```

## Workflow: New Feature

### 1. Create bd Feature Issue

```bash
bd create "Feature: Export reports to CSV" -t feature -p 1 --json
# Output: bd-101
```

### 2. Create Spec Kit Feature

```
/speckit-specify Export reports to CSV

User should be able to export reports in CSV format with all columns and data.
```

Result: Creates `specs/101-export-reports/spec.md`

### 3. Create Implementation Plan

```
/speckit-plan
```

Result: Creates `specs/101-export-reports/plan.md`

### 4. Generate Tasks

```
/speckit-tasks
```

Result:
- Creates `specs/101-export-reports/tasks.md`
- Creates bd task issues: bd-102, bd-103, etc.
- Links tasks to parent bd-101

### 5. Implement

```
/speckit-implement
```

AI assistant:
- Executes each task in order
- Updates bd status: `in_progress` → `closed`
- Marks tasks `[x]` in tasks.md

### 6. Create PR

```bash
git add .
git commit -m "bd-101: Export reports to CSV feature

Implemented CSV export functionality with tests.

Spec Kit feature: specs/101-export-reports/"

gh pr create --title "bd-101: Export reports to CSV"
```

### 7. Post-merge

```bash
bd close bd-101 --reason "Merged to main" --json
```

## Workflow: JIRA Story

### 1. Sync JIRA to bd

```bash
bd create "USER-456: Filter reports by date" \
  -t feature -p 1 \
  --external-ref "https://company.atlassian.net/browse/USER-456" \
  --json
```

### 2. Create Spec from JIRA

```
/speckit-specify USER-456: Filter reports by date range

[Paste JIRA user story]
[Paste Gherkin scenarios]
[Paste Definition of Done]
```

### 3-7. Follow Standard Workflow

Same as steps 3-7 above.

### 8. Update JIRA

After PR merge, update JIRA story to "Done" status.

## MCP Configuration

### Claude Code

`~/.config/claude/config.json`:

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

## File Structure

```
.
├── .beads/
│   ├── beads.db           # bd database
│   └── issues.jsonl       # Git-synced issues
├── .specify/              # Spec Kit internals
├── .claude/
│   └── commands/
│       └── speckit.*.md   # Claude Code slash commands (from `specify init`)
├── specs/
│   └── 001-feature-name/
│       ├── spec.md        # Feature specification
│       ├── plan.md        # Implementation plan
│       ├── tasks.md       # Task breakdown
│       └── research.md    # Research notes
├── CLAUDE.md              # Claude Code instructions
└── AGENTS.md              # General AI agent workflow
```

## Best Practices

### bd Workflow

- ✅ Always use `--json` flag for programmatic use
- ✅ Commit `.beads/issues.jsonl` with code changes
- ✅ Use `bd ready` to find unblocked work
- ✅ Link discovered work with `discovered-from`
- ❌ Never edit `.beads/issues.jsonl` manually
- ❌ Don't use markdown TODOs

### Spec Kit Workflow

- ✅ One feature = one Spec Kit directory
- ✅ Run commands in order: specify → plan → tasks → implement
- ✅ Update spec.md when requirements change
- ✅ Keep tasks.md in sync with bd issues
- ❌ Don't skip the planning phase
- ❌ Don't implement without tasks

### JIRA Integration

- ✅ Use `external_ref` to link bd ↔ JIRA
- ✅ Include JIRA ID in branch names
- ✅ Convert Gherkin scenarios to E2E tests
- ✅ Map DoD items to Spec Kit tasks
- ❌ Don't duplicate JIRA content in bd
- ❌ Don't forget to update JIRA after merge

## Troubleshooting

### bd not syncing

```bash
# Check .gitignore
cat .gitignore | grep beads

# Ensure .beads/ is tracked
git add .beads/issues.jsonl
git commit -m "Track bd issues"
```

### MCP not working

```bash
# Verify installation
python3 -c "import beads_mcp; print('OK')"

# Check config
cat ~/.config/claude/config.json

# Restart AI assistant
```

### specify not found

```bash
# Add to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Resources

- **bd**: https://github.com/steveyegge/beads
- **Spec Kit**: https://github.com/github/spec-kit
- **beads-mcp**: https://pypi.org/project/beads-mcp/
- **JIRA Workflow**: `docs/beads-spec-kit-onboarding/jira-to-speckit-workflow.md`
- **Slides**: `docs/beads-spec-kit-onboarding/slides.md`
