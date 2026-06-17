# Role Matrix

This repository separates reusable team AI assets into `core`, `roles`, and `advanced`.

## Source of Truth

- `core/` — always-on shared baseline
- `roles/backend/` — production-ready Go backend role
- `roles/frontend/` — production-ready frontend role
- `roles/product/` — production-ready product role
- `roles/qa/` — production-ready QA role
- `roles/devops/` — production-ready DevOps role
- `advanced/` — opt-in workflow-heavy capabilities

## Current Maturity

| Role | Status | Notes |
| --- | --- | --- |
| backend | ready | Full `.agents`, `.codex`, skills, and agent overlays |
| frontend | ready | Frontend `.agents`, React reviewer/build-resolver overlays, and frontend skill pack |
| product | ready | Product `.agents`, planner/spec overlays, and product research/capability skill pack |
| qa | ready | QA `.agents`, QA Codex role overlay, regression/browser/E2E skills, and E2E runner role |
| devops | ready | DevOps `.agents`, ops/network overlays, and deployment/ops skill pack |

## Practical Meaning

- Use `backend`, `frontend`, `product`, `qa`, and `devops` today for real projects
- Choose only the roles the target repository actually needs
