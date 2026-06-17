---
name: examples-redis-cache
load_when:
  - redis_example
  - cache_example
priority: low
purpose: Reference examples for Redis compressed values and Cache Aside.
---

# Redis Cache Examples

Examples are not rules. If an example conflicts with a loaded rule, the rule wins.

## Redis Compressed Cache Value

```go
// SaveConversationHistory 压缩保存会话历史，降低 Redis 内存占用。
func SaveConversationHistory(ctx context.Context, redisClient *redis.Client, key string, history []MessageHistory, ttl time.Duration) error {
	payload, err := json.Marshal(history)
	if err != nil {
		return fmt.Errorf("序列化会话历史失败: %w", err)
	}

	var compressed bytes.Buffer
	gzipWriter := gzip.NewWriter(&compressed)
	if _, err := gzipWriter.Write(payload); err != nil {
		_ = gzipWriter.Close()
		return fmt.Errorf("压缩会话历史失败: %w", err)
	}
	if err := gzipWriter.Close(); err != nil {
		return fmt.Errorf("关闭会话历史压缩流失败: %w", err)
	}

	if err := redisClient.Set(ctx, key, compressed.Bytes(), ttl).Err(); err != nil {
		return fmt.Errorf("写入压缩会话历史失败 key=%s: %w", key, err)
	}
	return nil
}
```

Use this when a Redis value is large, repeated, or expensive in memory. Do not compress tiny, extremely hot values unless CPU cost has been considered.
