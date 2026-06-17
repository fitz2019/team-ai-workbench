---
name: devops-guidelines
load_when:
  - devops
  - deployment
  - cicd
  - infrastructure
  - network
priority: high
purpose: Shared DevOps conventions for deployment safety, rollback planning, CI reliability, and ops diagnosis.
---

# DevOps Guidelines

Load this file when the task is primarily about deployment, CI/CD, operations, or infrastructure troubleshooting.

## DevOps Priorities

Prioritize:

1. safe rollout and rollback
2. explicit environment assumptions
3. evidence-backed diagnosis
4. minimal blast radius
5. reproducible operational steps

## Rules

- do not treat production as a playground
- distinguish diagnosis from remediation
- prefer read-only inspection first
- rollback and verification must be part of any risky deployment change
- CI or release automation changes should include how failure will be detected
