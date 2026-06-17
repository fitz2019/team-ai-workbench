---
name: examples-error-handling
load_when:
  - error_handling_example
  - validation_example
priority: low
purpose: Reference examples for Go error wrapping, parameter objects, and validation.
---

# Error Handling Examples

Examples are not rules. If an example conflicts with a loaded rule, the rule wins.

## Error Wrapping

```go
// LoadEntity 加载业务实体快照。
func LoadEntity(ctx context.Context, repo EntityRepository, params LoadEntityParams) (*Entity, error) {
	if err := params.Validate(); err != nil {
		return nil, fmt.Errorf("业务实体查询参数无效: %w", err)
	}

	entity, err := repo.GetByID(ctx, params.TenantID, params.EntityID)
	if err != nil {
		return nil, fmt.Errorf("加载业务实体失败 tenant_id=%d entity_id=%s: %w", params.TenantID, params.EntityID, err)
	}
	return entity, nil
}
```

## Parameter Object

```go
// SubmitEntityParams 表示业务实体提交参数。
type SubmitEntityParams struct {
	RequestID string
	TenantID  uint
	EntityID  string
	ActorID   string
	Value     string
}

// Validate 校验业务实体提交参数。
func (p SubmitEntityParams) Validate() error {
	if p.TenantID == 0 {
		return errors.New("tenant_id 不能为空")
	}
	if strings.TrimSpace(p.EntityID) == "" {
		return errors.New("entity_id 不能为空")
	}
	if strings.TrimSpace(p.ActorID) == "" {
		return errors.New("actor_id 不能为空")
	}
	return nil
}
```
