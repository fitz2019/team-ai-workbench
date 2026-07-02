---
name: forbidden
load_when:
  - code_generation
  - code_modification
  - code_review
  - refactor
  - architecture
priority: critical
purpose: Non-negotiable engineering and safety red lines.
---

# Forbidden Rules

Load this file before code generation, code modification, code review, refactor, or architecture suggestions.

These rules are hard boundaries.

## Scope And Behavior

- Do not modify unrelated files or behavior
- Do not refactor for style only
- Do not change existing behavior unless the user explicitly asks for it
- Do not revert user changes or dirty worktree changes you did not make
- Do not introduce a new framework when existing repository patterns are sufficient

## Error Handling

- Do not silently ignore errors
- Do not use `_ = err` to pass compilation
- Returned errors must include useful business context when practical
- Logs and errors must not expose tokens, secrets, passwords, cookies, private keys, personal data, or complete sensitive payloads

## Security And Data Boundaries

- Do not trust frontend-supplied identity, tenant, owner, user, role, or permission fields
- Do not read, update, or delete tenant-scoped objects without an owner or tenant predicate
- Do not use request-supplied `tenant_id`, `owner_id`, `user_id`, role, or permission fields directly for tenant-scoped reads or writes; derive them from trusted context or validate them against trusted context first
- Do not skip authorization, tenant, or owner predicates just to preserve legacy behavior; if legacy compatibility blocks enforcement, state the residual risk and lower-risk follow-up
- Do not expose internal implementation details, credentials, infrastructure paths, or complete sensitive payloads in user-facing responses

## Context And External I/O

- New DB, Redis, HTTP, RPC, WS, MQ, filesystem, or goroutine code must prefer `context.Context`
- Do not create `context.Background()` in a cancellable request chain without a clear compatibility reason
- Do not add unbounded goroutines
- Long-running workers must have cancellation and bounded concurrency
- If compatibility prevents passing `context.Context`, state the reason and residual risk

## Idempotency

- New write APIs, async tasks, delivery tasks, ACK, retry, and compensation logic must be idempotent
- Do not rely on "query first, then insert/update" for uniqueness
- Prefer DB conditional update, unique key, Redis Lua, or another atomic state transition

## Redis And Cache Red Lines

- Do not create cache keys without TTL
- Do not use `KEYS` in online code
- Do not use `HGETALL`, `SMEMBERS`, or full value reads for potentially large collections in hot paths
- Do not store large JSON or rich text cache values without evaluating compression or field slimming
- Do not implement locks with non-atomic `SETNX` plus separate `EXPIRE`
- Do not release a Redis lock without verifying the unique lock value
- Do not use Redis Pub/Sub or List as a reliable core message queue without ACK, retry, timeout recovery, dead letter, and idempotent consumption
- Do not allow DB writes to succeed while cache invalidation fails silently
- Do not treat Redis as the long-term source of truth for configuration-like data unless the business explicitly defines Redis as durable state and the persistence, TTL, invalidation, and recovery strategy are documented
- Do not treat cache invalidation, cache refresh, delivery, or background task failure as unimportant; record or return the failure with enough business context for follow-up

## Performance Red Lines

- Do not introduce N+1 queries in loops
- Do not add large OFFSET pagination on large tables
- Do not scan large tables without checking indexes
- Do not hold locks across slow I/O
- Do not create unbounded queues, polling loops, or retry loops

## Background Tasks And Delivery

- Do not swallow background task, MQ delivery, webhook callback, notification, or compensation failures
- Do not start async work that has no traceable task ID, request ID, business key, retry policy, or failure handling path when the work affects user-visible state

## Tests And Commands

- Do not run full repository `go test ./...`, `go vet ./...`, or `staticcheck ./...` unless the user explicitly asks
- Self-review and verification must focus only on files, packages, exact tests, and code paths touched by the current task
- Prefer target or exact tests first. If package-level confidence is needed, run the full test suite only for the touched package or packages
- Do not widen verification to unrelated packages, unrelated files, or repository-wide checks just to look thorough
- Do not hide failing verification

## Comments And Documentation

- New Go comments and GoDoc should follow the target repository language convention
- Comments should explain why, not repeat what the code says
- If a schema change is introduced, provide SQL or migration notes when the user expects release documentation
