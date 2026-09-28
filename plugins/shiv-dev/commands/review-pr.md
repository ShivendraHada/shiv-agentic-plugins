---
description: Review a GitHub pull request using GitHub MCP — fetches the diff, reads project guidelines, and posts line-level comments on your behalf
argument-hint: <PR URL or owner/repo#number>
---

# PR Review

Review the pull request: $ARGUMENTS

Delegate to the `pr-reviewer` agent to perform a full review.

The agent will:
1. Fetch the PR diff and changed files via GitHub MCP
2. Read this project's guidelines (CLAUDE.md, AGENTS.md, .windsurf/rules/) to understand team standards
3. Analyze the diff for correctness, security, error handling, performance, design, and test coverage
4. Post line-level comments on the PR
5. Submit the review as APPROVE, COMMENT, or REQUEST_CHANGES based on findings
6. Report back a summary of what was found

If no PR URL or number is provided, ask the user for it before proceeding.
