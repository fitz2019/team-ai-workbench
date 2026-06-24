---
name: api-design
description: Use when designing or reviewing REST APIs, endpoint contracts, pagination, filtering, errors, versioning, or rate limits.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# API Design Patterns

Use for new HTTP APIs, endpoint reviews, pagination/filtering design, and response contract work.

## Use Cases

- designing new endpoints
- reviewing API contracts
- adding pagination, filtering, or sorting
- defining error response structure
- planning backward-compatible API evolution

## Core Rules

- resources are nouns, plural, lowercase, kebab-case
- use query parameters for filtering and pagination
- keep sub-resources for ownership and containment
- avoid verbs in URLs except explicit actions that are not CRUD

## Status Code Guidance

- `200` for normal GET/PUT/PATCH responses
- `201` for creates, with `Location` when useful
- `204` for successful no-body operations
- `400` or `422` for validation failure depending on repository convention
- `401` / `403` / `404` / `409` / `429` where semantically appropriate
- `500+` for server-side failures without leaking internal details

## Response Shape

Recommended public shape:

```json
{
  "data": {},
  "meta": {},
  "links": {}
}
```

Recommended error shape:

```json
{
  "error": {
    "code": "validation_error",
    "message": "Request validation failed",
    "details": []
  }
}
```

## Review Checklist

- resource naming consistent
- backward compatibility preserved by default
- request/response fields documented
- pagination strategy explicit
- error semantics stable
- auth and permission boundaries clear

## Constraint

Prefer the target repository's existing envelope and error model over generic rewrites.
