# Changelog

This changelog tracks user-visible changes to `team-ai-workbench`.

The format is intentionally simple:

- `Added` for new roles, templates, skills, agents, or docs
- `Changed` for behavior changes and restructures
- `Fixed` for script bugs and incorrect defaults
- `Docs` for documentation-only improvements with adoption value

## Unreleased

### Added

- `codex-harness/` as the main cwc-style Codex runtime architecture, including:
  - `.codex/config.toml`
  - Codex hook scripts
  - long-running builder, evaluator, and progress agents
  - `.ai-harness/` durable runtime files
  - `.agents/harness-runtime.md`
- `docs/harness-architecture.md` to explain how the cwc-style harness maps to Codex
- `core/skills/README.md` to document `.agents/skills/` as the canonical generated repository skill surface
- `core/.agents/coding-discipline.md` as a shared baseline module for:
  - think before coding
  - simplicity first
  - surgical changes
  - goal-driven execution
- `core/skills/coding-discipline/` as an explicit reusable skill adapted from `multica-ai/andrej-karpathy-skills`
- `roles/backend/.agents/examples.md` to route backend implementation examples without making examples a rule source
- `advanced/executing-plans/` for plan-first execution with task-level verification checkpoints
- `advanced/finishing-a-development-branch/` for structured merge, PR, keep, or discard completion flow
- `roles/backend/skills/test-driven-development/` as a Go-backend TDD workflow adapted from local practice
- `advanced/requesting-code-review/` for structured review packaging and routing
- `advanced/receiving-code-review/` for disciplined technical intake of review feedback
- `docs/local-backport-playbook.md` to formalize how local backend improvements are promoted upstream

### Changed

- `scripts/init-project.ps1` now installs the Codex harness by default and keeps `core/roles/templates` as rule and role packs consumed by the harness
- README and README.zh-CN now position the repository as a Codex harness workbench, not just a rule/template repository
- `core/AGENTS.md` and `core/.agents/index.md` now include the harness runtime route proven in the local backend project
- `core/AGENTS.md` and `core/.agents/index.md` now route non-trivial coding work through the shared coding-discipline module by default
- `core/AGENTS.md` now mirrors the more practical workspace entry style proven in the local backend setup while remaining cross-role
- `core/.codex/AGENTS.md` now uses repository-generic runtime guidance instead of backend-specific wording
- `scripts/init-project.ps1` now installs shared skills into `.agents/skills/`, matching Codex's official repository skill discovery surface
- `roles/backend/.agents/tech-stack.md` now includes stronger Redis consistency, cluster-slot, MQ reliability, observability, and external-dependency guidance
- `roles/backend/.agents/commands.md` now gives clearer Git-root handling and narrower verification guidance
- `roles/backend/.agents/completion.md` now tightens backend verification expectations for changed behavior, external dependencies, and doc/release outputs
- `advanced/README.md`, `docs/extraction-audit.md`, `docs/adoption-guide.md`, and `docs/contribution-guide.md` now document the current triage result and local-to-upstream backport workflow

### Docs

- README and README.zh-CN now describe the shared coding-discipline baseline and acknowledge the upstream inspiration

## v0.2.0

### Added

- `core/ + roles/ + advanced/ + templates/ + scripts/ + docs/` source layout
- production-ready role packs for:
  - `backend`
  - `frontend`
  - `product`
  - `qa`
  - `devops`
- curated ECC-derived role skills and agent libraries
- template system with named templates:
  - `go-service`
  - `web-frontend`
  - `product-docs`
  - `qa-project`
  - `feature-delivery`
  - `ops-service`
- starter artifacts for `feature-delivery`
- governance docs:
  - `adoption-guide.md`
  - `versioning-strategy.md`
  - `contribution-guide.md`
  - `upgrade-playbook.md`
  - `role-matrix.md`
  - `template-catalog.md`
  - `ecc-role-candidate-map.md`
  - `roadmap.md`

### Changed

- repository renamed from `backend-ai-standards` to `team-ai-workbench`
- root compatibility layers removed in favor of strict source layout
- `init-project.ps1` now supports:
  - role composition
  - named templates
  - advanced-layer inclusion
  - template starter file copying

### Fixed

- role merge logic in `init-project.ps1` to correctly copy role files
- role overlay composition validation for multi-role initialization

## v0.1.0

Initial internal workbench baseline before formal release tracking.
