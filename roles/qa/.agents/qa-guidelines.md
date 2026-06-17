---
name: qa-guidelines
load_when:
  - qa
  - regression
  - e2e
  - browser_verification
priority: high
purpose: Shared QA conventions for regression, release verification, and browser-based validation.
---

# QA Guidelines

Load this file when the task is primarily about regression safety, smoke checks, browser verification, E2E flows, or release confidence.

## QA Priorities

Prioritize:

1. catching real regressions over broad test theater
2. verifying user-visible behavior, not only code paths
3. explicit pass/fail evidence
4. reproducible reports with exact steps or commands

## Regression Rules

- Every bug fix should be evaluated for a regression test.
- When AI modifies backend or API behavior, verify response shape and critical contract fields explicitly.
- When multiple execution paths exist, such as sandbox vs production or feature-flagged branches, test parity between them where practical.
- Do not claim a bug is fixed based only on code inspection; verify the original symptom or a focused regression test.

## Browser and E2E Rules

- Use browser automation on staging, preview, or local environments by default.
- Treat production as read-only unless the user explicitly asks for a mutating verification flow and provides a safe environment.
- Prefer critical path coverage over broad but shallow click-everything scripts.
- Capture enough artifacts for diagnosis: screenshots, failing URL, assertion, and relevant console or network errors.

## Release Verification

Before saying a feature is ready to ship, check:

- critical user journey still works
- primary API contract still matches the expected shape
- no new critical browser-console or 4xx/5xx regressions appear in the touched flow
- accessibility blockers or obvious mobile layout breaks are surfaced when the touched scope is UI-facing

## Reporting

QA output should include:

- what was checked
- what environment was used
- pass/fail result
- evidence or artifact notes
- residual risk
