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

1. Run `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Check checklists status** (if FEATURE_DIR/checklists/ exists):
   - Scan all checklist files in the checklists/ directory
   - For each checklist, count:
     - Total items: All lines matching `- [ ]` or `- [X]` or `- [x]`
     - Completed items: Lines matching `- [X]` or `- [x]`
     - Incomplete items: Lines matching `- [ ]`
   - Create a status table:

     ```text
     | Checklist | Total | Completed | Incomplete | Status |
     |-----------|-------|-----------|------------|--------|
     | ux.md     | 12    | 12        | 0          | ✓ PASS |
     | test.md   | 8     | 5         | 3          | ✗ FAIL |
     | security.md | 6   | 6         | 0          | ✓ PASS |
     ```

   - Calculate overall status:
     - **PASS**: All checklists have 0 incomplete items
     - **FAIL**: One or more checklists have incomplete items

   - **If any checklist is incomplete**:
     - Display the table with incomplete item counts
     - **STOP** and ask: "Some checklists are incomplete. Do you want to proceed with implementation anyway? (yes/no)"
     - Wait for user response before continuing
     - If user says "no" or "wait" or "stop", halt execution
     - If user says "yes" or "proceed" or "continue", proceed to step 3

   - **If all checklists are complete**:
     - Display the table showing all checklists passed
     - Automatically proceed to step 3

3. Load and analyze the implementation context:
   - **REQUIRED**: Read tasks.md to get the list of bd issue IDs organized by phase
   - **REQUIRED**: Extract all bd issue IDs from tasks.md (e.g., bd-102, bd-103, bd-112)
   - **REQUIRED**: Use `mcp__plugin_beads_beads__ready()` to find which bd issues are ready to work on (no blockers)
   - **REQUIRED**: Read plan.md for tech stack, architecture, and file structure
   - **IF EXISTS**: Read data-model.md for entities and relationships
   - **IF EXISTS**: Read contracts/ for API specifications and test requirements
   - **IF EXISTS**: Read research.md for technical decisions and constraints
   - **IF EXISTS**: Read quickstart.md for integration scenarios

4. **Project Setup Verification**:
   - **REQUIRED**: Create/verify ignore files based on actual project setup:

   **Detection & Creation Logic**:
   - Check if the following command succeeds to determine if the repository is a git repo (create/verify .gitignore if so):

     ```sh
     git rev-parse --git-dir 2>/dev/null
     ```

   - Check if Dockerfile* exists or Docker in plan.md → create/verify .dockerignore
   - Check if .eslintrc* exists → create/verify .eslintignore
   - Check if eslint.config.* exists → ensure the config's `ignores` entries cover required patterns
   - Check if .prettierrc* exists → create/verify .prettierignore
   - Check if .npmrc or package.json exists → create/verify .npmignore (if publishing)
   - Check if terraform files (*.tf) exist → create/verify .terraformignore
   - Check if .helmignore needed (helm charts present) → create/verify .helmignore

   **If ignore file already exists**: Verify it contains essential patterns, append missing critical patterns only
   **If ignore file missing**: Create with full pattern set for detected technology

   **Common Patterns by Technology** (from plan.md tech stack):
   - **Node.js/JavaScript/TypeScript**: `node_modules/`, `dist/`, `build/`, `*.log`, `.env*`
   - **Python**: `__pycache__/`, `*.pyc`, `.venv/`, `venv/`, `dist/`, `*.egg-info/`
   - **Java**: `target/`, `*.class`, `*.jar`, `.gradle/`, `build/`
   - **C#/.NET**: `bin/`, `obj/`, `*.user`, `*.suo`, `packages/`
   - **Go**: `*.exe`, `*.test`, `vendor/`, `*.out`
   - **Ruby**: `.bundle/`, `log/`, `tmp/`, `*.gem`, `vendor/bundle/`
   - **PHP**: `vendor/`, `*.log`, `*.cache`, `*.env`
   - **Rust**: `target/`, `debug/`, `release/`, `*.rs.bk`, `*.rlib`, `*.prof*`, `.idea/`, `*.log`, `.env*`
   - **Kotlin**: `build/`, `out/`, `.gradle/`, `.idea/`, `*.class`, `*.jar`, `*.iml`, `*.log`, `.env*`
   - **C++**: `build/`, `bin/`, `obj/`, `out/`, `*.o`, `*.so`, `*.a`, `*.exe`, `*.dll`, `.idea/`, `*.log`, `.env*`
   - **C**: `build/`, `bin/`, `obj/`, `out/`, `*.o`, `*.a`, `*.so`, `*.exe`, `Makefile`, `config.log`, `.idea/`, `*.log`, `.env*`
   - **Swift**: `.build/`, `DerivedData/`, `*.swiftpm/`, `Packages/`
   - **R**: `.Rproj.user/`, `.Rhistory`, `.RData`, `.Ruserdata`, `*.Rproj`, `packrat/`, `renv/`
   - **Universal**: `.DS_Store`, `Thumbs.db`, `*.tmp`, `*.swp`, `.vscode/`, `.idea/`

   **Tool-Specific Patterns**:
   - **Docker**: `node_modules/`, `.git/`, `Dockerfile*`, `.dockerignore`, `*.log*`, `.env*`, `coverage/`
   - **ESLint**: `node_modules/`, `dist/`, `build/`, `coverage/`, `*.min.js`
   - **Prettier**: `node_modules/`, `dist/`, `build/`, `coverage/`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`
   - **Terraform**: `.terraform/`, `*.tfstate*`, `*.tfvars`, `.terraform.lock.hcl`
   - **Kubernetes/k8s**: `*.secret.yaml`, `secrets/`, `.kube/`, `kubeconfig*`, `*.key`, `*.crt`

5. Execute implementation using bd workflow:
   - **Get ready work**: Use `mcp__plugin_beads_beads__ready()` to get list of bd issues ready to work on
   - **Phase-by-phase execution**: Work through phases in order (Setup → Foundational → User Stories → Polish)
   - **For each ready bd issue**:
     1. Use `mcp__plugin_beads_beads__show(issue_id)` to get full task details
     2. Claim the task: `mcp__plugin_beads_beads__update(issue_id, status="in_progress")`
     3. Implement the task based on its description and acceptance criteria
     4. When complete: `mcp__plugin_beads_beads__close(issue_id, reason="Completed")`
   - **Respect dependencies**: Only work on tasks that show up in `ready()` (no blockers)
   - **Validation checkpoints**: After each phase, verify all tasks in that phase are closed before moving to next phase

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
     5. Report progress
   - **Error handling**:
     - If implementation fails, keep task as `in_progress` and report error
     - Create new bd issues for discovered work using `mcp__plugin_beads_beads__create()`
     - Link discovered issues to parent using `mcp__plugin_beads_beads__dep()`

7. Progress tracking:
   - Report after each task: "Completed bd-XXX: [task title]"
   - Show remaining tasks: Use `mcp__plugin_beads_beads__list(status="open")` to show what's left
   - Show blocked tasks: Use `mcp__plugin_beads_beads__blocked()` to show what's waiting
   - **IMPORTANT**: DO NOT update tasks.md file - tasks.md is just a reference, bd holds the real state

8. Completion validation:
   - Use `mcp__plugin_beads_beads__list()` to verify all issues for this feature are closed
   - Check that implemented features match the original specification
   - Validate that tests pass (if tests were requested)
   - Confirm the implementation follows the technical plan
   - Report final status with summary: total tasks, completed, time taken

Note: This command reads bd issue IDs from tasks.md and works through them using bd MCP functions. If tasks.md doesn't exist or bd issues aren't created, run `/speckit.tasks` first.

LEGACY SECTION (Remove after migration):
   - Ensure the `bd` CLI is available in the current environment:

     ```bash
     bd --version
     ```

   - Determine the **parent bd feature issue** for this Spec Kit feature (created during `/speckit.tasks`):
     - If multiple candidates exist, prefer the one whose title matches the feature branch or spec H1.

   - For each task executed from `tasks.md`:
     - Parse the TaskID (e.g., T001) and locate the corresponding bd task issue whose title starts with that TaskID.
     - When work on a task begins, update the bd issue status to `in_progress`.
     - When the task is completed (and the checkbox is marked `[X]` in tasks.md), update the bd issue status to `closed` and add a brief comment summarizing what changed (including key file paths).

   - If no matching bd issue is found for a TaskID, warn the user and suggest re-running `/speckit.tasks` to regenerate bd mappings for that feature.

10. Completion validation:
   - Verify all required tasks are completed (and checked off in tasks.md)
   - Check that implemented features match the original specification
   - Validate that tests pass and coverage meets requirements
   - Confirm the implementation follows the technical plan
   - Confirm that all associated bd task issues are in a terminal state (typically `closed`) and that the parent feature issue accurately reflects overall progress
   - Report final status with summary of completed work

Note: This command assumes a complete task breakdown exists in tasks.md. If tasks are incomplete or missing, suggest running `/speckit.tasks` first to regenerate the task list.
