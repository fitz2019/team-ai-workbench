# Project Integration Guide

This guide explains how to connect a real repository to `team-ai-workbench` without turning the repository into a copy of the workbench source.

## Core Idea

Use `team-ai-workbench` as an **upstream harness source**, not as a runtime dependency.

A consumer repository should receive:

- generated Codex harness files
- generated rules
- generated role overlays
- generated template starter files

and then keep its own project truth locally.

## Integration Paths

### Path 1: New repository

Use a template whenever the repository type is obvious.

Example:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service
```

### Path 2: Existing repository

Do not overwrite directly.

Instead:

1. initialize into a temporary directory
2. compare the generated output with the real repository
3. merge only the reusable parts
4. preserve the repository's own `project-specific.md` and business rules

## What To Bring Into the Project

Bring in:

- `AGENTS.md`
- `.codex/`
- `.agents/`
- `.agents/skills/`
- `.ai-harness/`
- template starter docs when the template provides them

## What To Keep Project-Local

Keep these in the project repository:

- business vocabulary
- exact commands
- API compatibility notes
- release constraints
- rollout and rollback notes
- tenant, owner, and permission nuances

## First Successful Integration

A repository is successfully integrated when:

- `AGENTS.md` exists
- `.codex/config.toml` exists and `/hooks` has been reviewed in Codex
- `.agents/project-specific.md` is filled in
- `.ai-harness/BUILD_PLAN.md` and `.ai-harness/PROGRESS.md` exist
- the chosen role or template matches the repository's actual work
- one real task has been completed using the generated setup

## Long-running Harness

Do not enable long-running mode immediately for every task.

Use it when the task needs durable state:

```powershell
New-Item -ItemType File .\.ai-harness\ACTIVE -Force
```

If the team wants the Stop hook to continue until evidence passes:

```powershell
New-Item -ItemType File .\.ai-harness\CONTINUE_ON_STOP -Force
```

To pause:

```powershell
New-Item -ItemType File .\.ai-harness\AGENT_STOP -Force
```

## Upgrade Rule

Treat upgrades as merges, not reinstalls.

If the repository already has meaningful project-local truth, compare and merge deliberately instead of re-running initialization in place.
