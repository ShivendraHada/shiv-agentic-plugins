# Agentic TDD Workflow Installation Guide

This guide provides instructions for setting up and using the Agentic TDD workflow with Cascade/Windsurf.

## Prerequisites

- Bash shell environment (macOS, Linux, or WSL on Windows)
- Git repository with your project code
- Cascade/Windsurf AI assistant
- JIRA access for task management

## Installation Options

### Option 1: Global Installation (Recommended)

Installing the script globally allows you to run it from any directory:

```bash
# Navigate to the agentic-development repository
cd /path/to/agentic-development

# Run the installation script
./windsurf/scripts/cascade-tdd.sh --install
```

This will:
1. Create necessary directories in `~/.codeium/windsurf/workflows/`
2. Copy workflow files to the Windsurf directory
3. Create a symlink in `~/.local/bin/`
4. Add `~/.local/bin` to your PATH (if needed)
5. Create an alias for easier access

After installation, open a new terminal or run:

```bash
source ~/.zshrc  # or ~/.bashrc depending on your shell
```

### Option 2: Manual Usage (Without Installation)

If you prefer not to install globally:

```bash
# Navigate to the agentic-development repository
cd /path/to/agentic-development

# Run the script directly
./windsurf/scripts/cascade-tdd.sh <JIRA-TASK-ID>
```

## Usage

### Starting a New TDD Workflow

1. Navigate to your project repository:
   ```bash
   cd /path/to/your/project
   ```

2. Run the cascade-tdd script with your JIRA task ID:
   ```bash
   cascade-tdd PROJ-123  # If installed globally
   ```
   Or:
   ```bash
   /path/to/agentic-development/windsurf/scripts/cascade-tdd.sh PROJ-123  # If not installed
   ```

3. The script will generate a prompt and copy it to your clipboard

4. Open a new Cascade/Windsurf Chat window in write mode and paste the prompt

5. Cascade will start the Agentic TDD workflow and guide you through the process

### Workflow Steps

The workflow will follow these steps:
1. Initial requirement extraction from JIRA
2. Clarifying questions
3. Requirement validation (human checkpoint)
4. Writing failing unit tests
5. Test validation (human checkpoint)
6. Implementation code
7. Implementation validation (human checkpoint)
8. Refactoring
9. Refactor validation (human checkpoint)
10. Integration testing
11. Integration test validation (human checkpoint)
12. Integration code
13. Integration code validation (human checkpoint)
14. Pull request creation
15. Workflow completion

Each step with "(human checkpoint)" requires your explicit approval before proceeding.

## Uninstallation

If you installed the script globally and wish to remove it:

```bash
cascade-tdd --uninstall
```

Or:

```bash
/path/to/agentic-development/windsurf/scripts/cascade-tdd.sh --uninstall
```

## Troubleshooting

### Workflow File Not Found

If you see an error about the workflow file not being found:

```bash
# Reinstall to ensure workflow files are copied correctly
cascade-tdd --install
```

### Permission Denied

If you encounter permission issues:

```bash
# Make the script executable
chmod +x /path/to/agentic-development/windsurf/scripts/cascade-tdd.sh
```

### PATH Issues

If the `cascade-tdd` command is not found after installation:

```bash
# Add to PATH manually
export PATH="$HOME/.local/bin:$PATH"
```

## Additional Resources

- [Agentic TDD Workflow Documentation](./windsurf/workflows/agentic-tdd-jira.md)
- [Test Templates](./templates/test-templates.md)
- [Integration Guides](./docs/integrations.md)
- [AI Prompt Engineering Guide](./docs/prompts.md)
