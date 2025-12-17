# Sync Workflows Command

Synchronize Claude Code commands from a central repository's subfolder to your local project.

## User Input

```text
$ARGUMENTS
```

Use the input above to override default values if provided.

## Default Configuration

Use these defaults (prompt to change if needed):
- **ORG_REPO_URL** = git@github.com:WiserSolutions/agentic-development.git
- **ORG_BRANCH** = main
- **ORG_SUBDIR** = claude-commands
- **TARGET_DIR** = .claude/commands

## Execution Steps

### 1. Prepare folders
Create target directory and temporary directory for cloning:
```bash
mkdir -p "$TARGET_DIR"
TMP_DIR="$(mktemp -d 2>/dev/null || echo .claude/commands_tmp)"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
```

### 2. Fetch source (shallow clone)
Clone the repository with minimal depth:
```bash
git clone --depth 1 --branch "$ORG_BRANCH" "$ORG_REPO_URL" "$TMP_DIR/src"
```

### 3. Safety checks
Verify the source directory exists:
- If `"$TMP_DIR/src/$ORG_SUBDIR"` does not exist, stop and show the repo tree
- This prevents syncing from an invalid or restructured repository

### 4. Sync files
Prefer rsync for efficient syncing; fall back to cp:

**If rsync exists:**
```bash
rsync -a --delete "$TMP_DIR/src/$ORG_SUBDIR"/ "$TARGET_DIR"/
```

**Otherwise:**
```bash
find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
cp -R "$TMP_DIR/src/$ORG_SUBDIR"/. "$TARGET_DIR"/
```

### 5. Verify
List all synced markdown files:
```bash
find "$TARGET_DIR" -name "*.md" -maxdepth 2 -print | sort
```

### 6. Clean up
Remove temporary directory:
```bash
rm -rf "$TMP_DIR"
```

### 7. Finish
Summarize:
- What files were added, updated, or removed
- List all slash commands discovered (file names without .md extension)
- Any errors encountered during the sync process

## Example Output

```
Sync completed successfully!

Commands synced to .claude/commands/:
  - /create-epic
  - /create-story
  - /create-technical-enablement-story
  - /story-invest-score
  - /tdd-workflow
  - /auto-groom
  - /notes-to-work-item
  - /sync-workflows

Files changed:
  - Added: create-epic.md
  - Updated: create-story.md
  - Removed: deprecated-command.md

To use these commands, type / followed by the command name.
```

## Customization

To use a different source repository or branch, provide arguments:
```
/sync-workflows --repo git@github.com:MyOrg/my-repo.git --branch develop --subdir workflows
```

Or respond to the prompts when the command asks for configuration.
