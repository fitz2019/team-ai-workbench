# Template: ops-service

Recommended for:

- CI/CD or infra automation repositories
- deployment tooling
- operational services
- network or environment-heavy backends

Default composition:

- roles: `devops`, `backend`
- include shared skills: yes

Suggested init:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template ops-service
```

## Suggested Repository Shape

```text
cmd/
internal/
deploy/
infra/
scripts/
docs/
```

## Baseline Commands To Fill In

- build
- deployment
- rollback
- config validation
- environment checks
- diagnostics

## Also See

- [project-specific-sample.md](</C:/software/self/project/team-ai-workbench/templates/ops-service/project-specific-sample.md>)
