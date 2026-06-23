# Template Catalog

This catalog maps high-level repository types to `team-ai-workbench` templates.

All templates install the Codex harness by default:

- `.codex/` runtime config, agents, and hooks
- `.agents/` shared rules and selected role overlays
- `.ai-harness/` long-running state files

Use `-NoHarness` only when you intentionally want the older lightweight rule-only setup.

## Available Templates

| Template | Default Roles | Shared Skills | Best For |
| --- | --- | --- | --- |
| `go-service` | `backend, qa` | yes | Go APIs, workers, backend services |
| `web-frontend` | `frontend, qa, product` | yes | React or Next.js applications |
| `product-docs` | `product` | yes | PRD, capability, and research repositories |
| `qa-project` | `qa` | yes | Browser QA, regression labs, verification workspaces |
| `feature-delivery` | `product, qa` | yes | Product-to-QA feature delivery repositories |
| `ops-service` | `devops, backend` | yes | CI/CD, infra automation, deployment-heavy repos |

## Recommended Commands

```powershell
# Go backend service
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service

# Frontend project
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template web-frontend

# Product docs repo
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template product-docs

# QA repo
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template qa-project

# Product + QA delivery repo
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template feature-delivery

# Ops repo
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template ops-service

# Legacy rule-only setup, without Codex harness
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service -NoHarness
```
