---
description: Create high-quality User Stories following Wiser Solutions INVEST principles and standard templates
---

# Create User Story Workflow

This workflow guides the creation of high-quality User Stories that follow the Wiser Solutions Epic and Story Standard INVEST principles (Confluence Page ID: 4660658177).

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
- [ ] What epic does this story belong to?
- [ ] How does this story contribute to epic success criteria?
- [ ] What is the priority within the epic?

**User and Value Context:**
- [ ] Who is the specific user role for this story?
- [ ] What specific capability or action do they need?
- [ ] What business value or benefit will they gain?
- [ ] How can this value be measured or demonstrated?

**Functional Context:**
- [ ] What is the core functionality being delivered?
- [ ] What are the main user workflows involved?
- [ ] What data or systems are involved?
- [ ] What are the key edge cases or error scenarios?

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

#### **I - Independent** (Target: ≥3)
**Requirement**: Story can be developed without dependencies on other stories

**Validation Questions:**
- [ ] Can this story be developed without waiting for other stories?
- [ ] Are dependencies on other stories in the same sprint manageable?
- [ ] Can this story be developed in any order?
- [ ] Are interfaces with other work clearly defined?

**Score**: [1-5] - Rate the independence level

#### **N - Negotiable** (Target: ≥3)
**Requirement**: Story details can be refined through collaboration

**Validation Questions:**
- [ ] Is the implementation approach flexible?
- [ ] Can acceptance criteria be refined during development?
- [ ] Is there room for developer input on technical approach?
- [ ] Can scope be adjusted while maintaining core value?

**Score**: [1-5] - Rate the negotiability level

#### **V - Valuable** (Target: ≥4)
**Requirement**: Story delivers clear business or user value

**Validation Questions:**
- [ ] Is the value statement specific and measurable?
- [ ] Is the benefit meaningful to end users or business?
- [ ] Can value be demonstrated upon completion?
- [ ] Does it contribute to larger epic or business objective?

**Score**: [1-5] - Rate the value clarity and impact

#### **E - Estimable** (Target: ≥3)
**Requirement**: Story is well-defined enough for accurate estimation

**Validation Questions:**
- [ ] Are requirements clear and unambiguous?
- [ ] Is the technical approach understood?
- [ ] Are acceptance criteria specific enough?
- [ ] Can the team confidently estimate effort?

**Score**: [1-5] - Rate the estimability

#### **S - Small** (Target: ≥3)
**Requirement**: Story can be completed within one sprint

**Validation Questions:**
- [ ] Can this be completed in 1-5 days?
- [ ] Is scope focused on single functionality?
- [ ] Can it be demonstrated as working software?
- [ ] Is it estimated at 1-8 story points?

**Score**: [1-5] - Rate the size appropriateness

#### **T - Testable** (Target: ≥4)
**Requirement**: Story has clear, verifiable acceptance criteria

**Validation Questions:**
- [ ] Do acceptance criteria use Gherkin syntax?
- [ ] Do criteria cover happy path and edge cases?
- [ ] Are success/failure conditions unambiguous?
- [ ] Can criteria be automated as tests?

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
- **Ready for Sprint**: Average score ≥3.5 (21+ total) with no individual scores below 2
- **Needs Refinement**: Average score 3.0-3.4 (18-20 total) or any score below 2
- **Significant Rework Required**: Average score <3.0 (<18 total) or multiple scores below 3

### Step 5: Story Improvement (If Needed)

For any INVEST criterion scoring below target:

#### Independent (I) - Improvement Actions
**If Score < 3:**
- [ ] Identify and document all dependencies clearly
- [ ] Consider breaking story to reduce dependencies
- [ ] Define clear interfaces for dependent work
- [ ] Create contingency plans for dependency delays

#### Negotiable (N) - Improvement Actions
**If Score < 3:**
- [ ] Clarify which requirements are fixed vs. flexible
- [ ] Schedule refinement session with development team
- [ ] Identify areas where developer input would be valuable
- [ ] Document business constraints that limit negotiability

#### Valuable (V) - Improvement Actions
**If Score < 4:**
- [ ] Strengthen the "so that I can" clause with specific, measurable benefits
- [ ] Connect story to broader business objectives or user outcomes
- [ ] Add success metrics or validation criteria
- [ ] Clarify user impact and business value

#### Estimable (E) - Improvement Actions
**If Score < 3:**
- [ ] Schedule story refinement session to clarify requirements
- [ ] Break down technical approach and identify unknowns
- [ ] Add more specific acceptance criteria
- [ ] Involve technical team in requirement clarification

#### Small (S) - Improvement Actions
**If Score < 3:**
- [ ] Break story into smaller, independent pieces
- [ ] Identify minimum viable functionality for first iteration
- [ ] Consider horizontal vs. vertical slicing approaches
- [ ] Ensure each piece delivers atomic business value

#### Testable (T) - Improvement Actions
**If Score < 4:**
- [ ] Rewrite acceptance criteria using Gherkin format (Given/When/Then)
- [ ] Add specific test scenarios for edge cases
- [ ] Remove vague language ("user-friendly", "fast", "better")
- [ ] Include both positive and negative test cases

### Step 6: Technical Enablement Story Consideration

If this story is primarily technical work that doesn't fit the standard user story format:

**Assessment Questions:**
- [ ] Does this work primarily benefit the development team or technical system?
- [ ] Will this work enable or improve future user-facing features?
- [ ] Is the primary value technical (performance, maintainability, scalability)?
- [ ] Would a regular user story format feel forced or unnatural?

**If YES to most questions:**
- [ ] Consider using Technical Enablement story format instead
- [ ] Reference technical-enablement-rules.md for guidance
- [ ] Use modified INVEST principles for technical work
- [ ] Ensure technical work enables future user stories

### Step 7: Story Quality Validation

#### Story Quality Checklist
- [ ] Follows proper user story format (As a... I need... So that I can...)
- [ ] Value statement is specific and measurable
- [ ] Acceptance criteria are clear, specific, and unambiguous
- [ ] Gherkin syntax used for acceptance criteria
- [ ] Criteria cover happy path and edge cases
- [ ] Definition of Done is comprehensive and specific
- [ ] Story is independent and can be completed in one sprint
- [ ] Story is estimable by the development team
- [ ] All INVEST criteria meet target scores (average ≥3.5)
- [ ] Story contributes to epic success criteria

#### Anti-Pattern Check
Ensure the story avoids these common anti-patterns:

❌ **Vague User Story**:
```
As a user
I want the system to be better
So that it works well
```

❌ **Technical Story** (use Technical Enablement instead):
```
As a developer
I need to refactor the authentication module
So that the code is cleaner
```

❌ **Implementation-focused Acceptance Criteria**:
```
Acceptance Criteria:
- Use React hooks for state management
- Implement JWT authentication
- Store data in PostgreSQL
```

❌ **Untestable Criteria**:
```
Acceptance Criteria:
- The system should be fast
- Users should be happy
- It should work well
```

### Step 8: Story Finalization

#### Final Review
- [ ] Story follows Wiser Solutions template exactly
- [ ] All INVEST criteria satisfied (average ≥3.5)
- [ ] Quality checklist items all pass
- [ ] Anti-patterns avoided
- [ ] Story ready for sprint planning

#### Story Documentation
- [ ] Create story in appropriate project management tool
- [ ] Link to parent epic
- [ ] Add appropriate labels and components
- [ ] Set story points based on team estimation
- [ ] Add to product backlog with appropriate priority

#### Integration Planning
- [ ] Validate story contributes to epic success criteria
- [ ] Plan dependencies with other stories
- [ ] Schedule refinement sessions if needed
- [ ] Prepare for sprint planning discussion

## Workflow Completion Checklist

**User Story Created Successfully:**
- [ ] Story follows Wiser Solutions INVEST template exactly
- [ ] All INVEST criteria satisfied (average ≥3.5, no scores below 2)
- [ ] Business value clearly articulated and measurable
- [ ] Gherkin acceptance criteria comprehensive and testable
- [ ] Story is sprint-ready and estimable
- [ ] Contributes to epic success criteria

**Next Steps:**
1. Add story to product backlog with appropriate priority
2. Schedule story refinement sessions with development team
3. Plan integration with other stories in epic
4. Prepare for sprint planning and estimation

## Example Story Output

```markdown
# Story: View Order History

## User Story
As a customer
I need to view my complete order history with detailed information
So that I can track my purchases, reorder items, and resolve billing questions without contacting support

## Value Statement
Customers currently call support for 40% of order-related inquiries. Self-service order history will reduce these calls by an estimated 200 tickets/month, saving $6,000 in support costs and improving customer satisfaction through immediate access to information.

## Acceptance Criteria
```gherkin
Scenario: Customer views their order history
Given I am a logged-in customer with previous orders
When I navigate to "My Orders" page
Then I should see all my orders from the past 24 months
And each order should display order number, date, total amount, and status
And orders should be sorted by date (most recent first)
And I should see pagination for orders older than 50 items

Scenario: Customer views order details
Given I am viewing my order history
When I click on a specific order
Then I should see detailed order information including:
  - Items purchased with quantities and prices
  - Shipping address and method
  - Payment method (last 4 digits only)
  - Order timeline (placed, processed, shipped, delivered)
  - Tracking information if available

Scenario: Customer with no order history
Given I am a logged-in customer with no previous orders
When I navigate to "My Orders" page
Then I should see a message "You haven't placed any orders yet"
And I should see a "Start Shopping" button linking to the product catalog

Scenario: System error handling
Given I am viewing my order history
When the order service is temporarily unavailable
Then I should see a user-friendly error message
And I should see a "Try Again" button
And the error should be logged for support team review
```

## Definition of Done
- [ ] General DoD Checklist completed (see team standards)
- [ ] Performance tested: page loads in <2 seconds with 1000+ orders
- [ ] Security review: customer data access logging implemented
- [ ] Pagination implemented for order histories >50 items
- [ ] Error handling: graceful degradation when order service unavailable
- [ ] Documentation: customer support team trained on new order lookup features

## Assumptions
- Customer authentication system is available and reliable
- Order data is accessible via existing customer API
- Customers prefer chronological order display (most recent first)

## Dependencies
- Customer authentication must be working
- Order service API must be available
- Customer portal framework must be implemented

## Notes
- Consider implementing order search/filter functionality in future story
- May need to implement caching for customers with large order histories
- Should include analytics to track usage patterns
```

**INVEST Score Analysis:**
- Independent (I): 4/5 - Depends on auth and API but manageable
- Negotiable (N): 4/5 - Implementation details flexible, core requirements clear
- Valuable (V): 5/5 - Clear, quantifiable business value ($6,000 savings)
- Estimable (E): 4/5 - Well-defined with clear acceptance criteria
- Small (S): 4/5 - Can be completed in one sprint (estimated 5 points)
- Testable (T): 5/5 - Comprehensive Gherkin scenarios cover all cases

**Overall Score**: 26/30 (87%) - Average: 4.3/5 ✅ **Ready for Sprint**

This workflow ensures all user stories follow the Wiser Solutions standard and deliver measurable value to users and the business.
