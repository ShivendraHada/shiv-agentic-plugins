---
description: Transform quick notes and ideas into comprehensive epics or stories following Wiser's INVEST principles and agile standards
argument-hint: <project key and rough notes about the work item, e.g. "STACK - need a new user dashboard with filtering">
---

# Notes to Work Item Workflow

Transform quick notes and ideas into comprehensive epics or stories that follow Wiser's INVEST principles and agile standards.

## User Input

```text
$ARGUMENTS
```

Use the input above as quick notes to transform. If empty, ask for:
- **Project Key** (e.g., "STACK", "NGRI", "DATA", "MOBILE")
- Notes or ideas about the work item

## Workflow Steps

### Step 1: Project Information
Ask the user for:
- **Project Key** (e.g., "STACK", "NGRI", "DATA", "MOBILE")
- Confirm the project exists and is accessible

### Step 2: Work Item Type Determination
Ask the user:
- **"Is this an Epic or a Story?"**
- If unsure, help them decide based on scope:
  - **Epic**: Large feature or initiative that spans multiple sprints and can be broken into stories
  - **Story**: Specific functionality that can be completed in one sprint (1-3 days of work)

### Step 3: Epic Context (Stories Only)
If creating a Story:
- **Ask for the parent Epic key** (e.g., "STACK-123")
- If no epic exists, suggest creating the epic first
- Verify the epic exists and is accessible

### Step 4: Supporting Documentation
Ask if there are additional documents that would help with context:
- **IDEA documents** (problem statements, user needs)
- **W3D+ documents** (detailed product briefs)
- **Technical design documents**
- **Confluence pages** (URLs or page IDs)
- **Requirements documents**
- **User research or feedback**
- **Existing related work items**

If documents are provided:
- Read and analyze the content
- Extract relevant information for the work item
- Use the context to enhance the generated content

### Step 5: Gather Quick Notes
Ask the user to provide quick notes outlining the work item:
- **Problem or opportunity** being addressed
- **High-level solution approach**
- **Target users or stakeholders**
- **Expected business value**
- **Any constraints or dependencies**
- **Success criteria or acceptance conditions**

Accept any format: bullet points, paragraphs, rough ideas, or structured notes.

### Step 6: Generate Work Item Using Wiser's Rules

#### For Epics:
- Apply **SMART principles** (Specific, Measurable, Achievable, Relevant, Time-bound)
- Evaluate for **smallest valuable increment** breakdown potential
- Create comprehensive epic following standard guidelines
- Include business value, success metrics, and breakdown suggestions

#### For Stories:
- Apply **INVEST principles** (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- Follow story creation guidelines for smallest valuable increments
- Create **concise, actionable title** that summarizes the story without full user story format
- Structure description with proper user story format: "**As a** [user] **I want** [capability] **So that** [value]"
- Generate comprehensive **Gherkin acceptance criteria** covering:
  - Happy path scenarios
  - Edge cases
  - Error handling
- Include Definition of Done checklist with Jira-friendly formatting
- Use proper section formatting (*Business Value*, *Technical Considerations*, etc.)

### Step 7: User Review and Editing
Present the generated work item and ask:
- **"Would you like to make any changes to this [epic/story]?"**
- **"Are there any sections you'd like to modify or enhance?"**
- **"Should we add more details to any particular area?"**

Allow the user to:
- Edit specific sections
- Add more acceptance criteria
- Refine the business value statement
- Adjust scope or requirements
- Add technical considerations

### Step 8: Quality Analysis
Before committing, re-analyze the work item for quality:

#### For Epics - SMART Analysis:
- **Specific**: Is the epic clearly defined with concrete objectives?
- **Measurable**: Are there clear success metrics and indicators?
- **Achievable**: Is it realistic with available resources?
- **Relevant**: Does it align with business goals and provide clear value?
- **Time-bound**: Is there a reasonable timeframe for completion?

#### For Stories - INVEST Analysis:
- **Independent**: Can it be developed separately from other stories?
- **Negotiable**: Are details flexible and can be refined?
- **Valuable**: Does it deliver clear value to users or stakeholders?
- **Estimable**: Can the team reasonably estimate the effort?
- **Small**: Can it be completed within a few days, not weeks?
- **Testable**: Are acceptance criteria clear and verifiable?

Present the analysis results and ask:
- **"Based on the quality analysis, would you like to make any improvements?"**
- Highlight any areas that don't meet the standards
- Suggest specific improvements if needed

### Step 9: Epic Breakdown Suggestions (Epics Only)
If creating an Epic, ask:
- **"Would you like a report with suggestions for breaking this epic down into stories?"**

If yes, generate a breakdown report including:
- Suggested story slices using techniques:
  - Split by workflow steps
  - Split by user roles
  - Split by happy path vs. edge cases
  - Split by data variations
  - Split by operations (CRUD)
  - Split by interface (API vs. UI)
- Prioritization suggestions based on dependencies and value
- Estimated story sizes and sprint planning considerations

### Step 10: Jira Commitment
When the user is ready to commit:
- **"Are you ready to create this [epic/story] in Jira?"**
- Confirm all details are correct
- Create the work item in Jira using appropriate MCP integration

#### For Epics:
```
Use jira_create_issue with:
- project_key: [PROJECT_KEY]
- summary: [Concise Epic Title - avoid long "As a..." format in title]
- issue_type: "Epic"
- description: [Start with "As a... I want... So that..." format, followed by enhanced content]
```

#### For Stories:
```
Use jira_create_issue with:
- project_key: [PROJECT_KEY]
- summary: [Concise Story Title - avoid long "As a..." format in title]
- issue_type: "Story"
- description: [Start with "**As a** [user] **I want** [capability] **So that** [value]" format]
- additional_fields: {
  "customfield_10058": [Gherkin Acceptance Criteria],
  "parent": [Epic Key if applicable],
  "labels": ["notes-to-work-item"]
}
```

### Jira Description Formatting Guidelines:
- **User Story Format**: Start description with "**As a** [user] **I want** [capability] **So that** [value]"
- **Section Headers**: Use *italics* format (*Business Value*, *Definition of Done*, etc.)
- **Bullet Points**: Use bullet points instead of markdown checkboxes
- **Avoid**: Complex markdown formatting that doesn't render well in Jira
- **Structure**: Keep sections clean and readable in Jira's interface

### Step 11: Confirmation and Next Steps
After successful creation:
- Provide the new Jira ticket key
- Add "notes-to-work-item" label for tracking
- Ask if the user wants to:
  - Create additional related work items
  - Generate story breakdown for epics
  - Set up dependencies or links
  - Add the item to a specific sprint

## Success Criteria

- Work item follows Wiser's agile standards (SMART for epics, INVEST for stories)
- Comprehensive acceptance criteria with Gherkin scenarios (for stories)
- Clear business value and user focus
- Proper integration with existing epics and project structure
- Quality analysis ensures high standards before Jira creation
- Seamless transformation from rough notes to production-ready work items

## Expected Outcomes

- High-quality epics and stories created from minimal input
- Consistent application of Wiser's agile principles
- Reduced time from idea to actionable work item
- Better story breakdown and sprint planning
- Improved team productivity through well-defined work items

## Next Steps

After creating a work item from notes, consider these related commands:
- `/create-story` - Create additional stories for an epic that was just created
- `/create-epic` - Create a parent epic if one was needed but didn't exist
- `/create-technical-enablement-story` - Create technical enablement stories for infrastructure needs identified in the notes
- `/story-invest-score` - Score the newly created story against INVEST criteria for quality validation
- `/auto-groom` - Groom the entire sprint after adding new work items
