---
name: codebase-onboarding
description: Use when exploring an unfamiliar backend codebase and producing a structured onboarding map or starter instructions.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Codebase Onboarding

Systematically analyze an unfamiliar codebase and produce a concise onboarding guide.

## When to Use

- first time opening a project
- joining a new team or repository
- generating a starter `AGENTS.md` or `.agents/project-specific.md`
- user asks to understand the codebase before changes

## Reconnaissance

Gather these signals without reading every file:

1. manifest detection: `go.mod`, `Makefile`, Docker files, CI files
2. entry point detection: `main.go`, `cmd/`, service bootstrap paths
3. top-level directory snapshot
4. test structure: `*_test.go`, integration test directories
5. toolchain detection: lint, migration, codegen, deployment helpers

## Output

Produce:

- a short onboarding summary
- key directories and responsibilities
- request lifecycle sketch
- common commands
- starter project-specific instruction notes

## Constraint

Stay structural. Do not duplicate the README or dump every dependency.
