# Create Technical Enablement User Story Workflow

Create high-quality Technical Enablement User Stories for technical work that enables future features.

## User Input

```text
$ARGUMENTS
```

Consider the user input above when creating the story. If empty, ask for the technical work details.

## When to Use This Workflow

Use this workflow to create Technical Enablement stories for:
- Infrastructure work that enables future features
- Technical debt reduction that improves development velocity
- Platform capabilities that support multiple future features
- Developer tooling that improves team productivity
- Architecture improvements that enable scalability or maintainability
- Security enhancements that don't directly impact user workflows
- Performance optimizations that improve system capabilities
- Integration work that connects systems for future features

## Workflow Steps

### Step 1: Technical Work Assessment

**Determine if this should be a Technical Enablement story:**

Ask these qualifying questions:
- Does this work primarily benefit the development team or technical system rather than end users directly?
- Will this work enable or improve future user-facing features?
- Is the primary value technical (performance, maintainability, scalability, security)?
- Would a regular user story format feel forced or unnatural for this work?

**If YES to most questions**: Proceed with Technical Enablement story
**If NO to most questions**: Consider using regular user story format instead

### Step 2: Information Gathering

Collect the following information:

**Technical Context:**
- What technical problem or opportunity does this address?
- What technical capabilities will be created or improved?
- What future user stories or features will this enable?
- What are the current technical limitations or pain points?

**Value and Impact:**
- How will this improve development velocity or system capabilities?
- What measurable technical improvements are expected?
- Which specific future stories/features depend on this work?
- What risks does this work mitigate?

**Technical Requirements:**
- What are the specific technical acceptance criteria?
- What technical standards or quality metrics must be met?
- Are there performance, security, or scalability requirements?
- What technical dependencies exist?

### Step 3: Technical Story Creation

Create the Technical Enablement story using this structure:

#### 3.1 Technical Story Statement

Choose the appropriate format:

**Format A - Team/System Focus:**
```
As a [development team/system/platform]
I need to [technical capability or improvement]
So that I can [enable future capabilities or improve technical outcomes]
```

**Format B - Future Enablement Focus:**
```
As a [system/platform/service]
I need to [technical enhancement]
So that [future user stories/features] can [be implemented/perform better]
```

#### 3.2 Technical Value Statement

Write a detailed explanation that includes:
- Specific technical value being delivered
- Quantifiable impact where possible (performance, capacity, velocity)
- Connection to future user stories or business capabilities
- Technical risks being mitigated

#### 3.3 Enabled Capabilities Section

List specific future work this enables:
- Reference specific user story IDs or epic names
- Describe new technical capabilities that will be available
- Explain improvements to existing capabilities
- Note any technical constraints that will be removed

#### 3.4 Technical Acceptance Criteria

Write comprehensive Gherkin scenarios covering:

**Primary Technical Scenario:**
```gherkin
Scenario: [Main technical capability]
Given [initial technical state/context]
When [technical action or implementation]
Then [expected technical outcome]
And [additional technical verification]
```

**Edge Cases and Error Handling:**
```gherkin
Scenario: [Technical edge case or error scenario]
Given [different technical context/state]
When [different technical action or error condition]
Then [expected technical error handling]
And [technical recovery options]
```

**Performance/Quality Scenarios (if applicable):**
```gherkin
Scenario: [Performance or quality verification]
Given [technical baseline/context]
When [technical load or condition]
Then [expected performance/quality outcome]
```

#### 3.5 Technical Definition of Done

Include both general and story-specific items:
- [ ] General DoD Checklist completed (see team standards)
- [ ] Technical documentation updated
- [ ] Performance benchmarks met (if applicable)
- [ ] Security review completed (if applicable)
- [ ] Integration tests passing
- [ ] Monitoring/observability implemented (if applicable)
- [ ] Ready for use by future stories/features
- [ ] [Story-specific technical requirements]

#### 3.6 Technical Assumptions and Dependencies

Document:
- Technical assumptions made during story creation
- Dependencies on other technical stories, teams, or external factors
- Technical constraints or limitations
- Required technical resources or tools

### Step 4: Modified INVEST Validation

Validate the story against modified INVEST principles:

#### Independent (I) - Technical Independence
- Can be developed without dependencies on other technical stories
- Can be implemented and tested in isolation
- Has clear technical interfaces defined
- Can be deployed independently (if applicable)

#### Negotiable (N) - Technical Flexibility
- Technical approach can be refined through collaboration
- Implementation details are flexible
- Scope can be adjusted while maintaining core technical value
- Room for architectural input and alternatives

#### Valuable (V) - Technical Value
- Delivers clear technical value that enables future work
- Enables specific future user stories or features
- Improves measurable technical metrics
- Connects to broader technical or business objectives
- Value can be demonstrated through technical metrics

#### Estimable (E) - Technical Clarity
- Technical requirements are clear and unambiguous
- Technical approach is understood by the team
- Technical acceptance criteria are specific
- Team can confidently estimate technical effort

#### Small (S) - Technical Scope
- Can be completed within one sprint
- Estimated at 1-8 story points (team-dependent)
- Scope is focused on single technical capability
- Can be demonstrated as working technical solution

#### Testable (T) - Technical Testability
- Technical acceptance criteria use measurable outcomes
- Criteria cover successful implementation and edge cases
- Success/failure conditions are technically unambiguous
- Criteria can be automated as technical tests

### Step 5: Quality Review and Refinement

#### 5.1 Technical Story Quality Checklist

Review against these quality criteria:
- Follows proper technical story format
- Technical value statement is specific and measurable
- Technical acceptance criteria are clear and unambiguous
- Gherkin syntax used for technical acceptance criteria
- Criteria cover successful implementation and edge cases
- Technical Definition of Done is comprehensive
- Story is independent and can be completed in one sprint
- Story is estimable by the development team
- All modified INVEST criteria are met
- Enabled capabilities are clearly identified
- Technical assumptions and dependencies are documented

#### 5.2 Anti-Pattern Check

Ensure the story avoids these common anti-patterns:

**Vague Technical Story**:
- Problem: Generic technical improvements without specific outcomes
- Fix: Define specific technical capabilities and measurable improvements

**Implementation-Only Focus**:
- Problem: Focuses only on code changes without business connection
- Fix: Connect to future capabilities or measurable improvements

**Too Broad Scope**:
- Problem: Trying to address multiple technical areas in one story
- Fix: Break into specific, focused technical capabilities

**Untestable Technical Criteria**:
- Problem: Vague criteria like "better performance" or "cleaner code"
- Fix: Use specific, measurable technical criteria

### Step 6: Story Finalization

#### Final Review
- Technical story follows template structure exactly
- All sections are complete and specific
- Modified INVEST criteria are satisfied
- Quality checklist items all pass
- Integration planning is complete

#### Next Steps
1. Add story to product backlog with appropriate priority
2. Schedule for sprint planning when technical work is needed
3. Coordinate with teams working on dependent user stories
4. Plan measurement and validation of technical value delivery
