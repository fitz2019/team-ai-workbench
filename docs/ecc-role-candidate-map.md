# ECC Role Candidate Map

This document records which ECC assets are worth adopting into `team-ai-workbench`, grouped by role and adoption stage.

## Selection Rules

- **Adopt now**: reusable, role-aligned, low ambiguity, low team-process risk
- **Next candidates**: useful, but should be imported only when the role becomes active
- **Reference only**: good upstream ideas, but too tool-specific, too domain-specific, or too heavy for the current baseline

## Core

### Adopt now

- `documentation-lookup`
  Current library and framework behavior via docs or Context7
- `codebase-onboarding`
  Structured onboarding for unfamiliar repositories
- `code-reviewer`
  General correctness and maintainability review role
- `docs-lookup`
  Specialist role for documentation-backed answers

### Next candidates

- `planner`
  Useful shared planning role if the team standardizes planning flow

### Reference only

- `deep-research`
  Strong capability, but too heavy for the default engineering baseline

## Backend

### Adopt now

- `golang-patterns`
- `golang-testing`
- `verification-loop`
- `api-design`
- `database-migrations`
- `docker-patterns`
- `deployment-patterns`
- `go-reviewer`
- `go-build-resolver`
- `tdd-guide`

### Next candidates

- `backend-patterns`
  Good ideas, but biased toward Node and TS examples; should be rewritten for Go before import
- `security-reviewer`
  Worth promoting once backend security review becomes a default role
- `database-reviewer`
  Good candidate if the team wants a dedicated DB review role
- `performance-optimizer`
  Candidate when performance work becomes a recurring theme

### Reference only

- language-specific agents or skills not aligned with Go backend delivery

## Frontend

### Adopt now

- `frontend-patterns`
- `frontend-a11y`
- `frontend-design-direction`
- `react-reviewer`
- `react-build-resolver`

### Reference only

- `frontend-slides`
  Valuable for presentation-like deliverables, not for default product frontend work
- `design-system`
  Useful later, but needs explicit frontend design-system ownership

## Product

### Adopt now

- `product-lens`
- `product-capability`
- `market-research`
- `research-ops`
- `planner`
- `spec-miner`

### Reference only

- `chief-of-staff`
  Useful for communication-heavy operators, but not a default product baseline
- domain-specific investor or market skills unless the product team actually needs them

## QA

### Adopt now

- `ai-regression-testing`
- `e2e-testing`
- `browser-qa`
- `benchmark`
- `e2e-runner`

### Reference only

- stack-specific testing skills that do not match the team's actual toolchain

## DevOps

### Adopt now

- `docker-patterns`
- `deployment-patterns`
- `github-ops`
- `security-scan`
- `benchmark-optimization-loop`
- `network-troubleshooter`
- `network-config-reviewer`

### Reference only

- infra or network skills that are too environment-specific without a shared operating model

## Advanced

### Adopt as opt-in only

- `writing-plans`
- `dispatching-parallel-agents`
- `subagent-driven-development`
- `using-git-worktrees`
- `hexagonal-architecture`
- `github-ops`

These are valuable, but they change team operating style rather than just adding reusable engineering guidance.

## Recommendation

Current maturity suggests:

1. `backend`, `frontend`, `product`, `qa`, and `devops` now all have role packs
2. Add only the roles a repository actually needs
3. Keep `advanced/` opt-in even when the role itself is production-ready
