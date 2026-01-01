# Claude Code Project Instructions

## Issue Tracking: Use bd (Beads) - NOT TodoWrite

**CRITICAL**: This project uses **[bd (beads)](https://github.com/steveyegge/beads)** for ALL issue tracking.

### What This Means for You

1. **DO NOT use TodoWrite tool** - Never create, update, or manage todos via TodoWrite
2. **DO use bd MCP functions** - Use `mcp__plugin_beads_beads__*` functions for all task tracking
3. **DO NOT create markdown TODOs** - No TODO.md, task lists, or checklists in markdown

### Required Workflow

Before starting any work:

```
1. Check for ready work:
   mcp__plugin_beads_beads__ready()

2. Pick a task and claim it:
   mcp__plugin_beads_beads__update(issue_id="bd-XXX", status="in_progress")

3. Work on the task (code, tests, docs)

4. When done, close it:
   mcp__plugin_beads_beads__close(issue_id="bd-XXX", reason="Completed")
```

### Creating New Issues

If you discover new work while implementing:

```
mcp__plugin_beads_beads__create(
  title="Issue title",
  issue_type="task|bug|feature",
  priority=1,
  deps=["parent-issue-id"]  # if related to current work
)
```

### Why bd Instead of TodoWrite?

- **Persistent**: Issues survive across chat sessions
- **Dependency-aware**: Track blockers and relationships
- **Git-synced**: Auto-syncs to `.beads/issues.jsonl`
- **AI-optimized**: JSON output, ready work detection, discovered-from links
- **Multi-assistant safe**: Multiple assistants can work without conflicts

### Available bd MCP Functions

You have access to these MCP functions:
- `mcp__plugin_beads_beads__ready()` - Find tasks ready to work on
- `mcp__plugin_beads_beads__list()` - List all issues with filters
- `mcp__plugin_beads_beads__show(issue_id)` - Show detailed issue info
- `mcp__plugin_beads_beads__create()` - Create new issue
- `mcp__plugin_beads_beads__update()` - Update issue status/priority
- `mcp__plugin_beads_beads__close()` - Close completed issue
- `mcp__plugin_beads_beads__dep()` - Add dependencies between issues

### Important Rules

- ✅ **ALWAYS check `mcp__plugin_beads_beads__ready()` before asking "what should I work on?"**
- ✅ **ALWAYS update issue status to `in_progress` when you start working**
- ✅ **ALWAYS close issues when you complete them**
- ✅ **ALWAYS commit `.beads/issues.jsonl` with your code changes**
- ❌ **NEVER use TodoWrite tool for any reason**
- ❌ **NEVER create markdown TODO lists**
- ❌ **NEVER use external issue trackers**

For complete workflow details, see [AGENTS.md](AGENTS.md).

---

## Project Organization

This project is a general-purpose workspace for research, Agile artifacts, articles, and experimentation. Follow these folder conventions:

### Agile Artifacts (`agile/`)

All Agile artifacts (Epics, Stories, acceptance criteria, etc.) go under the `agile/` folder.

**Structure:**
```
agile/
├── <epic-id>/           # Folder named after the Epic ID (e.g., EPIC-001)
│   ├── epic.md          # Epic definition
│   ├── <story-id>.md    # Stories belonging to this Epic
│   └── ...
```

**Rules:**
- ✅ Create a folder for each Epic using its ID as the folder name
- ✅ Keep all Stories for an Epic within that Epic's folder
- ✅ Use consistent naming: `epic.md` for the Epic, story IDs for Stories
- ❌ Do NOT scatter Agile artifacts in the root or other folders

### Scripts (`scripts/`)

Research scripts, prototypes, and temporary/experimental scripts go in the `scripts/` folder.

**Examples:**
- Data extraction or scraping scripts
- One-off analysis scripts
- Proof-of-concept code
- Utility scripts for project tasks

**Rules:**
- ✅ Add a brief comment header explaining the script's purpose
- ✅ Clean up or archive scripts that are no longer needed
- ❌ Do NOT put production code here

### Articles (`articles/`)

Writing not directly related to this project (blog posts, documentation drafts, research notes, essays) goes in the `articles/` folder.

**Structure:**
```
articles/
├── <topic>/             # Organize by topic if multiple related pieces
│   ├── article.md
│   └── assets/          # Images, diagrams, etc.
└── standalone-article.md
```

**Rules:**
- ✅ Use descriptive filenames or topic folders
- ✅ Keep associated assets (images, diagrams) with their articles
- ❌ Do NOT mix project documentation with external articles

---

## Agentic Development Workflows

This project is designed as a workspace for **agentic development**—using AI assistants to drive software development, research, and content creation workflows. Here's how to use the folder structure effectively with AI agents.

### Overview: The Agentic Development Loop

```
┌─────────────────────────────────────────────────────────────┐
│                    AGENTIC DEVELOPMENT                       │
├─────────────────────────────────────────────────────────────┤
│  1. PLAN      → Create Epic/Stories in agile/<epic-id>/     │
│  2. TRACK     → Create bd issues for implementation tasks   │
│  3. PROTOTYPE → Write exploratory code in scripts/          │
│  4. BUILD     → Implement features (tracked via bd)         │
│  5. DOCUMENT  → Write articles/learnings in articles/       │
│  6. ITERATE   → Close issues, sync, push, repeat            │
└─────────────────────────────────────────────────────────────┘
```

### Workflow 1: Feature Development with Agile Artifacts

Use this workflow when developing new features or capabilities.

**Step 1: Create the Epic**
```bash
# Create epic folder and definition
mkdir -p agile/EPIC-001
# AI writes the epic.md with business context, goals, success criteria
```

**Step 2: Break Down into Stories**
```bash
# AI creates stories within the epic folder
agile/EPIC-001/
├── epic.md
├── STORY-001.md   # User-facing story with acceptance criteria
├── STORY-002.md
└── STORY-003.md
```

**Step 3: Create bd Issues for Implementation**
```
# For each story, create trackable implementation tasks
bd create --title="Implement STORY-001: User login" --type=feature
bd create --title="Add tests for STORY-001" --type=task
bd dep add <test-issue> <impl-issue>  # Tests depend on implementation
```

**Step 4: Implement and Track**
```
bd ready                              # Find what's ready to work on
bd update <issue-id> --status=in_progress
# ... do the work ...
bd close <issue-id>
bd sync
```

### Workflow 2: Research and Prototyping

Use this workflow when exploring new technologies, APIs, or approaches.

**Step 1: Create Research Script**
```python
# scripts/explore-new-api.py
"""
Research script: Exploring the XYZ API
Purpose: Evaluate feasibility for feature EPIC-002
Author: AI Assistant
Date: 2024-01-15
"""
# Prototype code here...
```

**Step 2: Track Research in bd**
```
bd create --title="Research XYZ API integration options" --type=task
bd update <issue-id> --status=in_progress
# ... run experiments in scripts/ ...
bd close <issue-id> --reason="Completed - documented findings in articles/xyz-api-research/"
```

**Step 3: Document Findings**
```
articles/
└── xyz-api-research/
    ├── findings.md      # Summary of research
    ├── code-samples.md  # Key code patterns discovered
    └── decision.md      # Recommendation and rationale
```

### Workflow 3: Writing and Content Creation

Use this workflow for blog posts, documentation, or technical writing.

**Step 1: Create Article Structure**
```
articles/
└── building-ai-agents/
    ├── outline.md       # Initial structure
    ├── draft-v1.md      # First draft
    ├── assets/
    │   └── architecture-diagram.png
    └── final.md         # Polished version
```

**Step 2: Track Writing Progress**
```
bd create --title="Write article: Building AI Agents" --type=task
bd create --title="Create diagrams for AI Agents article" --type=task
bd create --title="Review and edit AI Agents article" --type=task
# Set dependencies so review happens after writing
```

### Workflow 4: Multi-Session Agentic Projects

For larger projects spanning multiple AI sessions:

**Session 1: Planning**
```
1. Create Epic in agile/<epic-id>/
2. Create Stories with acceptance criteria
3. Create bd issues for all implementation tasks
4. Set up dependencies between issues
5. bd sync && git commit && git push
```

**Session 2+: Implementation**
```
1. bd ready                    # See what's unblocked
2. bd show <issue-id>          # Review context
3. Claim and work on issue
4. bd close <issue-id>
5. bd sync && git commit && git push
```

**Key Principle**: Every session ends with `bd sync && git push` so the next session (or another agent) can pick up where you left off.

### Best Practices for Agentic Development

| Practice | Why It Matters |
|----------|----------------|
| **Always use bd for tracking** | Persists across sessions, visible to all agents |
| **Keep scripts disposable** | Prototypes in `scripts/` can be deleted without guilt |
| **Epic folders are complete units** | Everything about a feature lives together |
| **Articles capture institutional knowledge** | Learnings don't get lost when chat history clears |
| **Commit frequently** | Small commits make it easy to resume or rollback |
| **Use dependencies in bd** | Prevents working on tasks with unmet prerequisites |

### Example: Full Agentic Development Cycle

```bash
# 1. User requests a feature
"Add user authentication with OAuth"

# 2. AI creates the Epic structure
mkdir -p agile/EPIC-AUTH
# Writes epic.md, STORY-001.md (login), STORY-002.md (logout), etc.

# 3. AI creates bd issues
bd create --title="Set up OAuth provider configuration" --type=task --priority=1
bd create --title="Implement OAuth callback handler" --type=task --priority=1
bd create --title="Add session management" --type=task --priority=1
bd create --title="Write auth integration tests" --type=task --priority=2
# Sets dependencies...

# 4. AI prototypes in scripts/
# scripts/test-oauth-flow.py - Quick validation of OAuth flow

# 5. AI implements (tracked via bd)
bd ready
bd update <issue> --status=in_progress
# ... implements feature ...
bd close <issue>

# 6. AI documents learnings
# articles/oauth-implementation-notes.md

# 7. Session ends properly
bd sync
git add .
git commit -m "feat: Add OAuth authentication (EPIC-AUTH)"
git push
```

This workflow ensures that:
- Work is never lost between sessions
- Multiple agents can collaborate on the same project
- Progress is visible and trackable
- Knowledge is captured and preserved
