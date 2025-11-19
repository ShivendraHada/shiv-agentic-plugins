---
description: Generate an actionable, dependency-ordered tasks.md for the feature based on available design artifacts.
handoffs: 
  - label: Analyze For Consistency
    agent: speckit.analyze
    prompt: Run a project analysis for consistency
    send: true
  - label: Implement Project
    agent: speckit.implement
    prompt: Start the implementation in phases
    send: true
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


---
**CRITICAL: This project uses bd (beads) for ALL task tracking**

Before proceeding with this workflow:
- **DO NOT use TodoWrite tool** - Never create, update, or manage todos via TodoWrite
- **DO use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all tracking
- **DO NOT create markdown TODOs** - No TODO.md, task lists, or checklists in markdown

See CLAUDE.md and AGENTS.md for complete bd workflow instructions.
---


## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. **Setup**: Run `.specify/scripts/bash/check-prerequisites.sh --json` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Load design documents**: Read from FEATURE_DIR:
   - **Required**: plan.md (tech stack, libraries, structure), spec.md (user stories with priorities)
   - **Optional**: data-model.md (entities), contracts/ (API endpoints), research.md (decisions), quickstart.md (test scenarios)
   - Note: Not all projects have all documents. Generate tasks based on what's available.

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
   - Create parallel execution examples per user story
   - Validate task completeness (each user story has all needed tasks, independently testable)

4. **Write tasks.md file**: Create the tasks.md file in FEATURE_DIR as a simple reference list:
   - **REQUIRED**: Actually write the file using the Write tool to `{FEATURE_DIR}/tasks.md`
   - Feature name and parent bd issue at the top (e.g., "# User Authentication\n\n**Feature**: User Authentication (bd-042)")
   - Simple hierarchical list of bd issues organized by phase:
     ```markdown
     ## Phase 1: Setup
     - **bd-102**: Create project structure per implementation plan
     - **bd-103**: Initialize dependencies (blocks: bd-102)

     ## Phase 3: User Story 1 - User can log in
     - **bd-112**: [US1] Create User model in src/models/user.py
     - **bd-113**: [US1] Create AuthService (blocks: bd-112)
     ```
   - Each line is just: `- **bd-XXX**: Brief description (blockers if any)`
   - No Task IDs (T001, T002) needed - bd issue IDs are the task IDs
   - No checkboxes - tasks.md is just a reference, bd issues hold the real state
   - Include footer with "Working with These Tasks" instructions (see tasks.md Footer section below)

5. **Report**: Output path to generated tasks.md and summary:
   - Confirm file was written: "Created {FEATURE_DIR}/tasks.md"
   - Parent bd issue ID and title
   - Total child issues created (e.g., "Created 5 child issues: bd-102, bd-103, bd-112, bd-113, bd-114")
   - bd issue IDs organized by phase
   - **Ready work**: Show which bd issues are ready to be worked on using `mcp__plugin_beads_beads__ready()`
   - Next steps: "Run `/speckit.implement` to start working on ready tasks"

Context for task generation: $ARGUMENTS

The tasks.md should be immediately executable - each task must be specific enough that an LLM can complete it without additional context.

## Task Generation Rules

**CRITICAL**: Tasks MUST be organized by user story to enable independent implementation and testing.

**CRITICAL**: All tasks MUST be created as bd child issues linked to the parent feature/epic.

**Tests are OPTIONAL**: Only generate test tasks if explicitly requested in the feature specification or if user requests TDD approach.

### bd Issue Creation (REQUIRED)

**Before generating tasks.md**:

1. **Identify parent issue**: Ask user for the parent bd issue ID (e.g., "bd-042") or find it using `mcp__plugin_beads_beads__list()`
2. **For each task**: Create a bd child issue using `mcp__plugin_beads_beads__create()`:
   - `title`: Task description (e.g., "Create User model in src/models/user.py")
   - `issue_type`: "task"
   - `priority`: Inherit from parent or set based on phase (Setup=1, Foundational=1, User Stories=2, Polish=3)
   - `description`: Include file path, technical details, and acceptance criteria
   - `deps`: Empty array initially (dependencies added in next step)
3. **Link to parent**: Use `mcp__plugin_beads_beads__dep()` to create parent-child relationship:
   - `issue_id`: Child task bd issue ID
   - `depends_on_id`: Parent feature/epic bd issue ID
   - `dep_type`: "parent-child"
4. **Create dependencies between tasks**: For tasks with sequential dependencies, use `mcp__plugin_beads_beads__dep()` with `dep_type="blocks"`
5. **Store mapping**: Keep a map of Task ID → bd issue ID (e.g., T001 → bd-102, T002 → bd-103)

### tasks.md Format (REQUIRED)

tasks.md is a **simple reference list** pointing to bd issues. The real task details, status, and dependencies live in bd.

**Format**: One line per bd issue:

```text
- **bd-XXX**: Brief description (blockers: bd-YYY if any)
```

**Components**:

1. **Bullet point**: Simple markdown list item
2. **bd issue ID**: In bold (e.g., `**bd-102**:`)
3. **Brief description**: What the task does (from bd issue title)
4. **Blockers** (optional): Note blocking dependencies in parentheses

**Examples**:

```markdown
## Phase 1: Setup

- **bd-102**: Create project structure per implementation plan
- **bd-103**: Initialize authentication dependencies (blocks: bd-102)

## Phase 3: User Story 1 - User can log in with email/password

- **bd-112**: [US1] Create User model in src/models/user.py (blocks: bd-103)
- **bd-113**: [US1] Create AuthService in src/services/auth_service.py (blocks: bd-103)
- **bd-114**: [US1] Implement login endpoint in src/api/auth.py (blocks: bd-112, bd-113)
```

**What NOT to include**:

- ❌ NO checkboxes `- [ ]` - bd tracks status, not markdown
- ❌ NO Task IDs like T001, T002 - bd issue IDs are the task IDs
- ❌ NO status indicators - use `bd ready` or `bd list --status open` to see status
- ❌ NO detailed descriptions - use `bd show bd-XXX` to see full details

### Task Organization

1. **From User Stories (spec.md)** - PRIMARY ORGANIZATION:
   - Each user story (P1, P2, P3...) gets its own phase
   - Map all related components to their story:
     - Models needed for that story
     - Services needed for that story
     - Endpoints/UI needed for that story
     - If tests requested: Tests specific to that story
   - Mark story dependencies (most stories should be independent)

2. **From Contracts**:
   - Map each contract/endpoint → to the user story it serves
   - If tests requested: Each contract → contract test task [P] before implementation in that story's phase

3. **From Data Model**:
   - Map each entity to the user story(ies) that need it
   - If entity serves multiple stories: Put in earliest story or Setup phase
   - Relationships → service layer tasks in appropriate story phase

4. **From Setup/Infrastructure**:
   - Shared infrastructure → Setup phase (Phase 1)
   - Foundational/blocking tasks → Foundational phase (Phase 2)
   - Story-specific setup → within that story's phase

### Phase Structure

- **Phase 1**: Setup (project initialization)
  - All tasks created as bd child issues with `priority=1`
  - Linked to parent feature/epic with `dep_type="parent-child"`
- **Phase 2**: Foundational (blocking prerequisites - MUST complete before user stories)
  - All tasks created as bd child issues with `priority=1`
  - Sequential tasks linked with `dep_type="blocks"`
- **Phase 3+**: User Stories in priority order (P1, P2, P3...)
  - Within each story: Tests (if requested) → Models → Services → Endpoints → Integration
  - Each phase should be a complete, independently testable increment
  - All tasks created as bd child issues with `priority=2`
  - Tasks within a story may have `dep_type="blocks"` relationships
- **Final Phase**: Polish & Cross-Cutting Concerns
  - All tasks created as bd child issues with `priority=3`

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

**Or use `/speckit.implement` to have AI implement tasks automatically.**
```
