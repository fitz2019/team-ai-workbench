# Backend Extraction Audit

This document records the current extraction status from `C:\software\backend` into `team-ai-workbench`.

## Already Extracted

Latest selective backport from the live `C:\software\backend` project:

- Loop Engineering runtime additions:
  - `.codex/harness/start-loop.ps1`
  - `.codex/harness/record-evaluation.ps1`
  - `.codex/harness/finish-loop.ps1`
  - `.codex/harness/archive-loop.ps1`
  - `.ai-harness/LOOP_STATE.json`
  - `.ai-harness/runs/`
  - stop-gate integration for paused/max-round loop states
- generated `AGENTS.md` execution-flow wording for scoped verification, existing-code inspection, external I/O context propagation, and optional project knowledge lookup
- `.agents/forbidden.md` red lines for Redis configuration source-of-truth and non-silent cache, delivery, and background-task failures
- `.agents/security.md` clarification that the module protects authorization, tenant isolation, and sensitive data
- backend `tech-stack.md` risk-focus guidance for API compatibility, tenant/owner/permission boundaries, DB/Redis consistency, async idempotency, and release/rollback checks
- backend `project-specific.md.example` sections for exact commands, knowledge capture, and project-local delivery notes
- `.codex/AGENTS.md` clarification of `.codex`, `.agents`, `.agents/skills`, and `.ai-harness` responsibilities
- `.codex/config.toml` persistent instruction tightened to route through `AGENTS.md` and `.agents/index.md`, preserve project patterns, and verify only touched scope

Shared rule modules:

- `AGENTS.md`
- `.agents/index.md`
- `.agents/quick-check.md`
- `.agents/forbidden.md`
- `.agents/security.md`
- `.agents/tech-stack.md`
- `.agents/commands.md`
- `.agents/completion.md`

Shared examples:

- `.agents/examples/concurrency.md`
- `.agents/examples/error-handling.md`
- `.agents/examples/db-idempotency.md`
- `.agents/examples/logging.md`
- `.agents/examples/redis-cache.md`

ECC-derived skills:

- `skills/golang-patterns`
- `skills/golang-testing`
- `skills/verification-loop`
- `skills/codebase-onboarding`
- `skills/api-design`
- `skills/database-migrations`
- `skills/docker-patterns`
- `skills/deployment-patterns`
- `skills/documentation-lookup`
- `skills/security-review`

QA role skills:

- `roles/qa/skills/ai-regression-testing`
- `roles/qa/skills/browser-qa`
- `roles/qa/skills/e2e-testing`
- `roles/qa/skills/benchmark`

ECC-derived agent library:

- `agents/go-reviewer.md`
- `agents/go-build-resolver.md`
- `agents/code-reviewer.md`
- `agents/tdd-guide.md`
- `agents/docs-lookup.md`
- `agents/security-reviewer.md`

QA role agents:

- `roles/qa/agents/e2e-runner.md`

Local reusable skills promoted from `backend/.codex/skills`:

- `skills/systematic-debugging`
- `skills/verification-before-completion`
- `core/.agents/coding-discipline.md`
- `core/skills/coding-discipline`
- `roles/backend/skills/test-driven-development`

## Still Project-Local

These should remain in each project repository:

- `.agents/project-specific.md`
- project command details
- business vocabulary like `shop_id`, `c_code`, `order_id`
- schema and release specifics
- API compatibility notes tied to one product
- repository-specific examples that leak business semantics
- strongly tool-specific bootstrap behavior such as `using-superpowers`; use the Superpowers plugin instead of vendoring it into generated projects by default
- local skill-authoring helpers such as `writing-skills` until contributor workflow is formalized

## Optional Next Extraction Candidates

Useful but not yet promoted into the shared layer:
- none in the current high-confidence local set

Promoted into `advanced/` instead of the default baseline:

- `advanced/writing-plans`
- `advanced/executing-plans`
- `advanced/finishing-a-development-branch`
- `advanced/requesting-code-review`
- `advanced/receiving-code-review`
- `advanced/dispatching-parallel-agents`
- `advanced/subagent-driven-development`
- `advanced/using-git-worktrees`
- `advanced/hexagonal-architecture`
- `advanced/github-ops`

Reason they are not in the default baseline:

- they are workflow-heavy and require team process alignment
- they change operating style, not only coding style
- some overlap with current `.codex/agents` and verification conventions

## Triaged Former Local `.codex/skills`

Current decision for the former local backend `.codex/skills` pack:

- already absorbed into `core/`:
  - `systematic-debugging`
  - `verification-before-completion`
  - `coding-discipline` (adapted from local experience plus Karpathy-style discipline)
- already absorbed into `advanced/`:
  - `writing-plans`
  - `executing-plans`
  - `finishing-a-development-branch`
  - `requesting-code-review`
  - `receiving-code-review`
  - `dispatching-parallel-agents`
  - `subagent-driven-development`
  - `using-git-worktrees`
- keep out of generated projects by default:
  - `using-superpowers` (provided by the user-level Superpowers plugin)
  - `writing-skills`
  - `brainstorming`
- no untriaged high-confidence local skill packs remain in the current backend set
