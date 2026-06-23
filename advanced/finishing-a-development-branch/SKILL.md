---
name: finishing-a-development-branch
description: Use when implementation is complete and the team needs a structured decision for merge, PR, branch preservation, or discard.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Finishing A Development Branch

Use this skill when implementation work is complete and the next question is how to integrate or close out the branch safely.

## When to Use

- planned implementation is finished
- the branch is ready for integration review
- the team wants a structured completion menu instead of an open-ended "what next?"
- a worktree or isolated branch may need cleanup

## Workflow

1. verify the required checks before presenting any completion options
2. detect repository and worktree state
3. determine the intended base branch
4. present a small explicit menu:
   - merge locally
   - push and open PR
   - keep as-is
   - discard
5. execute only the chosen path
6. clean up branches or worktrees only when that path requires it

## Verification Rule

Do not treat this skill as permission to run repository-wide checks by default.

Verification should still follow project rules:

- exact target checks first
- touched package or component checks second
- broader verification only when the team or user explicitly wants it before integration

If the team requires a wider pre-merge suite, say so explicitly before continuing.

## Safety Rules

- do not discard work without explicit confirmation
- do not force-push unless explicitly requested
- do not remove worktrees you do not clearly own
- do not present branch-completion options before verification is done
- if verification fails, stop and return to implementation instead of pushing broken work forward

## Team Fit

This skill is useful when the team wants branch hygiene, explicit integration choices, and safer worktree cleanup.

Keep it opt-in for teams that are ready for structured completion workflows.
