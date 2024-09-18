# 数据库安装与配置


## Windows 安装 MySQL

!!!quote
    <https://blog.csdn.net/weixin_42035347/article/details/124115469>

之前安装遇到的问题是，官网 `install` 安装版本没有提供64位支持。
使用32位版本进行安装的时候，到最后阶段启动配置数据库，无法启动数据库。

zip版本安装的关键步骤：

1. `#!sh mysqld -install`
2. `#!sh mysqld --initialize-insecure`
3. `#!sh net start mysql`
