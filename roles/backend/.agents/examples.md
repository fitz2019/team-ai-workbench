---
name: examples
load_when:
  - implementation_examples
priority: low
purpose: Index for optional focused implementation examples.
---

# Reference Examples

This file indexes reusable examples. It is not a rule source.

Canonical rules live in:

```text
AGENTS.md
.agents/index.md
.agents/*.md
```

If an example conflicts with a loaded rule, the rule wins.

Load only the focused example file needed by the current task:

| Need | Example File |
| --- | --- |
| Error wrapping, parameter object, validation | `.agents/examples/error-handling.md` |
| Bounded batch concurrency | `.agents/examples/concurrency.md` |
| Idempotent DB conditional update | `.agents/examples/db-idempotency.md` |
| Structured logging | `.agents/examples/logging.md` |
| Redis compressed values and Cache Aside | `.agents/examples/redis-cache.md` |
