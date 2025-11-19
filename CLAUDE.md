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
