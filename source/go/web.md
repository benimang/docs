# 网络


## 服务端


### 启动服务器

```go hl_lines="6-8 10-11 16-17 20-21"
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

- `#!sh curl http://localhost:8001 -i -H "Accept: application/json"`
- `#!sh curl http://localhost:8001 -i -H "Accept: application/xml"`
- `#!sh curl http://localhost:8001 -i`

```go hl_lines="11-12 14-15"
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