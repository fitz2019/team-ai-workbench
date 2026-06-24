---
name: browser-qa
description: Use when verifying browser-facing behavior, visual state, or UI interactions after feature changes.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Browser QA

Use this skill to automate visual testing and user-flow verification on local, preview, or staging environments.

## When to Use

- after deploying or previewing a feature
- before shipping UI-affecting changes
- when verifying forms, navigation, responsive layout, or browser-side regressions

## Safety

- default to read-only validation
- do not run mutating journeys against production unless the user explicitly requests it and the environment is safe
- use test credentials when auth flows are involved

## Verification Phases

1. smoke check:
   - open target URL
   - inspect console and network failures
   - capture key screenshots
2. interaction test:
   - critical nav links
   - valid and invalid form behavior
   - primary flow completion
3. visual regression:
   - check main breakpoints
   - flag overflow, missing elements, or major layout shifts
4. accessibility spot-check:
   - major label, contrast, keyboard, or focus issues

## Output

- environment
- URLs or journeys checked
- pass/fail by section
- artifacts and major findings
- ship / ship with fixes / do not ship / inconclusive
