# Sample: project-specific.md for qa-project

```md
## Workspace

- Workspace root: `C:\repo\qa-lab`

## Language And Communication

- QA reports default to Chinese

## Current Project Vocabulary

- `smoke`: minimum release gate checks
- `regression`: known bug-protection and path-consistency checks
- `ship verdict`: ship / ship with fixes / do not ship / inconclusive

## Commands

- Smoke: `pnpm test:smoke`
- Regression: `pnpm test:regression`
- Browser QA: `pnpm qa:browser`
- E2E: `pnpm playwright test`

## Security Sensitivity

- Use only test credentials for auth flows
- Production verification defaults to read-only

## Delivery Notes

- Browser QA runs on preview or staging by default
- Every failed release check must include environment, exact journey, and artifact reference
```
