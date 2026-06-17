# Template: web-frontend

Recommended for:

- React or Next.js applications
- browser-based products
- design-system-driven frontends

Default composition:

- roles: `frontend`, `qa`, `product`
- include shared skills: yes

Suggested init:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template web-frontend
```

## Suggested Repository Shape

```text
src/
  app/ or pages/
  components/
  hooks/
  lib/
  styles/
tests/
  e2e/
public/
docs/
```

## Baseline Commands To Fill In

- dev
- build
- typecheck
- unit test
- e2e test
- lint

Typical examples:

```text
pnpm dev
pnpm build
pnpm typecheck
pnpm test
pnpm playwright test
pnpm lint
```

## First Verification After Init

1. Document staging or preview URL for browser QA
2. Name the critical user journeys
3. Confirm design-system or component-library rules
4. Open with `codex` and run a small UI audit task

## Also See

- [project-specific-sample.md](</C:/software/self/project/team-ai-workbench/templates/web-frontend/project-specific-sample.md>)
