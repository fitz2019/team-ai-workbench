# Codex Harness

This directory is the main runtime architecture for `team-ai-workbench`.

It is modeled after the `cwc-long-running-agents` shape:

```text
codex-harness/
  .codex/
    config.toml
    AGENTS.md
    agents/
    hooks/
    harness/
  .agents/
    harness-runtime.md
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

The difference is that this is a Codex-first harness:

- `.codex/config.toml` defines Codex runtime defaults, subagents, and lifecycle hooks.
- `.codex/hooks/` provides the loop guardrails.
- `.codex/harness/` provides operator scripts for starting, recording, finishing, and archiving a loop.
- `.codex/agents/` provides the builder, evaluator, and progress roles.
- `.ai-harness/` is the durable runtime state that travels with the target repository.
- `.agents/` remains the rule and role knowledge source.

## Relationship To The Rest Of The Repository

`codex-harness/` is the mainline runtime.

The other top-level folders are source packs consumed by the harness:

- `core/` supplies shared rules, skills, and baseline agents.
- `roles/` supplies backend, frontend, product, QA, and DevOps overlays.
- `templates/` supplies project presets.
- `advanced/` supplies opt-in workflow packs.

In other words: the harness runs the work; the knowledge packs constrain how it thinks.

## Runtime Modes

The harness is installed by default into generated projects.

It is passive until a project starts a long-running loop:

```powershell
powershell -ExecutionPolicy Bypass -File .\.codex\harness\start-loop.ps1 -Objective "..." -AcceptanceCriteriaText "criterion one;criterion two"
```

Optional auto-continuation at turn stop:

```powershell
New-Item -ItemType File .\.ai-harness\CONTINUE_ON_STOP -Force
```

Stop the loop:

```powershell
New-Item -ItemType File .\.ai-harness\AGENT_STOP -Force
```

Record evaluator output:

```powershell
powershell -ExecutionPolicy Bypass -File .\.codex\harness\record-evaluation.ps1 -Result NEEDS_WORK -Findings "..." -FailureKey "..."
```

Finish after all criteria pass with evidence and the latest evaluator result is `PASS`:

```powershell
powershell -ExecutionPolicy Bypass -File .\.codex\harness\finish-loop.ps1
```

Archive the current loop snapshot:

```powershell
powershell -ExecutionPolicy Bypass -File .\.codex\harness\archive-loop.ps1
```

Default loop limits:

- `max_rounds`: 6
- `max_same_failure_count`: 3
- automatic continuation: disabled unless `CONTINUE_ON_STOP` exists

## cwc Mapping

| cwc primitive | Codex harness mapping |
| --- | --- |
| Default-fail contract | `.ai-harness/test-results.json` starts false until evidence exists |
| Fresh-context evaluator | `harness_evaluator` subagent and `EVALUATOR_RUBRIC.md` |
| Agent-maintained handoff | `.ai-harness/PROGRESS.md` |
| Loop state | `.ai-harness/LOOP_STATE.json` |
| Evaluation record | `.codex/harness/record-evaluation.ps1` and `.ai-harness/NEXT_FINDINGS.md` |
| Kill switch | `.ai-harness/AGENT_STOP` checked by hooks |
| Steering hook | `.ai-harness/STEER.md` injected by hooks |
| Verify gate | `stop-gate.ps1` checks test results in active mode |

Inspired by [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents). This repository does not vendor cwc; it adapts the architecture for Codex and this team's workbench.
