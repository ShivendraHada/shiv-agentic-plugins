---

description: "Task list for Beads + Spec Kit onboarding slide deck"
---

# Tasks: Beads + Spec Kit Onboarding Slide Deck

**Input**: Design documents from `/specs/001-beads-speckit-onboarding/`
**Prerequisites**: spec.md (required), plan.md (required), checklists/requirements.md

**Tests**: Validation is primarily manual using the spec success criteria and checklist. No automated tests required.

**Organization**: Tasks are grouped by phase and user story to enable independent implementation and testing of each slice of the deck.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Ensure repository and tools are ready to create and maintain the onboarding materials.

- [X] T001 Create documentation folder structure for the deck in `docs/beads-spec-kit-onboarding/`
- [X] T002 [P] Create initial `docs/beads-spec-kit-onboarding/README.md` describing the purpose and audience of the deck
- [X] T003 [P] Ensure Spec Kit prerequisites are documented in `specs/001-beads-speckit-onboarding/quickstart.md` (macOS, Homebrew, Python, uv, Windsurf, Claude Code)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Capture accurate, copy-pastable commands and validate they work locally so slides are trustworthy.

- [X] T004 Verify bd is installed or install via Homebrew on a reference machine; capture exact commands and outputs in `specs/001-beads-speckit-onboarding/research.md`
- [X] T005 [P] Verify Spec Kit is installed via `uv tool install specify-cli` on a reference machine; capture commands and outputs in `specs/001-beads-speckit-onboarding/research.md`
- [X] T006 [P] Verify `specify init --here --ai claude` and `specify init --here --ai windsurf` behavior in a sample repo and record any prompts/caveats in `specs/001-beads-speckit-onboarding/research.md`
- [X] T007 Confirm `/speckit.*` slash commands are available in Windsurf and Claude Code for the sample repo; add verification notes to `specs/001-beads-speckit-onboarding/research.md`

**Checkpoint**: Installation and initialization steps for bd and Spec Kit are validated and recorded. Slide content can safely reference them.

---

## Phase 3: User Story 1 - Understand Why We Need bd and Spec Kit (Priority: P1)

**Goal**: Convey the motivation and conceptual model for using bd + Spec Kit with AI assistants.

**Independent Test**: A new engineer can read only these slides and correctly explain why bd + Spec Kit are required and how they fit with Windsurf/Claude.

### Implementation for User Story 1

- [X] T008 [P] [US1] Draft outline of "Why AI assistants alone are not enough" in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T009 [P] [US1] Add section explaining bd (Beads) roles and benefits, referencing `AGENTS.md` and `.beads` behavior, in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T010 [P] [US1] Add section explaining Spec Kit and Spec-Driven Development workflow (`/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, `/speckit.implement`) in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T011 [US1] Add diagram or bullet slide that shows how bd + Spec Kit + AI assistants connect (issue → spec → plan → tasks → implementation) in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T012 [US1] Update `docs/beads-spec-kit-onboarding/README.md` with a concise summary of the rationale aligned with spec.md

**Checkpoint**: Rationale section is complete and consistent with `specs/001-beads-speckit-onboarding/spec.md` and `.specify/memory/constitution.md`.

---

## Phase 4: User Story 2 - Install and Configure bd and Spec Kit (Priority: P1)

**Goal**: Provide a clear install and setup path that an engineer can follow from scratch.

**Independent Test**: A developer with only the deck can install bd and Spec Kit and initialize a repo for Windsurf/Claude without extra docs.

### Implementation for User Story 2

- [X] T013 [P] [US2] Add slide(s) describing bd installation on macOS using Homebrew, including `brew install bd` and `brew upgrade bd` commands in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T014 [P] [US2] Add slide(s) showing how to initialize bd in a repo (`bd init`, `bd ready`, `bd create`, `bd update`, `bd close`) with examples in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T015 [P] [US2] Add slide(s) describing Spec Kit installation with `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git` and upgrade commands in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T016 [US2] Add slide(s) showing one-time usage via `uvx` for Spec Kit and when to prefer it vs. persistent installs in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T017 [US2] Add slide(s) explaining how to run `specify init --here --ai claude` and `specify init --here --ai windsurf` in an existing repo, including handling non-empty directory prompts, in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T018 [US2] Add slide(s) for verification commands (`bd --version`, `bd ready`, `specify --help`, `specify check`) and where to look for `.specify/`, `.windsurf/workflows/`, `.claude/` in the repo in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T019 [US2] Summarize installation and setup steps as a short text quickstart in `specs/001-beads-speckit-onboarding/quickstart.md` referencing the relevant slide numbers

**Checkpoint**: A fresh engineer can follow the installation slides and quickstart to get bd + Spec Kit working.

---

## Phase 5: User Story 3 - Use bd + Spec Kit + AI Assistants to Implement a Feature (Priority: P2)

**Goal**: Demonstrate an end-to-end workflow from idea to implemented feature using bd + Spec Kit + AI.

**Independent Test**: A small example feature can be implemented by following the workflow slides, with all steps traceable in bd and Spec Kit artifacts.

### Implementation for User Story 3

- [X] T020 [P] [US3] Choose a small example feature (e.g., documentation improvement or simple code tweak) and capture its description in `specs/001-beads-speckit-onboarding/research.md`
- [X] T021 [P] [US3] Create or reference a bd feature issue for the example and document the exact `bd create` command and resulting issue ID in `specs/001-beads-speckit-onboarding/research.md`
- [X] T022 [US3] Add slide(s) walking through `/speckit.specify` for the example feature from within Windsurf or Claude Code, including where `specs/NNN-short-name/spec.md` appears, in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T023 [US3] Add slide(s) for `/speckit.plan` and `/speckit.tasks` for the example, explaining how plan.md and tasks.md are used to drive the work in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T024 [US3] Add slide(s) showing `/speckit.implement` (or equivalent manual execution of tasks.md) to complete the example feature, highlighting how commits and PRs reference the bd issue and feature directory in `docs/beads-spec-kit-onboarding/slides.md`
- [X] T025 [US3] Add slide(s) summarizing how the workflow satisfies the project constitution (spec-driven, bd discipline, quality gates) in `docs/beads-spec-kit-onboarding/slides.md`

**Checkpoint**: Example workflow is fully documented, and all steps can be traced from bd issue → Spec Kit artifacts → code/docs changes.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improve clarity, maintainability, and discoverability of the deck and supporting docs.

- [X] T026 [P] Review `docs/beads-spec-kit-onboarding/slides.md` (or slides file) for consistency with `specs/001-beads-speckit-onboarding/spec.md` and `.specify/memory/constitution.md`; adjust language as needed
- [X] T027 [P] Ensure all commands in the deck were tested on at least one real machine and that any caveats are documented in `specs/001-beads-speckit-onboarding/research.md`
- [X] T028 [P] Add links from the main project `README.md` (or appropriate docs index) to `docs/beads-spec-kit-onboarding/README.md` and the slide deck
- [X] T029 Final review pass against `specs/001-beads-speckit-onboarding/checklists/requirements.md`; update spec/plan or slides where checklist items are not met

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately.
- **Foundational (Phase 2)**: Depends on Setup completion; validates commands before they are documented.
- **User Stories (Phases 3–5)**: Depend on Foundational completion to ensure instructions are correct.
- **Polish (Phase 6)**: Depends on completion of all user story phases.

### User Story Dependencies

- **User Story 1 (US1)**: Can start after Foundational (Phase 2) – no dependencies on other stories.
- **User Story 2 (US2)**: Depends on research and validations from Phase 2; otherwise independent of US1.
- **User Story 3 (US3)**: Depends on bd and Spec Kit being installed and understood (Phases 2 and 3–4).

### Parallel Opportunities

- Setup tasks T002 and T003 can run in parallel after T001.
- Foundational verification tasks T005–T007 can run in parallel.
- Within story phases, drafting different slide sections (e.g., rationale vs. commands vs. workflow) can proceed in parallel where marked [P].

## Implementation Strategy

- Start with Phases 1 and 2 to ensure commands and prerequisites are correct.
- Implement User Story 1 first to establish rationale and context.
- Implement User Story 2 to make the deck actionable for installation and setup.
- Implement User Story 3 to provide an end-to-end example.
- Finish with Polish (Phase 6) to align with the constitution, spec, and checklist.
