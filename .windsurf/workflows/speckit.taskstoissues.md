---
description: Convert existing tasks into actionable, dependency-ordered GitHub issues for the feature based on available design artifacts.
tools: ['github/github-mcp-server/issue_write']
---

---
**CRITICAL: This project uses bd (beads) for ALL task tracking**

**ABSOLUTE PROHIBITION - NO EXCEPTIONS:**
- **NEVER use TodoWrite tool** - Any use is a VIOLATION of the constitution
- **NEVER create TODO.md files** - Creating TODO.md is FORBIDDEN
- **NEVER create TODO lists in markdown** - Task lists in ANY markdown file are PROHIBITED
- **NEVER work around this requirement** - There are NO exceptions

**REQUIRED:**
- **ALWAYS use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all tracking
- **ALWAYS track ALL tasks in bd** - Every task, subtask, and work item MUST be in bd

See CLAUDE.md and AGENTS.md for complete bd workflow instructions.
See .specify/memory/constitution.md Section IV for full requirements.
---


---
**CRITICAL: This project uses bd (beads) for ALL task tracking**

Before proceeding with this workflow:
- **DO NOT use TodoWrite tool** - Never create, update, or manage todos via TodoWrite
- **DO use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all tracking
- **DO NOT create markdown TODOs** - No TODO.md, task lists, or checklists in markdown

See CLAUDE.md and AGENTS.md for complete bd workflow instructions.
---


## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. Run `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").
1. From the executed script, extract the path to **tasks**.
1. Get the Git remote by running:

```bash
git config --get remote.origin.url
```

**ONLY PROCEED TO NEXT STEPS IF THE REMOTE IS A GITHUB URL**

1. For each task in the list, use the GitHub MCP server to create a new issue in the repository that is representative of the Git remote.

**UNDER NO CIRCUMSTANCES EVER CREATE ISSUES IN REPOSITORIES THAT DO NOT MATCH THE REMOTE URL**
