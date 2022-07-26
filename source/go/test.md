# 测试


## 单元测试

`#!sh go test`

```go title="u_test.go" hl_lines="5-6 10 12"
package main

import "testing"

// 文件名必须以 _test.go 结尾
// 测试函数名必须以 Test 开头，参数类型为 *testing.T

func TestFunc(t *testing.T) {

	t.Error("错误，允许继续")

	t.Fatal("错误，立即终止")
}
```


## 基准测试

可以用来性能调优

`#!sh go test -bench . -benchmem`

```go title="b_test.go" hl_lines="8-13 33-34 39-40"
package main

import (
	"bytes"
	"testing"
)

// 文件名必须以 _test.go 结尾
// 基准测试函数名必须以 Benchmark 开头，参数类型为 *testing.B
// 循环次数使用 b.N 不需要考虑实际运行了多少次
// ns/op     每次操作耗时
// B/op      每次分配字节
// allocs/op 每次操作分配内存次数

const n = 100

func funcA() string {
	result := ""
	for i := 0; i < n; i++ {
		result += "a"
	}
	return result
}

func funcB() string {
	var buffer bytes.Buffer
	for i := 0; i < n; i++ {
		buffer.WriteString("a")
	}
	return buffer.String()
}

func BenchmarkA(b *testing.B) {
	for i := 0; i < b.N; i++ {
		funcA()
	}
}

func BenchmarkB(b *testing.B) {
	for i := 0; i < b.N; i++ {
		funcB()
	}
}
```