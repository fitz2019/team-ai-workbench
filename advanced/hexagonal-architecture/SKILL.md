---
name: hexagonal-architecture
description: Ports and adapters guidance for teams that explicitly choose domain-centric boundaries.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
  tier: advanced
---

# Hexagonal Architecture

Use when the team explicitly wants ports-and-adapters style boundaries.

## When to Use

- building a new subsystem with long-term boundary concerns
- refactoring framework-heavy business logic
- supporting multiple interfaces over the same use case

## Core Idea

- domain logic should not depend on transport or persistence details
- use cases orchestrate behavior
- ports define contracts
- adapters implement the ports
- composition root wires concrete implementations

## Warning

This is not a default baseline requirement.

If a repository already has a stable layered structure, do not force a hexagonal rewrite just because the pattern is attractive.
