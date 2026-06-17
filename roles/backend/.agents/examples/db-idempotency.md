---
name: examples-db-idempotency
load_when:
  - db_idempotency_example
  - conditional_update_example
priority: low
purpose: Reference example for idempotent DB conditional update.
---

# DB Idempotency Examples

Examples are not rules. If an example conflicts with a loaded rule, the rule wins.

## Idempotent DB Conditional Update

```go
// SubmitAssignment 提交资源分配结果。
func (s *AssignmentSubmitService) SubmitAssignment(ctx context.Context, params SubmitAssignmentParams) (SubmitResult, error) {
	if err := params.Validate(); err != nil {
		return SubmitResult{}, fmt.Errorf("资源分配提交参数无效: %w", err)
	}

	result := s.db.WithContext(ctx).
		Model(&AssignmentRecord{}).
		Where("tenant_id = ? AND resource_id = ? AND (assigned_actor_id = '' OR assigned_actor_id IS NULL)", params.TenantID, params.ResourceID).
		Updates(map[string]any{
			"assigned_actor_id": params.ActorID,
			"assigned_value":    params.Value,
		})
	if result.Error != nil {
		return SubmitResult{}, fmt.Errorf("提交资源分配失败 tenant_id=%d resource_id=%s: %w", params.TenantID, params.ResourceID, result.Error)
	}

	if result.RowsAffected > 0 {
		return SubmitResult{Submitted: true, Idempotent: false}, nil
	}

	assigned, err := s.resourceAlreadyAssigned(ctx, params.TenantID, params.ResourceID)
	if err != nil {
		return SubmitResult{}, fmt.Errorf("确认资源分配状态失败 tenant_id=%d resource_id=%s: %w", params.TenantID, params.ResourceID, err)
	}
	if assigned {
		return SubmitResult{Submitted: true, Idempotent: true}, nil
	}

	return SubmitResult{}, ErrResourceNotFound
}
```
