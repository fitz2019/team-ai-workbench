---
name: tech-stack
load_when:
  - go
  - redis
  - db
  - mq
  - ws
  - cache
  - concurrency
  - external_io
  - architecture
priority: high
purpose: Go backend technical stack and reliability practices.
---

# Technical Stack

Load this file when touching Go code, Redis, DB, MQ, WS, cache, concurrency, external I/O, or architecture.

## Role And Baseline

- Work as a senior Go backend engineer for cloud-native distributed systems
- Prefer existing repository layers, helpers, logging style, validation style, DB access style, and Redis helpers
- Keep abstractions small and introduced only when they remove real complexity

## Architecture Boundaries

- [MUST] Preserve the repository's existing layer direction
- [MUST] Avoid new circular dependencies between packages or same-layer modules
- [SHOULD] Inject external dependencies through constructors or existing service wiring instead of hardcoding creation inside business logic
- [SHOULD] Record important architecture tradeoffs when a change affects module boundaries, public APIs, storage, or external integrations

## Go Engineering Style

- Prefer clear business boundaries before implementation details
- Prefer guard clauses to reduce nesting
- Prefer concrete types; introduce interfaces only when replacement or testing value is clear
- If a function would take more than three business parameters, prefer a parameter struct
- New exported Go identifiers should follow the repository's GoDoc language convention

## DB

- Pass `context.Context` into new or touched DB calls when practical
- Use transactions only when state must be committed atomically
- Keep transactions short; do not hold transaction locks across slow external I/O
- Large-table queries must consider indexes and query shape
- Use keyset or cursor pagination for large result sets when possible
- For write idempotency, prefer conditional update, unique constraints, or transaction-level state checks

## Redis

### Key Design

- Key format should be stable and semantic:

```text
business:sub_business:object:business_id[:dimension]
```

- Do not concatenate raw user input directly into keys
- High-cardinality keys must consider memory and eviction risk
- Design Redis keys as if Redis Cluster or sharding is enabled by default

### TTL

- Cache keys must have TTL
- TTL should match business semantics
- Hot cache TTL should consider jitter to avoid avalanche

### Value Size

- Treat values over 10KB or large collection fields as big-key risks
- Consider compression, field slimming, bucketing, or pagination

### Consistency

- Use an explicit cache strategy: Cache Aside, Write Through, Write Back, double delete, or delayed double delete
- For persistent configuration, DB remains the source of truth unless the business explicitly defines Redis as durable state
- Preferred write path for strong-enough consistency: write DB first, then delete Redis cache
- Cache penetration mitigation: cache empty values with a short TTL when the key can be repeatedly missed
- Cache avalanche mitigation: add random TTL jitter for hot or high-cardinality caches

### Locks And Atomicity

- Use `SetNX(ctx, key, value, ttl)` with non-zero TTL or equivalent atomic command
- Lock value must be unique
- Release locks with value verification and Lua
- For multi-key state transitions, prefer Lua, Redis transaction, or DB conditional update

### Redis Operations

- Online code must not use `KEYS`
- Use Pipeline for multiple independent Redis operations after considering command count and value size

## Concurrency

- Short batch work: prefer `errgroup.WithContext` with `SetLimit`
- Long-running worker: prefer bounded worker pool with configurable worker size and queue size
- Queues must define behavior when full
- Do not start goroutines that cannot exit

## MQ And Async Delivery

- Core delivery flows need ACK, retry, timeout recovery, dead letter, and idempotent consumption
- Redis queues are acceptable only for non-critical or fully guarded flows

## HTTP And WS

- Validate external input before business logic
- Use request IDs or event IDs for traceability and idempotency
- WS ACK and retry flows must define event ID, ACK timing, retry behavior, and duplicate handling

## External Dependency Reliability

- [MUST] New external HTTP, RPC, MQ, WS, AI, or third-party calls must have timeout or context cancellation
- [MUST] Retries must be bounded, cancellable, and limited to retryable failures
- [SHOULD] Use backoff or jitter for retry loops that can amplify downstream pressure
- [SHOULD] Define degradation behavior for user-facing flows when an external dependency is unavailable

## Observability

- Logs should be structured and include useful business fields such as `request_id`, `task_id`, `tenant_id`, `owner_id`, `entity_id`, `resource_id`, and `status`
- Do not print complete sensitive payloads or cache values
- Use log levels consistently
