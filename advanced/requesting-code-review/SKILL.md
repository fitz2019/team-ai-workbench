---
name: requesting-code-review
description: Use after meaningful implementation work when you want an independent review package prepared and routed through the right reviewer surface before merge or the next task.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Requesting Code Review

Use this skill when you want a review loop to catch issues before they cascade into the next task, a merge, or a release.

## When To Use

- after a meaningful feature or bug-fix slice
- at plan checkpoints
- before merge or PR
- before a risky refactor proceeds further
- when you want a fresh reviewer perspective on unclear work

## Core Principle

Review packages should be scoped, factual, and independent.

The reviewer should get the work product, requirements, and verification state, not your entire session history.

## Build The Review Package

Before requesting review, prepare:

1. what changed
2. what requirement, plan step, or bug it was meant to satisfy
3. the exact review scope:
   - file list
   - touched package
   - git range
4. verification already run
5. known risks, assumptions, or open questions

## Choose The Right Reviewer Surface

Pick the narrowest reviewer that matches the change:

- general reviewer for correctness and maintainability
- backend reviewer for Go, DB, Redis, MQ, or concurrency work
- security reviewer for auth, tenant, permission, webhook, upload, or sensitive-data paths
- QA or browser reviewer for regression-oriented checks

If no specialized reviewer is available, use the generic review path and state the missing specialty.

## Review Workflow

1. prepare the scoped review package
2. send it to the appropriate reviewer surface
3. collect findings by severity
4. fix critical issues before proceeding
5. fix important issues before merge unless there is an explicit reason to defer
6. document accepted deferrals and residual risk

## Reviewer Request Checklist

A good request includes:

- summary of the change
- requirement or plan reference
- exact scope
- verification evidence
- explicit review focus when needed, such as:
  - compatibility
  - security boundaries
  - Redis consistency
  - concurrency
  - rollback risk

## Red Flags

- asking for review with no requirement or plan context
- asking a reviewer to inspect a huge unfocused diff
- hiding failed verification from the reviewer
- treating review as a formality after deciding to merge anyway
- ignoring critical issues because they arrived from a reviewer instead of CI
