# Sample: project-specific.md for go-service

```md
## Workspace

- Workspace root: `C:\repo\example-service`
- Main repository: root repo, no nested git repositories

## Language And Communication

- Product and implementation discussion language: `Chinese`
- User-facing summaries and release notes should be Chinese

## Current Project Vocabulary

- `tenant_id`: tenant scope
- `resource_id`: primary business resource identifier
- `actor_id`: authenticated user or service actor identifier
- `task_id`: async delivery or background task tracking identifier

## Commands

- Build: `go build ./cmd/server`
- Unit test: `go test ./internal/... -count=1`
- Touched package test: `go test ./internal/example -run TestName -count=1`
- Lint: `golangci-lint run`
- Migration up: `make migrate-up`
- Migration down: `make migrate-down`
- Local run: `make run`

## Security Sensitivity

- All reads and writes must be tenant-scoped
- Do not trust request-supplied `tenant_id` or `user_id`
- Webhook signatures must be verified before processing

## Delivery Notes

- API changes default to backward compatible behavior
- New async write paths must define idempotency behavior
- DB changes require rollout and rollback notes
```
