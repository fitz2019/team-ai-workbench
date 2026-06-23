---
name: harness-runtime
load_when:
  - every_task
priority: high
purpose: Define how the Codex harness consumes rules, roles, and durable runtime state.
---

# Harness Runtime

This repository is generated from Team AI Workbench's Codex harness.

The harness owns the execution loop. The `.agents/` modules own the rules and role-specific thinking.

## Runtime File Roles

| File | Purpose |
| --- | --- |
| `.ai-harness/BUILD_PLAN.md` | Current long-running objective, work items, and acceptance criteria |
| `.ai-harness/PROGRESS.md` | Durable handoff for current state, evidence, and next step |
| `.ai-harness/STEER.md` | Operator steering for the next turns |
| `.ai-harness/EVALUATOR_RUBRIC.md` | Fresh-context evaluator rules |
| `.ai-harness/NEXT_FINDINGS.md` | Latest evaluator findings that need another pass |
| `.ai-harness/test-results.json` | Default-fail evidence contract |
| `.ai-harness/ACTIVE` | Enables long-running mode |
| `.ai-harness/CONTINUE_ON_STOP` | Allows automatic Stop-hook continuation |
| `.ai-harness/AGENT_STOP` | Pauses tool use and autonomous continuation |

## Operating Contract

When `.ai-harness/ACTIVE` exists:

1. Read `BUILD_PLAN.md` and `PROGRESS.md` before editing.
2. Treat `STEER.md` as the operator's latest steering.
3. Complete one bounded item at a time.
4. Keep `PROGRESS.md` current enough for a fresh session to resume.
5. Keep `test-results.json` default-fail until evidence exists.
6. Use a fresh-context evaluator before claiming a long-running item is done.
7. Promote durable project knowledge into `.agents/project-specific.md` or project docs, not only chat.

When `.ai-harness/ACTIVE` does not exist, use the normal `.agents/` routing and keep harness files untouched unless the task is about long-running work.

## Evidence Contract

An acceptance criterion is not passed until:

- the relevant test, command, screenshot, log, or diff has been produced
- the evidence path or summary is recorded in `test-results.json`
- the evaluator can inspect it without relying on memory from the builder

Missing evidence means `NEEDS_WORK`.
