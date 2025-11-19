## Feature Specification: Beads + Spec Kit Onboarding Slide Deck

**Feature Branch**: `001-beads-speckit-onboarding`  
**Created**: 2025-11-18  
**Status**: Draft  
**Input**: User description: "Create a slide deck that describes why we need beads and Spec Kit to effectively develop features using AI assistants like Windsurf and Claude Code, then describes how to install beads (starting from Homebrew) and Spec Kit for both AI assistants and how to begin using them to implement a feature."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Understand Why We Need bd and Spec Kit (Priority: P1)

An engineer or AI-assistant user opens the slide deck to understand why
they should adopt **bd (Beads)** and **Spec Kit** when working with
Windsurf and Claude Code.

**Why this priority**: Without clear rationale, the tooling will not be
consistently used and the rest of the deck loses value.

**Independent Test**: A new team member can read only the "why" portion
of the deck and accurately explain, in their own words, the roles of bd,
Spec Kit, and AI assistants and how they fit together.

**Acceptance Scenarios**:

1. **Given** a developer unfamiliar with bd and Spec Kit, **when** they
   read the rationale slides, **then** they can describe:
   - The problems with using AI assistants alone
   - What bd provides (issue tracking, ready work, dependencies)
   - What Spec Kit provides (spec/plan/tasks/implement)
   - How bd + Spec Kit + AI assistants form a coherent workflow.
2. **Given** an engineering lead, **when** they review the rationale
   slides, **then** they can decide whether to adopt the tools across
   their team without needing additional background material.

---

### User Story 2 - Install and Configure bd and Spec Kit (Priority: P1)

An engineer follows the deck to install bd via Homebrew and install the
Spec Kit `specify` CLI, then initialize a repo for both Windsurf and
Claude Code.

**Why this priority**: The deck must make it easy to go from "no
install" to a fully wired environment.

**Independent Test**: A developer with only the slide deck (no extra
docs) can install bd and Spec Kit and initialize a project that exposes
`/speckit.*` commands in Windsurf and Claude Code without outside help.

**Acceptance Scenarios**:

1. **Given** a macOS machine with Homebrew, **when** the engineer
   follows the bd install slides, **then** `bd --version` succeeds and
   `bd init` creates a working `.beads` directory in a repo.
2. **Given** a machine with Python and `uv` available, **when** the
   engineer follows the Spec Kit install slides, **then** `specify
   --help` and `specify check` run successfully.
3. **Given** an existing git repo, **when** the engineer follows the
   initialization steps, **then** the repo contains `.specify/`,
   `specs/`, `.windsurf/workflows/` and `.claude/` files as expected.

---

### User Story 3 - Use bd + Spec Kit + AI Assistants to Implement a Feature (Priority: P2)

An engineer uses the deck as a runbook to go from "idea" to "implemented
feature" using bd issues, Spec Kit workflows, and AI assistants.

**Why this priority**: The ultimate goal is not only to install tools
but to drive a repeatable feature workflow.

**Independent Test**: A feature can be implemented end-to-end by
following the steps in the deck without additional instructions.

**Acceptance Scenarios**:

1. **Given** a new feature idea, **when** the engineer follows the
   deck, **then** they:
   - Create a bd issue for the feature
   - Run `/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, and
     `/speckit.implement` in Windsurf or Claude Code
   - Land code changes associated with the bd issue.
2. **Given** the completed deck, **when** a reviewer inspects the
   documented workflow, **then** it matches the project constitution and
   Spec Kit templates (no conflicting instructions).

### Edge Cases

- What happens when a developer only uses one AI assistant (Windsurf or
  Claude Code) and not both? The deck must still be usable by calling
  out what is common vs. assistant-specific.
- How does the deck handle missing prerequisites (e.g., `uv` not
  installed)? The deck should at least mention that `uv` is required for
  Spec Kit and link or point to installation docs.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The deck MUST explain the limitations of using AI
  assistants alone and clearly articulate why bd and Spec Kit are
  needed.
- **FR-002**: The deck MUST describe bd at a high level, including its
  role as a repo-local issue tracker, basic commands (`bd init`,
  `bd create`, `bd ready`, `bd update`, `bd close`), and how AI
  assistants should interact with it.
- **FR-003**: The deck MUST describe Spec Kit and Spec-Driven
  Development, including the purpose of `specify`, the `.specify/`
  directory, and the `/speckit.*` commands.
- **FR-004**: The deck MUST include **step-by-step installation
  instructions for bd** on macOS using Homebrew.
- **FR-005**: The deck MUST include **step-by-step installation
  instructions for Spec Kit** using `uv tool install` (persistent) and
  show at least one `uvx` one-time example.
- **FR-006**: The deck MUST explain how to initialize an existing repo
  with Spec Kit for **Claude Code** and **Windsurf** (e.g., `specify
  init --here --ai claude` and `specify init --here --ai windsurf`).
- **FR-007**: The deck MUST show how to verify installs via `bd --version`,
  `bd ready`, `specify check`, and the presence of `/speckit.*`
  workflows.
- **FR-008**: The deck MUST include an end-to-end example workflow for
  implementing a feature using:
  - A bd issue
  - `/speckit.specify`
  - `/speckit.plan`
  - `/speckit.tasks`
  - `/speckit.implement`
  in at least one AI assistant.

### Key Entities

- **Beads Issue (`bd` issue)**: A work item tracked in the bd database
  with fields such as id, title, type, priority, status, and
  dependencies.
- **Spec Kit Feature (`specs/NNN-short-name`)**: A directory containing
  `spec.md`, `plan.md`, `tasks.md`, and related documents for a single
  feature.
- **AI Assistant Session**: A chat-based interaction in Windsurf or
  Claude Code, driven by `/speckit.*` commands and referencing bd
  issues.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: At least one engineer, starting from a clean macOS setup
  with Homebrew and Python, can install bd and Spec Kit and initialize a
  repo **within 30 minutes** using only the deck.
- **SC-002**: At least one engineer can follow the deck to complete a
  small sample feature (e.g., documentation-only or a tiny code change)
  driven by bd + Spec Kit + AI assistants **without needing additional
  guidance**.
- **SC-003**: After presenting the deck, **>80% of attendees** report
  that they understand *why* bd and Spec Kit are part of the standard AI
  development workflow.
- **SC-004**: Within one sprint of introducing the deck, **>50% of
  AI-assisted feature work** in this repo references a bd issue and a
  Spec Kit `specs/NNN-*` feature directory.

