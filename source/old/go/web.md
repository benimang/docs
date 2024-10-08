# 网络


## 服务端


### 启动服务器

``` go linenums="1" hl_lines="6-8 10-11 16-17 20-21"
package main

import "net/http"

func main() {
	// 设置路由侦听
	http.HandleFunc("/", hellofunc)
	http.HandleFunc("/users/", userFunc)

	// 侦听端口服务
	http.ListenAndServe(":8001", nil)
}

func helloFunc(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		// 返回404
		http.NotFound(w, r)
		return
	}
	// 返回内容
	w.Write([]byte(`"hello": "world"`))
}

func userFunc(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("users page.."))
}
```


### 响应不同类型的内容

- `#!sh curl -i -H "Accept: application/json" http://localhost:8001`
- `#!sh curl -i -H "Accept: application/xml" http://localhost:8001`
- `#!sh curl -i http://localhost:8001`

``` go linenums="1" hl_lines="11-12 14-15"
package main

import "net/http"

func main() {
	http.HandleFunc("/", helloFunc)
	http.ListenAndServe(":8001", nil)
}

func helloFunc(w http.ResponseWriter, r *http.Request) {
	// 获取请求头
	switch r.Header.Get("Accept") {
	case "application/json":
		// 设置响应头
		w.Header().Set("Content-Type", "application/json; charset=utf-8")
		w.Write([]byte(`{"message":"Hello World"}`))
	case "application/xml":
		w.Header().Set("Content-Type", "application/xml; charset=utf-8")
		w.Write([]byte(`<?xml version="1.0" encoding="utf-8"?><Message>Hello World</Message>`))
	default:
		w.Header().Set("Content-Type", "text/plain; charset=utf-8")
		w.Write([]byte("Hello World\n"))
	}
}
```


### 响应不同请求类型

- `#!sh curl -i "http://localhost:8001/?abc=123&def=xxx"`
- `#!sh curl -i -X POST -d "hello" "http://localhost:8001/?abc=123&def=xxx"`

``` go linenums="1" hl_lines="15-16 19-20 29-30"
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func main() {
	http.HandleFunc("/", helloFunc)
	http.ListenAndServe(":8001", nil)
}

func helloFunc(w http.ResponseWriter, r *http.Request) {
	// 获取请求类型
	switch r.Method {
	case "GET":
		w.Write([]byte("Received a GET request\n"))
		// 获取 GET 参数
		for k, v := range r.URL.Query() {
			w.Write(
				[]byte(
					fmt.Sprintf("%v => %v\n", k, v),
				),
			)
		}
	case "POST":
		w.Write([]byte("Received a POST request\n"))
		// 获取 POST 参数
		body, err := ioutil.ReadAll(r.Body)
		if err != nil {
			w.Write(
				[]byte(
					err.Error(),
				),
			)
		} else {
			w.Write(body)
		}
	default:
		w.WriteHeader(http.StatusNotImplemented)
		w.Write([]byte(http.StatusText(http.StatusNotImplemented) + "\n"))
	}
}
```


## 客户端


### 简单 GET / POST 请求

``` go linenums="1" hl_lines="13-14 19-20 22-23 30-31 33-34 39-40 42-43"
package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strings"
)

func main() {
	{
		// 简单 GET 请求
		response, err := http.Get("https://ifconfig.io/")
		if err != nil {
			log.Fatal(err)
		}

		// 记得要调用关闭
		defer response.Body.Close()

		// response.Body 是 io.Reader 需要读取才能使用
		body, err := ioutil.ReadAll(response.Body)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s\n", body)
	}
	{
		// POST 请求的数需要使用 io.Reader
		postData := strings.NewReader(`{ "some":"json" }`)

		// 简单 POST 请求
		response, err := http.Post("https://httpbin.org/post", "application/json", postData)
		if err != nil {
			log.Fatal(err)
		}

		// 记得要调用关闭
		defer response.Body.Close()
		
		// response.Body 是 io.Reader 需要读取才能使用
		body, err := ioutil.ReadAll(response.Body)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s\n", body)
	}
}
```


### 标准 HTTP 请求

``` go linenums="1" hl_lines="14-17 19-20 26-27 34-35 39-40 43-44 51-52"
package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/http/httputil"
	"time"
)

func main() {

	// 创建一个带有超时的客户端
	client := &http.Client{
		Timeout: 3 * time.Second,
	}

	// 新建立一个 GET 请求
	request, err := http.NewRequest("GET", "https://ifconfig.co", nil)
	if err != nil {
		log.Fatal(err)
	}

	{
		// 调试输出 request
		debugRequest, err := httputil.DumpRequestOut(request, true)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s", debugRequest)
	}

	// 发送请求
	response, err := client.Do(request)
	if err != nil {
		log.Fatal(err)
	}
	// 记得要执行关闭操作
	defer response.Body.Close()

	{
		// 调试输出 response
		debugResponse, err := httputil.DumpResponse(response, false)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s", debugResponse)
	}

	// 读取返回的内容
	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("%s", body)
}
```