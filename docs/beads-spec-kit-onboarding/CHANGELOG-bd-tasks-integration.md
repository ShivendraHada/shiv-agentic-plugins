# Changelog: bd Tasks Integration

**Date**: 2025-11-19
**Version**: 1.1.0

## Overview

Updated `/speckit.tasks` and `/speckit.implement` workflows to use bd as the single source of truth for all task tracking. tasks.md is now a simple reference list pointing to bd issues, not a TODO list. All task state, dependencies, and tracking happen in bd.

## What Changed

### 1. Workflow Files Updated

**Files Modified**:
- [.claude/commands/speckit.tasks.md](../../.claude/commands/speckit.tasks.md)
- [.windsurf/workflows/speckit.tasks.md](../../.windsurf/workflows/speckit.tasks.md)

**Changes**:
- Added **bd Issue Creation** section with step-by-step instructions
- Changed **tasks.md Format** from markdown checkboxes to bd issue references
- Updated **Phase Structure** to specify bd child issue creation for each phase
- Added **bd Issue Summary Table** requirement at end of tasks.md

### 2. Task Format Change

**OLD Format** (Prohibited - TODO checkboxes):
```markdown
- [ ] T001 Create project structure per implementation plan
- [ ] T005 [P] Implement authentication middleware in src/middleware/auth.py
- [ ] T012 [P] [US1] Create User model in src/models/user.py
```

**NEW Format** (Required - bd issue references):
```markdown
- **bd-102**: Create project structure per implementation plan
- **bd-105**: Implement authentication middleware in src/middleware/auth.py
- **bd-112**: [US1] Create User model in src/models/user.py (blocks: bd-103)
```

**Key Changes**:
- ❌ NO checkboxes - bd tracks status, not markdown
- ❌ NO Task IDs (T001, T002) - bd issue IDs ARE the task IDs
- ✅ Simple bullet list with bd issue references
- ✅ Optional blocker notes in parentheses

### 3. Workflow Logic Changes

**Step 3: Execute task generation workflow** now includes:
- Identify or create parent bd issue using `mcp__plugin_beads_beads__list()`
- Create bd child issues for each task using `mcp__plugin_beads_beads__create()`
- Link to parent using `mcp__plugin_beads_beads__dep()` with `dep_type="parent-child"`

**Step 4: Generate tasks.md** now creates:
- Simple reference list (not detailed task breakdown)
- Just bd issue IDs with brief descriptions
- No checkboxes, no Task IDs, no status tracking
- Footer with bd usage instructions

**Step 5: Report** now includes:
- Parent bd issue ID
- Total bd child issues created
- Ready work using `mcp__plugin_beads_beads__ready()`

## How It Works

### During `/speckit.tasks` execution:

1. **Identify Parent Issue**: Workflow asks user for parent bd issue ID (e.g., "bd-042") or finds it using MCP functions

2. **Create Child Issues**: For each task to be generated:
   ```javascript
   mcp__plugin_beads_beads__create({
     title: "Create User model in src/models/user.py",
     issue_type: "task",
     priority: 2,  // Based on phase
     description: "File: src/models/user.py\n\nTechnical details...",
     deps: []
   })
   // Returns: { id: "bd-112", ... }
   ```

3. **Link to Parent**: Create parent-child relationship:
   ```javascript
   mcp__plugin_beads_beads__dep({
     issue_id: "bd-112",      // Child task
     depends_on_id: "bd-042", // Parent feature/epic
     dep_type: "parent-child"
   })
   ```

4. **Create Dependencies**: For sequential tasks:
   ```javascript
   mcp__plugin_beads_beads__dep({
     issue_id: "bd-103",      // Task that depends
     depends_on_id: "bd-102", // Task it depends on
     dep_type: "blocks"
   })
   ```

5. **Generate tasks.md**: Reference bd issue IDs instead of checkboxes:
   ```markdown
   ## Phase 1: Setup

   **bd-102**: [T001] Create project structure per implementation plan
   **bd-103**: [T002] Initialize dependencies (depends on bd-102)

   ## bd Issue Summary

   | Task ID | bd Issue ID | Status | Title | Blockers |
   |---------|-------------|--------|-------|----------|
   | T001 | bd-102 | open | Create project structure | - |
   | T002 | bd-103 | open | Initialize dependencies | bd-102 |
   ```

### During `/speckit.implement` execution:

The workflow now operates entirely through bd:

1. **Read tasks.md**: Extract bd issue IDs (just for reference)
2. **Get Ready Work**: `mcp__plugin_beads_beads__ready()` to find tasks with no blockers
3. **For each ready task**:
   - Show details: `mcp__plugin_beads_beads__show(issue_id)`
   - Claim task: `mcp__plugin_beads_beads__update(issue_id, status="in_progress")`
   - Implement the task
   - Complete task: `mcp__plugin_beads_beads__close(issue_id, reason="Completed")`
4. **Loop**: Continue until all tasks are closed
5. **IMPORTANT**: DO NOT update tasks.md - it's just a reference

## Benefits

1. **Persistent State**: Task status survives across AI assistant sessions
2. **Dependency Tracking**: Clear visibility of what's blocked vs. ready
3. **Parent-Child Hierarchy**: Feature → Tasks relationship explicit in bd
4. **Git-Synced**: All task state committed to `.beads/issues.jsonl`
5. **Constitution Compliance**: No more TODO lists that violate Section IV
6. **Multi-Assistant Safe**: Multiple team members and AI assistants work without conflicts

## Priority Mapping

Tasks are created with priorities based on their phase:

- **Phase 1 (Setup)**: `priority=1`
- **Phase 2 (Foundational)**: `priority=1`
- **Phase 3+ (User Stories)**: `priority=2`
- **Final Phase (Polish)**: `priority=3`

## Example

Given a feature "User Authentication" (bd-042):

```markdown
# tasks.md for User Authentication

**Feature**: User Authentication (bd-042)

## Phase 1: Setup

- **bd-102**: Create project structure per implementation plan
- **bd-103**: Initialize authentication dependencies (blocks: bd-102)

## Phase 3: User Story 1 - User can log in with email/password

- **bd-112**: [US1] Create User model in src/models/user.py (blocks: bd-103)
- **bd-113**: [US1] Create AuthService in src/services/auth_service.py (blocks: bd-103)
- **bd-114**: [US1] Implement login endpoint in src/api/auth.py (blocks: bd-112, bd-113)

---

## Working with These Tasks

All tasks are tracked in bd (beads). The list above is just a reference.

**Check what's ready to work on:**
```bash
bd ready --json
```

**View task details:**
```bash
bd show bd-XXX
```

**Claim a task:**
```bash
bd update bd-XXX --status in_progress
```

**Complete a task:**
```bash
bd close bd-XXX --reason "Completed"
```

**Or use `/speckit.implement` to have AI implement tasks automatically.**
```

In bd:
```
bd-042 [feature, priority=1, open] User Authentication
  ├─ bd-102 [task, priority=1, open] Create project structure (parent-child)
  ├─ bd-103 [task, priority=1, open] Initialize authentication dependencies (parent-child, blocks: bd-102)
  ├─ bd-112 [task, priority=2, open] [US1] Create User model (parent-child, blocks: bd-103)
  ├─ bd-113 [task, priority=2, open] [US1] Create AuthService (parent-child, blocks: bd-103)
  └─ bd-114 [task, priority=2, open] [US1] Implement login endpoint (parent-child, blocks: bd-112, bd-113)
```

## Migration Guide

If you have existing projects with TODO-based tasks.md files:

1. **Identify the parent feature**: Create or find the bd issue for the feature
2. **For each TODO task**: Create a bd child issue with the task description
3. **Link to parent**: Use `bd dep <child-id> <parent-id> --type parent-child`
4. **Simplify tasks.md**: Convert to simple bullet list format:
   - Remove checkboxes `- [ ]`
   - Remove Task IDs (T001, T002)
   - Keep just: `- **bd-XXX**: Brief description (blockers if any)`
5. **Add footer**: Include "Working with These Tasks" usage instructions

## Philosophy

**tasks.md is a reference, not a tracker**:
- bd holds the authoritative state (status, dependencies, assignees)
- tasks.md is for humans to quickly see what work exists
- Use `bd ready`, `bd list`, `bd show` to check status
- `/speckit.implement` reads tasks.md for issue IDs, then works entirely through bd

## Related Files

- [Constitution Section IV](../../.specify/memory/constitution.md) - bd mandate
- [CLAUDE.md](../../CLAUDE.md) - Claude Code bd workflow
- [AGENTS.md](../../AGENTS.md) - General AI agent bd workflow
- [install-bd-speckit.sh](../../install-bd-speckit.sh) - Installation script

## Version History

- **1.0.0** (2025-11-18): Initial bd enforcement with prohibition headers
- **1.1.0** (2025-11-19): Updated `/speckit.tasks` to create bd child issues instead of TODO lists
