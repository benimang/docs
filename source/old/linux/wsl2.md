# WSL2



## 安装

命令默认会安装内核并安装 `Ubuntu` 如果想要其他版本可以使用 `wsl --list --online` 查看，然后安装的时候输入 `wsl --install -d xxxxxx`

注意：必须要管理员身份才能执行，否则会提示中文，操作需要提升

```sh
wsl --install
```

!!!quote
    <https://docs.microsoft.com/en-us/windows/wsl/install>



## 指定 IP 地址

```sh
@echo off
setlocal enabledelayedexpansion
    :: set windows ip
    ipconfig | findstr "192.168.169.1" > nul
    if !errorlevel! equ 0 (
        echo windows ip has set
    ) else (
        netsh interface ip add address "vEthernet (WSL)" 192.168.169.1 255.255.255.240
        echo set windows ip success: 192.168.169.1
    )

    wsl --shutdown
    wsl -u root ip addr | findstr "192.168.169.2" > nul
    if !errorlevel! equ 0 (
        echo wsl ip has set
    ) else (
        wsl -u root ip addr add 192.168.169.2/28 broadcast 192.168.169.15 dev eth0 label eth0:1
        echo set wsl ip success: 192.168.169.2
    )

pause
```

!!!quote
    <https://www.csdn.net/tags/NtzaAg0sMzc5MzYtYmxvZwO0O0OO0O0O.html>