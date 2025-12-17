---
description: Synchronize the project with the available Wiser Windsurf workflows
auto_execution_mode: 1
---

# /sync-workflows
Sync org workflows from a central repo’s subfolder.

1. Use these defaults (prompt me to change if needed):
   - ORG_REPO_URL = git@github.com:WiserSolutions/agentic-development.git
   - ORG_BRANCH   = main
   - ORG_SUBDIR   = windsurf/workflows
   - TARGET_DIR   = .windsurf/workflows/_org

2. Prepare folders:
   - Run: `mkdir -p "$TARGET_DIR"`
   - Run: `TMP_DIR="$(mktemp -d 2>/dev/null || echo .windsurf/workflows/_org_tmp)"; rm -rf "$TMP_DIR"; mkdir -p "$TMP_DIR"`

3. Fetch source (shallow clone):
   - Run: `git clone --depth 1 --branch "$ORG_BRANCH" "$ORG_REPO_URL" "$TMP_DIR/src"`

4. Safety checks:
   - If `"$TMP_DIR/src/$ORG_SUBDIR"` does not exist, stop and show me the repo tree.

5. Sync files (prefer rsync; fall back to cp):
   - If `rsync` exists, run: `rsync -a --delete "$TMP_DIR/src/$ORG_SUBDIR"/ "$TARGET_DIR"/`
   - Else:
     - Run: `find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +`
     - Run: `cp -R "$TMP_DIR/src/$ORG_SUBDIR"/. "$TARGET_DIR"/`

6. Verify:
   - Run: `find "$TARGET_DIR" -name "*.md" -maxdepth 2 -print | sort`

7. Clean up:
   - Run: `rm -rf "$TMP_DIR"`

8. Finish:
   - Summarize what changed and list the slash commands discovered.
