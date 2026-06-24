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

## Productized Skill Shape

For the repository-wide skill authoring standard, see [`../../docs/skill-authoring-standard.md`](../../docs/skill-authoring-standard.md).

Each skill should use the standard Codex skill layout:

```text
skill-name/
  SKILL.md
  agents/
    openai.yaml
```

`SKILL.md` must include frontmatter with:

- `name`: matches the folder name
- `description`: starts with `Use when...` and describes trigger conditions, not a process summary

`agents/openai.yaml` should include:

- `interface.display_name`
- `interface.short_description`
- `interface.default_prompt` with the `$skill-name` invocation
- `policy.allow_implicit_invocation`

Only add tool dependencies when the skill genuinely depends on an MCP or other declared capability.

## Relationship To Other Skill Directories

- `.agents/skills/` = canonical repository skill location in generated projects
- user-level plugins = external workflow packs such as Superpowers

Do not create repo-local `.codex/skills/` by default. If a project intentionally vendors a local skill pack for reproducibility or offline use, keep that decision project-specific and document it in that repository.
