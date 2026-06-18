---
name: test-driven-development
description: Use when implementing or fixing Go backend behavior and you want test-first execution with focused Go verification before production code.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
---

# Test-Driven Development

Use this skill for Go backend features, bug fixes, and behavior-changing refactors when the repository shape allows a focused failing test before production code.

## When To Use

- new backend behavior
- bug fixes that should leave behind a regression test
- refactors that change observable behavior
- service, repository, cache, MQ, or HTTP logic where a focused test can prove the requirement

## Workflow

### 1. Choose The Smallest Useful Test Seam

Start at the narrowest layer that can prove the requirement:

- pure logic -> package-level unit test
- service behavior -> service-layer test
- storage or cache semantics -> repository or integration-style test in the touched package
- bug fix -> regression test at the layer where the bug was observed

Do not start with a broader seam unless a narrow seam cannot prove the behavior.

### 2. RED: Write The Failing Go Test First

- write or update a focused `_test.go` case
- give the test a behavior name, not an implementation name
- cover one requirement slice at a time
- use table-driven tests when the behavior naturally has multiple cases

For backend work, the failing test should make the business expectation visible:

- expected response or error
- expected tenant, owner, or permission behavior
- expected idempotency or duplicate-handling behavior
- expected cache invalidation or consistency behavior

### 3. Verify RED

Run the smallest Go command that proves the test fails for the right reason:

```powershell
go test ./path/to/package -run TestName -count=1
```

Confirm all of these:

- the test fails, not merely the build
- it fails because the feature or bug fix is missing
- the failure message reflects the intended behavior

If the test passes immediately, you are testing existing behavior or the wrong seam.

### 4. GREEN: Implement The Minimum Change

- write the smallest change that makes the failing test pass
- preserve repository patterns for wiring, errors, logging, context, Redis, DB, and concurrency
- do not add speculative abstractions, flags, or extension points
- do not refactor adjacent code while trying to get green

### 5. Verify GREEN

Run the exact target test again:

```powershell
go test ./path/to/package -run TestName -count=1
```

If needed for confidence, expand only to the touched package:

```powershell
go test ./path/to/package -count=1
```

Do not jump to repository-wide verification unless the user explicitly asks.

### 6. REFACTOR

After the test is green:

- remove duplication
- improve names
- extract helpers when they genuinely reduce noise
- keep behavior unchanged

Re-run the same focused verification after refactoring.

## Go Backend Testing Guidance

- prefer real behavior checks over tests that only prove mocks were called
- avoid real third-party dependencies in routine tests; use existing fakes, stubs, test doubles, or local fixtures
- for Redis, DB, MQ, or async flows, assert the business result and key failure semantics, not only intermediate function calls
- for API or security-sensitive paths, include the relevant boundary or permission case when that behavior changed
- for bug fixes, do not stop at a manual reproduction; leave behind a regression test when practical

## When Not To Use

- doc-only changes
- config-only changes with no executable behavior
- generated code where the generation source is the real target
- emergency compatibility patches where the harness cannot run tests right now

Even in those exceptions, add or schedule follow-up verification when practical.

## Recommended Pairing

Combine this skill with:

- `golang-testing` for Go test patterns
- `systematic-debugging` for root-cause work before the regression test
- `verification-before-completion` before claiming success

## Red Flags

- writing backend code first and planning to "add tests later"
- only manually checking the endpoint or worker output
- using repository-wide tests as a substitute for a focused failing test
- testing the mock setup rather than the business behavior
- hiding a difficult test seam instead of questioning the design
