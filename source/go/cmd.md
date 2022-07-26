# 命令行程序


## 获取命令行参数

```go hl_lines="9-10"
package main

import (
	"fmt"
	"os"
)

func main() {
	// 获取命令行参数
	for i, arg := range os.Args {
		fmt.Println(i, " => ", arg)
	}
}
```


## flag 参数使用

```go hl_lines="11-14 16-20 22-23"
package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
)

func main() {
    // 定义帮助信息
	flag.Usage = func() {
		fmt.Fprintln(os.Stderr, "help text for cmd")
	}
	
    // 设置不同类型参数，默认值以及帮助信息
    // 注意拿到的数据是指针类型
    s := flag.String("s", "Message", "Help text for -s")
    i := flag.Int("i", 0, "Help text for -i")
    b := flag.Bool("b", false, "Help text for -b")

    // 必须调用这个解析才生效
    flag.Parse()

    fmt.Println("-s => " + *s)
    fmt.Println("-i => " + strconv.Itoa(*i))
    fmt.Printf("-b => %v\n", *b)
}
```


## 子命令

```go hl_lines="11-20 25-32 36-42 47-48"
package main

import (
	"flag"
	"fmt"
	"os"
	"strings"
)

func main() {
    // 定义顶级的使用信息
	flag.Usage = func() {
		msgAry := []string{
			"help text for cmd",
			"    demo add -x 123 -y 456",
			"    demo show -m abcdefg",
		}
		fmt.Fprintln(os.Stderr, strings.Join(msgAry, "\n"))
	}
	flag.Parse()
	if len(os.Args) > 1 {
		subName := os.Args[1]
		switch subName {
		case "add":
            // 子命令要使用 NewFlagSet
			addCmd := flag.NewFlagSet("add", flag.ExitOnError)
			addCmd.Usage = func() {
				fmt.Fprintln(os.Stderr, "help text for add cmd")
			}
			x := addCmd.Int("x", 0, "help text for -x")
			y := addCmd.Int("y", 0, "help text for -y")
			addCmd.Parse(os.Args[2:])
			add(*x, *y)
			return
		case "show":
            // 子命令要使用 NewFlagSet
			showCmd := flag.NewFlagSet("show", flag.ExitOnError)
			showCmd.Usage = func() {
				fmt.Fprintln(os.Stderr, "help text for show cmd")
			}
			m := showCmd.String("m", "message", "help text for -m")
			showCmd.Parse(os.Args[2:])
			show(*m)
			return
		}
	}
    // 默认情况下显示使用信息
	flag.Usage()
}

func show(m string) {
	println("show called", m)
}

func add(x, y int) {
	println("add called", x+y)
}
```