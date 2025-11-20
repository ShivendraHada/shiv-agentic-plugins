# Specification Quality Checklist: Beads + Spec Kit Onboarding Slide Deck

**Purpose**: Validate specification completeness and quality before proceeding to planning
**Created**: 2025-11-18
**Feature**: ./spec.md

## Content Quality

- [ ] No implementation details (languages, frameworks, APIs) leak into the **requirements** section beyond what is necessary to name tools (bd, Homebrew, uv, specify)
- [ ] Focused on user value and business needs (why bd + Spec Kit are required with AI assistants)
- [ ] Written so both engineers and technical leads can understand the rationale
- [ ] All mandatory sections in spec.md are completed (User Scenarios, Requirements, Success Criteria)

## Requirement Completeness

- [ ] No `[NEEDS CLARIFICATION]` markers remain in spec.md
- [ ] Functional requirements cover rationale, installation, configuration, and workflow usage
- [ ] Success criteria are measurable and technology-agnostic (time to install, adoption, understanding)
- [ ] All acceptance scenarios for core user stories are defined
- [ ] Edge cases (single-assistant usage, missing prerequisites) are identified
- [ ] Scope of the deck is clearly bounded (onboarding + basic workflow, not deep architecture training)
- [ ] Dependencies and assumptions (macOS, Homebrew, Python/uv, access to Windsurf/Claude Code) are identified

## Feature Readiness

- [ ] All functional requirements have clear acceptance criteria in spec.md
- [ ] User scenarios cover primary flows: understanding why, installing tools, running an end-to-end feature
- [ ] Feature meets measurable outcomes defined in Success Criteria when implemented
- [ ] No low-level implementation details of slide tooling (Keynote, PowerPoint, etc.) appear in the spec

## Notes

- Items marked incomplete require spec updates before `/speckit.clarify` or `/speckit.plan`.

