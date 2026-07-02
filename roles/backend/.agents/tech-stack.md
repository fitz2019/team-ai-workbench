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
- Prefer `.agents/skills/` for project-owned reusable workflows. Use enabled user-level plugins for external workflow packs such as Superpowers.

## Architecture Boundaries

- [MUST] Preserve the repository's existing layer direction; do not introduce reverse dependencies from infrastructure or shared components back into business entrypoints
- [MUST] Avoid new circular dependencies between packages or same-layer modules
- [SHOULD] Inject clients, repositories, producers, cache helpers, and other external dependencies through constructors or existing service wiring instead of hardcoding creation inside business logic
- [SHOULD] Keep shared capabilities in existing common infrastructure or helper layers; do not make unrelated business modules call each other just to reuse code
- [SHOULD] Record important architecture tradeoffs in the final response or requested design document when a change affects module boundaries, public APIs, storage, or external integrations

## Go Engineering Style

- Prefer clear business boundaries before implementation details
- Prefer guard clauses to reduce nesting
- Prefer concrete types; introduce interfaces only when replacement or testing value is clear
- If a function would take more than three business parameters, prefer a parameter struct
- New exported Go identifiers should follow the repository's GoDoc language convention, and the GoDoc should begin with the identifier name when practical

## Backend Risk Focus

Apply the general coding discipline most strictly to these recurring backend risks:

### API Compatibility

- Before coding, identify whether the change adds fields, changes semantics, or risks breaking request/response compatibility
- Prefer additive, backward-compatible API changes unless the user explicitly accepts a breaking change
- If request fields such as tenant, owner, user, role, resource, platform, or business-scope identifiers are involved, confirm whether they come from trusted context or request payload

### Tenant, Owner, And Permission Boundaries

- Do not guess identity, tenant, owner, or permission rules from parameter names alone
- When the business boundary is unclear, stop and confirm the trusted source and enforcement path before implementing
- Simpler code is not better if it weakens cross-tenant, cross-owner, or cross-scope isolation; security and scope boundaries win

### Redis And DB Consistency

- Do not introduce cache writes, invalidation, TTL, or read-through behavior without first naming the consistency strategy
- Prefer the smallest design that preserves clear source-of-truth behavior; do not add clever cache layers speculatively
- When a change touches both DB and Redis, define what proves correctness: exact write path, invalidation path, stale-data window, and failure logging

### Async, MQ, And Idempotency

- Before coding async work, clarify retry behavior, duplicate handling, timeout recovery, and idempotency key or business key
- Do not solve delivery uncertainty by stacking retries and goroutines without an explicit bounded design
- Keep the fix surgical: change the exact delivery path or state transition involved, not the entire async framework

### Release And Rollback

- If the task affects schema, persisted state, configuration, or a public API, define rollout and rollback checks before implementation completes
- Success is not only "code compiles" but also whether deployment order, rollback path, and compatibility notes are clear enough for release

## DB

- Pass `context.Context` into new or touched DB calls when practical. If repository compatibility prevents this, state the reason.
- Use transactions only when state must be committed atomically
- Keep transactions short; do not hold transaction locks across slow external I/O
- Large-table queries must consider indexes and query shape
- Use keyset or cursor pagination for large result sets when possible. If OFFSET pagination is retained, explain the bounded data, compatibility, or index rationale.
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
- Prefer ordinary single-key operations for normal get/set paths
- When multi-key Lua, transaction, or pipeline logic requires keys in the same Redis Cluster slot, use a deliberate hash tag such as `tenant:{123}:config:a` and `tenant:{123}:config:lock`
- Do not use a broad hash tag such as `{tenant}` or `{config}` that forces unrelated tenants into one hot slot
- Avoid multi-key operations across different hash slots unless the client and command explicitly support it

### TTL

- Cache keys must have TTL
- TTL should match business semantics
- Hot cache TTL should consider jitter to avoid avalanche

### Value Size

- Treat these as large-key risks:
  - single value over 10KB
  - Hash field count over 200
  - large Set, ZSet, or List
  - large JSON, rich text, or repeated context payload
- Consider compression, field slimming, bucketing, or pagination

### Consistency

- Use an explicit cache strategy: Cache Aside, Write Through, Write Back, double delete, or delayed double delete
- Config and dictionary caches may be eventually consistent with short TTL, but write paths should delete or refresh cache and log invalidation failures
- Do not optimize with Redis if it creates unacceptable stale configuration behavior
- For persistent configuration, DB remains the source of truth. Redis is a cache unless the business explicitly defines Redis as durable state
- Preferred write path for strong-enough consistency: write DB first, then delete Redis cache; the next read backfills Redis
- Direct DB+Redis double write is allowed only with explicit TTL, jitter, failure logging, and a defined stale-data window
- Cache penetration mitigation: cache empty values with a short TTL when the key can be repeatedly missed
- Cache avalanche mitigation: add random TTL jitter for hot or high-cardinality caches
- Concurrent backfill mitigation: use `singleflight`, a short Redis lock, or another bounded request-coalescing mechanism before DB fallback

### Locks And Atomicity

- Use `SetNX(ctx, key, value, ttl)` with non-zero TTL or equivalent `SET key value NX EX`
- Lock value must be unique
- Release locks with value verification and Lua
- For multi-key state transitions, prefer Lua, Redis transaction, or DB conditional update

### Redis Operations

- Online code must not use `KEYS`
- `SCAN/HSCAN/SSCAN/ZSCAN` is for low-frequency governance, migration, inspection, or compensation, not hot-path strong pagination
- Use Pipeline for more than five independent Redis operations after considering command count and value size
- Keep Pipeline batches roughly 50 to 500 commands unless there is a measured reason

## Concurrency

- Short batch work: prefer `errgroup.WithContext` with `SetLimit`
- Long-running worker: prefer bounded worker pool with configurable worker size and queue size
- Queues must define behavior when full: reject, wait with context, retry, or degrade
- Do not start goroutines that cannot exit

## MQ And Async Delivery

- Core delivery flows need ACK, retry, timeout recovery, dead letter, and idempotent consumption
- Redis queues are acceptable only for non-critical or fully guarded flows
- High-reliability flows should prefer Kafka, RocketMQ, RabbitMQ, or an existing reliable MQ in the project
- When DB state, cache invalidation, MQ delivery, and compensation logic interact, document the ordering and recovery path instead of relying on vague "eventual consistency" language

## HTTP And WS

- Validate external input before business logic
- Use request IDs or event IDs for traceability and idempotency
- WS ACK and retry flows must define event ID, ACK timing, retry behavior, and duplicate handling

## External Dependency Reliability

- [MUST] New external HTTP, RPC, MQ, WS, AI, or third-party calls must have timeout or context cancellation
- [MUST] Retries must be bounded, cancellable, and limited to retryable failures; do not retry non-idempotent writes unless idempotency is guaranteed
- [SHOULD] Use backoff or jitter for retry loops that can amplify downstream pressure
- [SHOULD] Define degradation behavior for user-facing flows when an external dependency is unavailable: fail closed, return explicit error, use cached data, enqueue compensation, or skip optional enrichment
- [SHOULD] Log retry and degradation events with business identifiers and dependency name, without logging complete request or response payloads

## Observability

- Logs should be structured and include useful business fields such as `request_id`, `task_id`, `tenant_id`, `owner_id`, `entity_id`, `resource_id`, and `status`
- Do not print complete sensitive payloads or cache values
- Use log levels consistently: expected business outcomes at INFO, retry or degradation at WARN, and unexpected failures that need attention at ERROR
- For new critical tasks, delivery flows, workers, or external calls, consider latency, success/failure count, retry count, queue depth, and cache hit/miss metrics where the project has an existing metrics pattern
- New health-critical dependencies should have an observable failure signal, such as logs, metrics, health checks, or existing alerting hooks
- If a flow is important enough to need an operational handoff, also leave behind the key diagnostic command or runbook entry instead of relying only on chat history
