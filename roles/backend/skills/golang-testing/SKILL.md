---
name: golang-testing
description: Go testing patterns including table-driven tests, subtests, benchmarks, fuzzing, and TDD-oriented verification.
metadata:
  origin: ECC
  adapted_for: team-ai-workbench
---

# Go Testing Patterns

Comprehensive Go testing patterns for writing reliable, maintainable tests following TDD methodology.

## When to Activate

- Writing new Go functions or methods
- Adding test coverage to existing code
- Creating benchmarks for performance-critical code
- Following TDD workflow in Go projects

## TDD Workflow for Go

### RED-GREEN-REFACTOR

```text
RED       Write a failing test first
GREEN     Write minimal code to pass the test
REFACTOR  Improve code while keeping tests green
```

### Minimal Example

```go
// calculator.go
func Add(a, b int) int {
    panic("not implemented")
}

// calculator_test.go
func TestAdd(t *testing.T) {
    got := Add(2, 3)
    want := 5
    if got != want {
        t.Errorf("Add(2, 3) = %d; want %d", got, want)
    }
}
```

## Table-Driven Tests

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"positive numbers", 2, 3, 5},
        {"negative numbers", -1, -2, -3},
        {"zero values", 0, 0, 0},
        {"mixed signs", -1, 1, 0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got := Add(tt.a, tt.b)
            if got != tt.expected {
                t.Errorf("Add(%d, %d) = %d; want %d", tt.a, tt.b, got, tt.expected)
            }
        })
    }
}
```

## Subtests and Parallel Tests

```go
func TestParallel(t *testing.T) {
    tests := []struct {
        name  string
        input string
    }{
        {"case1", "input1"},
        {"case2", "input2"},
    }

    for _, tt := range tests {
        tt := tt
        t.Run(tt.name, func(t *testing.T) {
            t.Parallel()
            _ = Process(tt.input)
        })
    }
}
```

## Go Testing Guidance

- Prefer exact target tests before package-wide tests
- Cover main success path, boundary cases, and meaningful error paths
- Avoid real third-party dependencies in routine tests
- Use table-driven tests by default for logic-heavy functions
- Use benchmarks only for hot-path performance work
