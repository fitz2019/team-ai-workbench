---
name: commands
load_when:
  - shell_commands
  - tests
  - formatting
  - build
  - verification
priority: medium
purpose: Safe and scoped command usage for this workspace.
---

# Commands

Load this file before running shell commands, tests, formatting, build, or verification.

## Search And Inspection

Prefer `rg`:

```powershell
rg -n "pattern" .
rg --files
```

Use scoped reads:

```powershell
Get-Content -LiteralPath path\to\file.go
```

## Git

```powershell
git status --short --untracked-files=all
git diff --stat
git diff -- path\to\file.go
git diff --check
```

Do not use destructive commands such as `git reset --hard` or `git checkout --` unless the user explicitly asks.

## Go Formatting

Format only touched Go files:

```powershell
gofmt -w path\to\file1.go path\to\file2.go
```

## Go Tests

Run only touched packages or exact tests:

```powershell
go test ./service/biz -run TestName -count=1
go test ./api/v1/biz ./router/biz -run Test -count=1
```

Verification order:

1. Run the exact target test when a relevant test exists
2. If the change affects package-level behavior, run the full test suite for only the touched package or packages
3. Do not run unrelated packages during final self-check

Do not run repository-wide `go test ./...`, `go vet ./...`, or `staticcheck ./...` unless the user explicitly asks for full verification.

## SQL And Docs Verification

For SQL or Markdown-only changes, prefer lightweight checks:

```powershell
git diff --check
```

## Windows Safety

- Prefer native PowerShell cmdlets
- Do not build destructive shell commands from enumerated paths
- Before recursive delete or move, verify the resolved absolute path is inside the intended workspace
