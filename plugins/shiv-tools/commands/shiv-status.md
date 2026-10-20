---
description: Show installed Shiv plugins, available commands, and detect local overrides
---

# Shiv Plugin Status

Show the current state of all installed Shiv plugins.

## Steps

1. Check if plugins are installed at `~/.claude/plugins/marketplaces/shiv-agentic-plugins/plugins/`.

2. For each plugin directory (`shiv-agile`, `shiv-dev`, `shiv-speckit`, `shiv-tools`):
   - Read `.claude-plugin/plugin.json` for the plugin description
   - List all commands in `commands/` directory
   - List all skills in `skills/` directory
   - List all agents in `agents/` directory

3. Show version info:
   ```bash
   cd ~/.claude/plugins/marketplaces/shiv-agentic-plugins && git log -1 --format="%h %ci %s"
   ```

4. Detect local overrides in the current project:
   - Check `.claude/commands/` for files matching any global plugin command names
   - Check `.claude/skills/` for directories matching any global plugin skill names
   - Check `.claude/agents/` for files matching any global plugin agent names
   - For each match, report whether the local file is identical or modified

5. Present results in a clear summary table:

| Plugin | Commands | Skills | Agents |
|--------|----------|--------|--------|
| shiv-agile | N | N | N |
| shiv-dev | N | N | N |
| shiv-speckit | N | N | N |
| shiv-tools | N | N | N |

6. List any overrides found:
   - IDENTICAL: local file matches global (recommend removing local copy)
   - OVERRIDE: local file differs from global (active project-specific override)
