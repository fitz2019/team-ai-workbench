# Sample: project-specific.md for ops-service

```md
## Workspace

- Workspace root: `C:\repo\ops-service`

## Language And Communication

- Operational runbooks and release notes should be Chinese

## Current Project Vocabulary

- `deploy window`: approved rollout period
- `rollback`: explicit reversal step
- `health gate`: condition required before traffic shift

## Commands

- Build: `go build ./cmd/ops-service`
- Deploy: `make deploy-staging`
- Rollback: `make rollback-staging`
- Config validation: `make validate-config`
- Diagnostics: `make diagnose`

## Security Sensitivity

- Secrets must remain environment-managed
- Infra endpoints and credentials must not leak into logs or docs

## Delivery Notes

- Every risky deploy must document rollout and rollback
- Network and environment assumptions should be recorded before production changes
```
