---
description: Update all Shiv plugins to the latest version from the central repository
---

# Shiv Plugin Sync

Update all globally installed Shiv plugins to the latest version.

## Steps

1. Run the following command to pull the latest plugin updates:

```bash
cd ~/.claude/plugins/marketplaces/shiv-plugins && git fetch origin main --depth 1 && git reset --hard origin/main
```

2. Report what changed by comparing the previous and new versions.

3. List any new commands, skills, or agents that were added.

4. Check the current project for local overrides that may now differ from the updated global versions:
   - Scan `.claude/commands/`, `.claude/skills/`, and `.claude/agents/` for files with the same names as global plugin files
   - Report any that exist, indicating whether they are identical (safe to remove) or modified (active override)

5. Summarize:
   - Updated: yes/no
   - New additions: list any new files
   - Overrides detected: list any local files that shadow global plugins
