# Backend Extraction Audit

This document records the current extraction status from `C:\software\backend` into `team-ai-workbench`.

## Already Extracted

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
- strongly tool-specific bootstrap behavior such as `using-superpowers`
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

## Triaged Local `.codex/skills`

Current decision for `C:\software\backend\.codex\skills`:

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
- keep local for now:
  - `using-superpowers`
  - `writing-skills`
  - `brainstorming`
- no untriaged high-confidence `.codex/skills` remain in the current local backend set
