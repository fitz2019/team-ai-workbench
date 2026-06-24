# Skill Authoring Standard

This workbench treats skills as productized local assets, not loose prompt notes.

New skills and touched skills should use this structure:

```text
skill-name/
  SKILL.md
  agents/
    openai.yaml
```

## Required `SKILL.md` Shape

The `SKILL.md` frontmatter must include:

- `name`: matches the folder name
- `description`: starts with `Use when...`

Descriptions should describe trigger conditions, not summarize the workflow. Codex uses the description to decide whether to load the skill.

## Required `agents/openai.yaml` Shape

Each skill should include:

```yaml
interface:
  display_name: "Human-facing skill name"
  short_description: "Short UI description"
  default_prompt: "Use $skill-name to ..."
policy:
  allow_implicit_invocation: true
```

Only add tool dependencies when the skill genuinely depends on a declared MCP or other capability.

## Scope

This standard applies when adding or updating skills under:

- `core/skills/*`
- `roles/*/skills/*`
- `advanced/*` when the directory is a skill

Project-specific downstream adaptations may add local focus sections, but upstream workbench skills should stay reusable and avoid hardcoded project paths.
