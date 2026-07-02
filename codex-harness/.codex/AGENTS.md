# Codex Project Supplement

This file supplements the root `AGENTS.md`.

## Source Of Truth

- Root `AGENTS.md` and `.agents/` remain the canonical project rule system.
- `.agents/project-specific.md` stores project-local facts.
- `.ai-harness/` stores long-running task state.
- Do not replace project-specific rules with generic ECC or harness boilerplate.
- Keep `.agents/` project-local. Extract a separate reusable skill only when the same workflow proves useful across multiple repositories.

## Codex Runtime Surface

- `.codex/config.toml` defines project-local Codex runtime defaults.
- `.codex/agents/*.toml` defines helper roles for multi-agent workflows.
- `.codex/hooks/*.ps1` defines local harness guardrails for steering, stop checks, and kill switch behavior.
- `.agents/skills/` is the official repository skill discovery surface for this project.
- Do not restore repo-local `.codex/skills/` by default.
- External workflow packs such as Superpowers should be supplied by enabled user-level plugins. Project-owned reusable skills belong in `.agents/skills/`.

## Default Operating Mode

- For code, review, debugging, or architecture tasks, route through `.agents/index.md` first.
- For non-trivial coding work, include `.agents/coding-discipline.md` in the default module set.
- Load only the `.agents/*.md` modules required by the task.
- Prefer targeted verification over repository-wide checks.
- Preserve existing project patterns for context propagation, error handling, logging, data access, cache, concurrency, and tests.

## Harness Mode

- `.ai-harness/` stores long-running task state.
- Harness mode is active only when `.ai-harness/ACTIVE` exists.
- In harness mode, read `.agents/harness-runtime.md` and `.ai-harness/*` before tool use.
- Work on one bounded item at a time.
- Keep `.ai-harness/PROGRESS.md` current.
- Keep `.ai-harness/test-results.json` default-fail until evidence is real.
- Respect `.ai-harness/AGENT_STOP` as an operator kill switch.
- Treat `.ai-harness/STEER.md` as operator steering, not as a replacement for safety or project rules.
- Use `harness_evaluator` for fresh-context review before marking long-running work complete.

When harness mode is not active, use the normal `.agents/` rule system.
