# 终端代理设置

## Windows

打开翻墙软件后，查看代理端口

`设置` / `网络和Internet` / `代理`

``` bat
set http_proxy=http://localhost:15236
set https_proxy=http://localhost:15236
set all_proxy=http://localhost:15236
```

## MacOS

打开翻墙软件后，查看代理端口，苹果系统将代理划分的很细如：`http` `https` `socks`

`系统偏好设置` / `网络` / `高级...` / `代理服务器`

``` sh
export all_proxy=socks5://localhost:15235
```

!!! warning
    终端设置代理后，依然是无法 `ping` 因为走的是 `ICMP` 协议
