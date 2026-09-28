---
description: Create high-quality Epics following Shiv Solutions SMART criteria and standard templates
argument-hint: <epic title or description of the business problem/opportunity>
---

# Create Epic Workflow

Create high-quality Epics following Shiv Solutions SMART criteria and standard templates (Confluence Page ID: 4660658177).

## User Input

```text
$ARGUMENTS
```

Consider the user input above when creating the epic. If empty, ask for the epic details.

## Epic Definition (Shiv Standard)

An Epic is a large body of work that delivers significant business value and typically requires multiple sprints to complete. Epics represent strategic initiatives that align with business objectives and can be broken down into multiple User Stories.

## Epic Quality Requirements

1. **Duration**: Should not exceed 12 weeks, ideally 6-8 weeks
2. **Story Breakdown**: Must be decomposable into multiple User Stories
3. **Dependencies**: All external dependencies clearly identified
4. **Acceptance Criteria**: High-level criteria that define epic completion
5. **Business Value**: Quantified impact on users, revenue, or operational efficiency
6. **SMART Compliance**: Must meet all SMART criteria before sprint planning

## Workflow Steps

### Step 1: Epic Information Gathering

Collect the following information:

**Basic Epic Information:**
- Epic title (clear and concise)
- Business problem or opportunity being addressed
- Target users or stakeholders
- High-level solution approach
- Expected business outcomes

**Strategic Context:**
- How does this align with company/product strategy?
- What business metrics will this impact?
- Who are the key stakeholders?
- What is the priority relative to other initiatives?

**Scope and Constraints:**
- What is included in this epic?
- What is explicitly excluded?
- What are the key constraints (time, budget, resources)?
- What dependencies exist?

### Step 2: SMART Criteria Validation

Create the epic using the Shiv Solutions SMART template:

#### **S - Specific**
**Requirement**: Epic must clearly define what will be accomplished

**Complete these elements:**
- Clear problem statement or opportunity
- Defined scope and boundaries
- Identified target users or stakeholders
- Explicit success criteria

**Quality Check Questions:**
- Is the epic objective concrete and well-defined?
- Are the boundaries clear (what's in/out of scope)?
- Are target users specifically identified?
- Can someone unfamiliar with the project understand what will be accomplished?

#### **M - Measurable**
**Requirement**: Epic must include quantifiable success metrics

**Complete these elements:**
- Specific KPIs or metrics defined
- Baseline measurements established
- Target improvements quantified
- Success criteria can be objectively verified

**Quality Check Questions:**
- Can success be measured objectively?
- Are baseline measurements available or obtainable?
- Are target improvements specific and quantified?
- Will it be clear when the epic is successful?

#### **A - Achievable**
**Requirement**: Epic must be realistic given available resources and constraints

**Complete these elements:**
- Resource requirements assessed (team size, skills, timeline)
- Technical feasibility validated
- Dependencies identified and manageable
- Timeline is realistic for scope

**Quality Check Questions:**
- Is the epic realistic given available resources?
- Has technical feasibility been validated?
- Are dependencies identified and manageable?
- Is the timeline realistic for the scope?

#### **R - Relevant**
**Requirement**: Epic must align with business strategy and deliver meaningful value

**Complete these elements:**
- Clear business justification
- Alignment with company/product strategy
- Stakeholder value articulated
- Priority relative to other initiatives established

**Quality Check Questions:**
- Does this epic align with business strategy?
- Is the business value clear and meaningful?
- Do stakeholders understand and support the value?
- Is the priority appropriate relative to other work?

#### **T - Time-bound**
**Requirement**: Epic must have defined timeline using Target start and Target end date fields

**Complete these elements:**
- Target start date specified in epic fields
- Target end date specified in epic fields
- Key milestones identified between start and end dates
- Sprint allocation estimated based on timeline
- Regular review checkpoints defined

**Quality Check Questions:**
- Are start and end dates realistic and specific?
- Are key milestones identified?
- Is sprint allocation estimated?
- Are review checkpoints planned?

### Step 3: Epic Template Creation

Use the Shiv Solutions Epic template structure:

```markdown
# Epic: [Epic Title]

## Epic Statement
As [Shiv organization/team], we need [epic capability] so that we can [strategic business outcome].

## Business Justification
[Clear articulation of the business problem, opportunity, and strategic alignment]

## Success Criteria (SMART)

### Specific
- [ ] [Clear scope and boundaries]
- [ ] [Target users identified]
- [ ] [Success criteria defined]

### Measurable
- **Baseline**: [Current state measurements]
- **Target**: [Quantified improvement goals]
- **KPIs**: [Specific metrics to track]

### Achievable
- **Resources Required**: [Team size, skills, timeline]
- **Technical Feasibility**: [Confirmed/assessed]
- **Risk Assessment**: [High/Medium/Low with mitigation]

### Relevant
- **Business Alignment**: [Connection to strategy]
- **User Value**: [Specific user benefits]
- **Priority**: [High/Medium/Low with justification]

### Time-bound
- **Target Start Date**: [Date in epic field]
- **Target End Date**: [Date in epic field]
- **Sprint Allocation**: [Number of sprints estimated]
- **Key Milestones**:
  - [ ] [Milestone 1] - [Date]
  - [ ] [Milestone 2] - [Date]
  - [ ] [Final delivery] - [Target end date]

## Acceptance Criteria
[High-level criteria that define epic completion]

## Dependencies
[All external dependencies clearly identified]

## Assumptions
[Key assumptions made during epic creation]

## Risks and Mitigations
[Potential risks and mitigation strategies]
```

### Step 4: Epic Quality Validation

#### Epic Quality Checklist
- Epic follows SMART criteria (all 5 elements present and complete)
- Business value clearly articulated and quantifiable
- Success metrics are specific and measurable
- Timeline is realistic and specific (6-12 weeks max)
- Dependencies identified and manageable
- Can be broken down into 5-15 user stories
- Aligns with business strategy
- Target start and end dates specified in epic fields
- Key milestones identified
- Acceptance criteria define epic completion
- Risk assessment completed

#### SMART Compliance Check
Rate each SMART criterion (1-5 scale):

**Specific**: [1-5] - Is the epic clearly defined?
**Measurable**: [1-5] - Are success metrics quantifiable?
**Achievable**: [1-5] - Is it realistic given resources?
**Relevant**: [1-5] - Does it align with business strategy?
**Time-bound**: [1-5] - Are timelines specific and realistic?

**Overall SMART Score**: [Total]/25 ([Percentage]%)

**Quality Threshold**: Epic should score >=20 (80%) to proceed to story breakdown

### Step 5: Story Breakdown Planning

#### Story Identification
- Identify major user workflows within the epic
- Break workflows into smallest valuable increments
- Ensure each story can be completed in one sprint
- Validate stories will follow INVEST principles
- Plan story priorities and dependencies

### Step 6: Epic Finalization

#### Final Review
- All SMART criteria fully satisfied
- Epic template completely filled out
- Quality checklist items all pass
- Story breakdown approach planned
- Stakeholder review completed

## Next Steps

Once your epic is finalized, continue with these related commands:
- `/create-story` - Break this epic down into individual user stories
- `/create-technical-enablement-story` - Create technical enablement stories for infrastructure or platform work needed by this epic
- `/story-invest-score` - Score individual stories against INVEST criteria after creation
- `/story-quality-kpis` - Generate quality KPIs across teams for sprint tracking
