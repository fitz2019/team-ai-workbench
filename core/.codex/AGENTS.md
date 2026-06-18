# Codex Shared Supplement

This file supplements the root `AGENTS.md`.

## Source Of Truth

- Root `AGENTS.md` and `.agents/` remain the canonical rule system.
- Do not replace project rules with generic ECC boilerplate.
- Keep business-specific behavior in each target repository's `.agents/project-specific.md`.

## Codex Runtime Surface

- `.codex/config.toml` defines project-local Codex runtime defaults.
- `.codex/agents/*.toml` defines helper roles for multi-agent workflows.
- Root `skills/` is the preferred shared local skill surface.
- Local `.codex/skills/` are optional capability packs, not the primary rule source.
- Root `agents/` and `skills/` can be treated as the curated reusable library for agent and workflow patterns.

## Default Operating Mode

- For code, review, debugging, or architecture tasks, route through `.agents/index.md` first.
- For non-trivial coding work, include `.agents/coding-discipline.md` in the default module set.
- Load only the `.agents/*.md` modules required by the task.
- Prefer targeted verification over repository-wide checks.
- Preserve existing repository patterns for layering, context propagation, error handling, logging, tests, and external I/O.
