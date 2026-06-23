# Official Repo Skill Surface

This directory is the canonical source for shared repository skills that are installed into target projects under:

```text
.agents/skills/
```

Put stable reusable skills here when they should be discoverable by Codex without extra path configuration.

## What Belongs Here

- stable reusable engineering skills
- skills that should be discovered by Codex as repository-local skills
- skills that are good candidates for reuse across multiple repositories

Examples:

- `coding-discipline`
- `codebase-onboarding`
- `documentation-lookup`
- `knowledge-ops`
- `security-review`
- `systematic-debugging`
- `verification-before-completion`

## Relationship To Other Skill Directories

- `.agents/skills/` = canonical repository skill location in generated projects
- `.codex/skills/` = legacy local capability pack, when present in older projects

If a skill appears in both `.agents/skills/` and `.codex/skills/`, treat `.agents/skills/` as the source of truth.
