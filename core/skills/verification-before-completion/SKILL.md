---
name: verification-before-completion
description: Use when preparing to claim work is complete, fixed, passing, or ready for review.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
---

# Verification Before Completion

## Core Principle

Evidence before claims, always.

If you did not run the verification command in the current loop, do not claim success.

## Gate

Before saying a task is done:

1. identify the command that proves the claim
2. run the command fresh
3. read the full output and exit code
4. verify the output really supports the claim
5. only then report success

## Common Cases

- tests pass -> requires fresh test output
- build succeeds -> requires fresh build output
- lint is clean -> requires fresh lint output
- bug is fixed -> requires the original symptom or regression test to pass

## Red Flags

- "should work now"
- "probably fixed"
- success wording before verification
- relying on partial checks
- trusting another agent's report without checking

## Repository Constraint

For this standard, verification should still stay scoped:

- exact target test first
- touched package or file verification second
- repository-wide verification only when explicitly requested
