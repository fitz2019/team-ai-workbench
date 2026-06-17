# Roadmap

This roadmap tracks the most useful next work for `team-ai-workbench`.

It is not a promise list. It is a prioritization guide.

## Near Term

### 1. Strengthen `core/`

- evaluate whether `planner` should move into `core/`
- evaluate whether `spec-miner` should move into `core/`
- decide whether a shared `security-review` execution path needs more automation

### 2. Deepen templates

- add more starter files to `go-service`
- add frontend-specific artifact templates to `web-frontend`
- add release and rollback artifact templates to `ops-service`
- add stronger acceptance and verdict examples to `qa-project`

### 3. Consumer upgrade support

- add a helper script for safe scratch-dir upgrade comparison
- document role-specific upgrade examples
- define a lightweight release tagging convention

## Mid Term

### 4. Product and QA collaboration depth

- richer acceptance-checklist examples
- product-to-QA handoff examples across multiple feature types
- stronger bug-regression capture patterns

### 5. Frontend and DevOps depth

- decide whether `browser-qa` should partially move into `frontend` and partially stay in `qa`
- refine DevOps split between deployment guidance and infra diagnosis
- add examples for CI/CD release gates

### 6. Role maturity scoring

- define what "ready" means per role
- add checklists for promoting a scaffold role to production-ready

## Long Term

### 7. Release governance

- publish explicit version tags
- formalize release-note generation workflow
- document compatibility guarantees for consumer repositories

### 8. Shared reporting surfaces

- summary dashboards for roles, templates, and advanced capabilities
- standardized artifact locations for release and verification outputs

## Not Planned By Default

These are intentionally not default priorities:

- pulling all ECC assets in wholesale
- making every role equally heavy
- enabling `advanced/` by default
- turning this repository into a business repository
