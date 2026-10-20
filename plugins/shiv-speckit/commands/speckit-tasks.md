---
description: Generate an actionable, dependency-ordered tasks.md for the feature based on available design artifacts.
---

This command uses bd (beads) for task tracking. Refer to the bd-workflow skill for details.

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Setup**: Run `.specify/scripts/bash/check-prerequisites.sh --json` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute.

2. **Load design documents**: Read from FEATURE_DIR:
   - **Required**: plan.md (tech stack, libraries, structure), spec.md (user stories with priorities)
   - **Optional**: data-model.md (entities), contracts/ (API endpoints), research.md (decisions), quickstart.md (test scenarios)

3. **Execute task generation workflow**:
   - Load plan.md and extract tech stack, libraries, project structure
   - Load spec.md and extract user stories with their priorities (P1, P2, P3, etc.)
   - If data-model.md exists: Extract entities and map to user stories
   - If contracts/ exists: Map endpoints to user stories
   - If research.md exists: Extract decisions for setup tasks
   - **Identify or create parent bd issue**: Use `mcp__plugin_beads_beads__list()` to find the parent feature/epic issue, or prompt user for the issue ID
   - Generate tasks organized by user story (see Task Generation Rules below)
   - **Create bd child issues for each task**: Use `mcp__plugin_beads_beads__create()` to create child issues and link them to parent using `mcp__plugin_beads_beads__dep()`
   - Generate dependency graph showing user story completion order
   - Validate task completeness (each user story has all needed tasks, independently testable)

4. **Write tasks.md file**: Create the tasks.md file in FEATURE_DIR as a simple reference list:
   - **REQUIRED**: Actually write the file using the Write tool to `{FEATURE_DIR}/tasks.md`
   - Feature name and parent bd issue at the top
   - Simple hierarchical list of bd issues organized by phase:
     ```markdown
     ## Phase 1: Setup
     - **bd-102**: Create project structure per implementation plan
     - **bd-103**: Initialize dependencies (blocks: bd-102)
     ```
   - Each line is just: `- **bd-XXX**: Brief description (blockers if any)`
   - No Task IDs (T001, T002) needed - bd issue IDs are the task IDs
   - No checkboxes - tasks.md is just a reference, bd issues hold the real state
   - Include footer with "Working with These Tasks" instructions

5. **Report**: Output path to generated tasks.md and summary:
   - Parent bd issue ID and title
   - Total child issues created
   - **Ready work**: Show which bd issues are ready using `mcp__plugin_beads_beads__ready()`
   - Next steps: "Run `/speckit-implement` to start working on ready tasks"

## Task Generation Rules

**CRITICAL**: Tasks MUST be organized by user story to enable independent implementation and testing.

**CRITICAL**: All tasks MUST be created as bd child issues linked to the parent feature/epic.

### bd Issue Creation (REQUIRED)

**Before generating tasks.md**:

1. **Identify parent issue**: Ask user for the parent bd issue ID or find it using `mcp__plugin_beads_beads__list()`
2. **For each task**: Create a bd child issue using `mcp__plugin_beads_beads__create()`:
   - `title`: Task description
   - `issue_type`: "task"
   - `priority`: Based on phase (Setup=1, Foundational=1, User Stories=2, Polish=3)
   - `description`: Include file path, technical details, and acceptance criteria
3. **Link to parent**: Use `mcp__plugin_beads_beads__dep()` with `dep_type="parent-child"`
4. **Create dependencies between tasks**: Use `mcp__plugin_beads_beads__dep()` with `dep_type="blocks"`

### tasks.md Format (REQUIRED)

tasks.md is a **simple reference list** pointing to bd issues. The real task details, status, and dependencies live in bd.

**Format**: One line per bd issue:
```text
- **bd-XXX**: Brief description (blockers: bd-YYY if any)
```

**What NOT to include**:
- NO checkboxes `- [ ]` - bd tracks status, not markdown
- NO Task IDs like T001, T002 - bd issue IDs are the task IDs
- NO status indicators - use `bd ready` to see status

### Phase Structure

- **Phase 1**: Setup (project initialization) - `priority=1`
- **Phase 2**: Foundational (blocking prerequisites) - `priority=1`
- **Phase 3+**: User Stories in priority order - `priority=2`
- **Final Phase**: Polish & Cross-Cutting - `priority=3`

### tasks.md Footer

At the end of tasks.md, include usage instructions:

```markdown
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

**Or use `/speckit-implement` to have AI implement tasks automatically.**
```

## Next Steps

After generating tasks, consider running:
- `/speckit-implement` - Start implementing the tasks automatically
- `/speckit-taskstoissues` - Convert tasks into GitHub issues for team tracking
