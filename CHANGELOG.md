# Changelog

This changelog tracks user-visible changes to `team-ai-workbench`.

The format is intentionally simple:

- `Added` for new roles, templates, skills, agents, or docs
- `Changed` for behavior changes and restructures
- `Fixed` for script bugs and incorrect defaults
- `Docs` for documentation-only improvements with adoption value

## Unreleased

### Added

- `core/ + roles/ + advanced/ + templates/` source layout
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
- product-to-QA starter artifacts for `feature-delivery`
- governance docs:
  - `adoption-guide.md`
  - `versioning-strategy.md`
  - `contribution-guide.md`
  - `upgrade-playbook.md`
  - `role-matrix.md`
  - `template-catalog.md`
  - `ecc-role-candidate-map.md`

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
