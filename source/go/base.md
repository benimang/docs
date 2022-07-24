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
	
	var i32 int32 = 3333
	println(reflect.TypeOf(i32).Kind() == reflect.Int32) // true
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
	strconv.ParseBool("true")
	strconv.ParseInt("112", 10, 32)
	strconv.ParseFloat("123.456", 32)
}
```


## 声明变量

```go
package main

func main() {

	// 可以在任何地方使用
	var a = 123

	// 看其他源码用的最多，不过在函数外部不能使用
	b := 123

	// 唯一好处是右侧数据类型对应不上会立即知道
	var c int = 123

	// 没有初始化值，必须要指定数据类型
	var d int
	d = 123
	
	// 同时声明多个变量并赋值，在vscode中，这样写比用var好（语法提示）
	e, f := 123, 123

	// 以上效果的变量声明都一样效果
	println(a, b, c, d, e, f)
}
```