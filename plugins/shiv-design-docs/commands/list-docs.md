---
description: List all local design documents and their Confluence sync status.
argument-hint: [--space KEY] [--type TYPE] [--status STATUS]
---

# List Design Documents

Show all local design documents with their sync status, Confluence links, and metadata.

## User Input

```text
$ARGUMENTS
```

## Configuration

Load config from `~/.claude/shiv-design-docs-config.json`. Use `localDocsDir` from config.

---

## Step 1: Parse Arguments

1. **Parse flags** from `$ARGUMENTS`:
   - `--space KEY` — filter by Confluence space
   - `--type TYPE` — filter by doc type (tech-arch, detailed-design, adr, runbook, api-design)
   - `--status STATUS` — filter by status (draft, in-review, approved, not-synced)

---

## Step 2: Scan Local Documents

1. Find all markdown files under `<localDocsDir>/` that have design doc frontmatter (contain `confluencePageId` or `type` fields in YAML frontmatter)
2. For each file, extract frontmatter fields:
   - `title`
   - `type`
   - `confluencePageId`
   - `confluenceSpaceKey`
   - `jiraEpic`
   - `status`
   - `lastSyncedAt`
   - `lastLocalEditAt`
   - `lastRemoteEditAt`

3. Determine sync status for each document:
   - **Not synced**: `confluencePageId` is null
   - **In sync**: `lastSyncedAt` >= `lastLocalEditAt` and no remote changes
   - **Local changes**: `lastLocalEditAt` > `lastSyncedAt`
   - **Remote changes**: Cannot determine without API call — mark as "unknown" unless user runs with `--check-remote`
   - **Conflict**: Both local and remote changed (only detectable with API call)

---

## Step 3: Apply Filters

Filter the results based on provided flags:
- `--space`: Match against `confluenceSpaceKey`
- `--type`: Match against `type`
- `--status`: Match against computed sync status

---

## Step 4: Display Results

```
## Design Documents (docs/design/)

| # | Epic | Type | Title | Status | Sync | Last Edit |
|---|------|------|-------|--------|------|-----------|
| 1 | SPE-1019 | tech-arch | Technical Architecture - OAuth2 | Draft | Local changes | 2026-05-04 |
| 2 | SPE-1019 | detailed-design | Detailed Design - OAuth2 | Approved | In sync | 2026-05-03 |
| 3 | SPE-1025 | adr | ADR - Database Selection | In Review | Not synced | 2026-05-05 |

**Total**: 3 documents (1 in sync, 1 with local changes, 1 not synced)

### Actions
- `/design-doc --epic SPE-1019 --type tech-arch` — Update and push a document
- `/pull-doc <page-id>` — Pull latest from Confluence
```

If no documents found:
```
No design documents found in docs/design/.

Create one with `/design-doc --epic <KEY> --type tech-arch`
```

---

## Error Handling

- **Directory doesn't exist**: Create it and report "No documents found"
- **Malformed frontmatter**: Skip the file, warn user about the malformed file
- **No matching filters**: Report "No documents match the specified filters"
