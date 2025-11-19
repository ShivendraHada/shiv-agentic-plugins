---
description: Generate comprehensive Story Quality KPIs across engineering teams for sprint tracking and performance monitoring
auto_execution_mode: 1
---

# Story Quality KPIs Workflow

This workflow generates comprehensive Story Quality Key Performance Indicators (KPIs) across multiple engineering teams using INVEST principles. It provides statistical analysis for tracking team performance over time and identifying improvement opportunities.

## Target Projects

This workflow analyzes the following engineering teams:
- **NGPI**: Next Gen Price Intelligence
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

## INVEST Scoring Criteria

Each story is evaluated against the six INVEST principles on a scale of 0-5:

### Independent (I) - 0-5 points
- **5**: Story can be developed completely independently
- **4**: Minimal dependencies that are clearly documented
- **3**: Some dependencies but they don't block development
- **2**: Significant dependencies that may impact timing
- **1**: Major dependencies that make independent development difficult
- **0**: Cannot be developed independently due to critical dependencies

### Negotiable (N) - 0-5 points
- **5**: Story details are flexible and can be refined through collaboration
- **4**: Most aspects are negotiable with some fixed requirements
- **3**: Some aspects are negotiable, others are fixed
- **2**: Limited negotiability due to constraints
- **1**: Very little room for negotiation
- **0**: Story is completely fixed with no room for discussion

### Valuable (V) - 0-5 points
- **5**: Clear, measurable business value that directly impacts users or metrics
- **4**: Good business value that is well articulated
- **3**: Moderate business value that is somewhat clear
- **2**: Limited business value or unclear value proposition
- **1**: Minimal business value
- **0**: No clear business value or value statement missing

### Estimable (E) - 0-5 points
- **5**: Story is well-defined and easily estimable by the team
- **4**: Story is mostly clear with minor ambiguities
- **3**: Story has some unclear aspects but is generally estimable
- **2**: Story has significant ambiguities making estimation difficult
- **1**: Story is poorly defined making estimation very challenging
- **0**: Story cannot be estimated due to lack of clarity

### Small (S) - 0-5 points
- **5**: Story can be completed in 1-2 days (smallest valuable increment)
- **4**: Story can be completed in 2-3 days
- **3**: Story can be completed in 3-5 days (within one sprint)
- **2**: Story might take 5-8 days (spans most of sprint)
- **1**: Story is large and might not fit in one sprint
- **0**: Story is too large and needs to be broken down

### Testable (T) - 0-5 points
- **5**: Comprehensive Gherkin acceptance criteria covering all scenarios
- **4**: Good acceptance criteria with most scenarios covered
- **3**: Basic acceptance criteria present but missing some scenarios
- **2**: Limited acceptance criteria that don't fully define done
- **1**: Minimal or unclear acceptance criteria
- **0**: No acceptance criteria or completely untestable

## Step 1: Request Sprint Information
Ask the user for:
- Sprint identifier (e.g., "7511", "Sprint 2024.12", or "active" for current active sprint)
- Optional: Specific teams to analyze (default: all teams)

## Step 2: Fetch Stories for All Teams
// turbo
For each target project (NGPI, NGRI, NGMAP, IV2, MATCH, ORCH, EXT, SPE, EP, DATA, VP):

1. If sprint is "active", fetch the active sprint for the project
2. Otherwise, fetch all stories from the specified sprint using JQL: `project=[PROJECT_KEY] and sprint=[SPRINT_ID] and issuetype=Story`
3. Retrieve full story details including:
   - Summary and description
   - Acceptance criteria (customfield_10058)
   - Story points estimate (customfield_10016)
   - Status and assignee
   - Labels and components
4. Handle cases where teams have no stories in the sprint

## Step 3: Analyze Stories Against INVEST Criteria
For each story in each team:

1. **Independent Analysis**: Check dependencies and development isolation
2. **Negotiable Analysis**: Evaluate requirement flexibility
3. **Valuable Analysis**: Assess business value articulation
4. **Estimable Analysis**: Review clarity and estimation feasibility
5. **Small Analysis**: Evaluate story size and scope
6. **Testable Analysis**: Review acceptance criteria quality and completeness

Assign scores (0-5) for each INVEST criterion with detailed reasoning.

## Step 4: Calculate Team-Level Statistics
For each team, calculate comprehensive statistics:

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
- **Teams Analyzed**: Number of teams and total stories
- **Overall Engineering Grade**: Aggregate quality assessment
- **Key Findings**: Top 3 insights from the analysis

### Team Performance Dashboard

#### Team Summary Table
| Team | Stories | Mean Score | Grade | I | N | V | E | S | T | Consistency |
|------|---------|------------|-------|---|---|---|---|---|---|-------------|
| NGPI | X | XX.X% | A/B/C/D | X.X | X.X | X.X | X.X | X.X | X.X | High/Med/Low |
| NGRI | X | XX.X% | A/B/C/D | X.X | X.X | X.X | X.X | X.X | X.X | High/Med/Low |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

#### Detailed Team Statistics
For each team, provide:

**Team Name (Project Key)**
- **Stories Analyzed**: X stories
- **Overall Score**: XX.X% (Grade: A/B/C/D)
- **Quality Distribution**: 
  - Excellent (90-100%): X stories (XX%)
  - Good (80-89%): X stories (XX%)
  - Fair (70-79%): X stories (XX%)
  - Poor (<70%): X stories (XX%)

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

#### Engineering-Wide Statistics
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

#### Areas for Improvement
- **Lowest Performing Criterion**: [Criterion] - Average: X.X/5
- **High Variability Areas**: [Criteria with high cross-team std dev]
- **Teams Needing Support**: [Teams with lowest scores]

#### Strategic Recommendations
- **Training Priorities**: Based on lowest-scoring criteria
- **Best Practice Sharing**: Leverage high-performing teams
- **Process Improvements**: Address systemic quality issues
- **Team Support**: Targeted assistance for struggling teams

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
- **Actionable Insights**: Clear recommendations for engineering leadership
- **Trend Capability**: Data format suitable for historical tracking
- **Efficiency**: Analysis completed in 20-30 minutes for all teams

## Integration Notes
- Uses Jira MCP integration for story retrieval across all projects
- Leverages Wiser's agile rules and INVEST principles
- Compatible with existing invest-score workflow for individual team analysis
- Report format optimized for engineering leadership and team retrospectives
- Data structure suitable for integration with engineering dashboards