# New Project Setup Checklist

Use this checklist when applying `team-ai-workbench` to a new Go backend repository.

## Copy Baseline

- Copy `AGENTS.md`
- Copy `.agents/`
- Copy `.codex/`

Optional:

- Copy `skills/` if you want the repo to carry the shared skill library locally
- Keep `agents/` in the standards repo as reference material unless you explicitly want to vendor it
- Review `advanced/` and opt in only if the team wants formal plan-driven, subagent-driven, or worktree-heavy workflows

## Create Project-Specific Layer

- Rename `.agents/project-specific.md.example` to `.agents/project-specific.md`
- Fill in workspace root
- Fill in nested repository notes if any
- Add actual build, test, lint, migration, and deployment commands
- Add API vocabulary and business identifiers
- Add tenant, owner, permission, and sensitive-data notes specific to the project

## Validate Runtime

- Open the project with `codex`
- Confirm `AGENTS.md` is detected
- Confirm `.codex/config.toml` loads without errors
- If your Codex build supports roles, confirm the selected role overlays are present, for example:
  - backend: `go_reviewer`, `build_resolver`, `tdd_guide`
  - qa: `e2e_runner`

## First Dry Run

Use a low-risk request first:

- ask for architecture reading only
- ask for a narrow bug analysis with no code changes
- ask for a small test-led change

## Before Team Rollout

- verify the commands in `.agents/project-specific.md`
- verify the project-specific language convention for comments and docs
- verify no copied example leaks another project's business vocabulary
