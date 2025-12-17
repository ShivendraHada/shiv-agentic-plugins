# Agentic Jira-to-Terraform Workflow

Ensure infrastructure changes are tightly mapped to Jira requirements, fully auditable, and validated stepwise with explicit human checkpoints.

## User Input

```text
$ARGUMENTS
```

Provide the Jira ticket key or URL above. If not provided, ask for it.

**IMPORTANT:** No step may be skipped. At each specified checkpoint, pause and await explicit human approval before proceeding.

## Workflow Steps

### 1. Initial Requirement Extraction

**AI Action:**
Extract all infrastructure and contextual requirements for the AWS instance from the given Jira ticket, including:
- Core change/request details
- Relevant custom fields and attachments
- Comments that contain context or clarifications
- Linked issues that may impact infrastructure
- Assumptions/uncertainties

**Expected Output:**
A structured list of functional and technical requirements extracted from the ticket, with all assumptions clearly listed.

### 2. Clarifying Questions

**AI Action:**
Identify and list questions needed to clarify ambiguities or complete the requirement specification, e.g.:
- Specific AWS services or modules to target
- Versioning rules for infrastructure changes
- Naming/tagging conventions
- What existing Terraform resources/structure is impacted
- Any unaddressed edge cases

**Expected Output:**
A numbered list of questions that require explicit answers before implementing any technology change.

### 3. Requirement Validation - HUMAN CHECKPOINT

**AI Action:**
Wait for the human to respond to all clarifying questions. If all are not answered, ask again.

**CRITICAL CHECKPOINT:**
Do not proceed until all clarifying questions are resolved.

**Expected Output:**
A confirmation that all questions are answered and a finalized, human-validated requirements summary.

### 4. Change Preview & Mapping

**AI Action:**
Map the finalized Jira requirements to specific Terraform actions/changes, including:
- Which modules/resources will be created, updated, or removed
- Path(s) of the Terraform files to modify or create
- A clear, human-readable summary of changes to be implemented

Present a diff preview or detailed pseudo-changes for review (no file edits yet).

**Expected Output:**
A clear mapping and preview of the proposed infrastructure actions. Highlight any design choices or tradeoffs, and pause for confirmation before editing files.

### 5. Change Approval - HUMAN CHECKPOINT

**AI Action:**
Wait for human sign-off on the proposed infra changes and mappings.

**Expected Output:**
Explicit approval to proceed with code modifications, or request for further change/design adjustments.

### 6. Terraform File Update

**AI Action:**
- Branch off from the user-specified base branch, naming the branch as `[infra]/[JiraID]-short-description` (e.g., `infra/PROJ-123-scale-db`)
- Edit or write relevant Terraform files only
- Generate a diff or patch for all file changes (do not push yet)
- Ensure all changes follow existing project style, documentation, and validation rules
- Never destroy or recreate resources unless explicitly instructed

**Expected Output:**
A detailed diff of the file changes to be made, ready for human review.

### 7. File Change Validation - HUMAN CHECKPOINT

**AI Action:**
Present all code changes for explicit human approval before continuing.

**CRITICAL CHECKPOINT:**
Do not proceed until all file edits have been explicitly validated.

**Expected Output:**
Human acceptance of all file updates and readiness to create a PR.

### 8. Pull Request Preparation

**AI Action:**
- Push the branch with changed files (if approved)
- Prepare a PR titled `[JiraID]: <short description>`, base branch as specified by the human
- PR description should include:
  - Summary of the implemented requirements mapped to the Jira ticket, with a link
  - Rationale for all infra changes
  - A full list of impacted AWS resources
  - Validation/test plan, including any applied linters/validators
  - Known limitations or follow-ups

Present the final draft PR description for human review.

**Expected Output:**
A complete, human-ready PR draft with clear mapping between ticket, code, and infrastructure intent.

### 9. PR Review & Submission - HUMAN CHECKPOINT

**AI Action:**
Submit the PR only after explicit human approval.
- If human requests changes, return to step 6 or 8 as appropriate (maintaining full auditability)
- If approved, submit the detailed PR and notify the human

### 10. Workflow Complete & Progress Tracking

**AI Action:**
- Provide a summary of the actions taken, linked to requirements
- Advise on next actions, such as waiting for downstream review, subsequent infra validation, or starting a new ticket-based workflow

## Progress Tracker

Mark each step as you progress:
- **In Progress** (currently in progress)
- **Completed** (completed)
- **Awaiting Validation** (awaiting human validation)

Example:
```
Completed: 1. Requirement Extraction
Completed: 2. Clarifying Questions
Awaiting Validation: 3. Requirement Validation
```

## Notes

This workflow is designed for generic use - Jira tickets drive changes to AWS infrastructure via Terraform, with explicit human approval and full transparency at every step. It can be adapted by changing the infra platform, VCS, or mapping steps to other coding standards as needed.
