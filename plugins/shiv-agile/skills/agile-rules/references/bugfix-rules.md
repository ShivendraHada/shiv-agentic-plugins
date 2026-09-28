# Bugfix Rules -- Shiv Solutions Standard

## Overview

This reference defines Shiv Solutions standards for creating, triaging, analyzing, testing, and integrating bugfix work items into the agile workflow. Every bugfix should be actionable, traceable, and thorough enough for any developer on the team to pick up and resolve.

---

## Core Bugfix Principles

Every bugfix must adhere to these six principles:

| Principle      | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| **Root Cause Focus** | Address the underlying cause, not just the visible symptom.            |
| **Reproducible**     | Include clear, numbered steps that reliably reproduce the issue.       |
| **Testable**         | Define how to verify the fix works and that regressions are caught.    |
| **Traceable**        | Link to related issues, features, requirements, or incidents.          |
| **Prioritized**      | Clearly indicate severity and business impact.                         |
| **Documented**       | Provide sufficient context for any developer to understand the issue.  |

---

## Severity Classification

Classify every bug using Shiv's severity framework:

| Severity     | Definition                                                                     | Response Time          |
|--------------|--------------------------------------------------------------------------------|------------------------|
| **Blocker**  | System down, data loss, security breach, or blocking production deployment.    | Immediate -- all hands |
| **Critical** | Major functionality broken, significant user impact, workaround difficult.     | Fix in current sprint  |
| **Major**    | Minor functionality issues, moderate user impact, workaround available.        | Fix in next 1-2 sprints|
| **Minor**    | Cosmetic issues, minimal user impact, nice-to-have fixes.                      | Backlog -- fix when capacity allows |

---

## Bug Report Structure

Every bugfix work item should include these 11 sections:

### 1. Title
Clear, specific description of the issue. Use the pattern: `[Component] Brief description of incorrect behavior`.

### 2. Summary
One to two sentences describing the problem, who is affected, and the business impact.

### 3. Environment
Where the bug occurs: operating system, browser and version, application version, deployment environment (staging, production), and any relevant configuration.

### 4. Steps to Reproduce
Detailed, numbered steps that reliably reproduce the issue. Start from a known state and include specific data values where applicable.

### 5. Expected Behavior
What the system should do when the steps above are followed.

### 6. Actual Behavior
What the system actually does, including error messages, incorrect outputs, or unexpected states.

### 7. Impact Assessment
- Number of users affected.
- Business processes blocked or degraded.
- Workaround availability and cost.
- Customer escalation status.

### 8. Root Cause Analysis
Technical explanation of why the bug occurs. May be populated during investigation rather than at report time.

### 9. Proposed Solution
High-level description of the fix approach, including alternatives considered.

### 10. Test Plan
How to verify the fix works:
- Acceptance criteria in Gherkin format.
- Regression scenarios to validate.
- Performance impact to measure.

### 11. Risk Assessment
Potential side effects of the fix, including affected components, data migration risks, and rollback considerations.

---

## Bug Triage Process

### Severity Assessment

Use these guiding questions during triage:

1. How many users are affected?
2. Is there a workaround available?
3. Does this block other work?
4. What is the business impact?
5. How difficult is it to fix?
6. Could this cause data corruption?
7. Is this a regression from recent changes?

### Impact vs. Effort Matrix

Categorize bugs on two axes to guide prioritization:

| | Low Effort | High Effort |
|---|---|---|
| **High Impact** | Quick wins -- prioritize immediately | Major projects -- plan carefully |
| **Low Impact** | Fill-in work -- good for junior developers | Consider not fixing -- evaluate ROI |

### Assignment Criteria

Match bugs to developers based on:

- **Expertise** -- Domain knowledge and technical skills relevant to the bug.
- **Availability** -- Current workload and sprint capacity.
- **Learning Goals** -- Opportunities for skill development.
- **Ownership** -- Who worked on the original feature.

### Escalation Triggers

Escalate a bug when:

- Multiple fix attempts have failed.
- Root cause is unclear after investigation.
- The fix requires architectural changes.
- The bug affects multiple systems or teams.
- A customer escalation or SLA breach risk exists.

---

## Root Cause Analysis Techniques

### 5 Whys Method

Drill from symptom to root cause by asking "why" five times:

1. **Why** did the bug occur? (Immediate cause)
2. **Why** did that happen? (Contributing factor)
3. **Why** did that happen? (System cause)
4. **Why** did that happen? (Process cause)
5. **Why** did that happen? (Root cause)

Document the full chain. The root cause is typically a process or system issue, not an individual mistake.

### Fishbone Diagram Categories

Analyze potential causes across four categories:

- **People** -- Skills, training, communication, workload.
- **Process** -- Development workflow, testing coverage, deployment practices, code review gaps.
- **Technology** -- Tools, frameworks, infrastructure, dependency versions.
- **Environment** -- Hardware, network, configuration, data state.

### Timeline Analysis

Construct a timeline to understand:

- When the bug was introduced (commit, deployment, or configuration change).
- What changes occurred around that time.
- When the bug was first noticed.
- What conditions trigger the bug.

### Investigation Checklist

Systematically investigate these areas:

- [ ] Recent code changes and deployments
- [ ] Configuration changes
- [ ] Data changes or migrations
- [ ] Infrastructure changes
- [ ] Third-party service changes
- [ ] User behavior patterns
- [ ] Error logs and monitoring data
- [ ] Performance metrics
- [ ] Security events

---

## Testing Strategy for Bugfixes

### Testing Pyramid

Apply testing at four levels:

#### Unit Tests
- Test the specific function or method that was fixed.
- Cover the edge case that caused the original bug.
- Verify the fix works with various inputs.
- Ensure existing functionality still works.

#### Integration Tests
- Test interactions between components affected by the fix.
- Verify data flows correctly through the system.
- Check API contracts and responses.
- Validate database operations.

#### System Tests
- Test the complete user workflow end to end.
- Verify the fix in the actual (or production-like) environment.
- Check performance impact of the fix.
- Validate security implications.

#### Regression Tests
- Run existing test suites.
- Test related functionality.
- Check for unintended side effects.
- Verify no new bugs were introduced.

### Acceptance Criteria for Bugfixes (Gherkin Format)

```gherkin
Scenario: Bug is fixed
  Given [the conditions that caused the bug]
  When [the action that triggered the bug]
  Then [the system should behave correctly]
  And [no regression should occur]

Scenario: Related functionality works
  Given [normal operating conditions]
  When [performing related actions]
  Then [all functionality should work as expected]
```

### Testing Checklist

Before marking a bugfix complete:

- [ ] Original bug scenario no longer reproduces
- [ ] Unit tests pass for modified code
- [ ] Integration tests pass
- [ ] Regression tests pass
- [ ] Performance impact assessed
- [ ] Security implications reviewed
- [ ] Documentation updated
- [ ] Stakeholders notified

---

## Workflow Integration

### Sprint Capacity

- Reserve **20-30%** of sprint capacity for bug fixes.
- Triage bugs before sprint planning meetings.
- Classify bugs by sprint impact:
  - **Must Fix** -- Critical bugs blocking sprint goals.
  - **Should Fix** -- High-priority bugs affecting quality.
  - **Could Fix** -- Medium-priority bugs if capacity allows.
  - **Won't Fix** -- Low-priority bugs deferred to backlog.

### Bug vs. Feature Balance

Maintain a healthy balance based on product maturity:

| Product State    | Feature Work | Bug Work |
|------------------|-------------|----------|
| Healthy product  | 80%         | 20%      |
| Legacy system    | 60%         | 40%      |

Track bug debt accumulation and enforce quality gates: never ship with Blocker or Critical bugs unresolved.

### Definition of Done for Bugfixes

A bugfix is complete when all of the following are satisfied:

- [ ] Root cause identified and documented
- [ ] Fix implemented and code reviewed
- [ ] Unit tests added or updated
- [ ] Integration tests pass
- [ ] Regression tests pass
- [ ] Documentation updated
- [ ] Stakeholders notified
- [ ] Deployed to production
- [ ] Monitoring confirms resolution

### Workflow States

Track bugfixes through these states:

1. **Reported** -- Bug identified and logged.
2. **Triaged** -- Severity and priority assigned.
3. **Assigned** -- Developer allocated to fix.
4. **In Progress** -- Investigation and fixing underway.
5. **Code Review** -- Fix ready for peer review.
6. **Testing** -- QA validation in progress.
7. **Ready for Deploy** -- Approved for production.
8. **Deployed** -- Fix live in production.
9. **Verified** -- Confirmed working in production.
10. **Closed** -- Issue resolved and documented.

### Metrics to Track

| Metric              | Description                            |
|---------------------|----------------------------------------|
| Time to Resolution  | From report to verified fix            |
| Fix Rate            | Bugs fixed per sprint                  |
| Escape Rate         | Bugs found in production               |
| Recurrence Rate     | Bugs that reappear after being fixed   |
| Customer Impact     | Number of users affected by bugs       |
