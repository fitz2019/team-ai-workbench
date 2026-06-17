---
name: subagent-driven-development
description: Execute implementation plans by dispatching a fresh subagent per task with explicit review loops.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Subagent-Driven Development

Use this skill when the team wants to execute an implementation plan through isolated specialist roles instead of one long monolithic session.

## Use Cases

- the work already has a written plan
- tasks are mostly independent
- the team wants explicit implementer and reviewer separation
- the coordinator can manage review loops

## Workflow

1. extract tasks from the plan
2. dispatch an implementer per task
3. run a spec-compliance review
4. run a code-quality review
5. fix issues and re-review
6. move to the next task

## Important

This is not a default baseline behavior.

It increases structure, role clarity, and review rigor, but it also increases operational overhead.
Teams should enable it only after agreeing that the extra process is worth it.
