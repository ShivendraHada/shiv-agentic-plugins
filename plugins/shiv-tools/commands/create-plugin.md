---
description: Create a new Claude Code plugin with the standard Shiv structure, including scaffolding, marketplace registration, and optional commands/skills/agents
argument-hint: Plugin name and brief description (e.g. "shiv-analytics - Analytics dashboards and reporting workflows")
---

# Create Plugin

Scaffold a new plugin in the shiv-agentic-plugins repository following the established conventions.

## User Input

```text
$ARGUMENTS
```

Use the input above to determine the plugin name and purpose. If no input is provided, ask for:
1. Plugin name (must start with `shiv-` prefix)
2. Brief description of what the plugin does
3. Category: `development`, `productivity`, or `utilities`
4. What components to scaffold: commands, skills, agents (at least one required)

## Plugin Structure

Every plugin MUST follow this exact directory layout under `plugins/<plugin-name>/`:

```
plugins/<plugin-name>/
  .claude-plugin/
    plugin.json
  commands/        # Slash commands (user-invocable via /<plugin-name>:<command-name>)
  skills/          # Background knowledge (auto-applied when relevant)
  agents/          # Subagent definitions (invocable via Agent tool)
```

Only create the directories for components the user requested. At minimum one of commands/, skills/, or agents/ must exist.

## Step-by-Step Process

### 1. Validate Plugin Name

- MUST start with `shiv-` prefix
- MUST be lowercase kebab-case (e.g. `shiv-analytics`, `shiv-ci`)
- MUST NOT conflict with existing plugins — check `plugins/` directory
- If invalid, ask the user to provide a corrected name

### 2. Create plugin.json

Create `plugins/<plugin-name>/.claude-plugin/plugin.json`:

```json
{
  "name": "<plugin-name>",
  "description": "<full description of the plugin's purpose and capabilities>",
  "author": {
    "name": "Shiv Solutions",
    "email": "engineering@shivsolutions.com"
  }
}
```

### 3. Scaffold Components

For each requested component type, create the directory and a starter file:

#### Commands (slash commands)

Create `plugins/<plugin-name>/commands/<command-name>.md` with this template:

```markdown
---
description: <One-line description of what this command does>
argument-hint: <What the user should pass as arguments>
---

# <Command Title>

<Brief description of the command's purpose.>

## User Input

\```text
$ARGUMENTS
\```

Use the input above to understand the task. If no input is provided, ask the user for the required details.

## Steps

1. <First step>
2. <Second step>
3. <Continue as needed>
```

#### Skills (background knowledge)

Create `plugins/<plugin-name>/skills/<skill-name>/SKILL.md` with this template:

```markdown
---
description: <One-line description of when this skill applies>
trigger: <Condition that activates this skill automatically>
---

# <Skill Name>

<Background knowledge content that gets injected into context when the trigger condition is met.>

## Key Concepts

- <Concept 1>
- <Concept 2>

## Rules

- <Rule 1>
- <Rule 2>
```

Optional: create a `references/` subdirectory under the skill for supplementary .md files.

#### Agents (subagent definitions)

Create `plugins/<plugin-name>/agents/<agent-name>.md` with this template:

```markdown
---
description: <One-line description used to match this agent to tasks>
tools: <Comma-separated list of allowed tools, e.g. "Read, Glob, Grep">
---

# <Agent Name>

<Description of what this agent does and when it should be used.>

## Instructions

1. <Step 1>
2. <Step 2>
3. <Continue as needed>
```

### 4. Register in marketplace.json

Add the new plugin entry to `.claude-plugin/marketplace.json` in the `plugins` array:

```json
{
  "name": "<plugin-name>",
  "description": "<short marketplace description>",
  "version": "1.0.0",
  "author": {
    "name": "Shiv Solutions",
    "email": "engineering@shivsolutions.com"
  },
  "source": "./plugins/<plugin-name>",
  "category": "<development|productivity|utilities>"
}
```

### 5. Verify Structure

After creating all files, verify:
- [ ] `plugins/<plugin-name>/.claude-plugin/plugin.json` exists and is valid JSON
- [ ] At least one of `commands/`, `skills/`, or `agents/` exists with content
- [ ] Entry added to `.claude-plugin/marketplace.json`
- [ ] No naming conflicts with existing plugins or commands
- [ ] All .md files have valid frontmatter with `description` field

### 6. Summary

Report to the user:
- Plugin name and location
- Components created (list each command, skill, agent)
- How to use: `/<plugin-name>:<command-name>` for commands
- Remind them to run `/shiv-tools:shiv-sync` or reinstall to pick up changes

## Conventions

- Command filenames should be descriptive kebab-case (e.g. `run-analysis.md`, not `analysis.md`)
- Skill directories should be descriptive kebab-case (e.g. `ci-rules/`, not `rules/`)
- Agent filenames should describe the agent's role (e.g. `code-quality-checker.md`)
- All descriptions should be concise but specific enough for Claude to match them to user intent
- Commands MUST include `$ARGUMENTS` block to capture user input
- Skills MUST include a `trigger` field in frontmatter
- Agents MUST include a `tools` field in frontmatter listing allowed tools
