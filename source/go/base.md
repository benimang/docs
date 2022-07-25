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

	// 字符串 int十进制转换的便捷方法
	strconv.Atoi("123")
	strconv.Itoa(123)
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


## 常量定义

```go
package main

func main() {

	// 常量定义
	// 特别注意在go中不要将常量改为全大写
	// 因为开头字面大小写是有特殊用于，指定是否导出（共有或私有）
	const a = 123

	println(a)
}
```


## fmt.Printf

```go
package main

import (
	"fmt"
	"os"
)

type point struct {
	a, b int
}

func main() {

	// Go 为常规 Go 值的格式化设计提供了多种打印方式。
	p := point{1, 2}
	fmt.Printf("%v\n", p) // {1 2}

	// 如果值是一个结构体，%+v 的格式化输出内容将包括结构体的字段名。
	fmt.Printf("%+v\n", p) // {x:1 y:2}

	// %#v 形式则输出这个值的 Go 语法表示。例如，值的运行源代码片段。
	fmt.Printf("%#v\n", p) // main.point{x:1, y:2}

	// 需要打印值的类型，使用 %T。
	fmt.Printf("%T\n", p) // main.point

	// 格式化布尔值是简单的。
	fmt.Printf("%t\n", true) // true

	// 格式化整形数有多种方式，使用 %d进行标准的十进制格式化。
	fmt.Printf("%d\n", 123) // 123

	// 这个输出二进制表示形式。
	fmt.Printf("%b\n", 14) // 1110

	// 这个输出给定整数的对应字符。
	fmt.Printf("%c\n", 33) // !

	// %x 提供十六进制编码。
	fmt.Printf("%x\n", 456) // 1c8

	// 对于浮点型同样有很多的格式化选项。使用 %f 进行最基本的十进制格式化。
	fmt.Printf("%f\n", 78.9) // 78.900000

	// %e 和 %E 将浮点型格式化为（稍微有一点不同的）科学技科学记数法表示形式。
	fmt.Printf("%e\n", 123400000.0) // 1.234000e+08
	fmt.Printf("%E\n", 123400000.0) // 1.234000E+08

	// 使用 %s 进行基本的字符串输出。
	fmt.Printf("%s\n", "\"string\"") // "string"

	// 像 Go 源代码中那样带有双引号的输出，使用 %q。
	fmt.Printf("%q\n", "\"string\"") // "\"string\""

	// 和上面的整形数一样
	// %x 输出使用 base-16 编码的字符串，每个字节使用 2 个字符表示。
	fmt.Printf("%x\n", "hex this") // 6865782074686973

	// 要输出一个指针的值，使用 %p。
	fmt.Printf("%p\n", &p) // 0xc0000ac070

	// 当输出数字的时候，你将经常想要控制输出结果的宽度和精度
	// 可以使用在 % 后面使用数字来控制输出宽度。
	// 默认结果使用右对齐并且通过空格来填充空白部分。
	fmt.Printf("|%6d|%6d|\n", 12, 345) // |    12|   345|

	// 你也可以指定浮点型的输出宽度
	// 同时也可以通过 宽度.精度 的语法来指定输出的精度。
	fmt.Printf("|%6.2f|%6.2f|\n", 1.2, 3.45) // |  1.20|  3.45|

	// 要最对齐，使用 - 标志。
	fmt.Printf("|%-6.2f|%-6.2f|\n", 1.2, 3.45) // |1.20  |3.45  |

	// 你也许也想控制字符串输出时的宽度，特别是要确保他们在类表格输出时的对齐。
	// 这是基本的右对齐宽度表示。
	fmt.Printf("|%6s|%6s|\n", "foo", "b") // |   foo|     b|

	// 要左对齐，和数字一样，使用 - 标志。
	fmt.Printf("|%-6s|%-6s|\n", "foo", "b") // |foo   |b     |

	// 到目前为止，我们已经看过 Printf了，它通过 os.Stdout输出格式化的字符串。
	// Sprintf 则格式化并返回一个字符串而不带任何输出。
	s := fmt.Sprintf("a %s", "string")
	fmt.Println(s) // a string

	// 你可以使用 Fprintf 来格式化并输出到 io.Writers而不是 os.Stdout。
	fmt.Fprintf(os.Stderr, "an %s\n", "error")
}
```


## 指针

```go
package main

func main() {

	i := 123
	x := &i // 获取变量的地址

	updateInt(x)

	println(i)
	println(x)
	println(*x) // 指针前面加上*表示指针对应的值
}

// 类型前加上*表示指针
func updateInt(value *int) {
	// 指针前面加上*表示指针对应的值
	*value += 1
}
```


## 结构体

```go hl_lines="7-8 11-12 15-17 19-20 23-27 30-34 38-43"
package main

import "fmt"

func main() {

	// 结构体声明后就可以立即使用
	var m1 movie
	print("m1", m1)

	// 同样是生命结构体
	m2 := movie{}
	print("m2", m2)

	// 结构体的比较必须是同类型的
	// 比较是判断值相同，不会判断是否同一个对象
	print("m1==m2", m1 == m2) // m1==m2 => true

	// 使用 new 得到的是结构体指针
	m3 := new(movie)
	print("m3", m3)

	// 结构体初始化并指定参数，通过名称指定值
	m4 := movie{
		name:   "movie name 3",
		rating: 3,
	}
	print("m4", m4)

	// 结构体初始化并指定参数，根据顺序指定
	m5 := movie{
		"movie name 4",
		4,
	}
	print("m5", m5)
}

// 结构体的定义
// 注意：无法指定默认值
type movie struct {
	name   string
	rating float32
}

func print(name string, data interface{}) {
	fmt.Printf("%v = %+v\n", name, data)
}
```


## 结构体和指针

```go hl_lines="14 29-30"
package main

import "fmt"

func main() {
	apple := student{
		name: "apple",
		addr: address{
			city:   "Guangzhou",
			street: "Wenming Road",
		},
	}

	// 结构体直接赋值后，是另外一个新的结构体
	orange := apple
	orange.name = "orange"

	// orange = {name:orange addr:{city:Guangzhou street:Wenming Road}}
	print("orange", orange)
	// {name:apple addr:{city:Guangzhou street:Wenming Road}}
	print("apple", apple)

	myfun(&apple)

	// {name:Xxxxx addr:{city:Xxxxxxxxx street:Wenming Road}}
	print("apple", apple)
}

// 使用指针可以直接修改结构体的值
func myfun(value *student) {
	value.name = "Xxxxx"
	value.addr.city = "Xxxxxxxxx"
}

type student struct {
	name string
	addr address
}

type address struct {
	city   string
	street string
}

func print(name string, data interface{}) {
	fmt.Printf("%v = %+v\n", name, data)
}

```


## 函数

```go hl_lines="21-22 26-27 31-32 40-41 47-52"
package main

import "strconv"

func main() {
	println(aFunc(1))       // 2
	println(bFunc(1))       // 2 0
	println(cFunc())        // 0
	println(cFunc(1, 2, 3)) // 6
	println(dFunc())        // 123 sss
	{
		tempFunc := func(v1 int, v2 float32) string {
			s1 := strconv.FormatInt(int64(v1), 10)
			s2 := strconv.FormatFloat(float64(v2), 'f', 3, 32)
			return  s1 + " " + s2
		}
		println(eFunc(tempFunc, 123, 456.789)) // 123 456.789
	}
}

// 指定参数以及返回值
func aFunc(value int) int {
	return value + 1
}

// 指定多个返回值
func bFunc(value int) (int, int) {
	return value + 1, value - 1
}

// 指定任意参数
func cFunc(valueList ...int) int {
	result := 0
	for _, value := range valueList {
		result += value
	}
	return result
}

// 指定返回变量名字
func dFunc() (aa int, bb string) {
	aa += 123
	bb = "sss"
	return
}

// 指定一个函数作为参数
func eFunc(
	f func(int, float32) string,
	v1 int,
	v2 float32,
) string {
	return f(v1, v2)
}
```


## for 循环

```go hl_lines="7-8 18-19 24-25 30-31"
package main

func main() {
	{
		a := 0
		b := 3
		// 无条件循环
		for {
			a++
			if a > b {
				break
			}
		}
	}
	{
		a := 0
		b := 3
		// 带条件循环
		for a < b {
			a++
		}
	}
	{
		// 常规循环
		for i := 0; i < 3; i++ {
		}
	}
	{
		ary := []int{1, 2, 3, 4, 5}
		// 遍历数组
		for i, v := range ary {
			println(i, v)
		}
	}
}
```


## defer 延迟执行

```go hl_lines="15-18"
package main

func main() {
	// afunc xxx...1
	// afunc xxx...2
	// running in cfunc
	// running in bfunc
	// afunc result
	println(afunc())
}

func afunc() string {
	println("afunc xxx...1")

	// defer 指定的函数将会在当前所在函数返回结果出去前执行
	// 注意：越往后面调用的defer会越先执行
	defer bfunc()
	defer cfunc()

	println("afunc xxx...2")
	return "afunc result"
}

func bfunc() {
	println("running in bfunc")
}

func cfunc() {
	println("running in cfunc")
}
```


## 数组

```go hl_lines="7"
package main

import "fmt"

func main() {

	// 数组必须声明长度，而且长度不允许修改

	// 先声明数组，后面再使用
	var ary1 [2]int
	ary1[0] = 12
	ary1[1] = 34

	// 声明数组并初始化
	ary2 := [2]int{12, 34}

	// 声明数组并仅初始化部分
	ary3 := [2]int{1: 34}

	// len 获取数组长度
	fmt.Println(len(ary3))

	fmt.Println(ary1, ary2, ary3)
}
```


## 切片

```go hl_lines="7-9"
package main

import "fmt"

func main() {

	// 切片是底层数组的一个片段，可以添加或移除
	// 特别注意：切片执行append操作后得到新的切片，不一定是新的引用
	// 			取决于有没有超出底层数组的长度

	// 切片定义并初始化
	ary1 := []int{1, 2, 3, 4, 5}
	printAry("ary1", ary1)

	// 获取切片
	ary2 := ary1[2:4]
	printAry("ary2", ary2)

	// len 切片长度
	fmt.Printf("len(ary2) = %v\n", len(ary2))

	// cap 切片容量（底层数组到最后一个元素的长度）
	fmt.Printf("cap(ary2) = %v\n", cap(ary2))

	// 添加
	ary3 := append(ary1, 6, 7)
	printAry("ary3", ary3)

	// 移除（其实也是以来append来操作）
	ary4 := append(ary1[:2], ary1[3:]...)
	printAry("ary4", ary4)

	// 复制一个新的（注意：要先准备一个带长度的切片，否则无法弄进去）
	ary5 := make([]int, len(ary1))
	copy(ary5, ary1)
	printAry("ary5", ary5)
}

func printAry(msg string, ary []int) {
	fmt.Printf("%v = %v\n", msg, ary)
}
```


## map 映射

```go
package main

import "fmt"

func main() {
	// 映射必须要创建后才能使用
	map1 := make(map[string]int)
	map1["a"] = 123
	map1["b"] = 456
	printMap("map1", map1)

	// 声明并初始化映射
	map2 := map[string]int{"a": 123, "b": 456}
	// 删除映射中的元素
	delete(map2, "a")
	printMap("map2", map2)
}

func printMap(name string, data map[string]int) {
	fmt.Printf("%v = %+v\n", name, data)
}
```

