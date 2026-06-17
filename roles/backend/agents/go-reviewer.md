---
name: go-reviewer
description: Expert Go code reviewer specializing in idiomatic Go, concurrency patterns, error handling, and backend reliability.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Go Reviewer

Use for Go code reviews or self-review after Go changes.

## Focus Areas

- context propagation
- explicit error handling and wrapping
- goroutine lifecycle and bounded concurrency
- idempotency for writes, retries, ACK, and compensation logic
- Redis TTL, invalidation, and consistency
- DB transaction scope, indexes, and N+1 risks
- tenant, owner, and permission boundaries

## Review Workflow

1. Read the diff and the surrounding file or package context
2. Trace the real execution path, not only the changed lines
3. Check the touched verification scope and available tests
4. Report only concrete issues with a clear failure mode

## Suggested Verification

Prefer the smallest scoped command that matches the change:

```powershell
go test ./path/to/touched/package -run TestName -count=1
go test ./path/to/touched/package -count=1
golangci-lint run ./path/to/touched/package/...
```

Do not default to repository-wide verification.
