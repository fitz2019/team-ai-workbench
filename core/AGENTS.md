# AI Agent Instructions

This repository provides a reusable AI collaboration baseline that is composed from:

```text
core/
roles/<role>/
advanced/
```

For a consumer project, the generated root `AGENTS.md` should be treated as the entry point, and detailed rules should live in `.agents/`.

## Mandatory Entry

Before generating, modifying, or reviewing code, tests, architecture, or technical plans:

1. Read and follow `.agents/index.md`
2. Read `.agents/quick-check.md`
3. Load the task-specific modules required by the request
4. Keep context small and do not load unrelated modules

`.agents/examples.md` is optional and routes to focused examples under `.agents/examples/`.

## Working Principles

- Preserve existing behavior unless the user explicitly asks to change it
- Prefer existing repository patterns over generic rewrites
- Keep edits scoped to the requested behavior
- Verify only the touched scope unless the user explicitly asks for broader verification
- Final responses should state what changed, what was verified, and any residual risk
