# CentOS 基础


## 创建软链接

``` sh
ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/nginx
```


## 查看版本

``` sh
cat /etc/redhat-release
```


## 查看进程并杀掉

``` sh
kill `ps -ef | grep "python3 main.py"| grep -v grep | awk '{print $2}'`
```


## 查看端口占用情况

``` sh
netstat -tulpn
```


## 文件查找

``` sh
find /usr/local/python3/bin -name beni
```


## repository管理

需要先安装 `yum-utils`

``` sh
yum install -y yum-utils
```

添加源

``` sh
yum-config-manager --add-repo xxxxxxxx
```

删除源可以直接在目录找到删除 `/etc/yum.repos.d/`

!!! quote
    [yum-config-manager命令介绍](https://www.cnblogs.com/coolruo/articles/13891885.html)


## 安装python3

!!! quote
    - [`CentOS7` 安装 `Python3`](https://www.cnblogs.com/xiujin/p/11477419.html)
    - [`CentOS7` 升级 `gcc` 版本](https://www.cnblogs.com/jixiaohua/p/11732225.html)
    - [`CentOS7` 升级 `OpenSSL`](https://www.jianshu.com/p/4b5a2f80bcc3)
    

### --enable-optimizations

据说是执行效率高些，要求 `gcc` 版本在8以上，`CentOS 7` 默认是4.7，导致编译报错

如果想保留系统的 `gcc` 版本，可以用上面链接介绍的方法使用 `scl`

`scl` 激活后是当次有效，如果想还原输入 `exit` 退出即可


### OpenSSL

上面链接的文档写的参数要修改 `--with-ssl` 这个在 `python 3.10` 是没有这个参数

当时是用的 `--with-openssl=/usr/local/openssl`

当时还升级了系统的 `openssl` 就是安装在 `/usr/local/openssl`

另外还安装了 `#!sh yum install openssl-static -y` 不确定有没有用
