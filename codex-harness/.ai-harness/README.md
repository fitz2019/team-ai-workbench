# AI Harness Runtime

This directory stores durable state for long-running Codex work.

It is intentionally committed to the project when the team wants reusable task state, review evidence, and project knowledge to survive chat history.

## Files

- `BUILD_PLAN.md`
  Long-running objective, scope, work items, and acceptance criteria.
- `PROGRESS.md`
  Current state, completed work, evidence, and next step.
- `STEER.md`
  Operator steering. Edit this file when you need to redirect the next agent pass.
- `EVALUATOR_RUBRIC.md`
  Rules for fresh-context evaluation.
- `NEXT_FINDINGS.md`
  Findings that must be addressed before the next pass can be considered done.
- `test-results.json`
  Default-fail acceptance evidence.
- `LOOP_STATE.json`
  Loop status, current item, round counters, failure counters, and run id.
- `runs/`
  Per-loop snapshots and evaluator records. Store evidence summaries or paths only; do not copy large logs, secrets, or complete payloads.

## Control Files

Create these only when needed:

- `ACTIVE`
  Enables long-running harness mode.
- `CONTINUE_ON_STOP`
  Lets the Stop hook request another continuation when criteria remain failing.
- `AGENT_STOP`
  Stops autonomous tool use and continuation.

## Loop Engine Scripts

Project-local scripts live in `.codex/harness/`:

- `start-loop.ps1`
  Initializes `BUILD_PLAN.md`, `test-results.json`, `LOOP_STATE.json`, `runs/<run_id>/`, and creates `ACTIVE`.
- `record-evaluation.ps1`
  Records a `PASS` or `NEEDS_WORK` evaluator result into `NEXT_FINDINGS.md`, `LOOP_STATE.json`, and `runs/<run_id>/evaluator-###.md`.
- `finish-loop.ps1`
  Ends the loop only after all criteria pass with evidence and the latest evaluator result is `PASS`, unless `-Force` is used.
- `archive-loop.ps1`
  Copies current harness state into `runs/<run_id>/archive/` without copying large evidence files.

Default limits:

- `max_rounds`: 6
- `max_same_failure_count`: 3
- automatic continuation: disabled unless `CONTINUE_ON_STOP` exists
