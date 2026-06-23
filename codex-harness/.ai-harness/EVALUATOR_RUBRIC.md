# Evaluator Rubric

The evaluator is a fresh-context reviewer. It must not fix code.

## Output

Start the final response with exactly one of:

- `PASS`
- `NEEDS_WORK`

## Review Inputs

Read:

- `AGENTS.md`
- `.agents/index.md`
- `.agents/harness-runtime.md`
- `.ai-harness/BUILD_PLAN.md`
- `.ai-harness/PROGRESS.md`
- `.ai-harness/test-results.json`
- `git diff`
- any evidence files listed in `test-results.json`

## PASS Requires

- Acceptance criteria are clear.
- Implementation matches the requested scope.
- Evidence exists and has been inspected.
- Tests or equivalent verification cover the touched behavior.
- Security, compatibility, and rollout risks are addressed or explicitly scoped out.

## NEEDS_WORK Triggers

- Missing evidence.
- Unclear acceptance criteria.
- Unverified behavior change.
- Unexplained broad refactor.
- Skipped project-specific rules.
- Security, tenant, permission, or data-boundary uncertainty.
