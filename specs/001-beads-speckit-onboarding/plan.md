# Implementation Plan: Beads + Spec Kit Onboarding Slide Deck

**Branch**: `001-beads-speckit-onboarding` | **Date**: 2025-11-18 | **Spec**: `specs/001-beads-speckit-onboarding/spec.md`  
**Input**: Feature specification from `specs/001-beads-speckit-onboarding/spec.md`

## Summary

Create an onboarding slide deck that:

- Explains *why* bd (Beads) and Spec Kit are required to make AI
  assistants like Windsurf and Claude Code safe and effective for
  feature work.
- Provides clear, copy-pastable installation and verification steps for
  bd (Homebrew) and Spec Kit (via `uv` and `specify`).
- Shows, step by step, how to use bd + Spec Kit + AI assistants to
  implement a feature from idea → issue → spec → plan → tasks →
  implementation.

The output is documentation (slides and possibly a short quickstart
doc), not code changes.

## Technical Context

**Language/Version**: Markdown slide content, rendered via the team’s
preferred presentation tooling (Keynote, PowerPoint, Google Slides, or
Markdown-based slide engine).  
**Primary Dependencies**: bd CLI (`bd`), Spec Kit CLI (`specify` via
`uv`), Windsurf, Claude Code.  
**Storage**: Git repository files only (specs, plans, docs, slide
sources).  
**Testing**: Manual validation using the success criteria in the spec
and checklist; no automated test harness required for the deck itself.  
**Target Platform**: macOS developer machines using Windsurf and/or
Claude Code against this repository.  
**Project Type**: Documentation / enablement feature within existing
repo.  
**Performance Goals**: Not performance-sensitive; primary concern is
clarity and time-to-onboard (target ≤30 minutes to go from nothing to a
working bd + Spec Kit setup).  
**Constraints**: MUST align with the Agentic Development Constitution,
avoid security anti-patterns (no hard-coded secrets, no unsafe
installation guidance), and remain tool-agnostic where reasonable.  
**Scale/Scope**: Deck intended for engineering and AI-assistant users in
this repo; future reuse across teams is desirable but not mandatory for
this iteration.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Spec‑Driven, Outcome‑First**: This plan is derived from an explicit
  spec and focuses on measurable outcomes (time to install, adoption,
  understanding). **Status: PASS**.
- **Safety, Security, and Data Integrity by Default**: Deck must not
  recommend unsafe installation practices or storing secrets insecurely;
  it will point to official install docs where appropriate. **Status:
  PASS (no violations planned)**.
- **Test‑First, Observable, and Reproducible**: Success criteria define
  how to validate that the deck works (trial installs, sample feature
  run). **Status: PASS**.
- **Task and Workflow Discipline with bd**: The deck explicitly
  instructs that all AI work should be tied to bd issues and Spec Kit
  features, reinforcing the constitution. **Status: PASS**.
- **Architecture: Intentional, Evolvable, and Minimal**: This feature
  adds documentation only; no architectural complexity is introduced.
  **Status: PASS**.

No constitution violations are expected; Complexity Tracking can remain
empty for this feature.

## Project Structure

### Documentation (this feature)

```text
specs/001-beads-speckit-onboarding/
├── spec.md              # Feature specification (/speckit.specify)
├── plan.md              # This file (/speckit.plan output)
├── research.md          # (optional) additional notes on bd/Spec Kit usage
├── data-model.md        # (lightweight) key entities: bd issues, Spec Kit features
├── quickstart.md        # User-facing quickstart steps extracted from the deck
├── contracts/           # (not expected to be used; kept for template consistency)
└── tasks.md             # Generated later by /speckit.tasks
```

### Source Code (repository root)

This feature does not introduce new runtime code; it only adds
documentation and possibly slide-source files (if stored in-repo).

```text
docs/
└── beads-spec-kit-onboarding/
    ├── slides.md or slides.pptx
    └── README.md (optional overview pointing to the deck)
```

**Structure Decision**: Treat this as a documentation-only feature
anchored in `specs/001-beads-speckit-onboarding/` with optional
presentation assets under `docs/beads-spec-kit-onboarding/`. No new code
packages, services, or tests directories are required.

## Complexity Tracking

No constitutional violations or unusual complexity are anticipated for
this documentation feature; this section remains empty.
