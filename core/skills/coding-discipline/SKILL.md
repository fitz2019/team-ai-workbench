---
name: coding-discipline
description: Use before code changes, bug fixes, refactors, or technical plans to keep implementation cautious, simple, scoped, and verifiable.
metadata:
  origin: multica-ai/andrej-karpathy-skills
  adapted_for: team-ai-workbench
  upstream_reference: https://github.com/multica-ai/andrej-karpathy-skills
---

# Coding Discipline

This skill packages a shared coding discipline inspired by the Karpathy-style guidance popularized in `multica-ai/andrej-karpathy-skills`.

Use it to reduce four common failure modes in AI coding workflows:

- silent wrong assumptions
- overengineered solutions
- broad, unrelated diffs
- completion claims without proof

## When To Use

- implementing a feature
- fixing a bug
- reviewing code
- refactoring
- writing or evaluating a technical plan
- deciding whether a change is ready to ship

## The Four Principles

### 1. Think Before Coding

- restate the task in working terms when ambiguity matters
- state assumptions explicitly
- ask when uncertainty changes behavior, API, schema, security, rollout, or migration risk
- present tradeoffs instead of silently picking one path
- push back when a materially simpler path exists

### 2. Simplicity First

- implement the minimum code that solves the requested problem
- avoid speculative abstraction and flexibility
- avoid new layers for single-use cases
- prefer existing repository patterns over cleverness

### 3. Surgical Changes

- touch only what the request requires
- do not clean up adjacent code for taste
- remove only artifacts your own change made obsolete
- mention unrelated issues separately instead of bundling them into the diff

### 4. Goal-Driven Execution

- define the success check before editing when practical
- for bugs, reproduce the failure or create a failing check first when practical
- for features, identify the exact command, test, or observable outcome that proves success
- work in short step -> verify loops for multi-step tasks

## Recommended Pairing

Combine this skill with:

- `systematic-debugging` for failure analysis
- `verification-before-completion` before claiming success

## Red Flags

- "I think this is what they meant"
- "I added this option for future flexibility"
- "I also cleaned up some nearby code"
- "It should work now"

## Tradeoff

This discipline intentionally biases toward caution on non-trivial work.

For trivial, low-risk edits, use judgment and keep the loop light.
