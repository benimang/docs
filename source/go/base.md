# GO基础


## 检查变量类型

```go
package main

import (
	"reflect"
)

func main() {
	s := "string"
	reflect.TypeOf(s) // 返回的类型是 refect.Type
}
```


## 类型转换

```go
package main

import (
	"strconv"
)

func main() {

	// 其他类型转字符串
	strconv.FormatBool(false)
	strconv.FormatInt(112, 10)
	strconv.FormatFloat(123.456, 'f', -1, 32)

	// 字符串转其他类型
	b, _ := strconv.ParseBool("true")
	i, _ := strconv.ParseInt("112", 10, 32)
	f, _ := strconv.ParseFloat("123.456", 32)
}
```