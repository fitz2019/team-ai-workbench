---
name: completion
load_when:
  - final_response
  - completion_claim
  - review_output
  - verification
priority: high
purpose: Completion, self-review, verification, and final response criteria.
---

# Completion Criteria

Load this file before claiming work is complete, sending review output, or finalizing a task.

## Self-Review Checklist

Before final response, check the touched scope:

- The behavior matches the user's request
- Existing behavior is preserved unless explicitly changed
- Final self-review is limited to files, code paths, packages, and tests touched by this task
- Authorization, tenant isolation, and sensitive-data exposure were considered for touched API or data paths
- Errors are handled explicitly
- New external I/O receives `context.Context` where practical
- Any intentionally skipped "when practical" or "when possible" preference has a stated compatibility reason
- New writes are idempotent or the lack of idempotency is justified
- New concurrency is bounded and cancellable
- Logs include useful business identifiers and do not expose secrets
- Redis/cache changes have TTL, consistency strategy, and big-key consideration
- DB changes have suitable indexes and release SQL or migration notes when needed
- Tests or verification cover the touched behavior
- Tests for changed behavior cover the main success path, relevant boundary cases, and meaningful error paths when those paths are touched
- Tests avoid real external third-party dependencies; use existing fakes, mocks, test doubles, or local fixtures unless an integration test is explicitly required
- No unrelated refactor or metadata churn was introduced
- If the task produced docs, release notes, or API docking output, compatibility impact and residual risk are stated when relevant

## Verification

- Run the smallest useful verification command for the touched scope
- Prefer exact target tests first; run full package tests only for packages changed by this task
- Do not include unrelated package or repository-wide checks in final self-review unless the user explicitly asked for wider verification
- Do not claim tests passed unless the command actually completed successfully
- If verification cannot run, state why and what remains risky

## Review Focus

For code review or self-review, check the touched scope for:

- Clear responsibility boundaries and no new circular dependencies
- Explicit handling for normal, boundary, and failure paths
- Bounded retry, timeout, and degradation behavior for new external dependencies
- Compatibility impact on public APIs, response fields, database schema, serialized data, and configuration

## Code Review Output

When the user asks for review:

1. Findings first, ordered by severity
2. Include exact file and line
3. Explain the risk and concrete fix
4. Add open questions or assumptions
5. Summaries are secondary

If no issues are found, say that clearly and mention residual risk.

## Final Response

Keep the final response concise:

- What changed
- What was verified
- Any residual risk or operational note

For simple doc-only work, one short paragraph plus verification is enough.
