# Local Backport Playbook

This playbook defines how to promote proven local improvements from `C:\software\backend` into `team-ai-workbench`.

The goal is to stop relying on chat memory and turn local experience into a repeatable upstream workflow.

## Operating Model

Treat the local backend workspace as the **proving ground**.

Treat `team-ai-workbench` as the **upstream source repository**.

The flow is:

```text
local backend work
  -> repeated pattern or validated improvement
  -> reusable rewrite
  -> upstream backport into team-ai-workbench
  -> template or role regeneration for future projects
```

## What Qualifies For Backport

Backport only when the improvement is:

- proven in real work
- useful across multiple repositories or future repositories
- clear about which layer owns it
- free of project-specific business vocabulary

Good candidates:

- stronger reusable rules in `AGENTS.md` or `.agents/`
- backend patterns around DB, Redis, MQ, verification, release, or rollback
- reusable skills or workflow guides
- template improvements
- governance docs that make adoption or upgrades safer

## What Must Stay Local

Do not backport:

- business vocabulary such as `shop_id`, `c_code`, `order_id`
- one-service API semantics
- release notes for a single service
- raw chat transcripts
- one-off workarounds that have not been validated
- local filesystem paths unless they are only examples and clearly genericized

## Layer Routing

Use this routing before changing upstream:

- `core/`
  cross-role baseline rules, shared skills, shared agents
- `roles/backend/`
  Go/backend-specific rules, examples, skills, reviewer behavior
- `advanced/`
  opt-in workflow-heavy capabilities that change how teams work
- `templates/`
  repository presets, starter files, overlays
- `docs/`
  governance, extraction audit, adoption, contribution, upgrade guidance

## Standard Backport Workflow

### 1. Start From The Local Change

Identify the exact local improvement in:

- `C:\software\backend\AGENTS.md`
- `C:\software\backend\.agents\`
- `C:\software\backend\skills\`
- `C:\software\backend\.agents\skills\`
- local docs or knowledge files when they contain reusable patterns

### 2. Generate A Clean Comparison Target

Create a scratch repository from the current upstream source:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\scratch -Template go-service -IncludeAdvanced
```

This shows what the upstream currently produces.

### 3. Diff Scratch Against Local

Compare the generated scratch output against the local backend workspace to isolate what is truly different.

Focus on:

- rules that became clearer or safer
- skills that proved useful in repeated work
- workflow docs that reduce ambiguity

### 4. Rewrite For Reuse

Before promoting upstream:

- remove business-specific vocabulary
- remove local-only path assumptions
- remove temporary project context
- keep the underlying pattern, guardrail, or workflow

If the local wording only makes sense for one service, it does not belong upstream yet.

### 5. Patch The Upstream Layer

Apply the smallest change in `team-ai-workbench`:

- `core/` for cross-role baselines
- `roles/backend/` for backend-specific rules and skills
- `advanced/` for workflow-heavy skills
- `docs/` for governance and process

### 6. Update Governance Artifacts

Every accepted backport should leave an artifact trail:

- update [docs/extraction-audit.md](./extraction-audit.md)
- update [CHANGELOG.md](../CHANGELOG.md)
- update README or role docs if public behavior changed

Do not rely on chat to remember what was promoted.

### 7. Validate Generation Paths

Run the smallest relevant validation:

- for rule or skill changes, initialize at least one affected template or role
- for script changes, run the script path directly
- for template changes, inspect the generated files

### 8. Record Consumer Impact

State whether existing consumer repositories must:

- do nothing
- manually merge updated files
- re-run initialization in a scratch branch
- opt in to a new advanced capability

## Decision Table

Use this table when unsure:

| Local improvement | Target layer |
| --- | --- |
| clearer cross-role rule entry | `core/` |
| backend-specific DB/Redis/MQ guidance | `roles/backend/` |
| plan execution or branch completion workflow | `advanced/` |
| starter files or overlays | `templates/` |
| extraction and promotion process | `docs/` |

## Suggested Cadence

Do this on a small but regular rhythm:

- after a repeated review issue
- after a painful bug or release lesson
- after a workflow improvement proves useful more than once
- during weekly or biweekly local knowledge review

Avoid giant "sync everything" efforts. Small repeated backports are more reliable.

## Minimum Definition Of Done

A local improvement is considered successfully backported when:

- the reusable version exists in `team-ai-workbench`
- extraction audit and changelog are updated
- the affected generation path was validated
- the improvement no longer depends on remembering the original chat thread
