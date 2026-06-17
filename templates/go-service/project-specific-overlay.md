## Template Hints: Go Service

- Main stack: Go, HTTP framework, database layer, cache or queue if applicable
- Fill in exact commands for:
  - build
  - unit tests
  - package tests
  - lint
  - migration
  - local run
- Document:
  - request context propagation expectations
  - tenant or owner boundary rules
  - idempotency expectations for writes, retries, and async delivery
  - Redis key conventions if Redis is used
