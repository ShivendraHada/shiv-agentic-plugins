# Beads + Spec Kit Onboarding Deck

## 1. Why AI Assistants Alone Are Not Enough (T008)

- AI assistants are fast but lack persistent project memory.
- Specs and decisions get lost in chat histories.
- Hard to audit what was done, why, and in what order.
- No single source of truth for work items and dependencies.

## 2. Why We Use bd (Beads) (T009)

- Repo-local issue tracker that lives alongside your code.
- Tracks:
  - Features, bugs, chores, epics
  - Dependencies and blockers (parent-child, blocks, discovered-from)
  - Ready work (`bd ready`) for humans and agents.
- Auto-syncs with git via `.beads/issues.jsonl`.
- Gives AI assistants a structured backlog instead of ad-hoc prompts.

### Where TODO.md and ad-hoc checklists fail

- **No durable identity**:
  - TODO items are just lines in a file – no stable IDs, no audit trail.
  - When multiple people or assistants edit the same TODO.md, items are
    reworded, duplicated, or deleted with no history.
- **No dependency model**:
  - TODOs rarely encode parent/child or blocking relationships.
  - Agents can’t reliably find “ready” work vs. blocked work.
- **Hard to query for agents**:
  - Agents have to re-parse free-form text on every run.
  - It’s easy to miss items or misinterpret status.
- **Poor multi-assistant coordination**:
  - One assistant may silently re-plan or overwrite another’s TODO.md.
  - No shared audit log of who did what, when, and why.

bd fixes these problems by:

- Giving each issue a **stable ID** with full history.
- Encoding dependencies explicitly so `bd ready` can surface safe work.
- Storing the graph in a **machine-friendly format** that agents can query.
- Syncing via git so all humans and assistants see the same state.

## 3. Why We Use Spec Kit (Spec-Driven Development) (T010)

- Treats specs as first-class executable artifacts.
- Provides a repeatable flow:
  - `/speckit.specify` → feature spec (`spec.md`)
  - `/speckit.plan` → implementation plan (`plan.md`, `research.md`, `data-model.md`)
  - `/speckit.tasks` → ordered tasks (`tasks.md`)
  - `/speckit.implement` → implementation driven by tasks.
- Keeps conversation, docs, and code in sync under version control.

### Why Spec Kit is required for TDD-style discipline with AI

- **Prevents “spec drift”**:
  - Without Spec Kit, assistants tend to implement from the latest chat,
    not from a stable spec.
  - Requirements creep into code without being reflected in docs.
- **Enforces a testable workflow**:
  - `/speckit.specify` captures user stories, acceptance tests, and
    success criteria **before** implementation.
  - `/speckit.tasks` turns the spec into granular, checkable tasks.
- **Enables TDD-ish behavior for agents**:
  - Tasks can explicitly require tests or validation steps before code.
  - `/speckit.implement` walks tasks in order, ensuring test/verification
    tasks aren’t skipped.
- **Protects against AI “free-styling” a feature**:
  - Assistants are guided by `spec.md`, `plan.md`, and `tasks.md` instead
    of inventing their own plans mid-stream.
  - Every change can be traced: bd issue → Spec Kit docs → code/PR.

Together, **bd** and **Spec Kit** replace fragile TODO.md/task-list habits
with a disciplined, auditable workflow that multiple humans and assistants
can follow safely.

## 4. How bd + Spec Kit + AI Assistants Fit Together (T011)

- Start with a clear **feature idea**.
- Create a **bd feature issue** to capture intent and acceptance criteria.
- Use Spec Kit to generate:
  - Spec → plan → tasks → implementation.
- AI assistants (Windsurf, Claude Code) work **inside** this structure:
  - Use `/speckit.*` commands
  - Always tie work back to bd issues and Spec Kit feature directories.
- Result: every change can be traced from bd issue → Spec Kit docs → code/PR.

## 5. Installing bd on macOS (T013)

- Use **Homebrew** to install or upgrade bd:

  ```bash
  brew install bd
  # or, if already installed
  brew upgrade bd
  bd --version
  ```

- Run `bd --version` to confirm the CLI is available.

## 5a. Installing bd MCP Server for AI Assistants

- Install the **beads MCP server** to enable Claude Code and Windsurf to use bd functions directly:

  ```bash
  pip install beads-mcp
  ```

### For Claude Code

- Add to your Claude Code MCP config (e.g., `~/.config/claude/config.json`):

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

- Restart Claude Code to load the MCP server.
- Verify by checking that `mcp__plugin_beads_beads__*` functions are available.

### For Windsurf

- Add to your Windsurf MCP config (e.g., `~/.codeium/windsurf/mcp_settings.json`):

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

- Restart Windsurf to load the MCP server.
- Verify by checking that bd MCP functions are available in Windsurf's tool palette.

## 6. Initializing and Using bd in a Repo (T014)

- From the repository root:

  ```bash
  bd init
  ```

- Core bd workflow:
  - Create an issue:

    ```bash
    bd create "New feature: ..." -t feature -p 1 --json
    ```

  - See ready work:

    ```bash
    bd ready --json
    ```

  - Update and close issues as work progresses:

    ```bash
    bd update <id> --status in_progress --json
    bd close <id> --reason "Completed" --json
    ```

- Store `.beads/` and `.beads/issues.jsonl` in git to keep issues in sync with the repo.

## 7. Installing Spec Kit (Specify CLI) with uv (T015)

- Install Specify CLI from the Spec Kit repository using **uv**:

  ```bash
  uv tool install specify-cli \
    --from git+https://github.com/github/spec-kit.git

  specify --help
  specify check
  ```

- Use `specify check` to verify required tools (git, Claude Code, Windsurf, etc.) are available.

## 8. One-Time Usage via uvx (T016)

- For one-off experiments, you can avoid a persistent install:

  ```bash
  uvx --from git+https://github.com/github/spec-kit.git \
    specify init my-experiment --ai claude
  ```

- Prefer the persistent `uv tool install` route for long-term use; use `uvx` when you want to test Spec Kit without modifying your global toolchain.

## 9. Initializing Spec Kit for Claude Code and Windsurf (T017)

- From the repository root (this project has already done this):

  ```bash
  specify init --here --ai claude
  specify init --here --ai windsurf
  ```

- When the directory is not empty, Specify will warn and ask for confirmation before merging template files.
- After initialization, you should see:
  - `.specify/` (Spec Kit internals and templates)
  - `.windsurf/workflows/speckit.*.md`
  - Agent-specific files for Claude Code.

## 10. Verifying bd and Spec Kit Integration (T018)

- Validate CLI availability:

  ```bash
  bd --version
  specify check
  ```

- Open the repo in Windsurf and Claude Code and verify the following slash commands exist:
  - `/speckit.constitution`
  - `/speckit.specify`
  - `/speckit.plan`
  - `/speckit.tasks`
  - `/speckit.implement`

- Confirm that `.specify/`, `.windsurf/workflows/`, and any agent-specific files are present in the repo.

## 11. Making Spec Kit Use bd for All Tasks

- In this repository, the Spec Kit workflows for tasks and implementation are **bd-aware**:
  - `.windsurf/workflows/speckit.tasks.md` creates a bd feature issue and per-task bd issues from `tasks.md`.
  - `.windsurf/workflows/speckit.implement.md` updates the corresponding bd issues as tasks move to `in_progress` and `closed`.

- To enable the same behavior in another repo:
  - Ensure `bd` is installed and initialized in the repo (`bd init`).
  - Initialize Spec Kit (`specify init --here --ai claude` / `--ai windsurf`).
  - Copy or adapt the bd-aware workflow files from this project:
    - `.windsurf/workflows/speckit.tasks.md`
    - `.windsurf/workflows/speckit.implement.md`
  - Open the repo in Windsurf or Claude Code and run `/speckit.tasks` and `/speckit.implement` from the feature directory.

- Result: every Spec Kit task is backed by a bd issue, and progress through `/speckit.implement` is reflected directly in bd.

## 12. Example Workflow with Multiple Team Members and Assistants (T022–T024)

**Example feature**: "Link onboarding deck from main README" (see research.md).

1. **Create bd feature issue (T021)**
   - One team member (or assistant) runs:

     ```bash
     bd create "Link onboarding deck from main README" -t feature -p 3 --json
     ```

   - Everyone uses the resulting bd issue ID `<EXAMPLE_ID>` in:
     - Spec Kit feature directory name
     - Commit messages / PR titles

2. **Run `/speckit.specify` from Windsurf (T022)**
   - Engineer A opens the repo in **Windsurf**.
   - From the root or an appropriate context, they run:

     ```text
     /speckit.specify Link onboarding deck from main README
     ```

   - Result:
     - A new feature directory `specs/NNN-link-onboarding-deck/` is created.
     - `spec.md` describes the example feature and references `<EXAMPLE_ID>`.

3. **Run `/speckit.plan` and `/speckit.tasks` from Claude Code (T023)**
   - Engineer B opens the same repo in **Claude Code**.
   - In the new feature directory, they run:

     ```text
     /speckit.plan
     /speckit.tasks
     ```

   - Result:
     - `plan.md` captures the implementation approach.
     - `tasks.md` lists concrete tasks; bd-aware `/speckit.tasks` creates bd task issues linked to `<EXAMPLE_ID>`.

4. **Run `/speckit.implement` with both assistants (T024)**
   - Engineers A and B (or their assistants) pick tasks from `tasks.md`:
     - Windsurf focuses on code/doc changes.
     - Claude Code focuses on tests or additional docs.
   - Each task:
     - Is marked `[X]` in `tasks.md` when done.
     - Has its corresponding bd issue moved to `in_progress` then `closed` by the bd-aware `/speckit.implement` workflow.
   - Commits and PRs reference `<EXAMPLE_ID>` and the feature directory path.

## 13. Alignment with the Project Constitution (T025)

- **Spec-driven**: Every change is anchored in `spec.md`, `plan.md`, and `tasks.md`.
- **bd discipline**:
  - No meaningful work without a bd issue.
  - Parent/child relationships between the feature and tasks are explicit.
- **Quality gates**:
  - Checklists and success criteria in the spec must be satisfied.
  - `/speckit.implement` enforces task completion and bd status updates.
- **Multi-member, multi-assistant safe**:
  - Multiple engineers and assistants can collaborate without losing traceability.
  - The combination of bd + Spec Kit ensures a shared, auditable workflow across tools.

## 14. Working with JIRA Stories (INVEST + Gherkin + DoD)

### JIRA as Source, bd + Spec Kit as Implementation Layer

- **JIRA** remains the authoritative source for product/project management
- **bd** tracks implementation status and links to JIRA via `external_ref`
- **Spec Kit** bridges product requirements and technical implementation
- **Full traceability**: JIRA → bd → Spec Kit docs → code → PR

### Key Workflow Steps

1. **Sync JIRA to bd**:
   ```bash
   bd create "USER-123: Export reports to CSV" \
     -t feature -p 1 \
     --external-ref "https://company.atlassian.net/browse/USER-123" \
     --json
   ```

2. **Create Spec from JIRA**:
   - Run `/speckit.specify` with JIRA user story, Gherkin scenarios, and DoD
   - Spec Kit converts this into structured `spec.md`

3. **Generate tasks**:
   - `/speckit.plan` creates technical design
   - `/speckit.tasks` generates tasks and bd task issues

4. **Implement**:
   - `/speckit.implement` executes tasks, updating bd status
   - Gherkin scenarios become automated E2E tests

### Mapping INVEST to Spec Kit

- **Independent**: bd tracks dependencies; `/speckit.tasks` orders by dependencies
- **Negotiable**: `/speckit.specify` encourages clarification; captured in `spec.md`
- **Valuable**: User stories from JIRA preserved in spec; acceptance criteria front-and-center
- **Estimable**: Plan breaks work into concrete tasks with granular estimates
- **Small**: Spec Kit exposes if story is too large during planning
- **Testable**: Gherkin → E2E tests; DoD enforces test coverage

### Gherkin to Tests Example

**JIRA Gherkin**:
```gherkin
Scenario: Successful CSV export
  Given I am on the reports page
  When I click "Export to CSV"
  Then a CSV file should be downloaded
  And the CSV should contain all visible data
```

**Becomes E2E Test Task**: Write E2E test for successful CSV export (Gherkin scenario 1)

**Implemented as automated test** validating: filename, headers, data rows, CSV formatting

### Best Practices

- Use bd `external_ref` to link back to JIRA
- Include JIRA ID in branch names: `feature/USER-123-csv-export`
- Map DoD items to Spec Kit tasks
- Use `/speckit.clarify` for ambiguous JIRA stories
- PR links everything: JIRA ID + bd feature ID + Spec Kit directory

## 15. Complete JIRA Integration Example

**JIRA Story USER-456**: As a manager, I want to filter reports by date range

**Step 1**: Create bd issue linked to JIRA
```bash
bd create "USER-456: Filter reports by date range" \
  --external-ref "https://company.atlassian.net/browse/USER-456" --json
# Output: bd-101
```

**Step 2**: Run `/speckit.specify USER-456: Filter reports by date range`
- Include JIRA story, Gherkin scenarios, DoD checklist
- Creates `specs/101-filter-reports-by-date-range/spec.md`

**Step 3**: Run `/speckit.plan` → creates `plan.md` with technical approach

**Step 4**: Run `/speckit.tasks` → creates `tasks.md` and bd issues (bd-102 through bd-110)

**Step 5**: Run `/speckit.implement` → implements tasks, updates bd status

**Step 6**: Create PR referencing USER-456, bd-101, and Spec Kit directory

**Step 7**: Post-merge: close bd-101, update JIRA USER-456 to "Done"
