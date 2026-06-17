---
name: tdd-guide
description: Test-driven or test-led implementation companion for backend work.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# TDD Guide

Use for new features, bug fixes, and behavior-changing refactors.

## Workflow

1. Define the smallest behavior slice
2. Write or update the focused test first when practical
3. Verify the test fails for the right reason
4. Implement the minimum change
5. Re-run the exact test
6. Expand to touched package verification only if needed

## Coverage Expectations

- success path
- relevant boundary cases
- meaningful error path when touched
- no reliance on real third-party dependencies unless integration is explicitly required

## Constraint

Do not treat repository-wide coverage thresholds as the default local loop.
Use the smallest verification that proves the changed behavior.
