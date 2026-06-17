# Template: go-service

Recommended for:

- Go backend services
- HTTP APIs
- workers and background jobs
- services with Redis, DB, MQ, or external I/O

Default composition:

- roles: `backend`, `qa`
- include shared skills: yes

Suggested init:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service
```

## Suggested Repository Shape

```text
cmd/
internal/
api/ or transport/
pkg/              # only if truly reusable outside the service
configs/
migrations/ or db/migrations/
scripts/
tests/            # optional, if integration tests live outside packages
docs/
```

## Baseline Commands To Fill In

At minimum, define these in `.agents/project-specific.md`:

- build
- unit test
- touched-package test
- lint
- migration up/down
- local run

Typical examples:

```text
go build ./cmd/server
go test ./internal/order -count=1
golangci-lint run
make migrate-up
make run
```

## First Verification After Init

1. Fill in the actual commands for the repo
2. Document tenant, owner, and idempotency rules
3. Open the repo with `codex`
4. Ask for a read-only architecture pass before making code changes

## Also See

- [project-specific-sample.md](</C:/software/self/project/team-ai-workbench/templates/go-service/project-specific-sample.md>)
