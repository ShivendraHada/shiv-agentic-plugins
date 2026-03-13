# INVEST Principles for User Stories -- Wiser Solutions Standard

## Overview

INVEST is the quality framework Wiser Solutions uses to evaluate every user story before it enters sprint planning. Each criterion is scored on a 1-5 scale, and stories must achieve a target average of **3.5-4.0** across all six dimensions to be considered sprint-ready.

---

## Story Template Format

All user stories must follow this format:

```
As a [specific user/role/persona]
I want to [specific capability or action]
So that I can [specific, measurable outcome or value]
```

### Template Rules

- The **role** must be a specific user type, not a generic "user" or "someone."
- The **capability** must describe a concrete action the user performs.
- The **outcome** must articulate measurable business or user value.

---

## INVEST Criteria

### I -- Independent

**Requirement:** The story can be developed without dependencies on other stories in the same sprint.

**Quality Indicators:**
- Dependencies on other stories do not jeopardize sprint completion.
- The story can be developed in any order relative to other backlog items.
- Minimal coupling with other work items.
- Clear interfaces defined for any necessary integrations.

**Good Practice:**
- Story delivers a self-contained slice of functionality.
- Any external dependency is documented and has a known resolution path.
- The team can demo the story in isolation.

**Poor Practice:**
- Story cannot start until another in-flight story is complete.
- Shared code changes create merge conflicts with parallel work.
- Story assumes availability of an API or service that does not yet exist.

---

### N -- Negotiable

**Requirement:** Story details are flexible and can be refined through collaboration during planning and development.

**Quality Indicators:**
- Implementation approach is not prescribed; developers have latitude.
- Acceptance criteria can be refined during development without changing core value.
- Scope can be adjusted while maintaining the primary user benefit.
- Room for developer input on technical approach.

**Good Practice:**
- Story defines the "what" and "why" but leaves the "how" open.
- Product owner and developers agree on intent, not pixel-perfect specs.
- Acceptance criteria describe outcomes, not implementation steps.

**Poor Practice:**
- Story dictates specific technology choices (e.g., "use React hooks for state management").
- Acceptance criteria list implementation tasks rather than observable behaviors.
- Any scope change requires re-approval from multiple stakeholders.

---

### V -- Valuable

**Requirement:** The story delivers measurable user or business value.

**Quality Indicators:**
- Value statement clearly articulates the benefit.
- Benefit is meaningful to end users or the business.
- Value can be demonstrated upon completion.
- Story contributes to a larger epic or business objective.

**Good Practice:**
- Story includes a quantifiable value statement (e.g., "reduces manual data entry by 40%").
- Completion directly improves a user workflow or business metric.
- Stakeholders can observe the benefit in a demo.

**Poor Practice:**
- Value statement is vague ("improves the system").
- Story only benefits developers with no connection to user or business outcomes.
- Value cannot be demonstrated without completing other stories first.

---

### E -- Estimable

**Requirement:** The story is well-defined enough for the team to estimate effort with reasonable confidence.

**Quality Indicators:**
- Requirements are clear and unambiguous.
- Technical approach is understood.
- Acceptance criteria are specific.
- The team can confidently estimate effort (1-8 story points).

**Good Practice:**
- Story points reflect team consensus after discussion.
- Unknown areas have been spiked or investigated before estimation.
- Acceptance criteria remove ambiguity about scope boundaries.

**Poor Practice:**
- Team cannot agree on a size because requirements are unclear.
- Estimation varies wildly (e.g., 2 vs. 13 points) without resolution.
- Story contains hidden complexity discovered only during development.

---

### S -- Small

**Requirement:** The story can be completed within a single sprint.

**Quality Indicators:**
- Estimated at 1-8 story points (team-dependent).
- Can be completed in 1-5 days of development effort.
- Scope is focused on a single piece of functionality.
- Can be demonstrated as working software at sprint review.

**Good Practice:**
- Story delivers a thin, vertical slice of end-to-end functionality.
- Story has 3-5 acceptance criteria scenarios.
- A single developer can own the story from start to finish.

**Poor Practice:**
- Story requires more than one sprint to complete.
- Story touches multiple unrelated components or services.
- Story has more than 7 acceptance criteria scenarios, indicating it should be split.

**Splitting Techniques:**
- Split by workflow steps.
- Split by user roles.
- Split by happy path vs. edge cases.
- Split by data variations.
- Split by CRUD operations.
- Split by interface (API first, then UI).

---

### T -- Testable

**Requirement:** The story has clear, verifiable acceptance criteria that use Gherkin syntax.

**Quality Indicators:**
- Acceptance criteria use Given/When/Then format.
- Criteria cover the happy path and relevant edge cases.
- Success and failure conditions are unambiguous.
- Criteria can be automated as tests.

**Good Practice:**
- Every scenario is independently verifiable.
- Scenarios use concrete, realistic data examples.
- Error scenarios specify the expected system response.

**Poor Practice:**
- Criteria use subjective language ("the page should load quickly").
- Only the happy path is covered; edge cases are ignored.
- Criteria describe internal implementation rather than observable behavior.

---

## Gherkin Acceptance Criteria Format

All acceptance criteria must use Gherkin syntax:

```gherkin
Scenario: [Descriptive name]
  Given [specific precondition or context]
  When [specific action or event]
  Then [expected, verifiable outcome]
  And [additional verification point]
```

### Scenario Types to Include

1. **Happy Path** -- The primary successful user flow.
2. **Alternative Paths** -- Valid variations of the main flow.
3. **Edge Cases** -- Boundary conditions and unusual inputs.
4. **Error Cases** -- How the system handles invalid inputs or failures.

### Advanced Gherkin Patterns

**Background** for shared preconditions:

```gherkin
Background:
  Given the user is logged in as an admin
  And the product catalog contains at least one item

Scenario: Admin views product details
  When the admin clicks on a product
  Then the product detail page is displayed

Scenario: Admin edits product price
  When the admin updates the product price to $19.99
  Then the price is saved and displayed as $19.99
```

**Scenario Outline** for data-driven variations:

```gherkin
Scenario Outline: Validate user input for required fields
  Given the user is on the registration form
  When the user submits the form with <field> left blank
  Then an error message "<message>" is displayed

  Examples:
    | field      | message                    |
    | email      | Email is required          |
    | password   | Password is required       |
    | first_name | First name is required     |
```

---

## INVEST Scoring Rubric

Each criterion is rated on a 1-5 scale:

| Score | Label      | Meaning                                                      |
|-------|------------|--------------------------------------------------------------|
| 5     | Excellent  | Fully meets the criterion with no concerns                   |
| 4     | Good       | Meets the criterion with minor areas for improvement         |
| 3     | Acceptable | Meets basic requirements but has notable gaps                |
| 2     | Poor       | Partially meets the criterion with significant issues        |
| 1     | Failing    | Does not meet the criterion; requires major rework           |

### Quality Thresholds

| Average Score | Total (out of 30) | Verdict                    |
|---------------|--------------------|----------------------------|
| >= 3.5        | >= 21              | Ready for Sprint           |
| 3.0 - 3.4    | 18 - 20            | Needs Refinement           |
| < 3.0         | < 18               | Significant Rework Required|

Additional rule: any individual criterion scoring below 2 triggers mandatory refinement regardless of the overall average.

---

## Full Story Template (Wiser Standard)

```markdown
# Story: [Story Title]

## User Story
As a [specific user role]
I want to [specific action or capability]
So that I can [specific business value or benefit]

## Value Statement
[Detailed explanation of the business value, ideally with quantifiable impact]

## Acceptance Criteria
```gherkin
Scenario: [Primary happy path scenario]
  Given [initial context/state]
  When [action taken by user]
  Then [expected outcome]
  And [additional expected outcomes]

Scenario: [Edge case or error scenario]
  Given [different context/state]
  When [different action or error condition]
  Then [expected error handling]
  And [recovery options presented]
```

## Definition of Done
- [ ] General DoD Checklist completed (see team standards)
- [ ] [Story-specific requirements]
- [ ] Ready for production deployment

## Assumptions
[Any assumptions made during story creation]

## Dependencies
[Any dependencies on other stories, teams, or external factors]

## Notes
[Additional context, technical considerations, or implementation notes]
```

---

## Anti-Patterns to Avoid

**Vague User Story:**
```
As a user
I want the system to be better
So that it works well
```

**Technical Story Disguised as User Story** (use Technical Enablement instead):
```
As a developer
I need to refactor the authentication module
So that the code is cleaner
```

**Implementation-Focused Acceptance Criteria:**
```
Acceptance Criteria:
- Use React hooks for state management
- Implement JWT authentication
- Store data in PostgreSQL
```
