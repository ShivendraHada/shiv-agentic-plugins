# Beads + Spec Kit Onboarding

This directory contains onboarding materials for using **bd (Beads)** and **Spec Kit** with Claude Code.

## 📚 Documentation

### Getting Started

- **[QUICK-REFERENCE.md](QUICK-REFERENCE.md)** - Command reference and common workflows
- **[slides.md](slides.md)** - Presentation slides

### Workflows

- **[jira-to-speckit-workflow.md](jira-to-speckit-workflow.md)** - How to use Spec Kit with JIRA stories (INVEST + Gherkin + DoD)

## 🚀 Quick Start

### Automated Installation

From the repository root:

```bash
./install-bd-speckit.sh
```

This script has two phases:
- **Phase 1**: Install/upgrade bd, beads-mcp, and Spec Kit (system-wide)
- **Phase 2**: Initialize bd and Spec Kit in your repository (independent of Phase 1)
  - Configures constitution to enforce bd usage
  - Injects bd instructions into all workflow files
  - Updates CLAUDE.md and AGENTS.md

The repository initialization in Phase 2 runs regardless of whether you skip tool installations in Phase 1.

### Manual Steps Required

After running the installation script:

1. **Restart Claude Code**
2. **Verify MCP functions** are available
3. **Test Spec Kit slash commands** (`/speckit-*`)

## 📖 What You'll Learn

### Why bd + Spec Kit?

- **Persistent Memory**: AI assistants lose context; bd and Spec Kit preserve it
- **Dependency Tracking**: Know what's blocked vs. ready to work on
- **Multi-Assistant Coordination**: Multiple team members and AI assistants work without conflicts
- **Spec-Driven Development**: Prevent "spec drift" and maintain TDD discipline
- **Full Traceability**: Track from JIRA → bd issue → Spec Kit docs → code → PR

### Core Workflows

1. **Feature Development**
   - Create bd feature issue
   - Use `/speckit-specify` to create specification
   - Use `/speckit-plan` to create implementation plan
   - Use `/speckit-tasks` to generate tasks (auto-creates bd task issues)
   - Use `/speckit-implement` to execute (updates bd status)

2. **JIRA Integration**
   - Sync JIRA stories to bd with `external_ref`
   - Convert Gherkin scenarios to automated tests
   - Map Definition of Done to Spec Kit tasks
   - Maintain traceability: JIRA ↔ bd ↔ Spec Kit ↔ code

3. **AI Assistant Collaboration**
   - Claude Code uses MCP functions for bd
   - Uses Spec Kit slash commands
   - All changes tracked in git via `.beads/issues.jsonl`

## 🎯 Key Resources

### Installation

- **Automated Script**: `../../install-bd-speckit.sh`
- **Quick Reference**: [QUICK-REFERENCE.md](QUICK-REFERENCE.md)

### Presentation

- **Slides**: [slides.md](slides.md)

### Workflows

- **JIRA Integration**: [jira-to-speckit-workflow.md](jira-to-speckit-workflow.md)
  - Working with INVEST-compliant stories
  - Converting Gherkin to automated tests
  - Mapping Definition of Done to tasks

### Project Configuration

- **CLAUDE.md**: bd workflow for Claude Code (in repo root)
- **AGENTS.md**: General AI agent workflow (in repo root)

## 🔧 Tools Covered

### bd (Beads)

- **Purpose**: Repository-local issue tracker
- **Key Features**: Dependency tracking, git-sync, ready work detection
- **MCP Integration**: Direct function calls from AI assistants
- **GitHub**: https://github.com/steveyegge/beads

### Spec Kit

- **Purpose**: Spec-driven development toolkit
- **Key Features**: `/speckit-*` commands, version-controlled specs
- **Workflow**: specify → plan → tasks → implement
- **GitHub**: https://github.com/github/spec-kit

### beads-mcp

- **Purpose**: MCP server for bd integration
- **Enables**: AI assistants to use bd directly via MCP functions
- **PyPI**: https://pypi.org/project/beads-mcp/

## 📋 Prerequisites

- macOS (required for automated script)
- Homebrew
- Python 3
- Git repository
- Claude Code

## 🎓 Audience

This onboarding is designed for:

- Engineers using Claude Code
- Teams transitioning from TODO.md to structured issue tracking
- Teams using JIRA with INVEST stories and Gherkin acceptance criteria
- Anyone wanting to maintain discipline and traceability in AI-assisted development

## 📞 Support

- **Workflow Questions**: See [QUICK-REFERENCE.md](QUICK-REFERENCE.md)
- **JIRA Integration**: See [jira-to-speckit-workflow.md](jira-to-speckit-workflow.md)
- **Project-Specific**: See `AGENTS.md` and `CLAUDE.md` in repository root

## 🚦 Next Steps

1. **Install**: Run `./install-bd-speckit.sh` from repository root
2. **Review Slides**: Read [slides.md](slides.md)
3. **Try a Feature**: Use `/speckit-specify` to create your first feature
4. **Explore JIRA Workflow**: If using JIRA, see [jira-to-speckit-workflow.md](jira-to-speckit-workflow.md)

---

**Last Updated**: 2026-09-28
**Version**: 1.1
