# Contribution Guide

This guide explains how to contribute changes to `team-ai-workbench` without turning it into an ungoverned dump of prompts and rules.

## Contribution Principles

- add only reusable things
- keep project-specific business behavior out
- prefer small, role-aligned additions
- verify script or template behavior when changing generation paths
- treat docs as part of the product, not as optional afterthoughts

## Where To Put Changes

Use this routing:

- `core/`
  cross-role rules, shared runtime, shared skills, shared agents
- `roles/<role>/`
  role-specific overlays, role-specific skills, role-specific agents
- `advanced/`
  workflow-heavy, opt-in capabilities
- `templates/`
  reusable repository setup patterns
- `scripts/`
  initialization and maintenance automation
- `docs/`
  governance, adoption, matrices, upgrade notes, extraction audits

## What Not To Add

Do not add:

- business-specific vocabulary from one project
- project-specific API semantics
- release notes for one service
- one-off team habits that have not proven reusable
- huge upstream ECC imports without filtering

## Decision Test Before Adding Anything

Ask these questions:

1. Is this useful across multiple repositories?
2. Is the owning role clear?
3. Does it belong in baseline, role-specific, or advanced?
4. Will this make onboarding clearer rather than noisier?
5. Has this pattern already been validated in real work?

If several answers are "no", do not add it yet.

## Change Workflow

When contributing:

1. choose the target layer
2. make the smallest change that improves reuse
3. update docs if the public behavior changed
4. run the smallest relevant validation
5. note consumer impact in the final summary

## Required Validation

For different changes, validate differently:

- docs-only:
  verify links and examples are still coherent
- role or skill additions:
  inspect file placement and role matrix alignment
- init script changes:
  run at least one template or role initialization
- template changes:
  run the affected template and inspect generated files

## Review Expectations

A good contribution should answer:

- what layer changed
- why the change belongs there
- whether consumers must do anything
- what was validated

## Promotion Rule

Before moving something into `core/`, ask whether it truly belongs across roles.

Before moving something into default role layers, ask whether the team would want it in most repositories using that role.

Before moving something into `advanced/`, ask whether it changes working style rather than just adding guidance.
