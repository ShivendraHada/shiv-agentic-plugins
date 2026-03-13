---
name: agile-rules
description: Wiser Solutions agile standards including SMART epic criteria, INVEST story principles, Gherkin acceptance criteria patterns, JBTD framework, W3D+ methodology, and product documentation standards. Applied automatically when creating, reviewing, or grooming agile work items.
user-invocable: false
---

# Wiser Solutions Agile Standards

This skill provides background knowledge for all agile work item creation, review, and grooming activities at Wiser Solutions. The standards below are applied automatically by commands such as `/create-epic`, `/create-story`, `/create-technical-enablement-story`, `/auto-groom`, `/story-invest-score`, and `/notes-to-work-item`.

## SMART Criteria for Epics

Epics must satisfy all five SMART dimensions before sprint planning:

- **Specific** -- Clear problem statement, defined scope and boundaries, identified target users, explicit success criteria.
- **Measurable** -- Quantifiable KPIs with baselines and targets that can be objectively verified.
- **Achievable** -- Resources assessed, technical feasibility validated, dependencies identified, realistic timeline.
- **Relevant** -- Business justification documented, strategic alignment confirmed, stakeholder value articulated.
- **Time-bound** -- Target start and end dates set in epic fields, key milestones identified, sprint allocation estimated.

Epics should not exceed 12 weeks (ideally 6-8 weeks) and must be decomposable into multiple INVEST-compliant user stories.

## INVEST Principles for User Stories

Every user story is evaluated against the INVEST criteria on a 1-5 scale, with a target average of 3.5-4.0:

- **Independent** -- Developable without blocking dependencies on other stories.
- **Negotiable** -- Implementation details remain flexible during planning.
- **Valuable** -- Delivers measurable user or business value.
- **Estimable** -- Sized at 1-8 story points with clear, unambiguous requirements.
- **Small** -- Completable within a single sprint (1-5 days).
- **Testable** -- Acceptance criteria written in Gherkin syntax covering happy path and edge cases.

See `references/invest-principles.md` for the full INVEST reference including quality indicators, scoring rubric, story template, and Gherkin acceptance criteria format.

## Gherkin Acceptance Criteria

All acceptance criteria use the Given/When/Then format:

```gherkin
Scenario: [Descriptive name]
  Given [specific precondition or context]
  When [specific action or event]
  Then [expected, verifiable outcome]
  And [additional verification point]
```

Scenarios must cover happy paths, edge cases, and error conditions. Use `Background` for shared preconditions and `Scenario Outline` with `Examples` tables for data-driven variations.

## Jobs-to-be-Done (JBTD) Framework

Product documentation begins with JBTD thinking:

- Focus on the job the user is trying to accomplish, not features.
- Identify functional, emotional, and social dimensions of the job.
- Highlight current struggles and desired outcomes.
- Frame solutions in terms of job completion.

JBTD principles feed into Idea documents and W3D+ Product Briefs.

## W3D+ Methodology (Why, What, Wow, How, Plus)

W3D+ Product Briefs structure product decisions across five sections:

- **Why** -- Business drivers, customer needs, strategic alignment.
- **What** -- Solution description, key features, user experience, integration points.
- **Wow** -- Unique value proposition, competitive differentiation, innovation.
- **How** -- Implementation approach, resources, timeline, success criteria.
- **Plus** -- Risks, dependencies, open questions, next steps.

W3D+ documents bridge the gap between Ideas and Epics.

## Bugfix Standards

Bugfixes follow a structured approach with severity classification (Blocker, Critical, Major, Minor), an 11-section bug report structure, triage processes, and root cause analysis techniques. See `references/bugfix-rules.md` for complete guidelines.

## Technical Enablement Stories

Technical work that does not directly deliver end-user value uses a modified story format and adapted INVEST principles. See `references/technical-enablement-rules.md` for the full template, value validation categories, and anti-patterns to avoid.

## Reference Files

| File | Contents |
|------|----------|
| `references/invest-principles.md` | Full INVEST criteria, scoring rubric, story template, Gherkin format |
| `references/bugfix-rules.md` | Bug severity, report structure, triage, root cause analysis, testing |
| `references/technical-enablement-rules.md` | Technical story format, modified INVEST, value validation, anti-patterns |
