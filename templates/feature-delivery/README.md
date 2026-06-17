# Template: feature-delivery

Recommended for:

- product and QA working together on feature delivery
- repositories that need durable requirement, acceptance, and release-check artifacts
- teams that want a shared path from product intent to ship verdict

Default composition:

- roles: `product`, `qa`
- include shared skills: yes

Suggested init:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template feature-delivery
```

## Suggested Repository Shape

```text
docs/
  product/
  capabilities/
  qa/
  release/
```

## What This Template Adds

- a starter product-to-QA workflow note
- a capability note template
- an acceptance checklist template
- a ship verdict template

## Also See

- [project-specific-sample.md](</C:/software/self/project/team-ai-workbench/templates/feature-delivery/project-specific-sample.md>)
