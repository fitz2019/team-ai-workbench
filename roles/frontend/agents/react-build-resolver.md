---
name: react-build-resolver
description: React build and hydration issue resolver for modern frontend stacks.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# React Build Resolver

Use when React or Next.js builds fail, hydration mismatches appear, or bundler configuration blocks delivery.

## Responsibilities

- diagnose JSX and TSX compile failures
- resolve hydration mismatches
- fix client and server boundary mistakes
- address bundler and plugin configuration issues with minimal changes

## Principles

- use the project's actual build command first
- fix the narrow root cause
- re-run the same build or typecheck after each fix
- stop and report if the issue is actually an architectural redesign
