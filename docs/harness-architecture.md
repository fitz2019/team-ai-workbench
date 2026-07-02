# Harness Architecture

`team-ai-workbench` now uses a cwc-style architecture with a Codex-native runtime.

The repository is split into two concerns:

- `codex-harness/` is the runtime harness.
- `core/`, `roles/`, `templates/`, and `advanced/` are knowledge and workflow packs consumed by the harness.

## Target Project Shape

After initialization, a project receives:

```text
AGENTS.md
.codex/
  AGENTS.md
  config.toml
  agents/
  hooks/
  harness/
.agents/
  index.md
  harness-runtime.md
  project-specific.md
  skills/
.ai-harness/
  BUILD_PLAN.md
  PROGRESS.md
  STEER.md
  EVALUATOR_RUBRIC.md
  NEXT_FINDINGS.md
  test-results.json
  LOOP_STATE.json
  runs/
```

## How The Layers Work

`AGENTS.md` is the entry point.

`.codex/` controls how Codex runs:

- hooks
- subagents
- loop scripts
- sandbox defaults
- persistent runtime instructions

`.agents/` controls how Codex thinks:

- generic engineering rules
- role overlays
- project-specific truth
- reusable skills

`.ai-harness/` stores long-running state:

- current plan
- current progress
- steering
- evaluator rubric
- test/evidence status
- loop state and round limits
- evaluator records and archived snapshots

## Long-running Flow

1. Start with `.codex/harness/start-loop.ps1`, which initializes `BUILD_PLAN.md`, `test-results.json`, `LOOP_STATE.json`, `runs/<run_id>/`, and `ACTIVE`.
2. Keep `CONTINUE_ON_STOP` absent by default; create it only when the operator explicitly wants automatic continuation.
3. Codex reads `AGENTS.md`, `.agents/index.md`, `.agents/harness-runtime.md`, and `.ai-harness/*`.
4. The builder completes one bounded item.
5. Evidence is recorded in `test-results.json`.
6. `harness_evaluator` reviews from fresh context.
7. The main conversation or `progress_keeper` records the evaluator result with `.codex/harness/record-evaluation.ps1`.
8. `NEXT_FINDINGS.md`, `LOOP_STATE.json`, and `runs/<run_id>/evaluator-###.md` are updated.
9. `finish-loop.ps1` removes control files only after criteria pass with evidence and the latest evaluator result is `PASS`.
10. `archive-loop.ps1` snapshots current harness state without copying large logs or sensitive payloads.

## Loop State Machine

| Status | Meaning |
| --- | --- |
| `pending` | Loop files exist but execution has not started |
| `running` | Builder is working one bounded item |
| `needs_work` | Evaluator found gaps that require another pass |
| `passed` | Evaluator passed the loop, but finish cleanup has not run |
| `paused` | Operator review is required; `AGENT_STOP` should exist |
| `done` | Loop has been finished and control files were removed |

Default limits:

- `max_rounds = 6`
- `max_same_failure_count = 3`
- no automatic continuation unless `CONTINUE_ON_STOP` exists

## Control Files

| File | Effect |
| --- | --- |
| `.ai-harness/ACTIVE` | Enables long-running harness mode |
| `.ai-harness/CONTINUE_ON_STOP` | Lets the Stop hook continue when evidence is failing |
| `.ai-harness/AGENT_STOP` | Blocks tool use and stops autonomous continuation |

## cwc Mapping

| cwc idea | Codex implementation |
| --- | --- |
| Default-fail contract | `.ai-harness/test-results.json` |
| Fresh-context evaluator | `.codex/agents/harness-evaluator.toml` |
| Agent-maintained handoff | `.ai-harness/PROGRESS.md` |
| Loop state | `.ai-harness/LOOP_STATE.json` |
| Evaluation write-back | `.codex/harness/record-evaluation.ps1` writes `NEXT_FINDINGS.md` and evaluator records |
| Steering | `.ai-harness/STEER.md` plus `user-prompt-submit.ps1` |
| Kill switch | `.ai-harness/AGENT_STOP` plus `pre-tool-use-policy.ps1` |
| Stop gate | `.codex/hooks/stop-gate.ps1` |

## What Not To Do

- Do not put business facts in the harness template.
- Do not mark criteria passed without evidence.
- Do not enable `CONTINUE_ON_STOP` for vague or exploratory work.
- Do not copy large logs, secrets, or full request/response payloads into `.ai-harness/runs/`; store references or summaries.
- Do not treat hooks as a hard security boundary.
- Do not copy upstream cwc files verbatim into this repository.

## Recommended Use

Use normal Codex mode for small tasks.

Use harness mode when:

- the task spans multiple turns
- multiple roles must coordinate
- the task needs durable handoff
- verification needs an independent evaluator
- the team wants reusable project knowledge after the task
