# Adoption Guide

This guide explains how to adopt `team-ai-workbench` in a team without turning it into process theater.

## What This Repository Is

`team-ai-workbench` is a **source repository** for shared AI collaboration assets.

It is not a business repository.

It provides:

- shared baseline rules in `core/`
- role overlays in `roles/`
- opt-in workflow-heavy capabilities in `advanced/`
- project initialization paths in `templates/` and `scripts/`

Each consumer project should receive a **generated project-local copy** of the selected layers rather than depend on this repository at runtime.

## What Belongs Where

### In `team-ai-workbench`

Put only reusable things here:

- cross-project engineering rules
- role-specific review and workflow guidance
- reusable skills and agent roles
- initialization scripts and template structure

### In each project repository

Keep project truth there:

- business vocabulary
- exact commands
- API compatibility notes
- rollout and schema specifics
- tenant, owner, and permission nuances
- repository-specific examples

The dividing line is simple:

- if it is true for many projects, put it in `team-ai-workbench`
- if it is only true for one project, keep it in that project

Also see:

- [project-integration-guide.md](./project-integration-guide.md)
- [knowledge-capture-guide.md](./knowledge-capture-guide.md)
- [local-backport-playbook.md](./local-backport-playbook.md)

## Adoption Modes

### Mode 1: Single-role project

Use when a repository is clearly one kind of work.

Examples:

- Go service: `backend`
- Product documentation repo: `product`
- QA regression lab: `qa`

Command pattern:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Roles backend -IncludeSkills
```

### Mode 2: Multi-role project

Use when one repository requires sustained collaboration across roles.

Examples:

- frontend + product + QA
- backend + DevOps
- product + QA delivery workspace

Command pattern:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Roles frontend,product,qa -IncludeSkills
```

### Mode 3: Named template

Use when the repository type already matches a standard operating pattern.

Examples:

- `go-service`
- `web-frontend`
- `feature-delivery`
- `ops-service`

Command pattern:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template go-service
```

Prefer templates over manual role selection when the repository type is obvious.

## Which Template To Choose

Use this map:

| Situation | Recommended template |
| --- | --- |
| Go API, worker, service | `go-service` |
| React or Next.js product UI | `web-frontend` |
| PRD / capability / research repository | `product-docs` |
| Browser QA / regression workspace | `qa-project` |
| Product and QA handoff repository | `feature-delivery` |
| CI/CD, infra, deployment-heavy service | `ops-service` |

If no template fits well, use explicit role composition.

## Advanced Layer Policy

`advanced/` is intentionally **not part of the default baseline**.

Use it only when the team explicitly wants the operating model it implies.

Enable `advanced/` when:

- the team wants formal implementation plans
- the team wants worktree-based isolation
- the team is comfortable with subagent-driven execution
- the team benefits from parallel investigation workflows

Do **not** enable `advanced/` by default just because the capabilities look powerful.

Rule of thumb:

- baseline first
- advanced only after the team feels the pain it solves

## Rollout Strategy

Adopt this repository in stages.

### Stage 1: One real project

Pick one project with one or two obvious roles and initialize it.

Recommended first picks:

- `go-service`
- `web-frontend`
- `feature-delivery`

### Stage 2: Run for real work

Use the generated project for actual tasks, not demos:

- implementation
- review
- QA verification
- release notes

Collect friction:

- which rules were too generic
- which project-specific notes were missing
- which role combination felt too heavy

### Stage 3: Feed improvements upstream

When a change is reusable, move it back into `team-ai-workbench`.

When it is project-only, keep it local.

Use [local-backport-playbook.md](./local-backport-playbook.md) instead of relying on memory or chat history for the promotion process.

### Stage 4: Expand to more repositories

Only after one project has proven the pattern should the team standardize more broadly.

## Upgrade Strategy

Do not blindly re-run initialization over an existing mature repository.

Instead:

1. compare the current project-local files against the current `team-ai-workbench` source
2. identify reusable upstream improvements
3. apply updates deliberately
4. preserve project-specific business rules

For low-risk upgrades:

- copy updated role or core files into a scratch branch
- diff them
- merge only what the project actually wants

Treat `team-ai-workbench` as an upstream distribution, not an always-overwrite source.

## Team Operating Rules

To keep this sustainable:

- do not let every project invent a new role
- do not promote project quirks into shared baseline rules
- do not move workflow-heavy habits into default baseline without team agreement
- do not treat template initialization as the end; each project still needs `project-specific.md` completed

## Minimum Successful Adoption

A project is considered successfully adopted when:

- `AGENTS.md` and `.agents/` are present
- `.codex/` loads cleanly
- the chosen role or template matches the repository's actual work
- `.agents/project-specific.md` is filled in with real commands and boundaries
- one real task has been completed with the generated setup

## Practical Defaults

If the team wants a low-friction default:

- backend-heavy repo -> `go-service`
- frontend-heavy repo -> `web-frontend`
- coordination repo -> `feature-delivery`
- infra-heavy repo -> `ops-service`

Start there before inventing custom compositions.
