# Product to QA Delivery Loop

This repository uses a simple four-step loop:

1. `Product intent`
   - problem, scope, non-goals, success criteria
2. `Capability note`
   - implementation-facing constraints and open questions
3. `Acceptance checklist`
   - explicit checks for the feature's happy path, edge cases, and key regressions
4. `Ship verdict`
   - final release recommendation with evidence

## Hand-off Rule

- Product work is not ready for engineering or QA until the capability note is concrete enough to implement.
- QA should verify against the acceptance checklist, not against vague PRD prose.
- Ship verdicts must be evidence-backed, not tone-backed.
