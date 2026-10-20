# Using Spec Kit with JIRA Stories (INVEST + Gherkin + DoD)

This guide describes how to integrate **bd (Beads)** and **Spec Kit** into your existing JIRA-based workflow when your stories already follow INVEST principles, include Gherkin acceptance criteria, and have Definition of Done checklists.

## Overview

When you have well-structured JIRA stories, Spec Kit becomes a **bridge** between JIRA (your organizational tracking) and your codebase (where AI assistants work). This approach gives you:

- **Single source of truth**: JIRA remains authoritative for product/project management
- **Developer context**: Spec Kit provides rich, version-controlled design artifacts
- **AI-friendly structure**: bd + Spec Kit give AI assistants structured backlog and tasks
- **Traceability**: Every change maps: JIRA → bd → Spec Kit docs → code → PR

## Key Principle: JIRA as Source, bd + Spec Kit as Implementation Layer

```
┌─────────────────────────────────────────────────────────────┐
│                         JIRA Story                          │
│  • INVEST-compliant user story                              │
│  • Gherkin acceptance criteria (Given/When/Then)            │
│  • Definition of Done checklist                             │
│  • Product/business context                                 │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                        bd Feature Issue                     │
│  • Links to JIRA ID (via external_ref)                      │
│  • Tracks implementation status                             │
│  • Dependencies and blockers                                │
│  • Ready work detection                                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                  Spec Kit Feature Directory                 │
│  specs/NNN-feature-name/                                    │
│    • spec.md (from JIRA + elaboration)                      │
│    • plan.md (technical design)                             │
│    • tasks.md (implementation tasks)                        │
│    • research.md, data-model.md, etc.                       │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              bd Task Issues (one per task)                  │
│  • Each task in tasks.md → bd task issue                    │
│  • Links back to bd feature issue (parent-child)            │
│  • AI assistants update status during implementation        │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    Code + Tests + PR                        │
│  • Implementation guided by Spec Kit docs                   │
│  • Tests based on Gherkin scenarios                         │
│  • PR references JIRA ID + bd feature ID                    │
└─────────────────────────────────────────────────────────────┘
```

---

## Workflow: JIRA Story → bd → Spec Kit → Implementation

### Phase 1: Sync JIRA Story into bd

When a JIRA story is ready for development:

1. **Create a bd feature issue** linked to the JIRA story:

   ```bash
   bd create "USER-123: As a user, I want to export reports" \
     -t feature \
     -p 1 \
     --external-ref "https://yourcompany.atlassian.net/browse/USER-123" \
     --json
   ```

   This creates a bd issue with:
   - **Title**: Includes JIRA ID for easy reference
   - **external_ref**: Direct link back to JIRA
   - **Type**: `feature` (or `bug`, `task`, depending on JIRA issue type)
   - **Priority**: Mapped from JIRA priority

2. **Add JIRA acceptance criteria to bd issue description** (optional):

   ```bash
   bd update bd-42 --description "$(cat <<'EOF'
   ## User Story
   As a user, I want to export reports to CSV so that I can analyze data offline.

   ## Acceptance Criteria (Gherkin)

   **Scenario: Successful CSV export**
   Given I am on the reports page
   When I click the "Export to CSV" button
   Then a CSV file should be downloaded
   And the CSV should contain all visible report data
   And the CSV should include column headers

   **Scenario: No data to export**
   Given I am on the reports page with no data
   When I click the "Export to CSV" button
   Then I should see an error message "No data available to export"

   ## Definition of Done
   - [ ] All acceptance criteria pass
   - [ ] Unit tests written and passing
   - [ ] Integration tests written and passing
   - [ ] Code reviewed and approved
   - [ ] Documentation updated
   - [ ] JIRA story moved to "Done"
   EOF
   )" --json
   ```

   **Note**: This step is optional if you prefer to keep JIRA as the sole source of requirements. You can also reference the JIRA link and extract details on-demand.

### Phase 2: Create Spec Kit Feature Directory

Use `/speckit-specify` to create the feature specification from the JIRA story:

1. **Open your repo in Claude Code**

2. **Run `/speckit-specify` with JIRA context**:

   ```
   /speckit-specify USER-123: Export reports to CSV

   Here's the JIRA story:

   **User Story**: As a user, I want to export reports to CSV so that I can analyze data offline.

   **Acceptance Criteria (Gherkin)**:

   Scenario: Successful CSV export
     Given I am on the reports page
     When I click the "Export to CSV" button
     Then a CSV file should be downloaded
     And the CSV should contain all visible report data
     And the CSV should include column headers

   Scenario: No data to export
     Given I am on the reports page with no data
     When I click the "Export to CSV" button
     Then I should see an error message "No data available to export"

   **Definition of Done**:
   - All acceptance criteria pass
   - Unit tests written and passing
   - Integration tests written and passing
   - Code reviewed and approved
   - Documentation updated
   ```

3. **Result**: Spec Kit creates `specs/NNN-export-reports-to-csv/spec.md` containing:
   - Feature overview
   - User stories (from JIRA)
   - Gherkin scenarios (converted into acceptance tests section)
   - Success criteria (from DoD)
   - Any additional technical context or questions
   - Reference to bd feature issue ID and JIRA external_ref

### Phase 3: Technical Planning with `/speckit-plan`

After the spec is created, generate the implementation plan:

1. **From the feature directory**, run:

   ```
   /speckit-plan
   ```

2. **Result**: Spec Kit creates:
   - `plan.md`: Technical approach, architecture decisions, component design
   - `research.md` (if needed): Investigation notes, spike results, alternatives considered
   - `data-model.md` (if needed): Database schema, API contracts, data structures

3. **AI assistant behavior**:
   - Analyzes the Gherkin scenarios to identify technical requirements
   - Researches the codebase to find relevant patterns and integration points
   - Proposes design decisions aligned with existing architecture
   - Identifies dependencies and potential blockers

### Phase 4: Generate Tasks with `/speckit-tasks`

Convert the plan into actionable, dependency-ordered tasks:

1. **From the feature directory**, run:

   ```
   /speckit-tasks
   ```

2. **Result**: Spec Kit creates:
   - `tasks.md`: Ordered checklist of implementation tasks
   - **bd task issues** (one per task, linked to the bd feature issue)

3. **Task structure**:
   ```markdown
   ## Tasks

   - [ ] Setup: Create CSV export service class (bd-43)
   - [ ] Write unit tests for CSV formatter (bd-44)
   - [ ] Implement CSV formatter (bd-45)
   - [ ] Write unit tests for export endpoint (bd-46)
   - [ ] Implement export endpoint (bd-47)
   - [ ] Write integration test for happy path (bd-48)
   - [ ] Write integration test for no-data scenario (bd-49)
   - [ ] Update frontend to add export button (bd-50)
   - [ ] Write E2E tests matching Gherkin scenarios (bd-51)
   - [ ] Update documentation (bd-52)
   ```

4. **Each task becomes a bd issue**:
   ```bash
   bd list --status open --json
   # Shows: bd-43, bd-44, bd-45, ..., bd-52
   # All linked to parent bd-42 (the feature issue)
   ```

### Phase 5: Implement with `/speckit-implement`

Execute the implementation plan with AI assistance:

1. **From the feature directory**, run:

   ```
   /speckit-implement
   ```

2. **AI assistant behavior**:
   - Walks through `tasks.md` in order
   - For each task:
     - Marks bd issue as `in_progress`
     - Implements the task (code, tests, docs)
     - Marks task as `[x]` in `tasks.md`
     - Marks bd issue as `closed`
   - Uses Gherkin scenarios to guide test implementation
   - Ensures DoD checklist items are addressed

3. **Human validation checkpoints** (optional, based on your workflow):
   - After writing tests (before implementation)
   - After writing implementation (before refactoring)
   - After integration tests (before PR)

### Phase 6: Verify Definition of Done

Before creating a PR, validate that all DoD items are complete:

1. **Check DoD against Spec Kit artifacts**:

   | DoD Item | Validation |
   |----------|------------|
   | All acceptance criteria pass | Run E2E tests based on Gherkin scenarios |
   | Unit tests written and passing | Check task completion in `tasks.md` |
   | Integration tests written and passing | Check task completion in `tasks.md` |
   | Code reviewed and approved | PR review process |
   | Documentation updated | Check for docs task in `tasks.md` |

2. **Verify all bd tasks are closed**:

   ```bash
   bd list --status open --json
   # Should show no tasks under the feature
   ```

3. **Close the bd feature issue**:

   ```bash
   bd close bd-42 --reason "Completed: All tasks done, DoD met" --json
   ```

### Phase 7: Create Pull Request

Link everything together in the PR:

1. **Commit changes** (code + Spec Kit docs + bd issues):

   ```bash
   git add .
   git commit -m "USER-123: Implement CSV export feature (bd-42)

   - Implemented CSV export service and endpoint
   - Added comprehensive unit and integration tests
   - Tests cover all Gherkin scenarios from USER-123
   - Updated documentation

   Spec Kit feature: specs/042-export-reports-to-csv/

   🤖 Generated with Claude Code

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

2. **Create PR** with description:

   ```markdown
   ## JIRA Story
   [USER-123: Export reports to CSV](https://yourcompany.atlassian.net/browse/USER-123)

   ## bd Feature Issue
   bd-42

   ## Spec Kit Feature Directory
   `specs/042-export-reports-to-csv/`

   ## Summary
   Implements CSV export functionality as specified in USER-123. Users can now export
   reports to CSV format for offline analysis.

   ## Acceptance Criteria (from JIRA)
   - ✅ Successful CSV export with all data and headers
   - ✅ Error handling for empty reports
   - ✅ All Gherkin scenarios covered by E2E tests

   ## Definition of Done
   - ✅ All acceptance criteria pass
   - ✅ Unit tests written and passing (23 tests)
   - ✅ Integration tests written and passing (5 tests)
   - ✅ E2E tests matching Gherkin scenarios (2 tests)
   - ✅ Code reviewed and approved (pending)
   - ✅ Documentation updated (API docs, user guide)

   ## Implementation Notes
   - Used existing `ReportService` for data retrieval
   - Implemented streaming CSV generation for large datasets
   - Added proper error handling and validation

   ## Testing
   - Unit test coverage: 95%
   - All Gherkin scenarios automated in E2E test suite
   ```

3. **Update JIRA**:
   - Move story to "In Review" or "Ready for QA"
   - Add PR link to JIRA story
   - Update JIRA comments with any implementation notes

### Phase 8: Post-Merge Sync

After the PR is merged:

1. **Verify bd issues are closed**:

   ```bash
   bd list --status closed --json | grep "bd-42\|bd-43\|bd-44"
   ```

2. **Update JIRA story to "Done"**:
   - Move JIRA story to "Done" status
   - Confirm all acceptance criteria are verified
   - Add final notes or screenshots if needed

---

## Mapping INVEST Principles to Spec Kit

| INVEST Principle | How Spec Kit Supports It |
|------------------|--------------------------|
| **Independent** | bd tracks dependencies explicitly; `/speckit-tasks` orders tasks by dependencies |
| **Negotiable** | `/speckit-specify` encourages clarifying questions; `spec.md` captures final agreement |
| **Valuable** | User stories from JIRA are preserved in `spec.md`; acceptance criteria remain front-and-center |
| **Estimable** | `/speckit-plan` breaks work into concrete technical tasks; `tasks.md` provides granular estimates |
| **Small** | If JIRA story is too large, Spec Kit exposes this during planning; you can split into multiple features |
| **Testable** | Gherkin scenarios → E2E tests; `/speckit-tasks` ensures test tasks are included; DoD enforces test coverage |

---

## Mapping Gherkin Scenarios to Spec Kit Tests

### Gherkin in JIRA:

```gherkin
Scenario: Successful CSV export
  Given I am on the reports page
  When I click the "Export to CSV" button
  Then a CSV file should be downloaded
  And the CSV should contain all visible report data
  And the CSV should include column headers
```

### Converted to Spec Kit `spec.md`:

```markdown
## Acceptance Tests

### Test 1: Successful CSV export

**Preconditions**:
- User is authenticated
- Reports page contains visible data (at least 1 report row)

**Steps**:
1. Navigate to the reports page
2. Click the "Export to CSV" button

**Expected Results**:
- A CSV file is downloaded with filename `reports-YYYY-MM-DD.csv`
- The CSV contains all visible report data (matching on-screen rows)
- The CSV includes column headers as the first row
- All data is properly escaped and formatted per CSV spec
```

### Implemented in `tasks.md`:

```markdown
- [ ] Write E2E test for successful CSV export (Gherkin scenario 1) (bd-51)
  - Test: User clicks export → CSV downloads with correct data
  - Validates: filename, headers, data rows, CSV formatting
```

### Implemented as E2E test code:

```typescript
describe('CSV Export (USER-123)', () => {
  it('should export reports to CSV with headers and data', async () => {
    // Given: User is on the reports page
    await page.goto('/reports');
    await page.waitForSelector('[data-testid="report-row"]');

    // When: User clicks "Export to CSV" button
    const [download] = await Promise.all([
      page.waitForEvent('download'),
      page.click('[data-testid="export-csv-btn"]'),
    ]);

    // Then: CSV file should be downloaded
    const filename = download.suggestedFilename();
    expect(filename).toMatch(/reports-\d{4}-\d{2}-\d{2}\.csv/);

    // And: CSV should contain all visible report data
    const csvContent = await download.createReadStream().then(/* read stream */);
    const rows = csvContent.split('\n');

    // And: CSV should include column headers
    expect(rows[0]).toBe('Report ID,Title,Created Date,Status');
    expect(rows.length).toBeGreaterThan(1); // At least header + 1 data row
  });
});
```

---

## Best Practices

### 1. Use bd `external_ref` for JIRA Links

Always link bd issues back to JIRA:

```bash
bd create "USER-123: Feature title" \
  -t feature \
  -p 1 \
  --external-ref "https://yourcompany.atlassian.net/browse/USER-123" \
  --json
```

This allows:
- Easy navigation: JIRA ↔ bd ↔ Spec Kit
- Audit trail: Track implementation status in bd while keeping JIRA as source of truth
- Multi-tool support: Product managers use JIRA, developers use bd + Spec Kit

### 2. Include JIRA ID in Branch Names and Commits

```bash
git checkout -b feature/USER-123-csv-export
git commit -m "USER-123: Add CSV export endpoint (bd-42)"
```

### 3. Keep Gherkin Scenarios in Sync

- **JIRA**: Business-friendly Gherkin (high-level)
- **Spec Kit `spec.md`**: Elaborated acceptance tests (technical details)
- **E2E Tests**: Executable code matching Gherkin scenarios

If JIRA acceptance criteria change:
1. Update `spec.md` to reflect new criteria
2. Update or add E2E tests
3. Create new bd task issues if needed

### 4. Map DoD to Spec Kit Tasks

Ensure every DoD item has a corresponding task in `tasks.md`:

| DoD Item | Task in tasks.md |
|----------|------------------|
| Unit tests written and passing | "Write unit tests for X" |
| Integration tests written and passing | "Write integration test for Y" |
| Code reviewed and approved | (handled by PR process, not a task) |
| Documentation updated | "Update API docs and user guide" |

### 5. Use `/speckit-clarify` for Ambiguity

If JIRA story is unclear or missing details:

```
/speckit-clarify
```

This will:
- Identify underspecified areas in the spec
- Ask up to 5 targeted questions
- Encode answers back into `spec.md`

Bring these questions back to the product owner or update JIRA with clarifications.

### 6. Sync bd Status to JIRA (Optional Automation)

Consider setting up a webhook or script to sync bd issue status to JIRA:

- bd issue `in_progress` → JIRA story "In Progress"
- bd issue `closed` → JIRA story "Ready for QA" or "Done"

This keeps JIRA up-to-date without manual syncing.

---

## Example: Full Workflow

### JIRA Story: USER-456

**Title**: As a manager, I want to filter reports by date range

**Acceptance Criteria (Gherkin)**:

```gherkin
Scenario: Filter reports by valid date range
  Given I am on the reports page
  When I enter a start date of "2024-01-01" and end date of "2024-12-31"
  And I click "Apply Filter"
  Then only reports within that date range should be displayed

Scenario: Invalid date range
  Given I am on the reports page
  When I enter a start date of "2024-12-31" and end date of "2024-01-01"
  And I click "Apply Filter"
  Then I should see an error "Start date must be before end date"
```

**Definition of Done**:
- [ ] All acceptance criteria pass
- [ ] Unit tests for date validation logic
- [ ] Integration tests for filter endpoint
- [ ] E2E tests matching Gherkin scenarios
- [ ] Code reviewed
- [ ] Documentation updated

### Step 1: Create bd Feature Issue

```bash
bd create "USER-456: Filter reports by date range" \
  -t feature \
  -p 1 \
  --external-ref "https://company.atlassian.net/browse/USER-456" \
  --json
# Output: {"id": "bd-101", ...}
```

### Step 2: Run `/speckit-specify`

```
/speckit-specify USER-456: Filter reports by date range

[Include JIRA story, Gherkin, and DoD here]
```

**Result**: Creates `specs/101-filter-reports-by-date-range/spec.md`

### Step 3: Run `/speckit-plan`

```
/speckit-plan
```

**Result**: Creates `specs/101-filter-reports-by-date-range/plan.md`:

```markdown
## Implementation Plan

### Overview
Add date range filtering to the existing reports feature.

### Components to Modify
- Backend: Add date range query parameters to reports endpoint
- Frontend: Add date picker UI components
- Validation: Date range validation logic

### Technical Approach
1. Backend: Extend `GET /api/reports` with `startDate` and `endDate` query params
2. Frontend: Add DateRangePicker component from UI library
3. Validation: Validate start < end on both frontend and backend
4. Tests: Unit tests for validation, integration tests for endpoint, E2E for scenarios
```

### Step 4: Run `/speckit-tasks`

```
/speckit-tasks
```

**Result**: Creates `specs/101-filter-reports-by-date-range/tasks.md`:

```markdown
## Tasks

- [ ] Add date validation utility function (bd-102)
- [ ] Write unit tests for date validation (bd-103)
- [ ] Extend reports endpoint to accept date range params (bd-104)
- [ ] Write integration tests for filtered endpoint (bd-105)
- [ ] Add DateRangePicker component to frontend (bd-106)
- [ ] Wire up date picker to API call (bd-107)
- [ ] Write E2E test for valid date range (Gherkin scenario 1) (bd-108)
- [ ] Write E2E test for invalid date range (Gherkin scenario 2) (bd-109)
- [ ] Update API documentation (bd-110)
```

**bd issues created**: bd-102 through bd-110, all children of bd-101

### Step 5: Run `/speckit-implement`

```
/speckit-implement
```

**Result**: AI assistant implements each task in order, closing bd issues as it goes.

### Step 6: Create PR

```bash
git commit -m "USER-456: Add date range filtering to reports (bd-101)"
git push origin feature/USER-456-date-filter
gh pr create --title "USER-456: Filter reports by date range" --body "..."
```

**PR Description**:
- Links to JIRA: USER-456
- Links to bd: bd-101
- References Spec Kit: `specs/101-filter-reports-by-date-range/`
- Shows DoD checklist with all items checked

### Step 7: Post-Merge

- Close bd-101
- Update JIRA USER-456 to "Done"

---

## Troubleshooting

### Q: What if JIRA story is too vague?

Use `/speckit-clarify` to identify gaps, then bring questions to product owner. Update JIRA with answers before proceeding to `/speckit-plan`.

### Q: What if Gherkin scenarios are missing from JIRA?

You can draft them during `/speckit-specify`:
- AI assistant will suggest scenarios based on user story
- Add them to `spec.md`
- Recommend adding them back to JIRA for future reference

### Q: What if the JIRA story changes mid-implementation?

1. Update `spec.md` to reflect new requirements
2. Run `/speckit-plan` again (or manually update `plan.md`)
3. Run `/speckit-tasks` to generate new tasks
4. Create new bd task issues for the additional work
5. Continue with `/speckit-implement`

### Q: How do I handle dependencies between JIRA stories?

Use bd's dependency tracking:

```bash
bd dep bd-101 --depends-on bd-99 --type blocks
```

This ensures `bd ready` won't show bd-101 until bd-99 is closed.

### Q: Should I duplicate JIRA content into bd?

**No**. Keep JIRA as the source of truth. Use bd primarily for:
- Linking to JIRA (via `external_ref`)
- Tracking implementation status
- Surfacing ready work for AI assistants
- Managing task-level dependencies

---

## Summary

Using Spec Kit with JIRA stories that follow INVEST principles, include Gherkin acceptance criteria, and have Definition of Done checklists:

1. **JIRA** remains the source of truth for product management
2. **bd** tracks implementation status and dependencies, links to JIRA via `external_ref`
3. **Spec Kit** generates rich, version-controlled design artifacts from JIRA content
4. **AI assistants** work within the Spec Kit structure, guided by JIRA requirements
5. **Traceability** is maintained: JIRA → bd → Spec Kit docs → code → PR

This approach combines the best of both worlds:
- Product teams continue using JIRA as they always have
- Development teams gain structured, AI-friendly workflows
- Everyone benefits from improved traceability and auditability
