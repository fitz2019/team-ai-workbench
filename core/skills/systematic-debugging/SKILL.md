---
name: systematic-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
---

# Systematic Debugging

## Core Principle

No fixes without root-cause investigation first.

## When to Use

- test failures
- production bugs
- unexpected behavior
- performance problems
- build failures
- integration issues

## Workflow

### Phase 1: Root Cause Investigation

1. Read the full error and stack trace
2. Reproduce consistently
3. Check recent changes
4. Gather evidence at component boundaries
5. Trace bad data backward to the source

### Phase 2: Pattern Analysis

1. Find working examples in the same codebase
2. Compare against references
3. Identify the exact difference
4. Understand dependency and environment assumptions

### Phase 3: Hypothesis and Testing

1. State one concrete hypothesis
2. Make the smallest possible test change
3. Verify the result before continuing
4. If it fails, form a new hypothesis instead of stacking more fixes

### Phase 4: Implementation

1. Create the smallest failing regression test when practical
2. Implement one focused fix
3. Verify the original symptom and touched scope

## Red Flags

Stop and restart the workflow if you catch yourself doing any of these:

- guessing under time pressure
- proposing a fix before tracing the failure
- stacking multiple fixes at once
- claiming a bug is simple without reproducing it
- jumping to architecture changes after insufficient evidence
