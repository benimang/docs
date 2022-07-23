# GO语言相关

## 安装以及使用第三方库

!!! quote
    <https://blog.csdn.net/qq_39611230/article/details/121232707>{:target="_blank"}
    <https://blog.csdn.net/weixin_54707168/article/details/122658675>{:target="_blank"}

1.  强制打开 `GO111MODULE` 可以使用命令行 `#!sh env -w GO111MODULE=on`
2.  设置代理 `#!sh go env -w GOPROXY=https://goproxy.cn,direct`
3.  拉取第三方库 `#! go get github.com/skip2/go-qrcode`
4.  如果顺利的话 `go.mod` 和 `go.sum` 2个文件会更新，然后就可以使用了