# Sample: project-specific.md for feature-delivery

```md
## Workspace

- Workspace root: `C:\repo\feature-delivery`

## Language And Communication

- Product and QA discussion language: `Chinese`
- Durable feature and release artifacts should default to Chinese

## Current Project Vocabulary

- `capability`: implementation-facing feature definition
- `acceptance checklist`: QA-ready criteria set
- `ship verdict`: final release recommendation with evidence

## Commands

- No build command required in this repository
- Use lightweight diff checks for document-only changes

## Security Sensitivity

- Do not include private customer data or production credentials in examples or release notes

## Delivery Notes

- Product intent lives in `docs/product/`
- Capability notes live in `docs/capabilities/`
- Acceptance checklists live in `docs/qa/`
- Ship verdicts live in `docs/release/`
- A feature is not ready until capability, acceptance, and verdict artifacts are all present
```
