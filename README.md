# Team AI Workbench

Reusable AI collaboration workbench for real teams.

English | [简体中文](./README.zh-CN.md)

## What It Is

`team-ai-workbench` is a **source repository** for shared AI collaboration assets.

It is designed for teams that want:

- one shared AI operating model across repositories
- role-specific guidance for backend, frontend, product, QA, and DevOps
- repeatable project setup instead of one-off prompt craftsmanship
- a filtered downstream workbench built from ECC ideas and assets, not a raw ECC copy

This repository is not a business project.  
It is the upstream workbench that your real repositories are generated from.

## Quick Start

### 1. Pick a template

Use a named template when the repository type is obvious:

| Repository type | Template |
| --- | --- |
| Go API / worker / backend service | `go-service` |
| React / Next.js application | `web-frontend` |
| Product requirements / capability repo | `product-docs` |
| QA / regression / browser verification repo | `qa-project` |
| Product + QA feature delivery repo | `feature-delivery` |
| CI/CD / infra / operations repo | `ops-service` |

### 2. Initialize a project

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service
```

Examples:

```powershell
# Go backend service
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service

# Frontend product
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template web-frontend

# Product + QA delivery workspace
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template feature-delivery
```

### 3. Fill in project-local truth

After initialization, edit:

- `.agents/project-specific.md`

At minimum, define:

- real commands
- business vocabulary
- security and boundary notes
- release or rollout constraints

### 4. Open the generated repository in Codex

From the generated project root:

```powershell
codex
```

Use a small dry-run task first:

- architecture reading only
- narrow bug analysis
- one small change with scoped verification

## Why Teams Use This

Without a shared workbench, teams usually end up with:

- AI usage trapped in individual prompt habits
- repeated rework across projects
- no stable role boundaries
- weak onboarding for new repos and new teammates

This repository fixes that by turning AI collaboration into:

- a reusable baseline
- role-specific overlays
- project templates
- documented upgrade and contribution rules

## Roles

Current production-ready role packs:

| Role | What it is for |
| --- | --- |
| `backend` | Go services, APIs, workers, DB/Redis/MQ-heavy systems |
| `frontend` | React/Next.js UI work, accessibility, frontend build and review |
| `product` | product framing, capability definition, planning, research |
| `qa` | regression safety, browser QA, E2E, release confidence |
| `devops` | deployment, CI/CD, infra, network and ops review |

If a repository clearly maps to a standard type, prefer a template.  
If it needs a custom combination, use role composition.

## Layers

```text
core/
roles/
advanced/
templates/
scripts/
docs/
```

- `core/`
  Always-on baseline rules, runtime settings, shared agents, shared skills
- `roles/`
  Role-specific overlays for backend, frontend, product, QA, and DevOps
- `advanced/`
  Opt-in workflow-heavy capabilities that change how the team works
- `templates/`
  Repository presets and starter files
- `scripts/`
  Initialization and release helper scripts
- `docs/`
  Governance, adoption, upgrade, roadmap, and role docs

## Repository Philosophy

We do **not** use ECC raw.

We treat ECC as:

- an upstream capability source
- a structure reference
- a skill and agent library to curate from

Then we combine that with our own engineering standards to produce a downstream workbench that is easier for teams to adopt and maintain.

In short:

> We are not avoiding ECC. We are not using it unchanged.  
> We use ECC as a capability source, then combine it with our own engineering standards to build a workbench that fits day-to-day team delivery.

## Governance Docs

- [Template Catalog](./docs/template-catalog.md)
- [Adoption Guide](./docs/adoption-guide.md)
- [Project Integration Guide](./docs/project-integration-guide.md)
- [Knowledge Capture Guide](./docs/knowledge-capture-guide.md)
- [Role Matrix](./docs/role-matrix.md)
- [ECC Role Candidate Map](./docs/ecc-role-candidate-map.md)
- [Extraction Audit](./docs/extraction-audit.md)
- [Versioning Strategy](./docs/versioning-strategy.md)
- [Contribution Guide](./docs/contribution-guide.md)
- [Upgrade Playbook](./docs/upgrade-playbook.md)
- [Roadmap](./docs/roadmap.md)
- [Changelog](./CHANGELOG.md)

## Advanced Layer

`advanced/` is intentionally not part of the default baseline.

Use it only when the team explicitly wants heavier workflow modes such as:

- formal implementation plans
- subagent-driven execution
- parallel investigation
- worktree-heavy isolation

Do not enable `advanced/` just because it looks powerful.

## Suggested Adoption Order

For most teams:

1. start with one real repository
2. use a template, not a custom composition
3. run real work, not demos
4. feed reusable improvements back into this repository
5. only then expand to more templates, roles, or advanced workflows
