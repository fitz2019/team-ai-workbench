# Team AI Workbench

Reusable AI collaboration workbench for real teams.

English | [简体中文](./README.zh-CN.md)

## What It Is

`team-ai-workbench` is a **source repository for a team Codex harness**.

It is designed for teams that want:

- a Codex runtime that can handle controlled long-running work
- hooks, evaluator agents, handoff files, and default-fail verification
- one shared AI operating model across repositories
- one shared coding discipline: clarify before coding, prefer simple solutions, keep diffs surgical, and verify against explicit success criteria
- role-specific guidance for backend, frontend, product, QA, and DevOps
- repeatable project setup instead of one-off prompt craftsmanship
- a filtered downstream workbench built from ECC ideas and assets, not a raw ECC copy

This repository is not a business project.  
It is the upstream Codex harness that your real repositories are generated from.

In short:

> `codex-harness/` runs the workflow.
> `core/roles/templates` provide team rules, role thinking, and project presets.

## Quick Start

This repository is not something you copy into application code by hand. A teammate uses it like this:

1. Clone this workbench source repository
2. Use the initializer to install rules, roles, skills, and harness files into a real project
3. Start Codex from the real project root
4. Keep project-local knowledge in the project, and backport reusable team knowledge to this workbench

### 0. Clone the workbench source repo

```powershell
cd C:\software\self\project
git clone https://github.com/fitz2019/team-ai-workbench.git
cd team-ai-workbench
```

If it is already cloned, update it before initializing a new project:

```powershell
git pull
```

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

Replace `C:\path\to\repo` with the real target repository path:

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

After initialization, the target project receives:

| Path | Purpose |
| --- | --- |
| `AGENTS.md` | Root entrypoint that tells Codex which collaboration rules apply to this project |
| `.agents/` | Team rules, role constraints, project facts, and promoted stable knowledge |
| `.codex/` | Codex config, subagents, hooks, and default-scanned skills |
| `.ai-harness/` | Long-running plans, progress, evidence, pause controls, and continuation state |

### 3. Fill in project-local truth

After initialization, edit:

- `.agents/project-specific.md`

At minimum, define:

- real commands
- business vocabulary
- security and boundary notes
- release or rollout constraints

Generated projects also receive:

- `.codex/` for Codex config, subagents, and hooks
- `.agents/` for team rules and role constraints
- `.ai-harness/` for long-running plans, progress, evidence, and steering

### 4. Open the generated repository in Codex

Start Codex from the real project root, not from the `team-ai-workbench` repository:

```powershell
cd C:\path\to\repo
```

```powershell
codex
```

After opening the project, confirm that Codex trusts the project-local layer. The exact flow depends on the surface:

- Codex CLI TUI: if Codex says hooks need review, type `/hooks` to inspect and trust project hooks
- Codex desktop app: follow the project / hook trust prompt in the app; if no prompt appears, do not run `/hooks` manually
- If project hooks are not trusted, long-running harness features such as stop gates, steering, and evaluator triggers may not run

Use a small dry-run task first:

- architecture reading only
- narrow bug analysis
- one small change with scoped verification

### 5. Use it for everyday development

For small tasks, do not enable the harness. Work directly in the target project and let Codex follow the generated rules:

```text
Read the project rules and relevant code first. Analyze the root cause of this bug without editing code yet.
```

```text
Implement this small change using the current project rules. Keep the diff narrow and run the necessary verification.
```

```text
Review this change as a reviewer. Focus on regressions, edge cases, and missing tests.
```

### 6. Enable long-running mode

Enable only when the task should persist across multiple turns:

Write the plan first:

```powershell
notepad .\.ai-harness\BUILD_PLAN.md
```

Then enable the harness:

```powershell
New-Item -ItemType File .\.ai-harness\ACTIVE -Force
```

Allow stop-hook continuation when evidence is still failing:

```powershell
New-Item -ItemType File .\.ai-harness\CONTINUE_ON_STOP -Force
```

Pause autonomous work:

```powershell
New-Item -ItemType File .\.ai-harness\AGENT_STOP -Force
```

Then tell Codex:

```text
Execute according to .ai-harness/BUILD_PLAN.md. Update PROGRESS.md, EVIDENCE.md, and HANDOFF.md each round; do not mark the task complete if verification is failing.
```

### 7. Preserve project knowledge

Project knowledge has two layers:

| Location | Use it for |
| --- | --- |
| `.agents/project-specific.md` | Stable project facts Codex should know in every future session |
| `docs/knowledge/` | Chat retrospectives, draft lessons, issue notes, candidate rules, and knowledge that still needs validation |

Rules of thumb:

- Keep project-specific facts in the target project
- Backport repeatedly validated, cross-project lessons to `team-ai-workbench`
- Do not put project table names, API names, customer names, or one-off business facts into generic team rules

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
- a Codex harness
- durable handoff files
- fresh-context evaluation
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
codex-harness/
core/
roles/
advanced/
templates/
scripts/
docs/
```

- `codex-harness/`
  Main runtime layer. It maps cwc-style harness primitives to Codex config, hooks, evaluator agents, handoff files, and `.ai-harness` state.
- `core/`
  Always-on baseline rules, shared agents, and shared skills
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

Upstream reference:

- [ECC by affaan-m](https://github.com/affaan-m/ECC)

We treat ECC as:

- an upstream capability source
- a structure reference
- a skill and agent library to curate from

Then we combine that with our own engineering standards to produce a downstream workbench that is easier for teams to adopt and maintain.

In short:

> We are not avoiding ECC. We are not using it unchanged.  
> We use ECC as a capability source, then combine it with our own engineering standards to build a workbench that fits day-to-day team delivery.

## Why cwc Matters Here

[anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents) points to an important next step: AI coding is not just prompts or skills; it needs a controllable agent harness.

We adapt the architecture:

- default-fail evidence contracts
- fresh-context evaluator
- durable handoff files
- hooks for kill switch, steering, and stop gates

This repository is the Codex-native version of that idea: `codex-harness/` runs the loop, while `.agents/` and role packs constrain the reasoning.

## Acknowledgement

This workbench is informed by ideas and assets from [ECC](https://github.com/affaan-m/ECC).  
We use ECC as an upstream capability source and structure reference, then curate and adapt it to fit our own engineering standards and team operating model.

The long-running harness architecture is inspired by [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents). This repository adapts the architecture for Codex instead of vendoring the original project.

It is also informed by the coding-discipline framing popularized in [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills), adapted here into the shared `core` baseline instead of being used as a raw drop-in.

## Governance Docs

- [Template Catalog](./docs/template-catalog.md)
- [Adoption Guide](./docs/adoption-guide.md)
- [Project Integration Guide](./docs/project-integration-guide.md)
- [Knowledge Capture Guide](./docs/knowledge-capture-guide.md)
- [Harness Architecture](./docs/harness-architecture.md)
- [Local Backport Playbook](./docs/local-backport-playbook.md)
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
