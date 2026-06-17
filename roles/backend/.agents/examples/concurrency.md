---
name: examples-concurrency
load_when:
  - concurrency_example
  - batch_example
priority: low
purpose: Reference example for bounded Go batch concurrency.
---

# Concurrency Examples

Examples are not rules. If an example conflicts with a loaded rule, the rule wins.

## Bounded Batch Concurrency

```go
// ProcessBatch 并发处理任务，并限制最大并发数。
func ProcessBatch(ctx context.Context, items []Item) error {
	g, ctx := errgroup.WithContext(ctx)
	g.SetLimit(10)

	for _, item := range items {
		item := item
		g.Go(func() error {
			return processOne(ctx, item)
		})
	}

	return g.Wait()
}
```
