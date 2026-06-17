# Sample: project-specific.md for web-frontend

```md
## Workspace

- Workspace root: `C:\repo\web-frontend`
- Single repository, no nested git repositories

## Language And Communication

- Product and implementation discussion language: `Chinese`
- User-facing docs should be Chinese unless specified otherwise

## Current Project Vocabulary

- `workspace_id`: workspace scope
- `viewer`: authenticated current user
- `plan`: subscription tier concept

## Commands

- Dev: `pnpm dev`
- Build: `pnpm build`
- Typecheck: `pnpm typecheck`
- Unit test: `pnpm test`
- E2E: `pnpm playwright test`
- Lint: `pnpm lint`

## Security Sensitivity

- Do not leak server-only env vars into client bundles
- Auth-sensitive mutations must be verified against trusted backend context

## Delivery Notes

- Critical user journeys:
  - login
  - dashboard load
  - checkout or plan upgrade
- Browser QA uses preview URL from Vercel staging
- Accessibility blockers should be reported before ship signoff
```
