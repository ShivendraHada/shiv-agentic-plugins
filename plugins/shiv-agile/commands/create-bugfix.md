---
description: Create comprehensive bugfix work items following Shiv Solutions bug standards, automatically posted to Jira
argument-hint: [bug description] [--project KEY] [--severity blocker|critical|major|minor] [--dry-run]
---

# Create Bugfix Workflow

Create high-quality bugfix work items following Shiv Solutions bug standards (severity classification, structured root cause analysis, and a full test plan), automatically posted to Jira.

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

**On first run** (config file missing or `cloudId` is null):
1. Call `mcp__atlassian__getAccessibleAtlassianResources` to discover the Atlassian site(s) the connected account can access.
2. If exactly one site, use it. If multiple, list them and ask the user to pick.
3. Save the chosen site's `url` as `cloudId` in the config.

**Never hardcode a cloudId, project key, issue type ID, priority scheme, or custom field ID.** Every user connects their own Atlassian account with its own site, projects, priority values, and custom field schema. Resolve everything below dynamically and cache it in config.

---

## Step 1: Parse Arguments & Resolve Defaults

1. **Load config** from `~/.claude/shiv-agile-config.json` (create if missing)
2. **Parse flags** from `$ARGUMENTS`:
   - `--project KEY` — Jira project key (overrides config default)
   - `--severity LEVEL` — blocker, critical, major, minor (see severity framework below)
   - `--dry-run` — draft only, do not create on Jira
   - `--assign QUERY` — assignee search query
   - Everything else is the bug title/description
3. **If no description provided**: Ask the user what's broken

---

## Step 2: Resolve Project

If `--project` is provided, use it. Otherwise use `defaultProject` from config. If neither exists, fetch available projects using `mcp__atlassian__getVisibleJiraProjects` (with `expandIssueTypes: true`) and ask the user to pick one, then save their choice to config as `defaultProject`.

Resolve the issue type to use for bugs from the project's real type list:
- Look for a type named "Bug" (case-insensitive). If found, use it.
- **If no "Bug" type exists in this project** (some Jira templates, like the default team-managed Scrum template, don't include one), tell the user and ask them to pick a fallback — typically "Task" with a `bug` label added — rather than failing.

---

## Step 3: Initial Bug Assessment

Gather basic information about the bug:
- What system/component is affected?
- When was the bug first noticed, and who reported it?
- Is this blocking any critical workflows?
- Can it be reproduced? If not, gather more information from the reporter before proceeding.

---

## Step 4: Classify Severity

Apply the Shiv Solutions severity framework (see `references/bugfix-rules.md` in the `agile-rules` skill for full definitions):

| Severity | Definition | Response Time |
|----------|------------|----------------|
| **Blocker** | System down, data loss, security breach, or blocking production deployment | Immediate — all hands |
| **Critical** | Major functionality broken, significant user impact, workaround difficult | Fix in current sprint |
| **Major** | Minor functionality issues, moderate user impact, workaround available | Fix in next 1-2 sprints |
| **Minor** | Cosmetic issues, minimal user impact, nice-to-have | Backlog |

If `--severity` was not provided, ask the user or infer it from the impact assessment in Step 5 and confirm before proceeding.

---

## Step 5: Impact Assessment

Evaluate and record:
- How many users are affected?
- What business processes are impacted?
- Is there a workaround available?
- Are there data integrity or security concerns?
- Could this affect other systems?

---

## Step 6: Root Cause Analysis (if possible)

If enough information is available, run a quick 5 Whys pass:

```
1. Why did the bug occur? (Immediate cause)
2. Why did that happen? (Contributing factor)
3. Why did that happen? (System cause)
4. Why did that happen? (Process cause)
5. Why did that happen? (Root cause)
```

Document the chain. If the root cause can't be determined yet, note that it will be filled in during investigation.

---

## Step 7: Draft the Bug Report

Build the full 11-section report defined in `references/bugfix-rules.md`:

```markdown
## 🐛 Summary
[One to two sentences: what's broken, who's affected, business impact]

## 🖥️ Environment
[OS, browser/version, app version, deployment environment, relevant config]

## 🔄 Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Observe: ...]

## ✅ Expected Behavior
[What should happen]

## ❌ Actual Behavior
[What actually happens, including error messages]

## 📊 Impact Assessment
- Users affected: [...]
- Business processes affected: [...]
- Workaround: [available/none]
- Customer escalation: [yes/no]

## 🔍 Root Cause Analysis
[5 Whys chain or "pending investigation"]

## 🛠️ Proposed Solution
[High-level fix approach, alternatives considered]

## 🧪 Test Plan
[Acceptance criteria go in the dedicated field below — this section covers regression scope and performance impact to verify]

## ⚠️ Risk Assessment
[Side effects, affected components, data migration risk, rollback plan]

## 🔗 Dependencies
[Related issues, blockers]

## 📝 Notes
[Additional context]
```

**Special handling** — flag these explicitly in the report if applicable (see `references/bugfix-rules.md`):
- **Security bugs**: mark confidential, note responsible-disclosure coordination needed
- **Data corruption bugs**: note scope-of-data-affected assessment and backup/recovery coordination
- **Performance bugs**: include baseline metrics and affected workflows
- **Legacy system bugs**: note current-behavior documentation and risk of change

### Resolve Custom Field IDs

Check `fieldIds[<project key>]` in config first; if missing, fetch field metadata with `mcp__atlassian__getJiraIssueTypeMetaWithFields` for the resolved project + issue type and match fields by **name** — look for "Acceptance Criteria" (or similar). Save whatever is found to `fieldIds[<project key>]` in config so future runs skip this lookup.

### Acceptance Criteria (goes in the resolved Acceptance Criteria field, if one exists)

```gherkin
Scenario: Bug is fixed
  Given [the conditions that caused the bug]
  When [the action that triggered the bug]
  Then [the system should behave correctly]
  And [no regression should occur]

Scenario: Related functionality works
  Given [normal operating conditions]
  When [performing related actions]
  Then [all functionality should work as expected]
```

**IMPORTANT**: If a dedicated Acceptance Criteria field was resolved above, use it. If this project has no such field, include a `## Acceptance Criteria` section in the description instead — never drop it silently.

---

## Step 8: Show Summary & Confirm

Present the complete bug report to the user before creating:

```
## Bug Report Summary

**Project**: <resolved project key> — <project name>
**Severity**: Critical
**Summary**: User login fails with 500 error when using special characters in password

### Description
[full description preview]

### Acceptance Criteria (custom field)
[Gherkin scenarios preview]

---
Create on Jira? [Y/n]: _
```

If `--dry-run` was specified, show the summary and stop. Do not create.

---

## Step 9: Create on Jira

Use `mcp__atlassian__createJiraIssue` with:

```
cloudId: from config (resolved in Step 0, never hardcoded)
projectKey: resolved project key
issueTypeName: resolved issue type from Step 2 ("Bug" or the chosen fallback)
summary: one-line title, pattern "[Component] Brief description of incorrect behavior"
description: full description (markdown format)
contentFormat: "markdown"
additional_fields: {
  "<Acceptance Criteria field ID from field resolution, if resolved>": "<acceptance criteria in Gherkin>",
  "priority": "<mapped from severity to this project's real priority scheme>",
  "labels": <labels from config or user, plus "bug" if the fallback issue type was used>
}
```

**Priority mapping is not universal.** Fetch the project's actual allowed priority values via `mcp__atlassian__getJiraIssueTypeMetaWithFields` and map severity to whatever scale this instance actually uses — e.g. a 5-level Highest/High/Medium/Low/Lowest scale is common, not the Blocker/Critical/Major/Minor labels used elsewhere in this command. Pick the closest available value; don't assume the labels match.

Omit the Acceptance Criteria field entry if it wasn't resolved rather than guessing an ID.

If assignee was specified or is in config, include `assignee_account_id`. Use `mcp__atlassian__lookupJiraAccountId` to resolve from name/email if needed. Use assignment guidance from `references/bugfix-rules.md` (expertise, availability, ownership) when suggesting an assignee.

For **Blocker** and **Critical** bugs, remind the user to notify stakeholders (dev lead, product owner, customer support, security/infra as relevant) after creation.

---

## Step 10: Report Result

After successful creation, show:

```
## Created: <issue key>

**Severity**: Critical
**Summary**: User login fails with 500 error when using special characters in password
**URL**: https://<cloudId>/browse/<issue key>

### Next Steps
- Notify stakeholders (see severity-based routing in bugfix-rules)
- Set up monitoring/alerts if Blocker or Critical
- `/auto-groom` — Groom all stories in the sprint
```
