---
name: ai-regression-testing
description: Regression testing patterns for AI-assisted development, focused on catching contract drift and path inconsistency that code review often misses.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# AI Regression Testing

Use when AI-assisted code changes need stronger regression protection than code review alone can provide.

## When to Use

- backend or API behavior changed
- a bug was fixed and must stay fixed
- the same model wrote and reviewed the code
- multiple code paths exist, such as sandbox vs production or feature-flag branches

## Core Problem

AI can repeat the same blind spot across implementation and review.
Regression tests are the countermeasure.

## What to Verify

- response shape still includes required fields
- alternate execution paths return compatible structures
- bug-specific regression tests exist for previously observed failures
- build and tests run before saying "fixed"

## Recommended Pattern

1. identify the exact bug or drift risk
2. write a focused regression test for it
3. run the smallest command that proves the behavior
4. keep the regression test in place for future AI changes

## Common High-Value Targets

- missing fields in API responses
- sandbox/production parity
- error-path regressions
- feature-flag branch drift
- contract mismatches between frontend expectations and backend output
