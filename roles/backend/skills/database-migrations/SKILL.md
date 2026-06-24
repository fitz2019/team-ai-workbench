---
name: database-migrations
description: Use when planning schema changes, data backfills, rollout safety, rollback, or migration verification.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Database Migration Patterns

Use for schema changes, index work, large-table changes, and rollout planning.

## Core Principles

1. Every change is a migration
2. Migrations are immutable after deployment
3. Schema and data migrations should be separated when practical
4. Large-table behavior must be considered before rollout
5. Rollback strategy must be explicit

## Safety Checklist

- migration path identified
- large-table lock risk considered
- new columns are nullable or have safe defaults
- index creation strategy documented
- data backfill split out when needed
- rollout and rollback noted

## PostgreSQL Guidance

- avoid adding `NOT NULL` columns without a safe staged rollout
- use concurrent index creation on existing large tables when supported
- prefer expand-contract for destructive renames or removals
- backfills should be batched when data volume is large

## Delivery Notes

For DB changes, final output should include:

- migration file or SQL path
- whether large tables are affected
- index rationale
- rollback approach
- deployment order
- residual risk

## Constraint

Prefer the repository's existing migration tool and rollout conventions over generic examples.
