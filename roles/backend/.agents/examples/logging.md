---
name: examples-logging
load_when:
  - logging_example
  - observability_example
priority: low
purpose: Reference example for structured Go logging.
---

# Logging Examples

Examples are not rules. If an example conflicts with a loaded rule, the rule wins.

## Structured Log

```go
// LogTaskDelivered 记录任务投递结果。
func LogTaskDelivered(logger *zap.Logger, task DeliveryTask) {
	logger.Info("task_deliver",
		zap.String("desc", "任务已投递，等待确认"),
		zap.String("request_id", task.RequestID),
		zap.String("task_id", task.TaskID),
		zap.Uint("tenant_id", task.TenantID),
		zap.String("entity_id", task.EntityID),
		zap.Uint("actor_id", task.ActorID),
		zap.String("status", task.Status),
	)
}
```
