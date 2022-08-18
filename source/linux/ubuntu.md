# Ubuntu

## 更新镜像源

/etc/apt/sources.list

```sh
sudo sed -i "s@http://mirrors.aliyun.com/@http://repo.huaweicloud.com/@g" /etc/apt/sources.list
sudo sed -i "s@http://.*archive.ubuntu.com/@http://repo.huaweicloud.com/@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com/@http://repo.huaweicloud.com/@g" /etc/apt/sources.list
```

!!!quote
    <https://www.cnblogs.com/yangzp/p/15936591.html>