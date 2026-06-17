# Upgrade Playbook

This playbook describes how to bring improvements from `team-ai-workbench` into an existing consumer repository safely.

## Core Principle

Do not overwrite a mature project with a fresh initialization run unless the repository is intentionally being reset.

Treat upgrades as deliberate merges, not re-installs.

## Safe Upgrade Process

### 1. Identify the Source Layer

Decide which part changed upstream:

- `core/`
- one or more `roles/`
- `advanced/`
- `templates/`
- `scripts/`

### 2. Compare Before Copying

Compare the consumer repository against the current workbench output:

- root `AGENTS.md`
- `.agents/`
- `.codex/`
- optional `skills/`

Focus on the exact role or template the project originally adopted.

### 3. Protect Project-Specific Truth

Never blindly replace:

- `.agents/project-specific.md`
- project command lists
- business vocabulary
- release constraints
- project-local examples that document real business behavior

### 4. Upgrade in a Scratch Branch

Recommended process:

1. create a scratch branch
2. generate a fresh output from the current workbench into a temp directory
3. diff the temp output against the repository's existing project-local files
4. merge only the reusable improvements

### 5. Re-verify

After merging upgrades:

- confirm `AGENTS.md` still routes correctly
- confirm `.codex/config.toml` still loads
- confirm role-specific overlays are still present
- run a small dry-run task in Codex

## When Re-Initialization Is Acceptable

Re-run `init-project.ps1` directly into a target repository only when:

- the repository is brand new
- the repository is mostly generated and has very little local customization
- the team explicitly wants to reset the local AI surface

Even then, review the diff carefully.

## Upgrade Categories

### Low Risk

- docs clarifications
- new optional advanced capabilities
- additive role skills not already copied locally

### Medium Risk

- changed role overlays
- changed default role composition in a template
- new starter files in existing templates

### High Risk

- moved source-of-truth directories
- behavior changes in init script
- changed baseline rules in `core/`
- changes that affect all role combinations

High-risk upgrades should be applied deliberately, not casually.

## Practical Rule of Thumb

If the consumer repository contains real project-specific AI rules, upgrade it like code, not like a package reinstall.
