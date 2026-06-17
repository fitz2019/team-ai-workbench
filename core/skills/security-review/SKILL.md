---
name: security-review
description: Shared security review checklist and vulnerability patterns for authentication, input handling, secrets, and sensitive flows.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Security Review

Use when code touches authentication, authorization, user input, secrets, uploads, sensitive data, payments, or third-party integrations.

## What to Check

- secrets management
- input validation
- injection risk
- auth and authorization boundaries
- sensitive-data exposure
- file upload and callback safety
- dependency and configuration security

## Core Rules

- no hardcoded secrets
- validate and normalize external input
- parameterize DB queries
- fail closed on missing or ambiguous auth context
- avoid leaking internals or sensitive payloads
- document residual security risk when compatibility blocks full enforcement

## Output

- issue list by severity
- affected file and failure mode
- concrete remediation guidance
