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
3. Load the task-specific modules required by the request, including `.agents/coding-discipline.md` for non-trivial coding work.
4. Keep context small: do not read every module unless the task needs it.

`.agents/examples.md` is optional and routes to focused examples under `.agents/examples/`.

`.agents/` is the workspace rule system. Do not convert it into a Codex skill by default; extract a separate skill only when the same workflow becomes useful across multiple repositories.

The preferred shared local skill surface for this workspace is `.agents/skills/`, which is Codex's official repository skill discovery surface.
Existing `.codex/skills/` remains available as a legacy local capability pack and does not replace `.agents/` as the rule source.
The shared `.agents/skills/coding-discipline/` skill is available when an explicit reusable reminder is helpful, but `.agents/coding-discipline.md` remains the default rule path.

## Loading Shortcut

Use this shortcut when deciding what to read:

- Any task: `.agents/quick-check.md`
- Simple non-code or command-only task: `.agents/quick-check.md`, then only the narrow module required by `.agents/index.md`
- Complex implementation, review, or architecture task: follow `.agents/index.md` task routing
- Code change: `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, role-specific stack modules, `.agents/commands.md`, `.agents/completion.md`, `.agents/project-specific.md`
- Code review: `.agents/forbidden.md`, `.agents/coding-discipline.md`, `.agents/security.md`, role-specific stack modules, `.agents/completion.md`, `.agents/project-specific.md`
- Auth, permission, tenant, owner, user, token, cookie, webhook, upload, or sensitive data: `.agents/security.md`
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

1. Read the request and relevant existing files before changing anything.
2. Keep edits limited to the requested behavior.
3. Prefer existing repository patterns over generic rewrites.
4. Verify only the touched scope unless the user explicitly asks for a wider check.
5. Final responses should state what changed, what was verified, and any residual risk or intentional tradeoff.
6. When a task produces durable project knowledge, prefer writing it into project-owned docs or runbooks rather than leaving it only in chat history.
