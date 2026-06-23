# Codex Shared Supplement

This file supplements the root `AGENTS.md`.

## Source Of Truth

- Root `AGENTS.md` and `.agents/` remain the canonical rule system.
- Do not replace project rules with generic ECC boilerplate.
- Keep business-specific behavior in each target repository's `.agents/project-specific.md`.

## Codex Runtime Surface

- `.codex/config.toml` defines project-local Codex runtime defaults.
- `.codex/agents/*.toml` defines helper roles for multi-agent workflows.
- `.agents/skills/` is the official repository skill discovery surface.
- Do not create repo-local `.codex/skills/` by default; use enabled user-level plugins for external workflow packs such as Superpowers.
- Root `agents/` and `.agents/skills/` can be treated as the curated reusable library for agent and workflow patterns.

## Default Operating Mode

- For code, review, debugging, or architecture tasks, route through `.agents/index.md` first.
- For non-trivial coding work, include `.agents/coding-discipline.md` in the default module set.
- Load only the `.agents/*.md` modules required by the task.
- Prefer targeted verification over repository-wide checks.
- Preserve existing repository patterns for layering, context propagation, error handling, logging, tests, and external I/O.
