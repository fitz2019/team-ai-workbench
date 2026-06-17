# Knowledge Capture Guide

This guide explains how projects should retain useful AI-assisted context over time.

## Principle

Do not treat raw chat history as the knowledge base.

Raw chat is transient. Durable knowledge should be:

- summarized
- normalized
- stored in project-owned artifacts

## What To Keep Where

### Project repository

Put active, durable project knowledge in the project itself.

Examples:

- architecture notes
- capability notes
- acceptance checklists
- ship verdicts
- runbooks
- release notes

Suggested locations:

```text
docs/
  architecture/
  capabilities/
  qa/
  release/
  runbooks/
  knowledge/
```

### AI instruction layer

Put stable AI-facing project rules in:

- `AGENTS.md`
- `.agents/project-specific.md`

This layer should contain rules and constraints, not long-form session history.

### Team upstream repository

If a pattern becomes reusable across repositories, move it into:

- `core/`
- `roles/<role>/`
- `templates/`

## What To Persist From Sessions

Persist:

- decisions that affect implementation
- accepted constraints
- bug patterns worth regression coverage
- release and rollback expectations
- runbook-worthy debugging patterns

Do not persist by default:

- entire raw chat logs
- repetitive back-and-forth
- temporary dead ends with no future value
- low-signal trial-and-error noise

## Suggested Project Knowledge Files

For most repositories, this is enough:

```text
docs/
  knowledge/
    README.md
    decision-log.md
    session-notes/
  runbooks/
```

### Meaning of the files

- `decision-log.md`
  durable engineering or product decisions
- `session-notes/`
  short dated summaries of meaningful AI-assisted sessions
- `runbooks/`
  repeatable operational or debugging procedures

## ECC-Inspired Modes

This workbench supports three levels of knowledge capture inspired by ECC:

### 1. Lightweight project-local capture

Preferred default:

- docs in the project repo
- stable rules in `.agents/project-specific.md`
- short session summaries

### 2. Structured knowledge operations

Use when the team wants explicit ingest, dedupe, sync, or retrieval workflows.

See:

- `core/skills/knowledge-ops`

### 3. Automated learning / memory systems

Use only when the team intentionally wants hook-based or explicit save/resume memory workflows.

See:

- `advanced/continuous-learning-v2`
- `advanced/context-keeper`

## Recommended Default

For most teams:

1. keep project truth in project docs
2. keep stable AI instructions in `.agents/project-specific.md`
3. summarize meaningful sessions instead of hoarding raw chat
4. upstream reusable patterns back into `team-ai-workbench`
