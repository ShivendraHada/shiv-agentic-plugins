<!--
Sync Impact Report
- Version change: 0.0.0 → 1.0.0
- Modified principles: initialized from template (no prior concrete principles)
- Added sections: Core Principles, Additional Constraints & Standards, Development Workflow & Quality Gates, Governance
- Removed sections: None (template placeholders fully materialized)
- Templates reviewed (no content changes required):
  - ✅ .specify/templates/plan-template.md
  - ✅ .specify/templates/spec-template.md
  - ✅ .specify/templates/tasks-template.md
  - ✅ .specify/templates/checklist-template.md
  - ✅ .specify/templates/agent-file-template.md
- Deferred TODOs: None (all placeholders resolved for this version)
-->

# Agentic Development Constitution

## Core Principles

### I. Spec‑Driven, Outcome‑First

All significant work starts from an explicit specification and clear
outcome metrics rather than ad‑hoc implementation.

- Every feature has a written spec and plan generated via Spec Kit
  (`/speckit.specify`, `/speckit.plan`, `/speckit.tasks`).
- Specs focus on user value, measurable success criteria, and constraints
  before selecting technologies.
- Implementation follows the spec and plan; deviations MUST be captured
  as explicit updates to those artifacts.

### II. Safety, Security, and Data Integrity by Default

Security and data integrity constraints are treated as first‑class
requirements, not afterthoughts.

- All changes are reviewed for injection risks (SQL, command, template),
  XSS, CSRF, and credential leakage.
- Input validation, output encoding, and least‑privilege access are
  mandatory in all layers.
- Data‑affecting changes MUST define recovery/rollback expectations and
  be testable in non‑production environments.

### III. Test‑First, Observable, and Reproducible

Work is driven by tests and observability signals that make failures
obvious and reproducible.

- For non‑trivial changes, tests or explicit verification steps are
  defined before implementation.
- Each feature aims to include fast, automated checks (unit, contract,
  or integration) appropriate to its risk.
- Instrumentation (logging, metrics, or traces) MUST be sufficient to
  diagnose production issues without re‑deploying debug builds.

### IV. Task and Workflow Discipline with bd

All work is tracked and decomposed into explicit issues and tasks using
`bd` (beads); AI agents operate through those workflows.

- Every meaningful change has an associated bd issue with clear
  acceptance criteria and priority.
- Dependencies between tasks and features are modeled using bd
  relationships (e.g., `blocks`, `discovered-from`).
- AI‑driven changes (via Windsurf, Claude Code, or other agents) MUST
  reference the governing bd issue and keep it in sync with code state.

### V. Architecture: Intentional, Evolvable, and Minimal

Architecture follows domain needs and is kept as simple as possible
while supporting evolution.

- Prefer clear boundaries (DDD‑inspired, CQRS/event‑driven where
  justified) but avoid speculative abstraction.
- Cross‑service and cross‑boundary contracts MUST be explicit
  (interfaces, events, or APIs) and versioned deliberately.
- Complexity (frameworks, patterns, or infrastructure) MUST be
  justified in specs and plans, especially when it increases cognitive
  load for the team.

## Additional Constraints & Standards

This section captures global constraints that apply across all specs,
plans, and implementations.

- **Technology Baseline**: Modern, supported runtimes and libraries are
  required; end‑of‑life or unpatched dependencies MUST NOT be
  introduced.
- **Performance & Reliability**: Each feature spec defines success
  metrics where relevant (e.g., latency, throughput, error budgets).
  Changes MUST not violate established SLOs without an explicit, agreed
  trade‑off captured in the spec.
- **Security & Compliance**: All code paths that touch authentication,
  authorization, or sensitive data MUST include tests or explicit
  validation steps. Secrets must never be hard‑coded; configuration is
  provided via secure configuration mechanisms.
- **AI Agent Usage**: AI agents are assistants, not authorities. All
  generated code and configuration MUST be reviewed and validated
  against this constitution, project specs, and security constraints.

## Development Workflow & Quality Gates

The development workflow is driven by Spec Kit and bd.

- **Spec First**: `/speckit.specify` produces the feature spec; it MUST
  be understandable by humans and traceable to user or business value.
- **Plan Second**: `/speckit.plan` defines architecture, technology
  choices, and constraints; it MUST pass the Constitution Check section
  of the plan template.
- **Tasks Third**: `/speckit.tasks` generates an ordered task breakdown;
  tasks MUST be small, testable, and mapped to bd issues as
  appropriate.
- **Implementation**: `/speckit.implement` or equivalent manual work
  MUST follow the task breakdown and keep documentation in sync.
- **Quality Gates**: Before merging, feature work MUST have:
  - Updated specs/plans/tasks reflecting what was actually built.
  - Appropriate tests or documented verification steps.
  - bd issues moved to an appropriate terminal state with notes.

## Governance

This constitution governs how work is specified, planned, implemented,
and reviewed in this repository.

- This document supersedes informal conventions; conflicts are resolved
  in favor of the constitution.
- Amendments MUST be made via pull requests linked to bd issues that
  explain the motivation and impact.
- Version numbers follow semantic versioning:
  - **MAJOR**: Backwards‑incompatible changes to principles or
    governance.
  - **MINOR**: New principles or substantial expansions.
  - **PATCH**: Clarifications and non‑semantic edits.
- Every amendment MUST update the Sync Impact Report at the top of this
  file and review related templates for alignment.
- Compliance with this constitution is a required review gate for all
  changes; reviewers and AI agents should call out violations explicitly
  in review notes.

**Version**: 1.0.0 | **Ratified**: 2025-11-18 | **Last Amended**: 2025-11-18

