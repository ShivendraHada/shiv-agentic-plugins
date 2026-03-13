---
name: speckit-knowledge
description: Spec Kit specification framework knowledge for Wiser Solutions. Provides background on spec-driven development, feature specification templates, implementation planning, task breakdown patterns, and the full speckit workflow lifecycle. Applied automatically during speckit commands.
user-invocable: false
---

# Spec Kit Framework Knowledge

Spec Kit is a spec-driven development framework that ensures every feature goes through a rigorous specification, planning, and implementation lifecycle before code is written. This document provides the foundational knowledge applied during all speckit commands.

## Philosophy: Spec-Driven, Outcome-First Development

Spec Kit is built on a core belief: **written specifications before code**. The quality of software is determined long before the first line of implementation. By investing in clear specifications, structured plans, and prioritized task breakdowns, teams avoid rework, reduce ambiguity, and deliver features that match what users actually need.

### Key Principles

1. **Written specs before code**: No implementation begins without a reviewed, approved specification. Specifications capture the "what" and "why"; implementation plans capture the "how".

2. **Outcome-first thinking**: Specifications start with user scenarios and acceptance criteria, not technical solutions. The desired outcome drives the design, not the other way around.

3. **Safety and security by default**: Every feature is evaluated against security, privacy, and reliability concerns as part of the planning process. These are not afterthoughts bolted on during review.

4. **Test-first when tests are requested**: When the specification calls for tests, they are written before the implementation code and must fail before implementation begins (Red-Green-Refactor).

5. **Incremental, independently testable delivery**: Features are decomposed into user stories that can each be implemented, tested, and demonstrated independently. The first story delivered is a viable MVP.

6. **Human checkpoints at every stage**: The workflow includes explicit validation points where a human reviews and approves before the next phase begins. Automation supports humans; it does not replace judgment.

## The Speckit Workflow Lifecycle

The speckit workflow is a linear progression through seven stages. Each stage produces artifacts that feed into the next.

### 1. Specify (`/speckit.specify`)

**Purpose**: Capture the feature requirements as a structured specification.

**Inputs**: User description, context, and any existing requirements documentation.

**Outputs**: `specs/<feature>/spec.md`

The specification includes:
- User stories prioritized by importance (P1, P2, P3...)
- Acceptance scenarios in Given/When/Then format
- Functional requirements with unique identifiers (FR-001, FR-002...)
- Edge cases and boundary conditions
- Key entities (if the feature involves data)
- Success criteria with measurable outcomes

Each user story must be **independently testable** -- implementing just one story should yield a viable MVP that delivers value.

Items that are ambiguous or underspecified are marked with `[NEEDS CLARIFICATION]` rather than assumed.

See: `references/spec-template.md` for the full template.

### 2. Clarify (`/speckit.clarify`)

**Purpose**: Resolve ambiguities and fill gaps identified during specification.

**Inputs**: The specification with `[NEEDS CLARIFICATION]` markers, questions from reviewers.

**Outputs**: Updated `specs/<feature>/spec.md` with clarifications resolved.

This is an iterative stage. The specification is refined through dialogue until all stakeholders agree on the requirements. No planning begins until clarifications are resolved.

### 3. Plan (`/speckit.plan`)

**Purpose**: Create a concrete implementation plan based on the approved specification.

**Inputs**: Approved `spec.md`.

**Outputs**:
- `specs/<feature>/plan.md` -- Implementation plan with technical context and project structure
- `specs/<feature>/research.md` -- Technical research findings
- `specs/<feature>/data-model.md` -- Entity definitions and relationships (if applicable)
- `specs/<feature>/quickstart.md` -- Quick validation guide
- `specs/<feature>/contracts/` -- API contracts and interface definitions (if applicable)

The plan captures:
- Technical context (language, dependencies, storage, testing framework, platform)
- Constitution check (project guardrails and constraints)
- Project structure (source layout, test layout, documentation layout)
- Complexity tracking for any constraint violations

See: `references/plan-template.md` for the full template.

### 4. Tasks (`/speckit.tasks`)

**Purpose**: Break the implementation plan into ordered, actionable tasks.

**Inputs**: `plan.md`, `spec.md`, `data-model.md`, `contracts/`.

**Outputs**: `specs/<feature>/tasks.md`

Tasks are organized by phase:
- **Phase 1: Setup** -- Project initialization and structure
- **Phase 2: Foundational** -- Core infrastructure that blocks all user stories
- **Phase 3+: User Stories** -- One phase per user story, in priority order
- **Phase N: Polish** -- Cross-cutting concerns and cleanup

Within each phase:
- Tasks marked `[P]` can run in parallel (different files, no dependencies)
- Tasks marked `[US1]`, `[US2]`, etc. are linked to specific user stories
- Tests (when requested) are written FIRST and must FAIL before implementation
- Each user story phase ends with a checkpoint for independent validation

See: `references/tasks-template.md` for the full template.

### 5. Implement (`/speckit.implement`)

**Purpose**: Execute the task list, building the feature incrementally.

**Inputs**: `tasks.md` and all supporting design documents.

**Outputs**: Working code, tests, and documentation as specified by the task list.

Implementation follows the task order strictly:
- Complete Setup before Foundational
- Complete Foundational before any User Story
- Within each story: tests first (if requested), then models, then services, then endpoints
- Validate at each checkpoint before proceeding

### 6. Analyze (`/speckit.analyze`)

**Purpose**: Review the implementation against the specification and plan.

**Inputs**: Completed implementation, `spec.md`, `plan.md`, `tasks.md`.

**Outputs**: Analysis report identifying gaps, deviations, and areas for improvement.

The analysis checks:
- Are all functional requirements from the spec implemented?
- Do all acceptance scenarios pass?
- Are edge cases handled?
- Does the code match the planned structure?
- Are there any security or reliability concerns?

### 7. Checklist (`/speckit.checklist`)

**Purpose**: Generate a verification checklist tailored to the feature.

**Inputs**: Feature context, specific checklist type requested by the user.

**Outputs**: `specs/<feature>/checklists/<type>-checklist.md`

Checklists are generated on demand for specific concerns (e.g., security review, performance audit, deployment readiness). They are structured as actionable items with clear pass/fail criteria.

See: `references/checklist-template.md` for the full template.

## How Specifications Drive Implementation

The relationship between spec artifacts is hierarchical and traceable:

```
spec.md (User Stories + Requirements)
  |
  v
plan.md (Technical Approach + Structure)
  |
  v
tasks.md (Ordered Work Items linked to User Stories)
  |
  v
Implementation (Code, Tests, Documentation)
  |
  v
Analysis (Verification against spec.md)
```

Every task in `tasks.md` traces back to a user story in `spec.md`. Every technical decision in `plan.md` traces back to a requirement in `spec.md`. This traceability ensures that:

- No code is written without a corresponding requirement.
- No requirement is left unimplemented without explicit justification.
- Scope creep is detected early because tasks without a spec origin are flagged.
- Priorities are preserved from specification through implementation.

## Reference Templates

The following reference files contain the detailed templates used by each speckit command:

- `references/spec-template.md` -- Feature specification template with user stories, requirements, and success criteria
- `references/plan-template.md` -- Implementation plan template with technical context and project structure
- `references/tasks-template.md` -- Task breakdown template with phased execution and parallel markers
- `references/checklist-template.md` -- Verification checklist template with categorized items
