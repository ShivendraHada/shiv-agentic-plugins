---
description: Create high-quality User Stories following Wiser Solutions INVEST principles and standard templates
argument-hint: [story description] [--epic KEY] [--project KEY] [--type story|task|bug|spike|tech-debt] [--dry-run]
---

# Create Work Item Workflow

Create high-quality work items following Wiser Solutions INVEST principles, automatically posted to Jira.

## User Input

```text
$ARGUMENTS
```

## Configuration

This command uses user-scoped defaults stored at `~/.claude/wiser-agile-config.json`. If the config file exists, load it and use the values as prefilled defaults. Users can override any value per invocation.

**Config file format:**
```json
{
  "cloudId": "wisersolutions.atlassian.net",
  "defaultProject": "SPE",
  "defaultAssignee": null,
  "defaultTeam": null,
  "defaultLabels": []
}
```

**On first run**: If `~/.claude/wiser-agile-config.json` does not exist, ask the user for their default project key and create the config file. Use `wisersolutions.atlassian.net` as the cloudId.

---

## Step 1: Parse Arguments & Resolve Defaults

1. **Load config** from `~/.claude/wiser-agile-config.json` (create if missing)
2. **Parse flags** from `$ARGUMENTS`:
   - `--epic KEY` or `--parent KEY` — parent epic/story key
   - `--project KEY` — Jira project key (overrides config default)
   - `--type TYPE` — issue type (story, task, bug, spike, tech-debt, sub-task, support-request, adr)
   - `--dry-run` — draft only, do not create on Jira
   - `--assign QUERY` — assignee search query
   - Everything else is the story description/title
3. **If no description provided**: Ask the user what they need

---

## Step 2: Resolve Project & Issue Type

### Project (Board)

If `--project` is provided, use it. Otherwise use `defaultProject` from config.

If neither exists, fetch available projects using `mcp__atlassian__getVisibleJiraProjects` and ask the user to pick one. Show the list:

```
Which project? (enter key or number)
  1. SPE — SaaS Platform East
  2. ABC — Another Project
  ...
Your default project [none]: _
```

Save their choice to config as `defaultProject`.

### Issue Type

If `--type` is provided, map it:

| Flag Value | Jira Issue Type |
|-----------|----------------|
| `story` | Story |
| `task` | Task |
| `bug` | Bug |
| `spike` | Spike |
| `tech-debt` | Tech Debt |
| `sub-task` | Sub-task |
| `support-request` | Support Request |
| `adr` | Architecture Decision Record |

If not provided, ask the user:

```
What type of work item?
  1. Story — User-facing feature (default)
  2. Task — Discovery, documentation, or non-implementation work
  3. Bug — Unexpected behavior or defect
  4. Spike — Research or investigation with multiple paths
  5. Tech Debt — Addressing previous shortcuts
  6. Sub-task — Breakdown of a parent story/task
  ...
Type [story]: _
```

### Parent Epic

If `--epic` is provided, use it. If not, and the type is Sub-task, ask for the parent issue key.

If neither is provided and type is Story/Task/Bug, ask:

```
Parent epic? (enter key, or press Enter to skip)
Epic [none]: _
```

---

## Step 3: Gather Story Details

Based on what the user provided, ask for any missing information. Show prefilled values from config.

**Required information:**
- **Summary/Title**: One-line summary for the Jira ticket
- **User Story Statement** (for Story type): As a [role], I need to [action], So that I can [benefit]
- **Value Statement**: Why this matters (business impact)
- **Acceptance Criteria**: Gherkin syntax (Given/When/Then scenarios)
- **Assumptions**: Any assumptions made
- **Dependencies**: Blockers or related work

For non-Story types (Task, Bug, Spike, etc.), adapt the template:
- **Task**: Description of work, acceptance criteria, definition of done
- **Bug**: Steps to reproduce, expected vs actual behavior, acceptance criteria for the fix
- **Spike**: Research questions, time-box, expected output/decision
- **Tech Debt**: Current state, desired state, acceptance criteria

---

## Step 4: Draft the Work Item

### Description (goes in Jira `description` field)

For **Story** type:
```markdown
## User Story
As a [specific user role]
I need to [specific action or capability]
So that I can [specific business value or benefit]

## Value Statement
[Detailed explanation of the business value]

## Definition of Done
- General DoD Checklist completed
- [Story-specific requirements]
- Ready for production deployment

## Assumptions
[Any assumptions]

## Dependencies
[Any dependencies]

## Notes
[Additional context]
```

For **Task** type:
```markdown
## Description
[What needs to be done and why]

## Definition of Done
- [Specific completion criteria]

## Assumptions
[Any assumptions]

## Dependencies
[Any dependencies]
```

For **Bug** type:
```markdown
## Bug Description
[What is broken]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Observe: ...]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Dependencies
[Any dependencies]
```

For **Spike** type:
```markdown
## Research Question
[What we need to find out]

## Time Box
[Maximum time to spend]

## Expected Output
[Decision, proof of concept, or recommendation]

## Options Being Evaluated
[List of approaches being considered]
```

### Acceptance Criteria (goes in Jira custom field `customfield_10058`)

Always use Gherkin syntax:
```gherkin
Scenario: [Primary happy path]
Given [context]
When [action]
Then [outcome]

Scenario: [Edge case / error path]
Given [context]
When [action]
Then [outcome]
```

**IMPORTANT**: Acceptance criteria go into the dedicated Jira custom field (`customfield_10058`), NOT into the description. The description field contains the user story, value statement, and other context.

---

## Step 5: INVEST Score (Story type only)

For Story-type items, validate against INVEST criteria using the 1-5 scale:

| Criterion | Target | Score |
|-----------|--------|-------|
| **I**ndependent | >= 3 | [1-5] |
| **N**egotiable | >= 3 | [1-5] |
| **V**aluable | >= 4 | [1-5] |
| **E**stimable | >= 3 | [1-5] |
| **S**mall | >= 3 | [1-5] |
| **T**estable | >= 4 | [1-5] |

**Overall**: [Total]/30 ([Avg]/5)

Quality gate:
- **Ready**: Average >= 3.5 (21+), no score below 2
- **Needs Refinement**: Average 3.0-3.4 (18-20) or any below 2
- **Rework Required**: Average < 3.0 (< 18)

If below target, suggest specific improvements before creating.

**Do NOT include INVEST scores in the Jira ticket.** Show them only in the user-facing summary.

---

## Step 6: Show Summary & Confirm

Present the complete work item to the user before creating:

```
## Work Item Summary

**Project**: SPE — SaaS Platform East
**Type**: Story
**Parent**: SPE-1019
**Summary**: Add composite index on catalog_products

### Description
[full description preview]

### Acceptance Criteria (custom field)
[Gherkin scenarios preview]

### INVEST Score: 28/30 (4.7 avg) — Ready for Sprint
| I | N | V | E | S | T |
|---|---|---|---|---|---|
| 5 | 4 | 4 | 5 | 5 | 5 |

---
Create on Jira? [Y/n]: _
```

If `--dry-run` was specified, show the summary and stop. Do not create.

---

## Step 7: Create on Jira

Use `mcp__atlassian__createJiraIssue` with:

```
cloudId: from config (wisersolutions.atlassian.net)
projectKey: resolved project key
issueTypeName: resolved issue type name
summary: one-line title
description: full description (markdown format)
contentFormat: "markdown"
parent: epic key (if provided)
additional_fields: {
  "customfield_10058": "<acceptance criteria in Gherkin>",
  "customfield_10012": <story points if estimated>,
  "labels": <labels from config or user>
}
```

If assignee was specified or is in config, include `assignee_account_id`. Use `mcp__atlassian__lookupJiraAccountId` to resolve from name/email if needed.

---

## Step 8: Report Result

After successful creation, show:

```
## Created: SPE-1042

**Type**: Story
**Summary**: Add composite index on catalog_products
**Parent**: SPE-1019
**URL**: https://wisersolutions.atlassian.net/browse/SPE-1042

### INVEST Score: 28/30 (4.7 avg)
| I | N | V | E | S | T |
|---|---|---|---|---|---|
| 5 | 4 | 4 | 5 | 5 | 5 |

### Next Steps
- `/story-invest-score SPE-1042` — Re-score after refinement
- `/create-technical-enablement-story` — Create tech enablement stories
- `/auto-groom` — Groom all stories in the sprint
```

---

## Jira Field Reference

| Field | Jira Key | Type | Notes |
|-------|----------|------|-------|
| Summary | `summary` | string | Required. One-line title |
| Description | `description` | string | Required. Full story/task body (markdown) |
| Issue Type | `issuetype` | system | Required. Story, Task, Bug, Spike, etc. |
| Parent | `parent` | issuelink | Epic or parent story key |
| Acceptance Criteria | `customfield_10058` | textarea | **Gherkin scenarios go here, NOT in description** |
| Story Points | `customfield_10012` | number | Optional estimate |
| Sprint | `customfield_10008` | array | Optional sprint assignment |
| Team | `customfield_10001` | team | Optional team assignment |
| Assignee | `assignee` | user | Optional |
| Labels | `labels` | array[string] | Optional |
| Priority | `priority` | priority | Blocker, Critical, Major, Minor, Trivial, None |
| Components | `components` | array | Optional milestone/component |

## Supported Issue Types (SPE Project)

| Type | ID | When to Use |
|------|----|-------------|
| Story | 10001 | User-facing feature delivering incremental value |
| Task | 10002 | Discovery, documentation, non-implementation activity |
| Bug | 10004 | Unexpected behavior or defect |
| Spike | 10163 | Research when multiple paths exist |
| Tech Debt | 10152 | Addressing previous shortcuts |
| Sub-task | 10003 | Breakdown of parent story/task/bug |
| Support Request | 10008 | External/internal support needs |
| Architecture Decision Record | 10159 | Significant design decisions |

---

## Anti-Patterns to Avoid

**Vague stories:**
```
As a user, I want the system to be better, So that it works well
```

**Technical stories** (use `/create-technical-enablement-story` instead):
```
As a developer, I need to refactor the auth module, So that the code is cleaner
```

**Implementation-focused acceptance criteria:**
```
- Use React hooks
- Implement JWT auth
- Store in PostgreSQL
```

**Acceptance criteria in description** — always use `customfield_10058`.
