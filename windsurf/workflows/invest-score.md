---
description: Measure the INVEST score for the current sprint using Wiser's INVEST story criteria
auto_execution_mode: 1
---

# INVEST Score Measurement Workflow

This workflow measures the quality of stories in a sprint using Wiser's INVEST principles and generates a comprehensive score report.

## INVEST Scoring Criteria

Each story is evaluated against the six INVEST principles on a scale of 0-5:

### Independent (I) - 0-5 points
- **5**: Story can be developed completely independently with no dependencies on other stories
- **4**: Story has minimal dependencies that are clearly documented and manageable
- **3**: Story has some dependencies but they don't block development
- **2**: Story has significant dependencies that may impact development timing
- **1**: Story has major dependencies that make independent development difficult
- **0**: Story cannot be developed independently due to critical dependencies

### Negotiable (N) - 0-5 points
- **5**: Story details are flexible and can be refined through collaboration
- **4**: Most aspects are negotiable with some fixed requirements
- **3**: Some aspects are negotiable, others are fixed
- **2**: Limited negotiability due to technical or business constraints
- **1**: Very little room for negotiation
- **0**: Story is completely fixed with no room for discussion

### Valuable (V) - 0-5 points
- **5**: Clear, measurable business value that directly impacts users or business metrics
- **4**: Good business value that is well articulated
- **3**: Moderate business value that is somewhat clear
- **2**: Limited business value or unclear value proposition
- **1**: Minimal business value
- **0**: No clear business value or value statement missing

### Estimable (E) - 0-5 points
- **5**: Story is well-defined and easily estimable by the team
- **4**: Story is mostly clear with minor ambiguities
- **3**: Story has some unclear aspects but is generally estimable
- **2**: Story has significant ambiguities that make estimation difficult
- **1**: Story is poorly defined making estimation very challenging
- **0**: Story cannot be estimated due to lack of clarity or information

### Small (S) - 0-5 points
- **5**: Story can be completed in 1-2 days (smallest valuable increment)
- **4**: Story can be completed in 2-3 days
- **3**: Story can be completed in 3-5 days (within one sprint)
- **2**: Story might take 5-8 days (spans most of sprint)
- **1**: Story is large and might not fit in one sprint
- **0**: Story is too large and needs to be broken down

### Testable (T) - 0-5 points
- **5**: Comprehensive Gherkin acceptance criteria covering happy path, edge cases, and error scenarios
- **4**: Good acceptance criteria with most scenarios covered
- **3**: Basic acceptance criteria present but missing some scenarios
- **2**: Limited acceptance criteria that don't fully define done
- **1**: Minimal or unclear acceptance criteria
- **0**: No acceptance criteria or completely untestable

## Step 1: Request Sprint Information
Ask the user for:
- JIRA project key (e.g., "STACK", "DATA", "MOBILE")
- Sprint identifier (e.g., "7511", "Sprint 2024.12", or "active" for current active sprint)

## Step 2: Fetch Sprint Stories
// turbo
1. If sprint is "active", fetch the active sprint for the project
2. Otherwise, fetch all stories from the specified sprint using JQL: `project=[PROJECT_KEY] and sprint=[SPRINT_ID] and issuetype=Story`
3. Retrieve full story details including:
   - Summary and description
   - Acceptance criteria (customfield_10058)
   - Story points estimate
   - Status and assignee
   - Labels and components

## Step 3: Analyze Each Story Against INVEST Criteria
For each story in the sprint:

1. **Independent Analysis**:
   - Check for explicit dependencies in description or links
   - Analyze if story can be developed without waiting for other stories
   - Look for technical dependencies or shared components

2. **Negotiable Analysis**:
   - Evaluate if requirements are flexible vs. fixed
   - Check for business constraints or technical limitations
   - Assess room for collaborative refinement

3. **Valuable Analysis**:
   - Look for explicit business value statements
   - Check for user impact or business metrics
   - Evaluate alignment with business goals

4. **Estimable Analysis**:
   - Assess clarity of requirements and acceptance criteria
   - Check for ambiguous or missing information
   - Evaluate team's ability to size the story

5. **Small Analysis**:
   - Evaluate story size based on description and acceptance criteria
   - Check story points estimate if available
   - Assess if story represents smallest valuable increment

6. **Testable Analysis**:
   - Evaluate acceptance criteria quality and completeness
   - Check for Gherkin scenarios (Given/When/Then format)
   - Assess coverage of happy path, edge cases, and error scenarios

## Step 4: Calculate INVEST Scores
For each story:
1. Assign scores (0-5) for each INVEST criterion
2. Calculate individual story INVEST score (sum of all criteria / 30 * 100 = percentage)
3. Provide detailed reasoning for each score
4. Flag stories that score below 70% as needing improvement

## Step 5: Calculate Statistical Analysis
Perform comprehensive statistical analysis on the collected scores:

### Individual INVEST Criterion Statistics
For each criterion (I, N, V, E, S, T), calculate:
- **Mean**: Average score across all stories
- **Median**: Middle value when scores are sorted
- **Standard Deviation**: Measure of score variability and consistency

### Combined Score Statistics
For the overall INVEST scores (percentages), calculate:
- **Mean**: Average overall INVEST score for the sprint
- **Median**: Middle overall score when all story scores are sorted
- **Standard Deviation**: Measure of overall score consistency across stories

### Additional Statistical Insights
- **Range**: Minimum and maximum scores for each criterion and overall
- **Quartiles**: 25th, 50th (median), and 75th percentiles
- **Coefficient of Variation**: Standard deviation relative to mean (indicates consistency)

## Step 6: Generate Sprint INVEST Report
Create a comprehensive report including:

### Sprint Overview
- Sprint name/number and project
- Total stories analyzed
- Distribution of scores (excellent: 90-100%, good: 80-89%, fair: 70-79%, poor: <70%)

### Statistical Summary
#### Individual INVEST Criteria Statistics
Present a table with statistics for each criterion:

| Criterion | Mean | Median | Std Dev | Min | Max | Range |
|-----------|------|--------|---------|-----|-----|-------|
| Independent (I) | X.X | X.X | X.X | X | X | X |
| Negotiable (N) | X.X | X.X | X.X | X | X | X |
| Valuable (V) | X.X | X.X | X.X | X | X | X |
| Estimable (E) | X.X | X.X | X.X | X | X | X |
| Small (S) | X.X | X.X | X.X | X | X | X |
| Testable (T) | X.X | X.X | X.X | X | X | X |

#### Combined INVEST Score Statistics
- **Mean Overall Score**: XX.X% (interpretation: excellent/good/fair/poor)
- **Median Overall Score**: XX.X% 
- **Standard Deviation**: XX.X% (interpretation: high/moderate/low variability)
- **Score Range**: XX.X% - XX.X%
- **Coefficient of Variation**: XX.X% (consistency indicator)

#### Statistical Insights
- **Most Consistent Criterion**: [Criterion with lowest std dev]
- **Most Variable Criterion**: [Criterion with highest std dev]
- **Sprint Consistency**: [High/Moderate/Low based on overall std dev]
- **Quality Distribution**: [Analysis of score clustering]

### Individual Story Scores
For each story, include:
- Story key and title
- Overall INVEST score (percentage)
- Breakdown by criterion (I, N, V, E, S, T)
- Specific improvement recommendations
- Priority for improvement (high/medium/low)

### Sprint Quality Analysis
- **Strengths**: Areas where the sprint scores well (highest mean scores)
- **Improvement Areas**: INVEST criteria that need attention (lowest mean scores or highest variability)
- **Risk Assessment**: Stories that may impact sprint success (outliers or low scores)
- **Statistical Patterns**: Insights from the statistical analysis
- **Recommendations**: Specific actions to improve story quality based on statistical findings

### Quality Metrics
- **Statistical Distribution**: Normal vs. skewed distribution of scores
- **Consistency Analysis**: Teams with low standard deviation show more consistent story quality
- **Outlier Analysis**: Stories significantly above/below the mean that warrant attention
- **Trend Indicators**: Patterns that suggest systematic strengths or weaknesses
- **Benchmark Comparison**: How statistical measures compare to Wiser quality standards

## Step 7: Create Action Items
Based on the statistical analysis, generate specific action items:

1. **High Priority**: Stories scoring <60% that need immediate attention
2. **Medium Priority**: Stories scoring 60-79% that could be improved
3. **Statistical Outliers**: Stories with scores significantly outside normal range
4. **Process Improvements**: Patterns from statistical analysis indicating systematic issues
5. **Team Recommendations**: Suggestions for improving story quality based on statistical insights

## Step 8: Save Results
1. Create a markdown report file: `invest-score-[project]-[sprint]-[date].md`
2. Save detailed analysis in structured format
3. Include recommendations and action items
4. Provide summary for team review

## Statistical Interpretation Guidelines

### Standard Deviation Interpretation
- **Low (0-1.0)**: Very consistent story quality across the sprint
- **Moderate (1.0-2.0)**: Some variation but generally consistent
- **High (2.0+)**: Significant variation indicating inconsistent story quality

### Mean Score Interpretation
- **4.0-5.0**: Excellent performance in this criterion
- **3.0-3.9**: Good performance with room for improvement
- **2.0-2.9**: Fair performance, needs attention
- **Below 2.0**: Poor performance, requires immediate focus

### Coefficient of Variation (CV) Interpretation
- **CV < 25%**: High consistency
- **CV 25-50%**: Moderate consistency  
- **CV > 50%**: Low consistency, high variability

## Expected Outcomes
- **Quantitative assessment** of sprint story quality with statistical rigor
- **Statistical insights** into team consistency and patterns
- **Data-driven identification** of stories needing improvement
- **Evidence-based recommendations** for better story writing
- **Baseline statistical metrics** for tracking improvement over time
- **Risk identification** for sprint planning based on statistical outliers

## Success Metrics
- **Coverage**: All sprint stories analyzed with complete statistical analysis
- **Statistical Accuracy**: Mean, median, and standard deviation calculated correctly
- **Actionability**: Clear recommendations provided based on statistical insights
- **Efficiency**: Analysis completed in 10-15 minutes including statistical calculations
- **Value**: Statistical insights that improve team practices and consistency

## Quality Thresholds (Wiser Standards)
- **Excellent**: 90-100% - Stories are exemplary and ready for development
- **Good**: 80-89% - Stories are solid with minor improvements needed
- **Fair**: 70-79% - Stories are acceptable but have improvement opportunities
- **Poor**: <70% - Stories need significant work before development

## Integration Notes
- Uses Jira MCP integration for story retrieval
- Leverages Wiser's agile rules and INVEST principles
- Compatible with existing auto-groom workflow
- Can be run before or after grooming sessions for comparison