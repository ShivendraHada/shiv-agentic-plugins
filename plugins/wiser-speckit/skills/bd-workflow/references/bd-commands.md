# bd CLI Command Reference

Quick reference for all beads (bd) commands. Use `--json` flag with any command for machine-readable output.

## Task Discovery

### bd ready

Find unblocked tasks that are ready to be worked on.

```bash
bd ready [--json]
```

Returns issues whose dependencies are all resolved and whose status allows work to begin. This is the primary entry point for deciding what to work on next.

### bd list

List all issues in the database.

```bash
bd list [--json]
```

Returns all issues regardless of status or dependency state. Useful for getting a full picture of tracked work.

### bd show

Show full details of a specific issue.

```bash
bd show <id> [--json]
```

Displays all fields for the given issue including title, type, priority, status, dependencies, and history.

### bd search

Search issues by text content.

```bash
bd search <query>
```

Performs a text search across issue titles and descriptions. Useful for finding related issues or checking if a concern is already tracked.

## Task Management

### bd create

Create a new issue.

```bash
bd create "title" -t <type> -p <priority> [--deps <id1> <id2> ...] [--json]
```

**Parameters**:
- `"title"` -- Short descriptive title for the issue (required)
- `-t <type>` -- Issue type: `bug`, `feature`, `task`, `epic`, `chore` (required)
- `-p <priority>` -- Priority level: `0` (Critical), `1` (High), `2` (Medium), `3` (Low), `4` (Backlog) (required)
- `--deps <ids>` -- Space-separated list of issue IDs this issue depends on (optional)
- `--json` -- Output result as JSON (optional)

**Examples**:

```bash
# Create a high-priority feature
bd create "Add user authentication endpoint" -t feature -p 1

# Create a task that depends on two other issues
bd create "Integrate auth with API gateway" -t task -p 2 --deps 3 7

# Create a critical bug with JSON output
bd create "Fix null pointer in payment flow" -t bug -p 0 --json
```

### bd update

Update an existing issue.

```bash
bd update <id> --status <status> [--priority <n>] [--json]
```

**Parameters**:
- `<id>` -- Issue ID to update (required)
- `--status <status>` -- New status value (e.g., `in-progress`, `blocked`) (optional)
- `--priority <n>` -- New priority level (optional)
- `--json` -- Output result as JSON (optional)

**Examples**:

```bash
# Start working on an issue
bd update 5 --status in-progress

# Reprioritize an issue
bd update 12 --priority 1

# Mark as blocked with JSON output
bd update 8 --status blocked --json
```

### bd close

Close a completed issue.

```bash
bd close <id> --reason "reason" [--json]
```

**Parameters**:
- `<id>` -- Issue ID to close (required)
- `--reason "reason"` -- Explanation of what was done or why the issue is closed (required)
- `--json` -- Output result as JSON (optional)

**Examples**:

```bash
# Close a completed feature
bd close 5 --reason "Authentication endpoint implemented with JWT support and tests"

# Close a bug as resolved
bd close 9 --reason "Fixed null check in payment service, added regression test"

# Close as won't-fix
bd close 14 --reason "Superseded by new design in issue 20"
```

## Dependency Management

### bd dep add

Create a dependency relationship between two issues.

```bash
bd dep add <dependent-id> <dependency-id>
```

Makes issue `<dependent-id>` depend on issue `<dependency-id>`. The dependent issue will not appear in `bd ready` until the dependency is closed.

**Example**:

```bash
# Issue 10 cannot start until issue 5 is done
bd dep add 10 5
```

### bd dep tree

Display the dependency tree for an issue.

```bash
bd dep tree <id>
```

Shows what the issue depends on (upstream) and what depends on it (downstream). Useful for understanding blocking relationships and execution order.

**Example**:

```bash
bd dep tree 10
```

## Synchronization

### bd sync

Synchronize bd state with git.

```bash
bd sync
```

Ensures the in-memory database and `.beads/issues.jsonl` are consistent. Run this after pulling changes from a remote branch or resolving merge conflicts in the JSONL file.

### bd info

Show database information and statistics.

```bash
bd info
```

Displays summary statistics about the bd database: total issues, open/closed counts, type distribution, and sync status.
