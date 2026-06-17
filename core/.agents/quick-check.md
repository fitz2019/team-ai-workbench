---
name: quick-check
load_when:
  - every_task
priority: high
purpose: Compact preflight and final self-check for routine backend work.
---

# Quick Check

Load this after `.agents/index.md` for every task. It is a compact reminder only; if it conflicts with a detailed module, the detailed module wins.

## Preflight

- Read the request carefully and identify the touched scope before opening files
- Load only the detailed modules required by the task
- Preserve existing behavior unless the user explicitly asks to change it
- Do not modify unrelated files or clean up unrelated historical issues
- Do not trust request-supplied `tenant_id`, `owner_id`, `user_id`, role, or permission fields without trusted-context validation
- For external I/O, prefer `context.Context`, timeout, and bounded retry where practical
- Redis/cache changes need TTL, consistency strategy, and big-key consideration
- New writes, async tasks, delivery flows, ACK, retry, and compensation logic need idempotency
- API changes default to backward compatible behavior; breaking changes need migration or adaptation notes
- Logs and errors need useful business identifiers and must not expose secrets or sensitive payloads

## Verification

- Verify only files, packages, exact tests, and code paths touched by the current task
- Prefer exact target tests first; run full package tests only for packages changed by this task
- Do not run repository-wide checks unless the user explicitly asks
- Before final response, report what changed, what was verified, and any residual risk or intentional tradeoff
