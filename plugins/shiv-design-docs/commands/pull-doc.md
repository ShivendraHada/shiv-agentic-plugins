---
description: Pull a Confluence design document to local markdown. Supports bidirectional sync with conflict detection.
argument-hint: PAGE_ID [--force] [--output PATH]
---

# Pull Design Document from Confluence

Pull a Confluence page to local markdown, maintaining sync metadata for bidirectional updates.

## User Input

```text
$ARGUMENTS
```

## Configuration

Load config from `~/.claude/shiv-design-docs-config.json`. Use `cloudId` and `localDocsDir` from config.

---

## Step 1: Parse Arguments

1. **Parse flags** from `$ARGUMENTS`:
   - First positional argument: Confluence page ID (required)
   - `--force` — overwrite local without conflict check
   - `--output PATH` — custom local file path (overrides default location)
2. **If no page ID provided**: Ask the user:
   ```
   Enter the Confluence page ID or URL to pull: _
   ```
   If user provides a URL, extract the page ID from it.

---

## Step 2: Fetch from Confluence

1. Fetch the page using `mcp__atlassian__getConfluencePage`:
   ```
   cloudId: "<cloudId>"
   pageId: "<page-id>"
   contentFormat: "markdown"
   ```
2. Extract:
   - Page title
   - Page body (as markdown)
   - Space key and space ID
   - Parent page ID
   - Page status (draft/current)
   - Last modified timestamp
   - Page labels (if available via API)
   - Page version number

---

## Step 3: Determine Local File Path

### If `--output` is provided:
Use the specified path directly.

### If a local file with matching `confluencePageId` already exists:
Search for it:
```bash
grep -rl "confluencePageId: \"<page-id>\"" <localDocsDir>/
```
Use the found file path.

### If no existing local file:
Determine the path from the page metadata:
1. Try to detect the doc type from the page title (match against configured `titlePrefix` values)
2. Try to detect the epic/ticket key from the page title or labels
3. Construct path: `<localDocsDir>/<epic-key>/<type>.md`
4. If detection fails, ask the user:
   ```
   Where should this document be saved?
     Suggested: docs/design/SPE-1019/tech-arch.md
     Or enter a custom path: _
   ```

---

## Step 4: Check for Conflicts

### If local file exists:

1. Read the local file's frontmatter
2. Compare timestamps:
   - `lastSyncedAt` from frontmatter
   - `lastLocalEditAt` from frontmatter (or file modification time)
   - Remote last modified from Confluence

3. **No conflict** (remote is newer, local unchanged since last sync):
   - Proceed with update

4. **No conflict** (local is newer, remote unchanged since last sync):
   - Warn user: "Local version is newer than remote. Pull will overwrite local changes."
   - Ask for confirmation

5. **Conflict** (both changed since last sync):
   ```
   ## Sync Conflict Detected

   The document has been modified both locally and on Confluence since the last sync.

   **Last synced**: 2026-05-03T10:00:00Z
   **Local edit**: 2026-05-04T14:00:00Z  
   **Remote edit**: 2026-05-04T16:30:00Z

   Options:
     1. **Keep remote** — Overwrite local with the Confluence version
     2. **Keep local** — Do not pull, keep your local version
     3. **Show diff** — Show differences between local and remote
     4. **Abort** — Do nothing

   Your choice: _
   ```

### If `--force` is specified:
Skip conflict detection, overwrite local file.

---

## Step 5: Write Local File

1. Construct the frontmatter from page metadata:
   ```yaml
   ---
   title: "<page title>"
   type: <detected-type>
   confluencePageId: "<page-id>"
   confluenceSpaceKey: "<space-key>"
   confluenceSpaceId: "<space-id>"
   parentPageId: "<parent-page-id>"
   jiraEpic: <detected-epic-key or null>
   jiraTickets: [<detected-ticket-keys>]
   status: <page-status>
   labels: [<page-labels>]
   lastSyncedAt: <current-timestamp>
   lastLocalEditAt: <current-timestamp>
   lastRemoteEditAt: <remote-last-modified>
   ---
   ```

2. Write the file: frontmatter + page body (markdown)

3. Create parent directories if they don't exist

---

## Step 6: Report Result

```
## Pulled: [SPE-1019] Technical Architecture - OAuth2 Authentication

**Source**: https://<cloudId>/wiki/spaces/<space>/pages/<page-id>
**Local file**: docs/design/SPE-1019/tech-arch.md
**Status**: Current
**Synced at**: 2026-05-05T11:00:00Z

### Next Steps
- Edit the local file and run `/design-doc` to push changes back to Confluence
- `/list-docs` — View all local design docs and sync status
```

---

## Error Handling

- **Page not found**: Show error, suggest checking the page ID
- **Permission denied**: Show error, suggest checking Confluence permissions
- **Invalid page ID**: If user provided a URL, try to extract page ID; if that fails, show error
- **Local directory doesn't exist**: Create it automatically
