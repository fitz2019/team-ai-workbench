---
name: frontend-guidelines
load_when:
  - frontend
  - react
  - nextjs
  - ui
  - accessibility
priority: high
purpose: Shared frontend conventions for React, UI behavior, accessibility, and frontend verification.
---

# Frontend Guidelines

Load this file when the task is primarily frontend-facing.

## Frontend Priorities

Prioritize:

1. user-visible correctness
2. accessibility and keyboard reachability
3. stable render and data-flow behavior
4. responsive layout and visual integrity
5. reproducible verification

## Frontend Rules

- Prefer existing design system and routing patterns over new abstractions.
- Treat hooks correctness and client/server boundaries as correctness issues, not style issues.
- New interactive UI should remain keyboard reachable and labeled.
- For significant UI changes, verify both behavior and layout, not just build success.
- Preserve existing visual language unless the user explicitly asks for redesign.

## Verification

- run the smallest build or typecheck command that proves the touched scope
- for user-facing behavior changes, include at least one direct UI verification step
- if browser automation is used, state the environment and the exact flow checked
