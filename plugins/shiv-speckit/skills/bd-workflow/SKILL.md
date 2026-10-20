---
name: bd-workflow
description: Beads (bd) issue tracking workflow for Claude Code. Provides patterns for using bd CLI and MCP functions to track tasks, manage dependencies, and maintain issue state. Applied automatically when task tracking is needed. IMPORTANT - this project uses bd exclusively for task tracking, never TodoWrite or markdown TODOs.
user-invocable: false
---

# Beads (bd) Issue Tracking Workflow

Beads (bd) is the single source of truth for ALL task tracking in this project. This document defines how to use bd for issue management, dependency tracking, and workflow integration with Claude Code.

## Core Principle

**bd is the ONLY task tracking mechanism.** Do not use any other approach for tracking work items.

- **NEVER** use the `TodoWrite` tool. It is not part of the workflow.
- **NEVER** create markdown TODO lists, checkbox lists, or ad-hoc tracking files.
- **ALWAYS** use bd CLI commands or bd MCP functions to create, update, and close tasks.

All task state lives in the bd database. The `.beads/issues.jsonl` file is the persistent, git-tracked representation that keeps task state synchronized across sessions and collaborators.

## Available MCP Functions

When operating within Claude Code, prefer MCP functions for programmatic interaction with bd:

| Function | Purpose |
|---|---|
| `mcp__plugin_beads_beads__ready` | Find unblocked tasks ready for work |
| `mcp__plugin_beads_beads__list` | List all issues |
| `mcp__plugin_beads_beads__show` | Show details of a specific issue |
| `mcp__plugin_beads_beads__create` | Create a new issue |
| `mcp__plugin_beads_beads__update` | Update an existing issue (status, priority, etc.) |
| `mcp__plugin_beads_beads__close` | Close an issue with a reason |
| `mcp__plugin_beads_beads__dep` | Manage dependencies between issues |

## CLI Commands

When running commands in the shell, use the `bd` CLI. Always include the `--json` flag when the output will be parsed programmatically (e.g., by Claude Code).

| Command | Purpose |
|---|---|
| `bd ready [--json]` | Find unblocked tasks ready to be worked on |
| `bd create "title" -t type -p priority [--deps ...] [--json]` | Create a new issue |
| `bd update <id> --status <status> [--priority <n>] [--json]` | Update an issue |
| `bd close <id> --reason "reason" [--json]` | Close a completed issue |
| `bd list [--json]` | List all issues |
| `bd show <id> [--json]` | Show full details of an issue |
| `bd dep add <a> <b>` | Make issue `a` depend on issue `b` |
| `bd dep tree <id>` | Show the dependency tree for an issue |
| `bd search <query>` | Search issues by text |
| `bd sync` | Sync bd state with git |
| `bd info` | Show database info and statistics |

See: `references/bd-commands.md` for the complete command reference.

## Standard Workflow

The typical workflow for picking up and completing a task follows this sequence:

### 1. Check for Ready Tasks

```bash
bd ready --json
```

This returns all issues that are unblocked -- meaning all their dependencies are resolved. Work should always start from the ready queue rather than arbitrarily picking issues.

### 2. Claim a Task

```bash
bd update <id> --status in-progress
```

Move the issue to `in-progress` to signal that work has begun. This prevents duplicate effort when multiple agents or developers are active.

### 3. Work the Task

Implement the changes described by the issue. Follow the project's development practices (TDD cycle, code quality standards, etc.).

If during implementation you discover additional work that needs to be done:
- Create new issues with `bd create` for the discovered work.
- Link them with `bd dep add` if there are dependency relationships.
- Include `discovered-from: <parent-id>` context in the new issue description.

### 4. Close the Task

```bash
bd close <id> --reason "Implemented feature X with tests"
```

Provide a meaningful reason that explains what was accomplished. This serves as a log entry for the work done.

### 5. Commit the State

After closing tasks, commit the updated `.beads/issues.jsonl` file to git. This ensures the task state is tracked alongside the code changes it relates to.

```bash
git add .beads/issues.jsonl
git commit -m "Update task tracking: close <id>"
```

## Issue Types

Use the correct issue type when creating tasks:

| Type | When to Use |
|---|---|
| `bug` | Something is broken and needs to be fixed |
| `feature` | New functionality to be added |
| `task` | General work item (refactoring, configuration, setup) |
| `epic` | Large body of work that will be broken into sub-tasks |
| `chore` | Maintenance work (dependency updates, cleanup, tooling) |

## Priority Levels

Priorities are numeric, with lower numbers indicating higher urgency:

| Priority | Level | Meaning |
|---|---|---|
| 0 | Critical | Must be addressed immediately. Blocks all other work. |
| 1 | High | Important and should be addressed in the current cycle. |
| 2 | Medium | Normal priority. Address after high-priority items. |
| 3 | Low | Nice to have. Address when capacity permits. |
| 4 | Backlog | Tracked for future consideration. No immediate timeline. |

## Dependency Tracking

Dependencies define execution order. An issue with unresolved dependencies will not appear in `bd ready`.

### Adding Dependencies

```bash
bd dep add <dependent-id> <dependency-id>
```

This means: issue `<dependent-id>` depends on `<dependency-id>` and cannot start until `<dependency-id>` is closed.

### Viewing the Dependency Tree

```bash
bd dep tree <id>
```

This shows the full tree of what an issue depends on and what depends on it.

### Discovered-From Links

When working on an issue reveals additional necessary work, create the new issue and document the relationship:

```bash
bd create "Fix edge case in validation" -t bug -p 1 --deps <parent-id>
```

This maintains traceability from the original task to the discovered work.

## Auto-Sync Behavior

bd automatically manages synchronization between its in-memory database and the `.beads/issues.jsonl` file:

- **Export**: After any mutation (create, update, close, dep), bd exports the current state to `.beads/issues.jsonl`.
- **Import**: When bd starts, if `.beads/issues.jsonl` is newer than the database, bd imports the file to restore state.

This means:
- You can safely switch branches and bd will pick up the correct task state.
- Multiple collaborators can work on tasks as long as they commit `.beads/issues.jsonl` regularly.
- Git merge conflicts in `.beads/issues.jsonl` should be resolved by taking the union of changes and running `bd sync`.

## Integration with Speckit Workflow

When working within the speckit lifecycle:

1. After `/speckit-tasks` generates the task list, create corresponding bd issues for each task.
2. Use bd priorities to match the spec priorities (P1 = priority 1, P2 = priority 2, etc.).
3. Use bd dependencies to encode the phase ordering (Foundational blocks User Stories, etc.).
4. As you implement via `/speckit-implement`, use `bd ready` to determine the next task and `bd close` when each task is complete.
5. The bd issue history provides an audit trail of the implementation sequence.
