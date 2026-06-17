# Versioning Strategy

This document defines how `team-ai-workbench` should evolve without breaking consumer repositories unnecessarily.

## Goal

Keep the workbench stable enough for teams to adopt, while still allowing iterative improvement from real project experience.

## Versioning Model

Use semantic versioning at the repository level:

- `MAJOR`
  incompatible structural or behavioral changes
- `MINOR`
  new roles, new templates, new skills, new agent overlays, or additive baseline rules
- `PATCH`
  clarifications, bug fixes, documentation improvements, and safe script fixes

## What Counts As a Breaking Change

Treat these as `MAJOR` changes:

- changing the meaning of an existing role
- removing a role, template, skill, or agent that consumers may depend on
- changing initialization script behavior so existing commands no longer produce compatible output
- moving source-of-truth directories in a way that invalidates documented workflows
- changing baseline expectations that force consumers to rework their project-local files

## What Counts As a Minor Change

Treat these as `MINOR` changes:

- adding a new role
- adding a new template
- adding a new shared skill or agent
- promoting a previously optional capability into a supported role layer
- adding new starter files to templates

## What Counts As a Patch

Treat these as `PATCH` changes:

- fixing init script bugs without changing intended behavior
- clarifying docs
- improving examples
- tightening wording in existing rules without changing repository expectations

## Release Discipline

For each release:

1. record the version
2. summarize what changed
3. classify upgrade impact
4. note whether existing consumers need any manual action

Recommended release notes structure:

```text
Version: vX.Y.Z
Type: major / minor / patch
Highlights:
- ...

Consumer impact:
- no action required
- update recommended
- manual review required
```

## Upgrade Compatibility Promise

The repository should preserve these expectations whenever possible:

- project-local `project-specific.md` remains the adaptation point
- templates stay composable through `init-project.ps1`
- `advanced/` remains opt-in
- role overlays remain explicit rather than hidden

## Practical Rule

If a change would surprise an existing consumer repository, it is probably at least `MINOR`, and possibly `MAJOR`.
