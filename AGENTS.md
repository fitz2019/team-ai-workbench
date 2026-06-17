# Team AI Workbench Repository Instructions

This repository is the source workspace for shared team AI assets.

It is not a consumer project. The source of truth is organized as:

```text
core/
roles/
advanced/
templates/
scripts/
docs/
```

## How To Work In This Repository

When changing this repository:

1. Treat `core/` as the always-on baseline
2. Treat `roles/` as role-specific overlays
3. Treat `advanced/` as opt-in workflow capabilities
4. Keep `templates/` and `scripts/` aligned with the source layout
5. Do not recreate compatibility copies at the repository root

## Editing Rules

- Put shared baseline rules in `core/`
- Put backend-specific reusable rules and skills in `roles/backend/`
- Keep scaffold roles minimal until the team has agreed on shared conventions
- Only promote ECC-derived assets after they have been filtered for team usefulness
- Keep project-specific business behavior out of this repository; it belongs in each consumer project's own `.agents/project-specific.md`

## Verification

When updating initialization or composition behavior:

- validate the generated structure with `scripts/init-project.ps1`
- test at least one real role combination such as `backend`
- test one multi-role combination when role composition logic changes

## Final Output Expectations

When reporting changes in this repository:

- state which source layer changed (`core`, `roles`, `advanced`, `scripts`, `templates`)
- state whether initialization behavior was re-tested
- call out any migration note if the repository structure changed
