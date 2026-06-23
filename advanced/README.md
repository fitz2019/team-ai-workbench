# Advanced Workflow Layer

This directory contains optional workflow-heavy capabilities.

These are not the main harness. The main runtime architecture now lives in `codex-harness/`.

This directory contains optional add-on workflows because they change how a team organizes work, not just how code is written.

Current advanced skills:

- `writing-plans`
- `executing-plans`
- `finishing-a-development-branch`
- `requesting-code-review`
- `receiving-code-review`
- `dispatching-parallel-agents`
- `subagent-driven-development`
- `using-git-worktrees`

Use this layer when the team explicitly wants:

- formal implementation plans
- structured plan execution
- structured branch completion and cleanup
- structured review request and review intake workflows
- parallel investigation workflows
- subagent-based execution
- isolated worktree-based feature execution

Do not enable these by default for every repository unless the team agrees on the operating model.
