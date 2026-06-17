---
name: benchmark-optimization-loop
description: Bounded performance optimization loop for measured latency, throughput, or cost improvements.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Benchmark Optimization Loop

Use when the task is to make something faster through bounded, measured iteration.

## Rules

- define the metric first
- measure a baseline
- test one hypothesis per variant
- reject variants that fail correctness
- promote only the fastest safe variant with evidence
