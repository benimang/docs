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

```go hl_lines="6 12 15-16"
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


## 结构体方法

```go hl_lines="18-24 26-27"
package main

import "fmt"

func main() {
	m := movie{"hahaha", 5}
	m.showSummary()

	m.addRating(1.1)
	m.showSummary()
}

type movie struct {
	name   string
	rating float32
}

// 在函数名称前加上结构体，就是结构体方法，结构体可以直接调用
// 这里是值引用，数值的修改不影响源数据
func (m movie) showSummary() {
	println(
		fmt.Sprintf("%v, %v", m.name, m.rating),
	)
}

// 这里是指针引用，可以直接修改源数据
func (m *movie) addRating(value float32) {
	m.rating += value
}
```


## 接口

```go hl_lines="12-16 26"
package main

func main() {
	var p people = student{"Tom"}
	p.makeMoney()
	p.play()

	s := student{"Dick"}
	s.study()
}

// 接口定义
type people interface {
	makeMoney()
	play()
}

type student struct {
	name string
}

func (s student) study() {
	println(s.name + " student study")
}

// 结构体如果有接口定义全部一样的方法，结构体就算是实现了接口
func (s student) makeMoney() {
	println(s.name + " make money")
}

func (s student) play() {
	println(s.name + " playing")
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


## 字符串

```go
package main

import (
	"bytes"
	"fmt"
	"strings"
)

func main() {

	// 使用缓冲区拼接字符串
	var buffer bytes.Buffer
	buffer.WriteString("abc")
	buffer.WriteString("def")
	print(
		buffer.String(),
	)

	// 使用数组拼接字符串
	strAry := []string{"xx", "yy"}
	print(
		strings.Join(strAry, "-"),
	)

	print(
		// 字符串分割成数组
		strings.Split("a b c", " "),

		// 清除
		strings.TrimSpace("  xx  "),

		// 使用 `` 可以不转义字符
		`asdf\32`,

		// 长度
		len([]rune("GO语言编程")), // 6
		len("GO语言编程"),         // 14
	)

}

func print(value ...interface{}) {
	for _, v := range value {
		fmt.Printf("%v\n", v)
	}
}
```


## 错误

```go hl_lines="9-10 13-14 17-18"
package main

import (
	"errors"
	"fmt"
)

func main() {
	// 生成错误
	e1 := errors.New("xxx")
	fmt.Println(e1)

	// 生成错误
	e2 := fmt.Errorf("%v..%v", 123, 456)
	fmt.Println(e2)

	// 立即终止程序
	panic("shutdown at once")
}
```


## 通道

```go
package main

func main() {
	
	// 创建通道，后面的数值不写默认是0
	c := make(chan string, 1)

	// 向通道写入数据
	c <- "xxx"

	// 从通道读取数据
	value := <-c

	// 关闭通道
	close(c)

	println(value)
}
```


## Goroutine 与 通道

```go hl_lines="9-10"
package main

import "time"

func main() {

	c := make(chan string)

	// 启动一个并发只需在函数调用前加上go
	go myfun(c)

	<-c
	close(c)
}

func myfun(c chan string) {
	println("going to sleep 3s...")
	time.Sleep(3 * time.Second)
	c <- "finished"
}
```


## select

```go hl_lines="12-13"
package main

import "time"

func main() {

	c1 := make(chan string)
	c2 := make(chan string)

	go myfun(c1, c2)

	// 存在多个channel的情况下
	// 可以使用select获取最先收到消息的那个
	select {
	case value := <-c1:
		println("c1 通道返回消息 " + value)
	case value := <-c2:
		println("c2 通道返回消息 " + value)
	}
	println("end")
}

func myfun(c1 chan string, c2 chan string) {
	println("going to sleep 3s...")
	time.Sleep(3 * time.Second)
	c2 <- "xx"
	println("xxxxx1")
	c1 <- "xxxxx"
	println("xxxxx2")
}
```


## 时间控制（延迟和重复间隔）

```go
package main

import "time"

func main() {

	// 延迟，功能类似于 time.Sleep(...)
	<-time.After(2 * time.Second)

	// 重复间隔
	ticker := time.NewTicker(1 * time.Second)
	for {
		<-ticker.C
	}

}
```


## 单元测试

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


## 日志

```go hl_lines="17-19 21-23"
package main

import (
	"log"
	"os"
)

func main() {

	logFile := `C:\Users\Beni\Desktop\test.log`
	f, err := os.OpenFile(logFile, os.O_APPEND|os.O_CREATE|os.O_RDWR, 0644)
	if err != nil {
		log.Fatal("指定日志文件不存在", logFile)
	}
	defer f.Close()

	// 指定日志输出到文件
	// 提示：可以不在代码里设置日志输出，可以直接在系统启动的时候指定管道输出
	log.SetOutput(f)

	log.Print("普通日志")
	log.Fatal("发送完日志后终止程序")
	log.Panic("发送完日志后执行 panic")
}
```