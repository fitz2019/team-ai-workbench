---
name: index
load_when:
  - every_task
priority: highest
purpose: Route tasks to the required .agents modules and define rule priority.
---

# AI Engineering Standard Index

This file is the reusable index for the AI collaboration system.

The canonical rules are split into focused modules under `.agents/`. Load only the modules needed for the current task.

## Rule Priority

1. User's explicit request
2. `AGENTS.md`
3. This index
4. `.agents/forbidden.md`
5. `.agents/security.md`
6. `.agents/project-specific.md`
7. Other loaded `.agents/*.md`
8. `.agents/quick-check.md`
9. `.agents/examples.md` and `.agents/examples/*`

User requests can define scope and desired behavior, but they do not override safety, secret-handling, destructive-operation, or security boundary requirements.

Within loaded modules:

1. Hard rules and red lines
2. Security and data boundaries
3. Repository compatibility
4. Engineering preferences
5. Examples

`.agents/quick-check.md` is a compact reminder and does not override detailed modules.

`.agents/examples.md` and `.agents/examples/*` contain examples only. They are not rule sources.

## Workspace Rule System

`.agents/` is the shared baseline rule system. Keep it generic by default.

`.agents/skills/` is the canonical repository skill surface. Legacy `.codex/skills/` can exist in older projects, but it is not the primary rule source.

Do not convert these rules into a Codex skill unless the same workflow is repeatedly useful across multiple repositories, such as:

- `go-backend-review`
- `redis-cache-consistency`
- `backend-release-check`
- `security-boundary-review`

## Rule Growth

Do not add broad, all-purpose rules just to make the system look complete. Add or change rules only when they:

- Reflect a real project pain or repeated review issue.
- Prevent a concrete production, security, data consistency, or delivery risk.
- Fit an existing focused module, or justify a new module with a clear load condition.
- Keep context small enough for agents to apply reliably.

## Rule Levels

Use explicit levels when adding or interpreting rules:

- `[MUST]` Mandatory. Violations should block implementation or review unless the user changes the requirement and safety boundaries still hold.
- `[SHOULD]` Recommended default. If skipped, state the compatibility reason, tradeoff, and residual risk.
- `[MAY]` Optional. Use only when it fits the touched scope and existing repository patterns.

## Module Map

| Module | Load When | Purpose |
| --- | --- | --- |
| `.agents/quick-check.md` | After this index for every task | Compact preflight and final self-check reminders |
| `.agents/forbidden.md` | Before code generation, code modification, review, refactor, architecture suggestions | Non-negotiable red lines |
| `.agents/coding-discipline.md` | Before code generation, code modification, review, refactor, architecture suggestions | Shared coding discipline: clarify before coding, prefer simple solutions, keep diffs surgical, and verify against explicit goals |
| `.agents/security.md` | When touching auth, permission, tenant, owner, user, token, cookie, webhook, upload, external callback, or sensitive data | Security and data boundary rules |
| `.agents/tech-stack.md` | When touching Go code, Redis, DB, MQ, WS, cache, concurrency, external I/O, or architecture | Technical stack and engineering practices |
| `.agents/commands.md` | Before running shell commands, tests, formatting, build, or verification | Safe and scoped command usage |
| `.agents/completion.md` | Before claiming completion, sending review output, or finalizing work | Verification and final response criteria |
| `.agents/project-specific.md` | Whenever project behavior, docs, API, DB, or business logic is touched | Repository-specific conventions |
| `.agents/harness-runtime.md` | When `.ai-harness/ACTIVE` exists or the task is about long-running agent work | Codex harness runtime rules, handoff, steering, and evidence contract |
| `.agents/examples.md` | When an implementation example helps | Index for optional reference snippets |
| `.agents/examples/*` | After `.agents/examples.md`, load only the relevant example file | Focused implementation examples |

## Task Routing

Use this mechanical routing table before reading modules:

| Task | Required Modules |
| --- | --- |
| Every task | `.agents/quick-check.md`, then task-specific modules below |
| Code modification | `.agents/quick-check.md`, `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, `.agents/tech-stack.md`, `.agents/commands.md`, `.agents/completion.md`, `.agents/project-specific.md` |
| Code review | `.agents/quick-check.md`, `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, `.agents/tech-stack.md`, `.agents/completion.md`, `.agents/project-specific.md` |
| Architecture or technical plan | `.agents/quick-check.md`, `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, `.agents/tech-stack.md`, `.agents/completion.md`, `.agents/project-specific.md` |
| Command-only task | `.agents/quick-check.md`, `.agents/commands.md`, `.agents/completion.md` |
| Narrow technical question | `.agents/quick-check.md`, `.agents/forbidden.md`, `.agents/project-specific.md`; add `.agents/coding-discipline.md`, `.agents/security.md`, or `.agents/tech-stack.md` when relevant |
| Long-running harness task | `.agents/quick-check.md`, `.agents/harness-runtime.md`, `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, `.agents/tech-stack.md`, `.agents/commands.md`, `.agents/completion.md`, `.agents/project-specific.md` |
| Redis, DB, MQ, WS, worker, cache, concurrency, or external I/O | `.agents/tech-stack.md` |
| Auth, permission, tenant, owner, user, token, cookie, webhook, upload, or sensitive data | `.agents/security.md` |
| Final response, completion claim, or review output | `.agents/completion.md` |
| Need implementation examples | `.agents/examples.md`, then one relevant `.agents/examples/*` file |

## Repository Compatibility

- Preserve existing behavior unless the user explicitly asks to change it.
- Prefer local repository patterns over new abstractions.
- Keep changes scoped to the requested behavior.
- Do not clean up unrelated historical issues just because they violate a preference.
- When a preference conflicts with stable local behavior, explain the tradeoff and choose the lower-risk path.

## Working Loop

1. Understand the request and inspect relevant files.
2. Load the modules required by the task.
3. Make the smallest safe change.
4. Verify the touched scope only: exact target tests first, then full tests only for touched packages when needed.
5. Report changes, verification, and residual risk.
6. If a "when practical" or "when possible" preference was intentionally not followed, state the compatibility reason and tradeoff.
