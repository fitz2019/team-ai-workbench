---
name: coding-discipline
load_when:
  - code_generation
  - code_modification
  - code_review
  - refactor
  - architecture
priority: high
purpose: Shared coding discipline to reduce guessing, overengineering, wide diffs, and unverifiable work.
---

# Coding Discipline

Load this file before code generation, code modification, code review, refactor, or architecture suggestions.

This is the shared baseline discipline for how agents should approach non-trivial coding work.

## 1. Think Before Coding

- Do not silently pick an interpretation when ambiguity changes behavior, API shape, data model, security posture, rollout, or migration risk
- State important assumptions explicitly before implementing
- Ask for clarification when the uncertainty changes the solution, not after the wrong implementation lands
- Present tradeoffs when more than one reasonable path exists
- Push back when the requested path is clearly more complex than necessary
- If confusion remains after reading the relevant files, stop and name what is unclear

## 2. Simplicity First

- Solve the requested problem with the smallest coherent change
- Do not add speculative flexibility, configurability, or extension points that were not requested
- Do not create a new abstraction for one call site or one use case
- Prefer existing repository patterns over "better" patterns invented for this task
- If the same result can be achieved with materially less code and equal clarity, choose the simpler version
- Error handling should be real and useful, not decorative branching for impossible scenarios

## 3. Surgical Changes

- Touch only the files, lines, and behavior required by the request
- Do not "improve" adjacent code, comments, or formatting just because you noticed them
- Do not refactor unrelated code while implementing a feature or fix
- Match local naming, layering, and style unless the user explicitly asks for a different direction
- Remove only the imports, variables, helpers, or tests that your own change made obsolete
- If you notice unrelated technical debt, mention it separately instead of folding it into the change

## 4. Goal-Driven Execution

- Translate vague instructions into verifiable outcomes before implementing when practical
- For bug fixes, reproduce the symptom or create a failing check first when practical
- For features, identify the command, test, or concrete check that proves the change works
- For multi-step tasks, work in short step -> verify loops
- Do not declare success from code inspection alone when a real check is available
- Pair this discipline with `.agents/completion.md` and the `verification-before-completion` skill before claiming a task is done

## Red Flags

Stop and reassess if you catch any of these:

- guessing because the request "probably means" something
- adding knobs, interfaces, or layers for future flexibility
- widening the diff because nearby code also looks messy
- proposing a rewrite before understanding the existing behavior
- using "should work" or "probably fixed" language without a verification path

## Scope Note

Use judgment for trivial, low-risk edits such as obvious typos or one-line mechanical fixes.

For non-trivial work, default to this discipline.
