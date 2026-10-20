# Shiv Agentic Plugins App: What We Can Achieve

Candidate capabilities for an app built on top of this marketplace. The app should read `plugins/` and `marketplace.json` as the single source of truth and never keep its own copy of plugin logic.

Each capability lists the plugin it builds on and a rough stage:

- **Stage 1**: static, read-only, generated at build time.
- **Stage 2**: read-only data, needs a backend or stored history.
- **Stage 3**: runs workflows, needs auth, Claude API, and Jira/Confluence access.

---

## 1. Discovery and Install

| Capability | Built on | Stage |
|---|---|---|
| Browse all plugins with description and version | `marketplace.json`, `plugin.json` | 1 |
| List every command, skill, and agent per plugin | plugin folder frontmatter | 1 |
| Search across commands and skills | plugin frontmatter | 1 |
| Copy-paste install snippet per plugin | `install-shiv-plugins.sh` | 1 |
| Show installed vs. latest version, detect local overrides | `shiv-tools:shiv-status`, `shiv-sync` | 2 |
| Changelog view per plugin | git history | 2 |

## 2. Agile Workflows (`shiv-agile`)

| Capability | Built on | Stage |
|---|---|---|
| Guided form to create an Epic (SMART criteria checks) | `create-epic`, `epic-validator` | 3 |
| Guided form to create a Story (INVEST + Gherkin AC) | `create-story`, `story-reviewer` | 3 |
| Create bugfix and technical enablement items | `create-bugfix`, `create-technical-enablement-story` | 3 |
| Turn rough notes into an Epic or Story | `notes-to-work-item` | 3 |
| Score a story against INVEST, with recommendations | `story-invest-score` | 3 |
| Groom a whole sprint in one pass | `auto-groom` | 3 |
| Story quality KPIs per team and sprint | `story-quality-kpis` | 2 |
| INVEST score trends over time | stored `story-invest-score` results | 2 |

## 3. Design Docs (`shiv-design-docs`)

| Capability | Built on | Stage |
|---|---|---|
| List local design docs with Confluence sync status | `list-docs` | 2 |
| Generate Technical Architecture, Detailed Design, ADR, Runbook, and API Design docs from Jira context | `design-doc`, `doc-writer` | 3 |
| Pull a Confluence doc to local markdown with conflict detection | `pull-doc` | 3 |
| Side-by-side diff of local vs. Confluence version | `pull-doc` | 3 |

## 4. Development Workflows (`shiv-dev`)

| Capability | Built on | Stage |
|---|---|---|
| Review a GitHub PR and post line-level comments | `review-pr`, `pr-reviewer` | 3 |
| Code quality report (clean code, SOLID, DRY, security) | `code-quality-checker` | 3 |
| Test suite quality review (AAA, edge cases, coverage) | `test-reviewer` | 3 |
| TDD workflow tracker with human checkpoints per Jira task | `tdd-workflow`, `agentic-tdd-jira` | 3 |
| Terraform change tracker mapped to Jira requirements | `agentic-terraform` | 3 |

## 5. Spec-Driven Development (`shiv-speckit`)

| Capability | Built on | Stage |
|---|---|---|
| Spec to plan to tasks pipeline view | `speckit-specify`, `speckit-plan`, `speckit-tasks` | 3 |
| Clarification Q&A that writes answers back to the spec | `speckit-clarify` | 3 |
| Cross-artifact consistency report (spec, plan, tasks) | `speckit-analyze`, `spec-validator` | 3 |
| Custom checklist generation per feature | `speckit-checklist` | 3 |
| Convert tasks into GitHub issues | `speckit-taskstoissues` | 3 |
| Project constitution editor | `speckit-constitution` | 3 |

## 6. Plugin Authoring (`shiv-tools`)

| Capability | Built on | Stage |
|---|---|---|
| Scaffold a new plugin with the standard structure | `create-plugin` | 3 |
| Validate plugin frontmatter and marketplace registration | `plugin.json`, `marketplace.json` | 1 |
| Edit markdown commands and skills in the browser, open a PR | git, GitHub API | 3 |

---

## Cross-Cutting Requirements

- **Auth**: Jira and Confluence OAuth. Must stay multi-tenant, with no hardcoded instances.
- **Secrets**: Claude API key and tokens are server-side only.
- **Source of truth**: read `plugins/` at build time or via the GitHub API. No copied prompts.
- **Audit trail**: log every write to Jira, Confluence, or GitHub with who, what, and when.
- **Human checkpoints**: any workflow that writes externally shows a preview and needs explicit approval, matching the existing TDD and Terraform flows.

## Suggested Rollout

1. **Stage 1: Catalog site.** Items marked Stage 1 above. Low risk, high discoverability.
2. **Stage 2: Dashboards.** KPIs, INVEST trends, doc sync status. Needs stored history.
3. **Stage 3: Workflow runner.** Start with `create-story` and `story-invest-score`, then expand. Build only if non-CLI users ask for it.

## Open Questions

- Who are the target users: developers only, or POs and EMs too?
- Where should score and KPI history live?
- Is the runner allowed to write to Jira directly, or only draft for review?
