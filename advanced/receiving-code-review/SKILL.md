---
name: receiving-code-review
description: Use when review feedback arrives from a human, reviewer agent, PR comments, or CI notes and you need a disciplined way to evaluate it before changing code.
metadata:
  origin: local-backend-codex
  adapted_for: team-ai-workbench
  tier: advanced
---

# Receiving Code Review

Use this skill when review feedback arrives and the next step is to evaluate it technically instead of reacting socially or implementing blindly.

## Core Principle

Verify before implementing.  
Ask before assuming.  
Technical correctness beats performative agreement.

## When To Use

- human review feedback
- reviewer-agent findings
- pull-request comments
- CI or QA notes that imply code changes

## Workflow

1. read the complete feedback set before acting
2. restate unclear items in technical terms
3. verify each item against the requirements and actual codebase state
4. classify each item:
   - correct
   - partially correct
   - wrong for this codebase
   - blocked by missing context
5. implement one item or one coherent batch at a time
6. verify each accepted change before moving on
7. reply with factual status, not performance

## Handling Unclear Feedback

If any item is unclear:

- stop before implementation
- ask for clarification on the unclear items
- do not partially implement a multi-item review set while guessing at the rest

## When To Push Back

Push back when the suggestion:

- breaks existing behavior without intent
- ignores repository constraints or compatibility
- weakens security, tenant, owner, or permission boundaries
- adds unnecessary complexity
- misunderstands the current architecture or requirements

Push back with technical reasoning:

- what the code does today
- why the suggestion is risky or incorrect
- what lower-risk alternative you recommend

## Safe Response Pattern

Prefer responses like:

- "Verified item 2. The risk is X because Y. I will adapt it this way."
- "Items 1 and 3 are clear. Need clarification on item 2 before implementing."
- "Checked this against the current code path. The suggested change would break Z, so I recommend A instead."

Avoid:

- agreeing before verification
- defending your prior work before checking
- implementing unclear items to look responsive

## Implementation Order

When multiple review items exist, prefer this order:

1. correctness, security, data-boundary, and regression issues
2. missing behavior or test gaps
3. maintainability and cleanup issues
4. optional polish

## Red Flags

- "I'll just fix the obvious items first" when some items are still unclear
- "The reviewer is probably right" without checking
- "The reviewer is probably wrong" without checking
- batching unrelated review items into one unverifiable diff
- responding with tone instead of technical content
