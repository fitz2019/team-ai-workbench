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
```

## How The Layers Work

`AGENTS.md` is the entry point.

`.codex/` controls how Codex runs:

- hooks
- subagents
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

## Long-running Flow

1. Fill `.ai-harness/BUILD_PLAN.md` with the objective and criteria.
2. Create `.ai-harness/ACTIVE`.
3. Codex reads `AGENTS.md`, `.agents/index.md`, `.agents/harness-runtime.md`, and `.ai-harness/*`.
4. The builder completes one bounded item.
5. Evidence is recorded in `test-results.json`.
6. `harness_evaluator` reviews from fresh context.
7. `PROGRESS.md` and `NEXT_FINDINGS.md` are updated.
8. The Stop hook warns or continues depending on `CONTINUE_ON_STOP`.

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
| Steering | `.ai-harness/STEER.md` plus `user-prompt-submit.ps1` |
| Kill switch | `.ai-harness/AGENT_STOP` plus `pre-tool-use-policy.ps1` |
| Stop gate | `.codex/hooks/stop-gate.ps1` |

## What Not To Do

- Do not put business facts in the harness template.
- Do not mark criteria passed without evidence.
- Do not enable `CONTINUE_ON_STOP` for vague or exploratory work.
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
