---
description: Automatically groom all stories in a sprint following Wiser's agile rules and INVEST principles
argument-hint: <JIRA sprint number and project key, e.g. "7511 STACK" or "Sprint 2024.12 DATA">
---

# Auto-Groom Sprint Workflow

Automatically groom all stories in a sprint following Wiser's agile rules and INVEST principles.

## User Input

```text
$ARGUMENTS
```

Use the input above for sprint information. If not provided, ask for:
- JIRA sprint number (e.g., "7511" or "Sprint 2024.12")
- Project key (e.g., "STACK", "DATA", "MOBILE")

## Workflow Steps

### Step 1: Load Agile Rules
Apply these standards for all story creation and revision:
- Apply INVEST principles (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- Use Wiser's specific agile practices and story quality standards
- Follow the Gherkin scenario generation guidelines

### Step 2: Request Sprint Information
If not provided in user input, ask for:
- JIRA sprint number (e.g., "7511" or "Sprint 2024.12")
- Project key (e.g., "STACK", "DATA", "MOBILE")

### Step 3: Request Additional Document References
Ask if there are any additional documents to reference for context:
- Confluence pages (provide URLs or page IDs)
- Epic documentation
- Requirements documents
- Design specifications
- Any other relevant documentation

If document references are provided, read and incorporate them into the story revisions.

### Step 4: Analyze and Create Local Revisions

1. Fetch all stories from the sprint using JQL: `project=[PROJECT_KEY] and sprint=[SPRINT_NUMBER] and issuetype=Story` (do not quote the SPRINT_NUMBER unless it is multi-word)
2. Retrieve full story details including current description and acceptance criteria (customfield_10058)
3. **Smart Content Detection**: For each story, automatically identify:
   - Embedded images (patterns like `!image.png!` or `[^attachment.jpg]`)
   - External links (URLs to Confluence, design docs, etc.)
   - Smart links to other Jira issues (patterns like `[EP-123]` or `EP-123`)
   - Important existing content that should be preserved
4. Apply Wiser INVEST rules to analyze each story
5. Create comprehensive revisions for ALL stories in the sprint:
   - Enhanced user story format (As a [specific user], I want [capability], So that [value])
   - Comprehensive Gherkin acceptance criteria with happy path, edge cases, and error handling
   - Clear business value explanation
   - Definition of Done checklist
   - Technical considerations and dependencies
   - **Auto-preserve detected content** in appropriate sections (e.g., links in "References" section)
6. **Flag complex stories**: Mark stories with significant existing content for user review
7. Generate markdown files for each revised story in a directory named "sprint-[Project key]-[sprint_number]"
8. Create a summary report including content preservation notes

### Step 5: User Review and Editing

1. Present the revised stories for user review, highlighting:
   - **Flagged stories** with existing content that was auto-preserved
   - **Content preservation summary** for stories with detected links/images
   - **Recommended manual review** for complex stories
2. Allow the user to make any changes, additions, or modifications to the revisions
3. **Quick approval option**: For stories with no detected content, offer bulk approval
4. Update the local markdown files with any changes requested
5. Confirm all revisions are approved before proceeding to Jira updates

### Step 6: Update Jira Directly

For each approved revised story, update the original Jira story with:
1. **Enhanced description** combining new user story format with preserved existing content
2. **Comprehensive acceptance criteria** in the customfield_10058 field
3. **Preserve existing labels** (add "auto-groomed" to existing labels, don't replace)
4. **Add comment** documenting the auto-grooming session with:
   - Date and summary of changes made
   - **Content preservation note** if links/images were detected and preserved
   - Link to the local markdown file for reference
5. **Quick verification**: For stories with preserved content, verify links still work
6. Provide confirmation of all Jira updates completed
7. Generate final summary report including content preservation audit

## Expected Outcomes

- All sprint stories follow proper user story format
- All stories have comprehensive Gherkin acceptance criteria
- Stories are analyzed against INVEST principles
- Local markdown files created for documentation
- Jira stories updated with enhanced content **while preserving existing links and images**
- **Zero content loss**: Existing attachments, links, and images automatically preserved
- Audit trail maintained with "auto-groomed" labels and comments
- **Efficient process**: Simple stories auto-processed, complex stories flagged for review

## Success Metrics

- Stories processed: Total count of stories revised
- Quality improvements: INVEST compliance before/after
- Acceptance criteria: Stories with proper Gherkin scenarios
- Jira updates: Successful field updates and labels applied
- **Content preservation**: Automatic detection and preservation of existing links/images
- **Efficiency balance**: Fast processing with smart content protection
- Time efficiency: Complete process typically takes 10-15 minutes

## Smart Content Preservation Features

- **Automatic detection**: Links, images, and smart references identified automatically
- **Intelligent integration**: Existing content placed in appropriate sections of new structure
- **Bulk processing**: Stories without existing content processed quickly
- **Selective review**: Only complex stories require manual attention
- **Verification**: Quick link validation for preserved content
- **Audit trail**: Complete documentation of what was preserved

## Next Steps

After auto-grooming the sprint, consider these related commands:
- `/story-invest-score` - Run detailed INVEST score analysis on individual stories that need further refinement
- `/story-quality-kpis` - Generate quality KPIs to measure the impact of auto-grooming on sprint quality
- `/create-story` - Create additional stories identified during the grooming process
- `/create-technical-enablement-story` - Create technical enablement stories for infrastructure work discovered during grooming
