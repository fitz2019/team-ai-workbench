---
name: security
load_when:
  - auth
  - permission
  - tenant
  - user
  - owner
  - token
  - cookie
  - webhook
  - upload
  - external_callback
  - sensitive_data
priority: critical
purpose: Authorization, tenant isolation, and sensitive data boundaries.
---

# Security And Data Boundaries

Load this file before code generation, code modification, code review, refactor, API design, or architecture work that touches auth, permission, tenant, owner, user, token, cookie, webhook, upload, external callback, or sensitive data.

## Identity And Authorization

- Do not trust frontend-supplied `user_id`, `tenant_id`, `owner_id`, role, resource ownership, or permission fields
- Derive identity and tenant scope from authenticated context, session, token claims, or existing trusted middleware
- Privileged and admin operations must have explicit authorization checks
- Fail closed when identity, tenant, role, or permission context is missing or ambiguous
- Object reads, writes, updates, and deletes must include the correct tenant or owner predicate, not only the object ID
- Cross-tenant, cross-owner, or cross-scope access must be explicitly justified by business logic

## Sensitive Data

- Do not hardcode tokens, secrets, passwords, cookies, private keys, API keys, AK/SK, webhook secrets, or authorization headers in code, tests, docs, or config templates
- Do not log or return tokens, secrets, passwords, cookies, private keys, authorization headers, or complete sensitive payloads
- Logs, traces, metrics labels, and error responses must filter or mask sensitive fields
- Mask or omit personal data such as phone numbers, email addresses, addresses, identity numbers, and customer contact details unless the business explicitly requires exposure
- API errors returned to callers should avoid internal implementation details; logs may include safe business identifiers for diagnosis
- Third-party or AI calls must not send sensitive data unless the business need is explicit and the target is approved by existing project practice

## API And Input

- Validate and normalize external input before business logic
- Do not rely on frontend-only validation for security, ownership, status transitions, or monetary or quantity fields
- Reject unknown enum values, invalid state transitions, and unsupported integration or source values
- Webhooks and external callbacks must verify signature or trusted source when the upstream supports it
- Webhooks and callbacks must defend against replay with timestamp, nonce, event ID, idempotency key, or existing project mechanism

## Cache, Files, And External Boundaries

- Cache keys and cache values must not create cross-tenant data leaks
- Tenant, owner, account, and user dimensions in cache keys must come from trusted normalized values
- File or path handling must reject path traversal and validate size and type when uploads or filesystem access are touched
- Import, export, upload, download, and temporary file paths must stay inside the intended workspace or configured storage root
- High-risk file operations must define resource limits such as size, count, extension, content type, or processing timeout
- Do not expose internal URLs, filesystem paths, credentials, or infrastructure details in user-facing responses

## Required Tradeoff Note

If a security rule cannot be applied because of stable repository compatibility or legacy behavior, preserve behavior only when necessary and state the reason, residual risk, and lower-risk follow-up.

## Security Workflow Note

- For auth, permission, webhook, file upload, or other clearly security-sensitive changes, prefer loading the shared `skills/security-review` surface when it clearly applies.
- If a security-sensitive change also requires release notes, incident notes, or runbook updates, summarize the change safely without including secrets, raw payloads, tokens, private keys, or exploit details.
