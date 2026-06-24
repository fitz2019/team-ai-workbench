---
name: benchmark
description: Use when measuring performance baselines or regressions for APIs, builds, browser flows, or backend hot paths.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Benchmark

Use when the team needs evidence about performance before and after a change.

## When to Use

- user reports something is slow
- before or after a PR to detect performance regression
- before a release to confirm target performance

## Modes

- API latency benchmark
- build or feedback-loop timing
- browser performance baseline when UI exists

## Rules

- define the metric first
- capture a baseline before optimization
- compare like-for-like inputs
- do not call a change "faster" without measurements
