---
name: deployment-patterns
description: Deployment workflows, health checks, rollback strategy, and production readiness patterns for backend services.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Deployment Patterns

Use when planning release workflows, production rollout strategy, health checks, and rollback.

## Use Cases

- production release planning
- rollout strategy discussion
- CI/CD pipeline review
- health and readiness design
- rollback planning

## Rollout Modes

- rolling deployment: default for backward-compatible changes
- blue-green: for fast rollback and clearer cutover
- canary: for high-risk changes with traffic sampling

## Readiness Checklist

- health endpoint exists and reflects real readiness
- config and secrets are environment-driven
- migrations and app rollout order are clear
- backward compatibility is understood
- rollback path is documented

## Container and CI Notes

- runtime image should be minimal and explicit
- CI should separate lint, tests, build, and deploy gates
- release-critical paths should not rely on unverified manual assumptions

## Constraint

Prefer the team's actual hosting platform and deployment workflow over generic cloud-agnostic examples.
