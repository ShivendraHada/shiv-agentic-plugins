---
description: Score a single story against INVEST criteria and provide improvement recommendations following Shiv Solutions standards
argument-hint: <story key (e.g. PROJ-123) or paste the full story text to analyze>
---

# Story INVEST Score Analysis Workflow

Score a single story against INVEST criteria and provide improvement recommendations following the Shiv Solutions Epic and Story Standard (Confluence Page ID: 4660658177).

## User Input

```text
$ARGUMENTS
```

Analyze the story provided above. If no story is provided, ask for the story details including:
- Story Key (e.g., PROJ-123)
- Story Title
- Story Description (full story text including user story format)
- Acceptance Criteria
- Story Points (current estimation)
- Dependencies (any linked issues)
- Epic Link (parent epic if applicable)

## INVEST Scoring Analysis (Shiv Standard)

Score each INVEST criterion on a 1-5 scale using the Shiv Solutions standard rubric:

**Scoring Scale:**
- **5**: Excellent - Fully meets the criterion with no concerns
- **4**: Good - Meets the criterion with minor areas for improvement
- **3**: Acceptable - Meets basic requirements but has notable gaps
- **2**: Poor - Partially meets the criterion with significant issues
- **1**: Failing - Does not meet the criterion, requires major rework

**Target Performance**: Stories should average **3.5-4.0** across all INVEST criteria

### Independent (I) - Dependency Analysis (Shiv Standard)
**Requirement**: Story can be developed without dependencies on other stories

**Scoring Criteria:**
- **5**: No dependencies on other stories; can be developed in complete isolation
- **4**: Dependencies on other stories in the same sprint do not jeopardize completion
- **3**: Some dependencies but can be developed in any order with coordination
- **2**: Significant dependencies that may impact timing or require careful sequencing
- **1**: Major dependencies that make independent development very difficult

**Quality Indicators:**
- Dependencies on other stories in the same sprint do not jeopardize completion
- Can be developed in any order
- Minimal coupling with other work items
- Clear interfaces defined for necessary integrations

**Analysis Questions:**
- Does this story depend on other stories in the current sprint?
- Are there external dependencies (APIs, services, other teams)?
- Can the story be completed if other work is delayed?
- Are interfaces between dependent work clearly defined?

### Negotiable (N) - Flexibility Assessment (Shiv Standard)
**Requirement**: Story details can be refined through collaboration

**Scoring Criteria:**
- **5**: Implementation approach and details are highly flexible and collaborative
- **4**: Most aspects negotiable with some fixed business requirements
- **3**: Balanced mix of fixed requirements and flexible implementation
- **2**: Limited flexibility due to technical or regulatory constraints
- **1**: Very rigid requirements with minimal room for developer input

**Quality Indicators:**
- Implementation approach is flexible
- Acceptance criteria can be refined during development
- Scope can be adjusted while maintaining core value
- Room for developer input on technical approach

### Valuable (V) - Business Value Assessment (Shiv Standard)
**Requirement**: Story delivers clear business or user value

**Scoring Criteria:**
- **5**: Clear, quantifiable business value with specific metrics and user impact
- **4**: Well-articulated business value that connects to business objectives
- **3**: Moderate business value that is reasonably clear to stakeholders
- **2**: Limited or unclear business value proposition
- **1**: Minimal business value or poorly articulated benefits

**Quality Indicators:**
- Value statement clearly articulates benefit
- Benefit is meaningful to end users or business
- Value can be demonstrated upon completion
- Contributes to larger epic or business objective

### Estimable (E) - Clarity and Estimability (Shiv Standard)
**Requirement**: Story is well-defined enough for accurate estimation

**Scoring Criteria:**
- **5**: Story is crystal clear and team can confidently estimate effort
- **4**: Story is well-defined with only minor clarifications needed
- **3**: Story is generally clear but has some ambiguous aspects
- **2**: Story has significant unclear areas that complicate estimation
- **1**: Story is poorly defined making estimation very difficult

**Quality Indicators:**
- Requirements are clear and unambiguous
- Technical approach is understood
- Acceptance criteria are specific
- Team can confidently estimate effort

### Small (S) - Size and Scope Assessment (Shiv Standard)
**Requirement**: Story can be completed within one sprint

**Scoring Criteria:**
- **5**: Story is appropriately sized for single sprint completion (1-3 points)
- **4**: Story is well-sized with clear scope boundaries (3-5 points)
- **3**: Story is moderately sized but manageable within sprint (5-8 points)
- **2**: Story is large but could fit in sprint with risk (8+ points)
- **1**: Story is too large for single sprint and should be broken down

**Quality Indicators:**
- Estimated at 1-8 story points (team-dependent)
- Can be completed in 1-5 days
- Scope is focused on single functionality
- Can be demonstrated as working software

### Testable (T) - Verification and Validation (Shiv Standard)
**Requirement**: Story has clear, verifiable acceptance criteria

**Scoring Criteria:**
- **5**: Comprehensive, specific acceptance criteria using Gherkin syntax
- **4**: Clear acceptance criteria that cover main scenarios and edge cases
- **3**: Adequate acceptance criteria with some gaps in edge case coverage
- **2**: Basic acceptance criteria but missing important test scenarios
- **1**: Vague or incomplete acceptance criteria that are hard to verify

**Quality Indicators:**
- Acceptance criteria use Gherkin syntax (Given/When/Then)
- Criteria cover happy path and edge cases
- Success/failure conditions are unambiguous
- Criteria can be automated as tests

## Score Calculation and Analysis

**Individual Scores (Shiv Standard 1-5 Scale):**
- Independent (I): [1-5] / 5
- Negotiable (N): [1-5] / 5
- Valuable (V): [1-5] / 5
- Estimable (E): [1-5] / 5
- Small (S): [1-5] / 5
- Testable (T): [1-5] / 5

**Overall INVEST Score:** [Total] / 30 ([Percentage]%)
**Average Score:** [Total/6] (Target: 3.5-4.0)

**Quality Grade (Shiv Standard):**
- 26-30 points (87-100%): **A - Excellent**
- 22-25 points (73-86%): **B - Good**
- 18-21 points (60-72%): **C - Acceptable**
- 14-17 points (47-59%): **D - Needs Improvement**
- 6-13 points (20-46%): **F - Significant Issues**

## Improvement Recommendations

For each criterion scoring below 4, provide specific, actionable recommendations:

### Independent (I) - Improvement Actions
**If Score < 4:**
- Identify and document all dependencies clearly
- Consider breaking story to reduce dependencies
- Coordinate with dependent teams to ensure availability
- Define clear interfaces for dependent work
- Create contingency plans for dependency delays

### Negotiable (N) - Improvement Actions
**If Score < 4:**
- Clarify which requirements are fixed vs. flexible
- Schedule refinement session with development team
- Identify areas where developer input would be valuable
- Document business constraints that limit negotiability
- Consider alternative approaches that meet business needs

### Valuable (V) - Improvement Actions
**If Score < 4:**
- Strengthen the "so that" clause with specific, measurable benefits
- Connect story to broader business objectives or user outcomes
- Add success metrics or validation criteria
- Clarify user impact and business value
- Consider if story should be deprioritized if value is unclear

### Estimable (E) - Improvement Actions
**If Score < 4:**
- Schedule story refinement session to clarify requirements
- Break down technical approach and identify unknowns
- Create spike stories for investigation if needed
- Add more specific acceptance criteria
- Involve technical team in requirement clarification

### Small (S) - Improvement Actions
**If Score < 4:**
- Break story into smaller, independent pieces
- Identify minimum viable functionality for first iteration
- Consider horizontal vs. vertical slicing approaches
- Ensure each piece delivers atomic business value
- Re-estimate broken-down stories

### Testable (T) - Improvement Actions
**If Score < 4:**
- Rewrite acceptance criteria using Gherkin format (Given/When/Then)
- Add specific test scenarios for edge cases
- Remove vague language ("user-friendly", "fast", "better")
- Include both positive and negative test cases
- Ensure criteria can be verified objectively

## Action Plan Summary

**Priority Improvements** (Scores 0-2):
1. [List critical improvements needed]
2. [Next critical improvement]
3. [Additional critical items]

**Recommended Improvements** (Scores 3):
1. [List recommended enhancements]
2. [Next recommended item]

**Story Readiness Assessment (Shiv Standard):**
- **Ready for Sprint**: Average score >=3.5 (21+ total) with no individual scores below 2
- **Needs Refinement**: Average score 3.0-3.4 (18-20 total) or any score below 2
- **Significant Rework Required**: Average score <3.0 (<18 total) or multiple scores below 3

## Technical Enablement Story Consideration

If this story is primarily technical work that doesn't fit the standard user story format:
- **Consider Technical Enablement Story**: Use modified INVEST principles for technical work
- **Use /create-technical-enablement-story**: For infrastructure, tech debt, or platform work
- **Technical Value Assessment**: Ensure technical work enables future user stories or measurable improvements

## Summary

- **Original INVEST Score:** [Score] / 30 ([Percentage]%) - Average: [Score/6]
- **Estimated Improved Score:** [Projected score after improvements]
- **Key Improvements Made:** [List 2-3 most important changes]
- **Readiness Status:** [Ready/Needs Refinement/Significant Rework Required]
- **Shiv Standard Compliance:** [Meets/Does not meet] target average of 3.5-4.0

## Next Steps

Based on the INVEST score analysis, consider these related commands:
- `/create-story` - Rewrite or create an improved version of the story based on recommendations
- `/create-technical-enablement-story` - If the story is better suited as a technical enablement story
- `/auto-groom` - Automatically groom all stories in the sprint to improve overall quality
- `/story-quality-kpis` - Generate quality KPIs across teams to track improvement trends
