---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task before touching code.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Writing Plans

Use this skill when the task is large enough that implementation should be driven by a written plan instead of ad hoc execution.

## When to Use

- multi-step features
- refactors across multiple files or packages
- requirements that need explicit task decomposition
- work that will be delegated to subagents or another engineer

## Expectations

- map files before defining tasks
- split work into small verifiable steps
- make test and verification steps explicit
- avoid placeholders like `TODO`, `fill in later`, or vague "handle edge cases"

## Suggested Save Location

Prefer a project-local plan path such as:

```text
docs/ai-plans/YYYY-MM-DD-feature-name.md
```

Teams may override the directory, but the key rule is:

- plans must live in the project
- plans must be reviewable
- plan steps must be executable in order
