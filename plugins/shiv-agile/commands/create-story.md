---
description: Create high-quality User Stories following Shiv Solutions INVEST principles and standard templates
argument-hint: [story description] [--epic KEY] [--project KEY] [--type story|task|bug|spike|tech-debt] [--dry-run]
---

# Create Work Item Workflow

Create high-quality work items following Shiv Solutions INVEST principles, automatically posted to Jira.

## User Input

```text
$ARGUMENTS
```

## Configuration

This command uses user-scoped defaults stored at `~/.claude/shiv-agile-config.json`. If the config file exists, load it and use the values as prefilled defaults. Users can override any value per invocation.

**Config file format:**
```json
{
  "cloudId": null,
  "defaultProject": null,
  "defaultAssignee": null,
  "defaultTeam": null,
  "defaultLabels": [],
  "fieldIds": {}
}
```

`fieldIds` caches per-project custom field IDs resolved by name (see Step 3.5), keyed by project key, e.g. `{"SPE": {"Acceptance Criteria": "customfield_10058", "Story point estimate": "customfield_10012"}}`.

**On first run** (config file missing or `cloudId` is null):
1. Call `mcp__atlassian__getAccessibleAtlassianResources` to discover the Atlassian site(s) the connected account can access.
2. If exactly one site, use it. If multiple, list them and ask the user to pick.
3. Save the chosen site's `url` as `cloudId` in the config.

**Never hardcode a cloudId, project key, issue type ID, or custom field ID.** Every user connects their own Atlassian account — it has its own site, its own projects, and its own custom field schema (field IDs like `customfield_10058` are assigned per-instance and will differ for every user). Everything below must be resolved dynamically from the connected account, then cached in config so it isn't re-fetched on every run.

---

## Step 1: Parse Arguments & Resolve Defaults

1. **Load config** from `~/.claude/shiv-agile-config.json` (create if missing)
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

Fetch the issue types actually available in the resolved project via `mcp__atlassian__getVisibleJiraProjects` (with `expandIssueTypes: true`) or `mcp__atlassian__getJiraProjectIssueTypesMetadata`. Different Jira instances and project templates expose different type sets — do not assume Story/Task/Bug/Spike/Tech Debt/Sub-task/Support Request/ADR all exist.

If `--type` is provided, map the flag value to the closest matching type **name** returned by the API (case-insensitive match, e.g. `bug` → "Bug"). If no matching type exists in this project, tell the user which types are actually available and ask them to pick one instead of failing silently.

If not provided, ask the user using the project's real type list:

```
What type of work item? (available in this project)
  1. Story — User-facing feature (default)
  2. Task — Discovery, documentation, or non-implementation work
  3. Bug — Unexpected behavior or defect
  ...
Type [story]: _
```

Only list types that exist in the resolved project.

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

## Step 3.5: Resolve Custom Field IDs

Before drafting, resolve the field IDs this project actually uses. Check `fieldIds[<project key>]` in config first; if missing, fetch field metadata with `mcp__atlassian__getJiraIssueTypeMetaWithFields` for the resolved project + issue type and match fields by **name**, not by assuming an ID:

- Look for a field named "Acceptance Criteria" (or similar, e.g. "AC") — this may be a custom field or may not exist at all.
- Look for "Story point estimate" / "Story Points".
- Look for "Sprint" and "Team" if relevant.

Save whatever is found to `fieldIds[<project key>]` in config, keyed by field name → field key (e.g. `customfield_10058`), so future runs skip this lookup.

**If a field doesn't exist in this project** (e.g. no dedicated Acceptance Criteria field), don't fail — fall back to including that content in the `description` body instead, under its own clearly marked section, and note the fallback to the user.

---

## Step 4: Draft the Work Item

### Description (goes in Jira `description` field)

For **Story** type:
```markdown
## 📖 User Story
As a [specific user role]
I need to [specific action or capability]
So that I can [specific business value or benefit]

## 💎 Value Statement
[Detailed explanation of the business value]

## ✅ Definition of Done
- General DoD Checklist completed
- [Story-specific requirements]
- Ready for production deployment

## 💡 Assumptions
[Any assumptions]

## 🔗 Dependencies
[Any dependencies]

## 📝 Notes
[Additional context]
```

For **Task** type:
```markdown
## 📋 Description
[What needs to be done and why]

## ✅ Definition of Done
- [Specific completion criteria]

## 💡 Assumptions
[Any assumptions]

## 🔗 Dependencies
[Any dependencies]
```

For **Bug** type:
```markdown
## 🐛 Bug Description
[What is broken]

## 🔄 Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Observe: ...]

## ✅ Expected Behavior
[What should happen]

## ❌ Actual Behavior
[What actually happens]

## 🔗 Dependencies
[Any dependencies]
```

For **Spike** type:
```markdown
## 🔬 Research Question
[What we need to find out]

## ⏱️ Time Box
[Maximum time to spend]

## 🎯 Expected Output
[Decision, proof of concept, or recommendation]

## 🔀 Options Being Evaluated
[List of approaches being considered]
```

### Acceptance Criteria (goes in the resolved Acceptance Criteria field, if one exists)

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

**IMPORTANT**: If Step 3.5 resolved a dedicated Acceptance Criteria field for this project, acceptance criteria go there, NOT into the description. If no such field exists in this project, include a `## Acceptance Criteria` section in the description instead — never drop the acceptance criteria silently.

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

**Project**: <resolved project key> — <project name>
**Type**: Story
**Parent**: <resolved epic key, if any>
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
cloudId: from config (resolved in Step 0, never hardcoded)
projectKey: resolved project key
issueTypeName: resolved issue type name
summary: one-line title
description: full description (markdown format)
contentFormat: "markdown"
parent: epic key (if provided)
additional_fields: {
  "<Acceptance Criteria field ID from Step 3.5, if resolved>": "<acceptance criteria in Gherkin>",
  "<Story Points field ID from Step 3.5, if resolved>": <story points if estimated>,
  "labels": <labels from config or user>
}
```

Omit any `additional_fields` entry whose field wasn't resolved in Step 3.5 rather than guessing an ID.

If assignee was specified or is in config, include `assignee_account_id`. Use `mcp__atlassian__lookupJiraAccountId` to resolve from name/email if needed.

---

## Step 8: Report Result

After successful creation, show:

```
## Created: <issue key>

**Type**: Story
**Summary**: Add composite index on catalog_products
**Parent**: <epic key, if any>
**URL**: https://<cloudId>/browse/<issue key>

### INVEST Score: 28/30 (4.7 avg)
| I | N | V | E | S | T |
|---|---|---|---|---|---|
| 5 | 4 | 4 | 5 | 5 | 5 |

### Next Steps
- `/story-invest-score <issue key>` — Re-score after refinement
- `/create-technical-enablement-story` — Create tech enablement stories
- `/auto-groom` — Groom all stories in the sprint
```

---

## Jira Field Reference

Standard (system) fields are the same across every Jira instance. Custom fields (Acceptance Criteria, Story Points, Sprint, Team) are **not** — their field keys (`customfield_NNNNN`) are assigned per Atlassian site and must be resolved per Step 3.5, never assumed.

| Field | Jira Key | Type | Notes |
|-------|----------|------|-------|
| Summary | `summary` | system | Required. One-line title |
| Description | `description` | system | Required. Full story/task body (markdown) |
| Issue Type | `issuetype` | system | Required. Resolved by name from the project's real type list (Step 2) |
| Parent | `parent` | issuelink | Epic or parent story key |
| Acceptance Criteria | resolved via Step 3.5 | custom, varies per site | May not exist in every project — falls back to description |
| Story Points | resolved via Step 3.5 | custom, varies per site | May not exist in every project |
| Sprint | resolved via Step 3.5 | custom, varies per site | May not exist in every project |
| Team | resolved via Step 3.5 | custom, varies per site | May not exist in every project |
| Assignee | `assignee` | system | Optional |
| Labels | `labels` | system | Optional |
| Priority | `priority` | system | Blocker/Highest through Lowest — allowed values vary per site, resolve from `getJiraIssueTypeMetaWithFields` |
| Components | `components` | system | Optional milestone/component |

## Supported Issue Types

Issue types (Story, Task, Bug, Spike, Tech Debt, Sub-task, Support Request, ADR, etc.) and their IDs are **project-specific and vary by Jira instance and template**. Resolve the real list for the target project in Step 2 — do not assume any of these exist.

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

**Acceptance criteria in description when a dedicated field exists** — use the field resolved in Step 3.5 instead.

---

## Emoji Usage

Use one emoji per section heading in the Jira description to improve scannability. Keep it minimal — headings only, never in body text or acceptance criteria.

| Heading | Emoji |
|---------|-------|
| User Story | 📖 |
| Value Statement | 💎 |
| Definition of Done | ✅ |
| Assumptions | 💡 |
| Dependencies | 🔗 |
| Notes | 📝 |
| Description (Task) | 📋 |
| Bug Description | 🐛 |
| Steps to Reproduce | 🔄 |
| Expected Behavior | ✅ |
| Actual Behavior | ❌ |
| Research Question (Spike) | 🔬 |
| Time Box | ⏱️ |
| Expected Output | 🎯 |
| Options Being Evaluated | 🔀 |
