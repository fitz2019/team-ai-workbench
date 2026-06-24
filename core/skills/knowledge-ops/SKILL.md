---
name: knowledge-ops
description: Use when storing, syncing, deduplicating, or retrieving durable project or team knowledge.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Knowledge Operations

Use when the task is about saving, organizing, syncing, deduplicating, or retrieving knowledge across project and team layers.

## Use Cases

- deciding where a new piece of information should live
- saving important decisions from a work session
- cleaning up duplicate or stale notes
- pushing reusable patterns back upstream

## Storage Layers

### Project truth

Primary home for active knowledge:

- architecture docs
- capability notes
- acceptance checklists
- release notes
- runbooks

### AI rule layer

Stable instructions belong in:

- `AGENTS.md`
- `.agents/project-specific.md`

### Team upstream layer

Reusable cross-project patterns belong in:

- `team-ai-workbench/core/`
- `team-ai-workbench/roles/`
- `team-ai-workbench/templates/`

## Rules

- deduplicate before storing
- summarize rather than hoard raw chat by default
- keep one canonical home per fact set
- redact sensitive data before durable storage
