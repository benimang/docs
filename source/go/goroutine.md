# Goroutine


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