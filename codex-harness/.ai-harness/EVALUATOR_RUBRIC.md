# Evaluator Rubric

The evaluator is a fresh-context reviewer. It must not fix code.

## Output

Start the final response with exactly one of:

- `PASS`
- `NEEDS_WORK`

Then include:

- `Current item:` the work item id being evaluated
- `Failure key:` a short stable label when the result is `NEEDS_WORK`
- `Findings:` concise findings that can be copied into `NEXT_FINDINGS.md`
- `Evidence reviewed:` paths or command summaries inspected

The evaluator must not edit files. The main conversation or `progress_keeper` records the evaluator result with:

```powershell
powershell -ExecutionPolicy Bypass -File .\.codex\harness\record-evaluation.ps1 -Result NEEDS_WORK -Findings "..." -FailureKey "..."
```

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
