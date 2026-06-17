---
name: dispatching-parallel-agents
description: Use when facing 2 or more independent tasks that can be worked on without shared state or sequential dependencies.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Dispatching Parallel Agents

Use this skill when multiple failures or investigations are independent and can be explored safely in parallel.

## When to Use

- several unrelated failing tests
- multiple independent subsystems are broken
- each problem can be investigated without shared state
- the coordinator can integrate and verify the results afterward

## Do Not Use

- when failures are likely related
- when all agents would edit the same files
- when broad system context is required

## Pattern

1. group failures by independent domain
2. create one focused task per domain
3. dispatch them in parallel
4. review outputs
5. integrate and re-verify

## Constraint

This is an advanced workflow tool. Teams should adopt it deliberately, not by default.
