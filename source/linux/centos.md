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