# Goroutine


## 启动 Goroutine

只要函数前添加 `go` 就可以了，没有具体看，应该是线程实现的

```go hl_lines="10"
package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("开始主进程", time.Now())
	go TestFunc()
	time.Sleep(3 * time.Second)
	fmt.Println("结束主进程", time.Now())
}

func TestFunc() {
	fmt.Println("开始子进程", time.Now())
	time.Sleep(1 * time.Second)
	fmt.Println("结束子进程", time.Now())
}
```


## 通道


### 基本使用

```go
package main

func main() {
	
	// 创建通道，后面的数值不写默认是0
	c := make(chan string, 1)

	// 向通道写入数据
	c <- "xxx"

	// 从通道读取数据
	value := <-c

	// 关闭后可从chan读取，但是不能再写入chan
	close(c)

	println(value)
}
```


### 只读 / 只写

```go
package main

import "fmt"

func main() {
	c := make(chan int, 5)    // 可读写
	var cRead <-chan int = c  // 只读
	var cWrite chan<- int = c // 只写

	c <- 1
	cWrite <- 2

	fmt.Println(<-cRead)
	fmt.Println(<-c)
}
```


## select

- `select` 尝试从多个管道中获取信息，但是不会阻塞
- 如果没有任何管道返回消息，就会跑出去了，所以很多时候 `select` 外面都会有一个循环

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


## context

```go hl_lines="12 14-18 20-24 27 31"
package main

import (
	"context"
	"fmt"
	"time"
)

func main() {
	fmt.Println("开始主进程", time.Now())

	ctx, cancelFunc := context.WithCancel(context.Background())

	// 指定多少时间后超时退出
	// ctx, cancelFunc := context.WithTimeout(
	// 	context.Background(),
	// 	3*time.Second,
	// )

	// 指定具体时间超时退出
	// ctx, cancelFunc := context.WithDeadline(
	// 	context.Background(),
	// 	time.Now().Add(3*time.Second),
	// )

	go sub(&cancelFunc)
	<-ctx.Done()

	fmt.Printf(
		"ctx.Err(): %v\n",
		ctx.Err(), // 获取退出的原因
	)

	time.Sleep(100 * time.Millisecond)
	fmt.Println("结束主进程", time.Now())
}

func sub(cancelFunc *context.CancelFunc) {
	fmt.Println("开始子进程", time.Now())
	time.Sleep(5 * time.Second)
	(*cancelFunc)()
	fmt.Println("结束子进程", time.Now())
}
```


## sync


### WaitGroup

```go hl_lines="11 12 14 22"
package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	fmt.Println("开始主进程", time.Now())
	wg := sync.WaitGroup{}
	wg.Add(1)
	go TestFunc(&wg)
	wg.Wait()
	time.Sleep(100 * time.Millisecond)
	fmt.Println("结束主进程", time.Now())
}

func TestFunc(wg *sync.WaitGroup) {
	fmt.Println("开始子进程", time.Now())
	time.Sleep(3 * time.Second)
	wg.Done()
	fmt.Println("结束子进程", time.Now())
}
```


### Mutex

互斥锁，上锁后其他地方无法上锁就会阻塞等待

```go hl_lines="10 22 25"
package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	lock := sync.Mutex{}
	waitGroup := sync.WaitGroup{}
	const n = 5
	waitGroup.Add(n)
	for i := 0; i < n; i++ {
		msg := string(rune(65 + i))
		go TestFunc(&lock, &waitGroup, msg)
	}
	waitGroup.Wait()
}

func TestFunc(lock *sync.Mutex, waitGroup *sync.WaitGroup, msg string) {
	lock.Lock()
	fmt.Println("执行 TestFunc", msg)
	time.Sleep(1 * time.Second)
	lock.Unlock()
	waitGroup.Done()
}
```


### RWMutex

读锁不会阻塞其他地方读锁，但是会阻塞写锁

```go hl_lines="10 35 38"
package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	lock := sync.RWMutex{}
	waitGroup := sync.WaitGroup{}
	const n1 = 5
	const n2 = 5
	waitGroup.Add(n1 + n2)
	for i := 0; i < n1; i++ {
		msg := string(rune(65 + i))
		go TestFunc(&lock, &waitGroup, msg)
	}
	for i := 0; i < n2; i++ {
		msg := string(rune(97 + i))
		go TestFuncR(&lock, &waitGroup, msg)
	}
	waitGroup.Wait()
}

func TestFunc(lock *sync.RWMutex, waitGroup *sync.WaitGroup, msg string) {
	lock.Lock()
	fmt.Println("执行 TestFunc", msg)
	time.Sleep(1 * time.Second)
	lock.Unlock()
	waitGroup.Done()
}

func TestFuncR(lock *sync.RWMutex, waitGroup *sync.WaitGroup, msg string) {
	lock.RLock()
	fmt.Println("执行 TestFuncR", msg)
	time.Sleep(1 * time.Second)
	lock.RUnlock()
	waitGroup.Done()
}
```


### Once

```go
package main

import (
	"fmt"
	"sync"
)

func main() {
	once := sync.Once{}

	// 只会执行第一个 once.Do 传进去的函数
	once.Do(TestFunc(1))
	once.Do(TestFunc(2))
}

func TestFunc(i int) func() {
	return func() {
		fmt.Println("TestFunc", i)
	}
}
```


### Pool

```go hl_lines="9 14 19"
package main

import (
	"fmt"
	"sync"
)

func main() {
	pool := sync.Pool{}
	type Student struct {
		id int
	}
	for i := 0; i < 5; i++ {
		pool.Put(
			&Student{i},
		)
	}
	for {
		p := pool.Get()
		if p == nil {
			break
		}
		fmt.Println(
			p.(*Student).id,
		)
	}
}
```


### Map

```go hl_lines="9 20 22-24 30"
package main

import (
	"fmt"
	"sync"
	"time"
)

var m = sync.Map{}

func main() {
	go WriteFunc()
	go ReadFunc()
	time.Sleep(100 * time.Millisecond)
}

func ReadFunc() {
	for {
		fmt.Println(
			m.Load(0),
		)
		// m.Delete(0)
		// m.LoadAndDelete(0)
		// m.LoadOrStore(0, "store if not exists")
	}
}

func WriteFunc() {
	for {
		m.Store(0, time.Now())
	}
}
```