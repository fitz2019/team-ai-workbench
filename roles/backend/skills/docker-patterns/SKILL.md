---
name: docker-patterns
description: Containerization and local multi-service orchestration patterns for backend projects.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Docker Patterns

Use for Dockerfiles, Compose files, local multi-service setups, and container review.

## Use Cases

- local development stacks
- reviewing Dockerfiles
- multi-service orchestration
- container networking and volume layout
- runtime hardening and image slimming

## Baseline Practices

- use explicit base image versions, not `latest`
- use multi-stage builds
- run as non-root where possible
- copy dependency manifests early for cache efficiency
- use `.dockerignore`
- add health checks when the service exposes a health endpoint

## Go-Focused Notes

- prefer a builder stage plus a minimal runtime stage
- set `CGO_ENABLED`, `GOOS`, and target output explicitly when cross-building
- include CA certificates in minimal runtime images when outbound HTTPS is required

## Compose Guidance

- expose only what is needed
- keep service names stable for local discovery
- use named volumes for stateful services
- separate local-dev convenience from production assumptions

## Review Checklist

- image size reasonable
- secrets not baked into image
- ports and networks intentional
- health checks present where useful
- local-dev mounts do not leak into production assumptions
