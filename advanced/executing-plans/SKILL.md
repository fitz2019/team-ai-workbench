---
name: executing-plans
description: Use when a written implementation plan already exists and the team wants disciplined step-by-step execution with checkpoints.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Executing Plans

Use this skill when the work already has a written plan and the team wants execution to follow that plan instead of drifting into ad hoc implementation.

## When to Use

- a reviewed plan already exists
- the work spans multiple checkpoints or files
- the team wants plan-first execution
- the coordinator wants explicit stop points when blocked

## Workflow

1. load the plan and review it critically before coding
2. confirm the plan is still compatible with the current repository state
3. identify blockers, gaps, or risky assumptions before starting
4. execute one task at a time in plan order
5. verify each task at the smallest useful scope before moving on
6. stop and ask when blocked instead of improvising around the plan
7. when all planned work is complete, hand off to `finishing-a-development-branch`

## Important

- a plan is executable guidance, not ceremony
- if the plan is wrong, stop and fix the plan before implementation continues
- do not silently widen scope just because adjacent work looks related
- do not skip task-level verification and claim the full plan is done

## Team Fit

This is not a default baseline behavior.

It is useful for teams that already accept written plans, explicit checkpoints, and higher execution discipline.
