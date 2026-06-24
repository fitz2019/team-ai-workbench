---
name: e2e-testing
description: Use when designing Playwright-style end-to-end checks, handling artifacts, or investigating flaky critical flows.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# E2E Testing

Use when the project needs maintainable end-to-end tests for critical user journeys.

## Use Cases

- auth flows
- core CRUD journeys
- regression protection for key business paths
- CI-integrated browser test coverage

## Guidance

- organize tests by journey or feature
- use page objects or similarly stable abstractions when the suite is non-trivial
- collect screenshots and traces on failure
- identify and quarantine flaky tests instead of pretending they are stable
- keep E2E focused on critical paths; do not try to replace all lower-level tests

## Stability Rules

- prefer explicit wait conditions over sleeps
- prefer stable selectors
- avoid shared state between tests
- make CI output inspectable through artifacts
