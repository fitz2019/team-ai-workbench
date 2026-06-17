# Template: product-docs

Recommended for:

- PRD repositories
- capability planning repositories
- research and product decision workspaces

Default composition:

- roles: `product`
- include shared skills: yes

Suggested init:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\init-project.ps1 -TargetProjectPath C:\path\to\repo -Template product-docs
```

## Suggested Repository Shape

```text
docs/
  product/
  capabilities/
  research/
  decisions/
templates/
```

## What To Define Early

- where PRDs live
- where capability notes live
- where research memos live
- what counts as implementation-ready handoff
- which fields every capability doc should include

## Also See

- [project-specific-sample.md](</C:/software/self/project/team-ai-workbench/templates/product-docs/project-specific-sample.md>)
