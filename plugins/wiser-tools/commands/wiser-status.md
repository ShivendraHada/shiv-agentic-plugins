---
description: Show installed Wiser plugins, available commands, and detect local overrides
---

# Wiser Plugin Status

Show the current state of all installed Wiser plugins.

## Steps

1. Check if plugins are installed at `~/.claude/plugins/marketplaces/wiser-plugins/plugins/`.

2. For each plugin directory (`wiser-agile`, `wiser-dev`, `wiser-speckit`, `wiser-tools`):
   - Read `.claude-plugin/plugin.json` for the plugin description
   - List all commands in `commands/` directory
   - List all skills in `skills/` directory
   - List all agents in `agents/` directory

3. Show version info:
   ```bash
   cd ~/.claude/plugins/marketplaces/wiser-plugins && git log -1 --format="%h %ci %s"
   ```

4. Detect local overrides in the current project:
   - Check `.claude/commands/` for files matching any global plugin command names
   - Check `.claude/skills/` for directories matching any global plugin skill names
   - Check `.claude/agents/` for files matching any global plugin agent names
   - For each match, report whether the local file is identical or modified

5. Present results in a clear summary table:

| Plugin | Commands | Skills | Agents |
|--------|----------|--------|--------|
| wiser-agile | N | N | N |
| wiser-dev | N | N | N |
| wiser-speckit | N | N | N |
| wiser-tools | N | N | N |

6. List any overrides found:
   - IDENTICAL: local file matches global (recommend removing local copy)
   - OVERRIDE: local file differs from global (active project-specific override)
