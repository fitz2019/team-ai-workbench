# Codex Harness Supplement

This project uses the Team AI Workbench Codex harness.

## Source Of Truth

- Root `AGENTS.md` is the entry point.
- `.agents/index.md` routes task-specific rules.
- `.agents/project-specific.md` stores project-local facts.
- `.ai-harness/` stores long-running task state.

Do not replace project-specific facts with generic examples.

## Harness Runtime

Before non-trivial code, review, debugging, planning, or product work:

1. Read `AGENTS.md`.
2. Read `.agents/index.md`.
3. Read `.agents/harness-runtime.md`.
4. If `.ai-harness/ACTIVE` exists, read:
   - `.ai-harness/BUILD_PLAN.md`
   - `.ai-harness/PROGRESS.md`
   - `.ai-harness/STEER.md`
   - `.ai-harness/EVALUATOR_RUBRIC.md`
   - `.ai-harness/test-results.json`
5. Load only the role modules required by the current task.

## Long-running Mode

When `.ai-harness/ACTIVE` exists:

- Work on one bounded item at a time.
- Keep `.ai-harness/PROGRESS.md` current.
- Keep `.ai-harness/test-results.json` default-fail until evidence is real.
- Use `harness_evaluator` for independent review before claiming completion.
- Respect `.ai-harness/AGENT_STOP` immediately.
- Treat `.ai-harness/STEER.md` as operator steering, not as a replacement for safety or project rules.

When long-running mode is not active, use the normal `.agents/` rule system.
