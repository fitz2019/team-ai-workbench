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

## Control Files

Create these only when needed:

- `ACTIVE`
  Enables long-running harness mode.
- `CONTINUE_ON_STOP`
  Lets the Stop hook request another continuation when criteria remain failing.
- `AGENT_STOP`
  Stops autonomous tool use and continuation.
