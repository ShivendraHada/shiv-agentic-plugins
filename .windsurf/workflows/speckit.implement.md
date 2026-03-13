---
description: Execute the implementation plan by processing and executing all tasks defined in tasks.md
---

---
**CRITICAL: This project uses bd (beads) for ALL task tracking**

**ABSOLUTE PROHIBITION - NO EXCEPTIONS:**
- **NEVER use TodoWrite tool** - Any use is a VIOLATION of the constitution
- **NEVER create TODO.md files** - Creating TODO.md is FORBIDDEN
- **NEVER create TODO lists in markdown** - Task lists in ANY markdown file are PROHIBITED
- **NEVER work around this requirement** - There are NO exceptions

**REQUIRED:**
- **ALWAYS use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all tracking
- **ALWAYS track ALL tasks in bd** - Every task, subtask, and work item MUST be in bd

See CLAUDE.md and AGENTS.md for complete bd workflow instructions.
See .specify/memory/constitution.md Section IV for full requirements.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. Run `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list.

2. **Check checklists status** (if FEATURE_DIR/checklists/ exists):
   - Scan all checklist files and count completed vs incomplete items
   - If any incomplete, ask user if they want to proceed anyway

3. Load and analyze the implementation context:
   - **REQUIRED**: Read tasks.md to get the list of bd issue IDs organized by phase
   - **REQUIRED**: Extract all bd issue IDs from tasks.md (e.g., bd-102, bd-103, bd-112)
   - **REQUIRED**: Use `mcp__plugin_beads_beads__ready()` to find which bd issues are ready to work on
   - **REQUIRED**: Read plan.md for tech stack, architecture, and file structure
   - **IF EXISTS**: Read data-model.md, contracts/, research.md, quickstart.md

4. **Project Setup Verification**:
   - Create/verify ignore files based on actual project setup (.gitignore, .dockerignore, etc.)

5. Execute implementation using bd workflow:
   - **Get ready work**: Use `mcp__plugin_beads_beads__ready()` to get list of bd issues ready to work on
   - **Phase-by-phase execution**: Work through phases in order (Setup → Foundational → User Stories → Polish)
   - **For each ready bd issue**:
     1. Use `mcp__plugin_beads_beads__show(issue_id)` to get full task details
     2. Claim the task: `mcp__plugin_beads_beads__update(issue_id, status="in_progress")`
     3. Implement the task based on its description and acceptance criteria
     4. When complete: `mcp__plugin_beads_beads__close(issue_id, reason="Completed")`
   - **Respect dependencies**: Only work on tasks that show up in `ready()` (no blockers)

6. Implementation execution workflow:
   - **Continuous loop**:
     1. Call `mcp__plugin_beads_beads__ready()` to get next ready tasks
     2. If no ready tasks and uncompleted tasks exist, report blockers and wait
     3. If no uncompleted tasks, implementation is complete
   - **For each ready task**:
     1. Show task details: `mcp__plugin_beads_beads__show(issue_id)`
     2. Claim task: `mcp__plugin_beads_beads__update(issue_id, status="in_progress")`
     3. Implement based on task description, file path, and acceptance criteria
     4. Complete task: `mcp__plugin_beads_beads__close(issue_id, reason="Completed")`
   - **Error handling**:
     - If implementation fails, keep task as `in_progress` and report error
     - Create new bd issues for discovered work using `mcp__plugin_beads_beads__create()`
     - Link discovered issues to parent using `mcp__plugin_beads_beads__dep()`

7. Progress tracking:
   - Report after each task: "Completed bd-XXX: [task title]"
   - Show remaining tasks: Use `mcp__plugin_beads_beads__list(status="open")`
   - Show blocked tasks: Use `mcp__plugin_beads_beads__blocked()`
   - **IMPORTANT**: DO NOT update tasks.md file - bd holds the real state

8. Completion validation:
   - Use `mcp__plugin_beads_beads__list()` to verify all issues are closed
   - Check that implemented features match the original specification
   - Report final status with summary: total tasks, completed, time taken

Note: This command reads bd issue IDs from tasks.md and works through them using bd MCP functions. If tasks.md doesn't exist or bd issues aren't created, run `/speckit.tasks` first.
