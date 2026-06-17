# Codex Shared Supplement

This file supplements the root `AGENTS.md`.

## Source Of Truth

- Root `AGENTS.md` and `.agents/` remain the canonical rule system.
- Do not replace project rules with generic ECC boilerplate.
- Keep business-specific behavior in each target repository's `.agents/project-specific.md`.

## Codex Runtime Surface

- `.codex/config.toml` defines project-local Codex runtime defaults.
- `.codex/agents/*.toml` defines helper roles for multi-agent workflows.
- Local `.codex/skills/` are optional capability packs, not the primary rule source.
- Root `agents/` and `skills/` can be treated as the curated ECC-derived library for reusable agent and workflow patterns.

## Default Operating Mode

- For code, review, debugging, or architecture tasks, route through `.agents/index.md` first.
- Load only the `.agents/*.md` modules required by the task.
- Prefer targeted verification over repository-wide checks.
- Preserve existing Go backend patterns for context propagation, error handling, logging, DB access, Redis/cache, and concurrency.
