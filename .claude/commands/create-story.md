# Create User Story Workflow

Create high-quality User Stories following Wiser Solutions INVEST principles and standard templates (Confluence Page ID: 4660658177).

## User Input

```text
$ARGUMENTS
```

Consider the user input above when creating the story. If empty, ask for the story details.

## User Story Definition (Wiser Standard)

A User Story is a concise description of a feature from an end-user perspective that delivers incremental value and can be completed within a single sprint.

## Required Story Format (Wiser Standard)

```
As a [specific user role]
I need to [specific action or capability]
So that I can [specific business value or benefit]
```

## Story Quality Requirements

1. **Format**: Must follow the required "As a... I need to... So that I can..." format
2. **Value**: Must include detailed value statement with quantifiable impact
3. **Acceptance Criteria**: Must use Gherkin syntax (Given/When/Then)
4. **Size**: Must be completable within one sprint (1-8 story points)
5. **Independence**: Should minimize dependencies on other stories
6. **INVEST Compliance**: Must meet all INVEST criteria with target average of 3.5-4.0

## Workflow Steps

### Step 1: Story Context and Information Gathering

**Epic Context:**
- What epic does this story belong to?
- How does this story contribute to epic success criteria?
- What is the priority within the epic?

**User and Value Context:**
- Who is the specific user role for this story?
- What specific capability or action do they need?
- What business value or benefit will they gain?
- How can this value be measured or demonstrated?

**Functional Context:**
- What is the core functionality being delivered?
- What are the main user workflows involved?
- What data or systems are involved?
- What are the key edge cases or error scenarios?

### Step 2: Story Creation Using Wiser Template

Create the story using the Wiser Solutions template structure:

```markdown
# Story: [Story Title]

## User Story
As a [specific user role]
I need to [specific action or capability]
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

Scenario: [Additional scenarios as needed]
Given [context]
When [action]
Then [outcome]
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

### Step 3: INVEST Criteria Validation

Validate the story against each INVEST criterion using the Wiser Solutions 1-5 scale:

#### **I - Independent** (Target: >=3)
**Requirement**: Story can be developed without dependencies on other stories

**Validation Questions:**
- Can this story be developed without waiting for other stories?
- Are dependencies on other stories in the same sprint manageable?
- Can this story be developed in any order?
- Are interfaces with other work clearly defined?

**Score**: [1-5] - Rate the independence level

#### **N - Negotiable** (Target: >=3)
**Requirement**: Story details can be refined through collaboration

**Validation Questions:**
- Is the implementation approach flexible?
- Can acceptance criteria be refined during development?
- Is there room for developer input on technical approach?
- Can scope be adjusted while maintaining core value?

**Score**: [1-5] - Rate the negotiability level

#### **V - Valuable** (Target: >=4)
**Requirement**: Story delivers clear business or user value

**Validation Questions:**
- Is the value statement specific and measurable?
- Is the benefit meaningful to end users or business?
- Can value be demonstrated upon completion?
- Does it contribute to larger epic or business objective?

**Score**: [1-5] - Rate the value clarity and impact

#### **E - Estimable** (Target: >=3)
**Requirement**: Story is well-defined enough for accurate estimation

**Validation Questions:**
- Are requirements clear and unambiguous?
- Is the technical approach understood?
- Are acceptance criteria specific enough?
- Can the team confidently estimate effort?

**Score**: [1-5] - Rate the estimability

#### **S - Small** (Target: >=3)
**Requirement**: Story can be completed within one sprint

**Validation Questions:**
- Can this be completed in 1-5 days?
- Is scope focused on single functionality?
- Can it be demonstrated as working software?
- Is it estimated at 1-8 story points?

**Score**: [1-5] - Rate the size appropriateness

#### **T - Testable** (Target: >=4)
**Requirement**: Story has clear, verifiable acceptance criteria

**Validation Questions:**
- Do acceptance criteria use Gherkin syntax?
- Do criteria cover happy path and edge cases?
- Are success/failure conditions unambiguous?
- Can criteria be automated as tests?

**Score**: [1-5] - Rate the testability

### Step 4: INVEST Score Analysis

**Individual INVEST Scores:**
- Independent (I): [1-5] / 5
- Negotiable (N): [1-5] / 5
- Valuable (V): [1-5] / 5
- Estimable (E): [1-5] / 5
- Small (S): [1-5] / 5
- Testable (T): [1-5] / 5

**Overall INVEST Score**: [Total] / 30 ([Percentage]%)
**Average Score**: [Total/6] (Target: 3.5-4.0)

**Quality Assessment:**
- **Ready for Sprint**: Average score >=3.5 (21+ total) with no individual scores below 2
- **Needs Refinement**: Average score 3.0-3.4 (18-20 total) or any score below 2
- **Significant Rework Required**: Average score <3.0 (<18 total) or multiple scores below 3

### Step 5: Story Improvement (If Needed)

For any INVEST criterion scoring below target, provide specific improvement recommendations.

### Step 6: Story Quality Validation

#### Story Quality Checklist
- Follows proper user story format (As a... I need... So that I can...)
- Value statement is specific and measurable
- Acceptance criteria are clear, specific, and unambiguous
- Gherkin syntax used for acceptance criteria
- Criteria cover happy path and edge cases
- Definition of Done is comprehensive and specific
- Story is independent and can be completed in one sprint
- Story is estimable by the development team
- All INVEST criteria meet target scores (average >=3.5)
- Story contributes to epic success criteria

#### Anti-Pattern Check
Ensure the story avoids these common anti-patterns:

**Vague User Story**:
```
As a user
I want the system to be better
So that it works well
```

**Technical Story** (use Technical Enablement instead):
```
As a developer
I need to refactor the authentication module
So that the code is cleaner
```

**Implementation-focused Acceptance Criteria**:
```
Acceptance Criteria:
- Use React hooks for state management
- Implement JWT authentication
- Store data in PostgreSQL
```

### Step 7: Story Finalization

#### Final Review
- Story follows Wiser Solutions template exactly
- All INVEST criteria satisfied (average >=3.5)
- Quality checklist items all pass
- Anti-patterns avoided
- Story ready for sprint planning

#### Next Steps
1. Add story to product backlog with appropriate priority
2. Schedule story refinement sessions with development team
3. Plan integration with other stories in epic
4. Prepare for sprint planning and estimation
