---
name: verification-loop
description: A reusable post-change verification sequence adapted for Go backend projects.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Verification Loop

Use this skill after a feature, bug fix, refactor, or review-ready change.

## When to Use

- After completing a feature or significant code change
- Before opening a PR
- After refactoring
- When you want explicit quality gates

## Verification Phases

### Phase 1: Build Verification

```powershell
go build ./path/to/touched/package
```

If build fails, stop and fix before continuing.

### Phase 2: Lint or Static Verification

Use the smallest relevant command that matches the repository's existing tooling.

Examples:

```powershell
golangci-lint run ./path/to/touched/package/...
go vet ./path/to/touched/package/...
```

Do not widen verification to the whole repository unless the user explicitly asks.

### Phase 3: Target Tests

```powershell
go test ./path/to/touched/package -run TestName -count=1
```

If package-level confidence is needed:

```powershell
go test ./path/to/touched/package -count=1
```

### Phase 4: Security and Diff Review

Check:

- tenant and owner predicates
- secret leakage
- context propagation
- idempotency for writes or retries
- Redis TTL and invalidation paths
- unintended file changes

Suggested commands:

```powershell
git diff --stat
git diff -- path\to\touched.go
git diff --check
```

## Output Format

Produce a compact report:

```text
VERIFICATION REPORT

Build: PASS/FAIL
Lint/Vet: PASS/FAIL
Tests: PASS/FAIL
Security Review: PASS/FAIL
Diff Review: PASS/FAIL

Overall: READY / NOT READY

Open Issues:
1. ...
2. ...
```

## Important Constraint

This repository follows scoped verification:

- exact target tests first
- touched package verification second
- never default to `go test ./...` or repo-wide checks unless explicitly requested
