---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from the current workspace or before executing larger plans.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Using Git Worktrees

Use this skill when feature work should happen in an isolated workspace instead of the current checkout.

## When to Use

- larger feature implementation
- concurrent branches for independent work
- risky refactors
- plan execution that should not pollute the current workspace

## Workflow

1. detect whether isolation already exists
2. prefer native platform worktree support if available
3. otherwise use `git worktree`
4. set up the project in the new workspace
5. verify baseline before coding

## Team Fit

This skill is valuable when the team already accepts:

- isolated workspaces
- explicit branch hygiene
- multi-stream feature work

If the team is not ready for that, keep this as optional guidance.
