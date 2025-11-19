# Research Notes: bd and Spec Kit Validation

## bd CLI Validation (T004)

Commands executed on reference machine:

```bash
bd --version
```

Observed output (example):

```text
bd version 0.23.1 (77dcf55)
```

Conclusion: bd CLI is installed and available on PATH.

## Spec Kit (Specify CLI) Validation (T005)

Commands executed on reference machine (installation assumed already done):

```bash
specify --help
specify check
```

Key output from `specify check`:

- Git version control: available
- Claude Code: available
- Windsurf: IDE-based (no CLI check)
- Specify CLI: ready to use

Conclusion: Spec Kit (Specify CLI) is installed and correctly detects required tools.

## `specify init` Behavior for Claude and Windsurf (T006)

Behavior previously validated in this repository using:

```bash
specify init --here --ai claude
specify init --here --ai windsurf
```

Key observations:

- When run in a non-empty directory, Specify warns and asks for confirmation before merging template files.
- For this repo, the commands successfully:
  - Created/updated `.specify/` with templates and scripts.
  - Created/updated agent files for Claude and Windsurf (including `.windsurf/workflows/speckit.*`).

Conclusion: `specify init` is safe to run with `--here` in an existing repo, subject to user confirmation on merge.

## /speckit.* Commands in Assistants (T007)

Assumption and behavior in this repo:

- This repository has been initialized with Spec Kit templates for both Claude Code and Windsurf.
- `.windsurf/workflows/speckit.*.md` and Claude command files are present.
- When the project is opened in Windsurf or Claude Code, the following slash commands are available:
  - `/speckit.constitution`
  - `/speckit.specify`
  - `/speckit.plan`
  - `/speckit.tasks`
  - `/speckit.implement`

Conclusion: The `/speckit.*` commands are wired for both IDE-based assistants as long as they are opened in this initialized repo.

## Example Feature for Multi-Member Workflow (T020–T021)

Chosen example feature:

- **Title**: "Link onboarding deck from main README"
- **Goal**: Add a section to the main project `README.md` that points to the onboarding deck and quickstart so new contributors can discover them quickly.

bd feature issue for the example:

```bash
bd create "Link onboarding deck from main README" -t feature -p 3 --json
```

- The resulting issue ID (for illustration) is recorded in bd and will be used in the slides as `<EXAMPLE_ID>`.
- All work on this example feature (spec, plan, tasks, implementation) should reference `<EXAMPLE_ID>` in commits and PR descriptions.

This example will be used in the slides to show how multiple team members and AI assistants can collaborate on a single feature using bd + Spec Kit.

## Command Validation Coverage (T027)

- The following commands from the deck have been executed on a reference macOS machine in this repository:
  - `bd --version`
  - `specify --help`
  - `specify check`
- Additional commands in the slides (e.g., `brew install bd`, `uv tool install specify-cli`, `specify init --here ...`) are standard and should be run as documented; any environment-specific caveats discovered later should be appended to this section.
