# Codex Harness Hooks

These hooks are the Codex adaptation of the cwc long-running harness primitives.

They are project-local hooks. Codex will ask the user to review and trust them before they run.

## Hooks

- `session-start.ps1`
  Adds harness context at session startup or resume.
- `user-prompt-submit.ps1`
  Injects current steering and stop-state context into the next turn.
- `pre-tool-use-policy.ps1`
  Blocks tool use when `.ai-harness/AGENT_STOP` exists and guards suspicious direct pass writes.
- `stop-gate.ps1`
  Checks active long-running state at turn stop and can continue the loop when `.ai-harness/CONTINUE_ON_STOP` exists.

## Runtime Files

- `.ai-harness/ACTIVE`
  Enables long-running harness mode.
- `.ai-harness/CONTINUE_ON_STOP`
  Allows the Stop hook to request another pass when criteria are still failing.
- `.ai-harness/AGENT_STOP`
  Stops tool use and disables automatic continuation.

Hooks are workflow guardrails, not a security boundary.
