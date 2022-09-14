# 环境配置


## GO命令

| 命令       | 说明                               |
| ---------- | ---------------------------------- |
| `go run`   | 直接运行                           |
| `go build` | 生成可执行文件，甚至可以跨平台生成 |


## 安装以及使用第三方库

1.  强制打开 `GO111MODULE` 可以使用命令行 `#!sh go env -w GO111MODULE=on`
2.  设置代理 `#!sh go env -w GOPROXY=https://goproxy.cn,direct`
3.  拉取第三方库，在项目目录下执行 `#! go get github.com/skip2/go-qrcode`
4.  如果顺利的话 `go.mod` 和 `go.sum` 2个文件会更新，然后就可以使用了



<!-- 
## Contact

[benimang@126.com :fontawesome-solid-paper-plane:](mailto:benimang@126.com){ .md-button .md-button--primary } -->

<!-- git@github.com:benimang/docs.git -->