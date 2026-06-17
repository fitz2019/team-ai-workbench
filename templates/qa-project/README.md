# Template: qa-project

Recommended for:

- test harness repositories
- regression labs
- browser QA workspaces
- release verification repositories

Default composition:

- roles: `qa`
- include shared skills: yes

Suggested init:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template qa-project
```

## Suggested Repository Shape

```text
tests/
  regression/
  browser/
  e2e/
artifacts/
docs/
scripts/
```

## Baseline Commands To Fill In

- smoke checks
- regression suite
- browser QA command
- E2E command
- artifact collection or report command

## Also See

- [project-specific-sample.md](</C:/software/self/project/team-ai-workbench/templates/qa-project/project-specific-sample.md>)
