---
description: Generate comprehensive Story Quality KPIs across engineering teams for sprint tracking and performance monitoring
auto_execution_mode: 1
---

# Story Quality KPIs Workflow

This workflow generates comprehensive Story Quality Key Performance Indicators (KPIs) across multiple engineering teams using the Wiser Solutions Epic and Story Standard INVEST principles (Confluence Page ID: 4660658177). It provides statistical analysis for tracking team performance over time and identifying improvement opportunities.

## Target Projects

This workflow analyzes the following engineering teams:
- **PI**: Next Gen Price Intelligence
- **NGRI**: Next Gen Retail Intelligence  
- **NGMAP**: MAP Next Generation
- **IV2**: Digital Shelf Intelligence
- **MATCH**: Polaris Matching
- **ORCH**: Orchestration
- **EXT**: Extraction
- **SPE**: SaaS Platform East
- **EP**: Enterprise Platform
- **DATA**: Data Platform
- **VP**: Vision Prix

## Story Format Quality Criteria

Before applying INVEST principles, evaluate story format fundamentals:

### User Story Format (1-5 points - Wiser Standard)
Stories should follow the Wiser Solutions standard form: **"As a [specific user role], I need to [specific action or capability] so that I can [specific business value or benefit]"**

- **5**: Perfect format with clear, specific role, action, and value statement
- **4**: Follows format with minor clarity issues in one element
- **3**: Has all three elements but format could be more specific
- **2**: Missing or vague value statement ("so that" clause)
- **1**: Only has action, missing role or value, or very poor format

### Value Statement (1-5 points - Wiser Standard)
The "so that I can" clause should articulate clear business or user value:

- **5**: Quantifiable value with clear business impact (e.g., "reduce processing time by 50%")
- **4**: Clear value tied to user outcome or business goal
- **3**: General value statement present but could be more specific
- **2**: Vague value statement (e.g., "so that it works better")
- **1**: Value implied but not explicitly stated or completely unclear benefit

### Definition of Done (1-5 points - Wiser Standard)
Stories must have explicit, verifiable completion criteria:

- **5**: Comprehensive DoD with specific, measurable exit criteria
- **4**: Good DoD covering functional, testing, and documentation requirements
- **3**: Basic DoD present with main completion criteria
- **2**: Partial DoD with some criteria missing or vague
- **1**: Minimal DoD that doesn't fully define completion

### Acceptance Criteria Format (1-5 points - Wiser Standard)
Stories should use Gherkin format (Given/When/Then) for testable acceptance criteria per Wiser standard:

- **5**: All criteria in proper Gherkin format covering happy path and edge cases
- **4**: Most criteria in Gherkin format with good scenario coverage
- **3**: Some Gherkin format used but inconsistent or incomplete
- **2**: Basic acceptance criteria present but not in Gherkin format
- **1**: Vague acceptance criteria that are hard to test or completely untestable statements

**Why Gherkin scores higher**: Gherkin syntax directly translates to automated tests, reduces ambiguity, and provides executable specifications that both technical and non-technical stakeholders can understand.

## INVEST Scoring Criteria (Wiser Standard)

Each story is evaluated against the six INVEST principles on a scale of 1-5 per Wiser Solutions standard:

**Scoring Scale:**
- **5**: Excellent - Fully meets the criterion with no concerns
- **4**: Good - Meets the criterion with minor areas for improvement
- **3**: Acceptable - Meets basic requirements but has notable gaps
- **2**: Poor - Partially meets the criterion with significant issues
- **1**: Failing - Does not meet the criterion, requires major rework

**Target Performance**: Stories should average **3.5-4.0** across all INVEST criteria

### Independent (I) - 1-5 points (Wiser Standard)
- **5**: Story can be developed completely independently
- **4**: Dependencies on other stories in the same sprint do not jeopardize completion
- **3**: Some dependencies but can be developed in any order with coordination
- **2**: Significant dependencies that may impact timing or require careful sequencing
- **1**: Major dependencies that make independent development very difficult

### Negotiable (N) - 1-5 points (Wiser Standard)
- **5**: Implementation approach and details are highly flexible and collaborative
- **4**: Most aspects negotiable with some fixed business requirements
- **3**: Balanced mix of fixed requirements and flexible implementation
- **2**: Limited flexibility due to technical or regulatory constraints
- **1**: Very rigid requirements with minimal room for developer input

### Valuable (V) - 1-5 points (Wiser Standard)
- **5**: Clear, quantifiable business value with specific metrics and user impact
- **4**: Well-articulated business value that connects to business objectives
- **3**: Moderate business value that is reasonably clear to stakeholders
- **2**: Limited or unclear business value proposition
- **1**: Minimal business value or poorly articulated benefits

### Estimable (E) - 1-5 points (Wiser Standard)
- **5**: Story is crystal clear and team can confidently estimate effort
- **4**: Story is well-defined with only minor clarifications needed
- **3**: Story is generally clear but has some ambiguous aspects
- **2**: Story has significant unclear areas that complicate estimation
- **1**: Story is poorly defined making estimation very difficult

### Small (S) - 1-5 points (Wiser Standard)
- **5**: Story is appropriately sized for single sprint completion (1-3 points)
- **4**: Story is well-sized with clear scope boundaries (3-5 points)
- **3**: Story is moderately sized but manageable within sprint (5-8 points)
- **2**: Story is large but could fit in sprint with risk (8+ points)
- **1**: Story is too large for single sprint and should be broken down

### Testable (T) - 1-5 points (Wiser Standard)
**Gherkin syntax (Given/When/Then) is required per Wiser standard:**
- **5**: Comprehensive, specific acceptance criteria using Gherkin syntax
- **4**: Clear acceptance criteria that cover main scenarios and edge cases
- **3**: Adequate acceptance criteria with some gaps in edge case coverage
- **2**: Basic acceptance criteria but missing important test scenarios
- **1**: Vague or incomplete acceptance criteria that are hard to verify
- **1**: Minimal or unclear acceptance criteria
- **0**: No acceptance criteria or completely untestable

**Gherkin Example for Maximum Score:**
```gherkin
Scenario: User successfully completes checkout
  Given a logged-in user with items in cart
  When the user clicks "Complete Purchase"
  Then the order should be created
  And the user should see a confirmation message
  And inventory should be decremented
```

## Step 1: Request Sprint Information
Ask the user for:
- Sprint identifier (e.g., "7511", "Sprint 2024.12", or "active" for current active sprint)
- Optional: Specific teams to analyze (default: all teams)

## Step 2: Fetch Stories for Each Project Individually
// turbo
**IMPORTANT**: Process each project one at a time to ensure complete data retrieval and proper error handling.

For each target project in sequence (NGPI, NGRI, NGMAP, IV2, MATCH, ORCH, EXT, SPE, EP, DATA, VP):

1. **Identify the sprint**:
   - If sprint is "active", fetch the active sprint for the specific project
   - Otherwise, use the provided sprint identifier

2. **Fetch ALL stories from the sprint** using JQL that explicitly includes ALL statuses:
   ```
   project=[PROJECT_KEY] AND sprint=[SPRINT_ID] AND issuetype=Story
   ```
   **Note**: This query retrieves stories in ALL statuses including:
   - To Do / Open / Backlog
   - In Progress / In Development
   - In Review / Code Review
   - Done / Closed / Completed

   If the Jira instance filters by default, use explicit status inclusion:
   ```
   project=[PROJECT_KEY] AND sprint=[SPRINT_ID] AND issuetype=Story AND status in ("To Do", "In Progress", "In Review", "Done", "Closed")
   ```
   Or use the broader approach to capture all possible statuses:
   ```
   project=[PROJECT_KEY] AND sprint=[SPRINT_ID] AND issuetype=Story AND status was in (Open, "To Do", "In Progress", "In Review", Done, Closed, Completed) DURING (startOfSprint(), endOfSprint())
   ```

3. **Retrieve full story details** including:
   - Summary and description
   - Acceptance criteria (customfield_10058)
   - Story points estimate (customfield_10016)
   - **Status** (critical for tracking Done stories)
   - Assignee
   - Labels and components
   - Resolution (for completed stories)

4. **Log project results** before moving to next project:
   - Record total stories found
   - Record count by status (especially Done count)
   - Note any retrieval errors

5. **Handle edge cases**:
   - Teams with no stories in the sprint
   - API rate limits between project queries
   - Projects where sprint doesn't exist

## Step 3: Analyze Stories Against Quality Criteria
For each story in each team:

### Story Format Quality Analysis
1. **User Story Format**: Check for "As a [role], I need to [action] so that [benefit]" structure
2. **Value Statement**: Evaluate the "so that" clause for clear business/user value
3. **Definition of Done**: Verify explicit, verifiable completion criteria exist
4. **Acceptance Criteria Format**: Check for Gherkin syntax (Given/When/Then) - award higher scores for Gherkin usage

### INVEST Criteria Analysis
1. **Independent Analysis**: Check dependencies and development isolation
2. **Negotiable Analysis**: Evaluate requirement flexibility
3. **Valuable Analysis**: Assess business value articulation (cross-reference with Value Statement score)
4. **Estimable Analysis**: Review clarity and estimation feasibility
5. **Small Analysis**: Evaluate story size and scope
6. **Testable Analysis**: Review acceptance criteria quality - **prioritize Gherkin syntax** for higher scores

Assign scores (0-5) for each criterion with detailed reasoning.

### Gherkin Detection Rules
When analyzing acceptance criteria, look for:
- **Given**: Preconditions or initial context
- **When**: Action or trigger event
- **Then**: Expected outcome or result
- **And/But**: Additional conditions or outcomes

Stories with properly formatted Gherkin scenarios should receive bonus consideration in both:
- Acceptance Criteria Format score (Story Format Quality)
- Testable (T) score (INVEST)

## Step 4: Calculate Team-Level Statistics
For each team, calculate comprehensive statistics:

### Story Format Quality Statistics
For each criterion (User Story Format, Value Statement, Definition of Done, Gherkin/AC Format), calculate:
- **Mean**: Average score across all team stories
- **Median**: Middle value when scores are sorted
- **Standard Deviation**: Measure of score variability
- **Min/Max/Range**: Score distribution metrics

### Gherkin Adoption Metrics
Track Gherkin syntax usage:
- **Full Gherkin**: Stories with complete Given/When/Then scenarios
- **Partial Gherkin**: Stories with some Gherkin elements
- **No Gherkin**: Stories without any Gherkin syntax
- **Adoption Rate**: Percentage of stories using any Gherkin

### Individual INVEST Criterion Statistics
For each criterion (I, N, V, E, S, T), calculate:
- **Mean**: Average score across all team stories
- **Median**: Middle value when scores are sorted
- **Standard Deviation**: Measure of score variability and consistency
- **Min**: Lowest score in the team
- **Max**: Highest score in the team
- **Range**: Difference between max and min

### Combined Score Statistics
For the overall INVEST scores (percentages), calculate:
- **Mean Overall Score**: Average INVEST score for the team
- **Median Overall Score**: Middle overall score
- **Standard Deviation**: Overall score consistency
- **Min/Max/Range**: Score distribution metrics

### Team Quality Metrics
- **Story Count**: Total stories analyzed
- **Status Breakdown**: Count of stories by status (To Do, In Progress, In Review, Done)
- **Completion Rate**: Percentage of stories in Done status
- **Quality Distribution**: Count of excellent/good/fair/poor stories
- **Team Grade**: A/B/C/D based on mean performance
- **Consistency Rating**: High/Moderate/Low based on standard deviation

## Step 5: Calculate Cross-Team Statistics
Aggregate statistics across all teams:

### Overall Engineering Statistics
- **Cross-Team Averages**: Mean of team means for each criterion
- **Best Performing Teams**: Teams with highest scores per criterion
- **Most Consistent Teams**: Teams with lowest standard deviation
- **Engineering-Wide Trends**: Overall quality patterns

### Comparative Analysis
- **Team Rankings**: Rank teams by overall INVEST score
- **Criterion Leaders**: Which teams excel in each INVEST area
- **Improvement Opportunities**: Teams with lowest scores needing support

## Step 6: Generate Comprehensive KPI Report

### Executive Summary
- **Sprint Overview**: Sprint identifier and analysis date
- **Teams Analyzed**: Number of teams and total stories (all statuses including Done)
- **Sprint Progress**: Overall completion rate across all teams
- **Overall Engineering Grade**: Aggregate quality assessment
- **Key Findings**: Top 3 insights from the analysis

### Team Performance Dashboard

#### Team Summary Table
| Team | Stories | Done | Completion | Mean Score | Grade | Format | Value | DoD | Gherkin | I | N | V | E | S | T | Consistency |
|------|---------|------|------------|------------|-------|--------|-------|-----|---------|---|---|---|---|---|---|-------------|
| NGPI | X | X | XX% | XX.X% | A/B/C/D | X.X | X.X | X.X | X.X | X.X | X.X | X.X | X.X | X.X | X.X | High/Med/Low |
| NGRI | X | X | XX% | XX.X% | A/B/C/D | X.X | X.X | X.X | X.X | X.X | X.X | X.X | X.X | X.X | X.X | High/Med/Low |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

**Column Legend:**
- **Stories**: Total stories in sprint (all statuses)
- **Done**: Number of stories in Done/Closed status
- **Completion**: Percentage of sprint stories completed (Done/Total)
- **Format**: User Story Format score (As a/I need/So that)
- **Value**: Value Statement clarity score
- **DoD**: Definition of Done completeness
- **Gherkin**: Acceptance Criteria Format (Gherkin syntax usage)
- **I/N/V/E/S/T**: INVEST criteria scores

#### Detailed Team Statistics
For each team, provide:

**Team Name (Project Key)**
- **Stories Analyzed**: X stories (all statuses in sprint)
- **Status Distribution**:
  - To Do / Open: X stories (XX%)
  - In Progress: X stories (XX%)
  - In Review: X stories (XX%)
  - **Done / Closed: X stories (XX%)**
- **Sprint Completion Rate**: XX%
- **Overall Score**: XX.X% (Grade: A/B/C/D)
- **Quality Distribution**:
  - Excellent (90-100%): X stories (XX%)
  - Good (80-89%): X stories (XX%)
  - Fair (70-79%): X stories (XX%)
  - Poor (<70%): X stories (XX%)

**Story Format Quality Performance**:
| Criterion | Mean | Median | Std Dev | Min | Max | Range |
|-----------|------|--------|---------|-----|-----|-------|
| User Story Format | X.X | X.X | X.X | X | X | X |
| Value Statement | X.X | X.X | X.X | X | X | X |
| Definition of Done | X.X | X.X | X.X | X | X | X |
| Gherkin/AC Format | X.X | X.X | X.X | X | X | X |

**Gherkin Adoption Metrics**:
- Stories with full Gherkin syntax: X (XX%)
- Stories with partial Gherkin: X (XX%)
- Stories without Gherkin: X (XX%)

**INVEST Criteria Performance**:
| Criterion | Mean | Median | Std Dev | Min | Max | Range |
|-----------|------|--------|---------|-----|-----|-------|
| Independent (I) | X.X | X.X | X.X | X | X | X |
| Negotiable (N) | X.X | X.X | X.X | X | X | X |
| Valuable (V) | X.X | X.X | X.X | X | X | X |
| Estimable (E) | X.X | X.X | X.X | X | X | X |
| Small (S) | X.X | X.X | X.X | X | X | X |
| Testable (T) | X.X | X.X | X.X | X | X | X |

### Cross-Team Analysis

#### Sprint Completion by Team
| Team | Total Stories | Done | In Progress | To Do | Completion Rate |
|------|---------------|------|-------------|-------|-----------------|
| NGPI | X | X | X | X | XX% |
| NGRI | X | X | X | X | XX% |
| ... | ... | ... | ... | ... | ... |
| **Total** | **X** | **X** | **X** | **X** | **XX%** |

#### Engineering-Wide Story Format Statistics
| Criterion | Best Team | Worst Team | Eng Avg | Std Dev | Range |
|-----------|-----------|------------|---------|---------|-------|
| User Story Format | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Value Statement | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Definition of Done | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Gherkin/AC Format | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |

#### Gherkin Adoption by Team
| Team | Full Gherkin | Partial | None | Adoption Rate |
|------|--------------|---------|------|---------------|
| NGPI | X | X | X | XX% |
| ... | ... | ... | ... | ... |

#### Engineering-Wide INVEST Statistics
| Criterion | Best Team | Worst Team | Eng Avg | Std Dev | Range |
|-----------|-----------|------------|---------|---------|-------|
| Independent (I) | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Negotiable (N) | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Valuable (V) | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Estimable (E) | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Small (S) | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |
| Testable (T) | TEAM (X.X) | TEAM (X.X) | X.X | X.X | X.X |

#### Team Rankings
1. **[Team]**: XX.X% (Grade A) - [Key strength]
2. **[Team]**: XX.X% (Grade B) - [Key strength]
3. **[Team]**: XX.X% (Grade B) - [Key strength]
...

### Insights and Recommendations

#### Engineering-Wide Strengths
- **Best Performing Criterion**: [Criterion] - Average: X.X/5
- **Most Consistent Teams**: [Teams with low std dev]
- **Quality Leaders**: [Teams with highest overall scores]
- **Gherkin Champions**: [Teams with highest Gherkin adoption]

#### Areas for Improvement
- **Lowest Performing Criterion**: [Criterion] - Average: X.X/5
- **High Variability Areas**: [Criteria with high cross-team std dev]
- **Teams Needing Support**: [Teams with lowest scores]
- **Story Format Gaps**: [Teams with poor "As a/I need/So that" adherence]
- **Gherkin Adoption Lag**: [Teams with low Gherkin usage]

#### Strategic Recommendations
- **Training Priorities**: Based on lowest-scoring criteria
- **Best Practice Sharing**: Leverage high-performing teams
- **Process Improvements**: Address systemic quality issues
- **Team Support**: Targeted assistance for struggling teams
- **Story Writing Workshop**: Focus on "As a [role], I need to [action] so that [benefit]" format
- **Gherkin Training**: Increase adoption of Given/When/Then acceptance criteria
- **Value Statement Coaching**: Help teams articulate clear business value in stories
- **Definition of Done Standards**: Establish team-wide DoD templates

## Step 7: Generate Trend Analysis (if historical data available)
If previous sprint data exists:
- **Sprint-over-Sprint Trends**: Compare current vs previous performance
- **Team Improvement Trajectories**: Track team progress over time
- **Engineering Quality Trends**: Overall quality direction

## Step 8: Save KPI Results
1. Create comprehensive report file: `story-quality-kpis-[sprint]-[date].md`
2. Save team-level data in structured format for trend analysis
3. Export summary statistics for dashboard integration
4. Store historical data for future trend analysis

## Quality Thresholds (Wiser Standards)
- **Excellent**: 90-100% - Stories are exemplary and ready for development
- **Good**: 80-89% - Stories are solid with minor improvements needed
- **Fair**: 70-79% - Stories are acceptable but have improvement opportunities
- **Poor**: <70% - Stories need significant work before development

## Team Grading Scale
- **Grade A** (4.0-5.0 mean): Excellent team performance, ready for advanced practices
- **Grade B** (3.0-3.9 mean): Good team performance, minor improvements needed
- **Grade C** (2.0-2.9 mean): Fair team performance, focused improvement required
- **Grade D** (Below 2.0 mean): Poor team performance, significant training needed

## Success Metrics
- **Coverage**: All target teams analyzed with complete statistical analysis
- **Statistical Accuracy**: Comprehensive metrics calculated correctly
- **Story Format Compliance**: Track "As a/I need/So that" format adherence
- **Gherkin Adoption**: Monitor Given/When/Then acceptance criteria usage
- **Value Clarity**: Measure quality of value statements in stories
- **DoD Completeness**: Ensure Definition of Done standards are met
- **Actionable Insights**: Clear recommendations for engineering leadership
- **Trend Capability**: Data format suitable for historical tracking
- **Efficiency**: Analysis completed in 20-30 minutes for all teams

## Integration Notes
- Uses Jira MCP integration for story retrieval across all projects
- Leverages Wiser's agile rules and INVEST principles
- Compatible with existing invest-score workflow for individual team analysis
- Report format optimized for engineering leadership and team retrospectives
- Data structure suitable for integration with engineering dashboards