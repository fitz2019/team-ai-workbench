# AI Agent Instructions

This workspace uses a reusable AI collaboration system:

```text
AGENTS.md
  -> .agents/index.md
      -> .agents/quick-check.md
      -> .agents/*.md
```

`AGENTS.md` is only the entry point. Detailed rules live in `.agents/` and should be loaded on demand.

## Mandatory Entry

Before generating, modifying, or reviewing code, tests, architecture, or technical plans:

1. Read and follow `.agents/index.md`.
2. Read `.agents/quick-check.md` as a short preflight checklist.
3. Load the `.agents/` modules required by the task, including `.agents/coding-discipline.md` for non-trivial coding work.
4. Keep context small: do not read every module unless the task needs it.

`.agents/examples.md` is optional and routes to focused examples under `.agents/examples/`.

`.agents/` is the workspace rule system. Do not convert it into a Codex skill by default; extract a separate skill only when the same workflow becomes useful across multiple repositories.

The official repository skill discovery surface for this workspace is `.agents/skills/`.
The shared `.agents/skills/coding-discipline/` skill is available when an explicit reusable reminder is helpful, but `.agents/coding-discipline.md` remains the default rule path.
Do not create repo-local `.codex/skills/` by default. External workflow packs such as Superpowers should come from enabled user-level plugins, while project-owned reusable skills should live under `.agents/skills/`.

## Codex Harness

Generated projects can include the Team AI Workbench Codex harness:

```text
.codex/hooks/
.codex/agents/harness-*.toml
.agents/harness-runtime.md
.ai-harness/
```

Normal small tasks should still follow the regular `.agents/` route.

Only enter harness mode when `.ai-harness/ACTIVE` exists. In harness mode:

1. Read `.agents/harness-runtime.md`.
2. Read `.ai-harness/BUILD_PLAN.md`, `.ai-harness/PROGRESS.md`, `.ai-harness/STEER.md`, `.ai-harness/EVALUATOR_RUBRIC.md`, and `.ai-harness/test-results.json`.
3. Work on one bounded item at a time.
4. Keep `.ai-harness/PROGRESS.md` current.
5. Keep `.ai-harness/test-results.json` default-fail until real evidence exists.
6. Use `harness_evaluator` before claiming a long-running item is complete.

## Loading Shortcut

Use this shortcut when deciding what to read:

- Any task: `.agents/quick-check.md`
- Simple non-code or command-only task: `.agents/quick-check.md`, then only the narrow module required by `.agents/index.md`
- Complex implementation, review, or architecture task: follow `.agents/index.md` task routing
- Code change: `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, role-specific stack modules, `.agents/commands.md`, `.agents/completion.md`, `.agents/project-specific.md`
- Code review: `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, role-specific stack modules, `.agents/completion.md`, `.agents/project-specific.md`
- Auth, permission, tenant, owner, user, token, cookie, webhook, upload, or sensitive data: `.agents/security.md`
- Long-running harness task: `.agents/harness-runtime.md`, then the normal task-specific modules
- Running tests, formatting, search, build, or verification commands: `.agents/commands.md`, `.agents/completion.md`
- Need implementation examples: `.agents/examples.md`, then the specific file under `.agents/examples/`

If rules conflict, priority is:

1. User's explicit request
2. `AGENTS.md`
3. `.agents/index.md`
4. `.agents/forbidden.md`
5. `.agents/security.md`
6. `.agents/project-specific.md`
7. Other loaded `.agents/*.md`
8. `.agents/quick-check.md`
9. `.agents/examples.md` and `.agents/examples/*`

User requests can define scope and desired behavior, but they do not override safety, secret-handling, destructive-operation, or security boundary requirements.

When repository patterns conflict with a preference rule, preserve behavior, keep the change scoped, and explain the tradeoff.

## Execution Flow

When working in this workspace:

1. Read the request and relevant existing code or documents before changing files.
2. Keep edits limited to the requested behavior.
3. Prefer existing repository patterns for services, data access, logging, validation, tests, and integrations.
4. For new or touched external I/O, pass `context.Context` or the repository's equivalent cancellation mechanism through the call chain where practical; if compatibility prevents this, state the reason.
5. Verify only touched packages, files, or exact tests unless the user asks for a wider check; prefer target tests first, and run full package tests only for packages changed by this task.
6. Final responses should state what changed, what was verified, and any residual risk or intentional rule tradeoff.
7. When a task produces durable project knowledge, prefer writing it into project-owned docs or runbooks rather than leaving it only in chat history.
8. When a task may depend on previously distilled project knowledge, check the project-owned knowledge location if one exists and load only the relevant file.
