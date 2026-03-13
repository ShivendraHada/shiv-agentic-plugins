# Claude Code Commands

This folder contains Claude Code slash commands that can be installed in any project.

## Installation

### Quick Install (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/WiserSolutions/agentic-development/main/install-claude-commands.sh | bash
```

### Manual Installation

1. Clone or download this repository
2. Copy the desired `.md` files to your project's `.claude/commands/` folder

```bash
# Create the commands directory
mkdir -p .claude/commands

# Copy all commands
cp claude-commands/*.md .claude/commands/
```

### Using the Install Script

```bash
# Run with defaults
./install-claude-commands.sh

# Override options
./install-claude-commands.sh --repo https://github.com/MyOrg/my-repo.git --branch develop

# Show help
./install-claude-commands.sh --help
```

## Available Commands

### Agile & Story Management

| Command | Description |
|---------|-------------|
| `/create-epic` | Create high-quality Epics following SMART criteria |
| `/create-story` | Create high-quality User Stories following INVEST principles |
| `/create-technical-enablement-story` | Create Technical Enablement stories for infrastructure work |
| `/story-invest-score` | Score a story against INVEST criteria with improvement recommendations |
| `/story-quality-kpis` | Generate Story Quality KPIs across engineering teams |
| `/auto-groom` | Automatically groom all stories in a sprint |
| `/notes-to-work-item` | Transform quick notes into epics or stories |

### Development Workflows

| Command | Description |
|---------|-------------|
| `/tdd-workflow` | Agentic Test-Driven Development with human checkpoints |
| `/agentic-tdd-jira` | TDD workflow integrated with JIRA task tracking |
| `/agentic-terraform` | Jira-to-Terraform infrastructure workflow |

### Speckit Commands

| Command | Description |
|---------|-------------|
| `/speckit.specify` | Create feature specifications from natural language |
| `/speckit.clarify` | Clarify underspecified areas in specifications |
| `/speckit.plan` | Generate implementation plans from specifications |
| `/speckit.tasks` | Generate actionable task lists from plans |
| `/speckit.implement` | Execute implementation by processing tasks |
| `/speckit.analyze` | Cross-artifact consistency analysis |
| `/speckit.checklist` | Generate custom checklists for features |
| `/speckit.constitution` | Create/update project constitution |
| `/speckit.taskstoissues` | Convert tasks to GitHub issues |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/sync-workflows` | Sync commands from the central repository |

## Usage

To use a command in Claude Code, type `/` followed by the command name:

```
/create-story
```

You can also pass arguments:

```
/create-story As a customer, I want to view my order history
```

## Customization

Commands are simple markdown files. You can:

1. **Modify existing commands** - Edit the `.md` files in `.claude/commands/`
2. **Create new commands** - Add new `.md` files with your custom prompts
3. **Share commands** - Commands can be shared across teams via git

## Command Structure

Each command file is a markdown document that serves as a prompt template:

```markdown
# Command Name

Description of what this command does.

## User Input

\`\`\`text
$ARGUMENTS
\`\`\`

## Workflow Steps

1. Step one
2. Step two
...
```

The `$ARGUMENTS` placeholder is replaced with any text the user types after the command.

## Syncing Commands

To update commands from the central repository:

```bash
/sync-workflows
```

Or run the install script again:

```bash
./install-claude-commands.sh
```

## Contributing

To add or improve commands:

1. Create/edit command files in `claude-commands/`
2. Test locally by copying to `.claude/commands/`
3. Submit a pull request

## Related

- [Windsurf Workflows](.windsurf/workflows/) - Original Windsurf workflow versions
- [CLAUDE.md](../CLAUDE.md) - Project-specific Claude Code instructions
- [AGENTS.md](../AGENTS.md) - Agent workflow documentation
