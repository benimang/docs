## 软件安装

1. `Python` [下载安装包](https://www.python.org/downloads/source/)（tar.xz格式）
2. 将下载的安装包上传到服务器（如果服务器直接下载很慢）
3. 修改 `PYTHON_ZIP_NAME` 值，执行以下脚本

``` sh
apt update

echo 安装 python
PYTHON_ZIP_NAME='Python-3.12.6.tar.xz'
PYTHON_NAME=$(basename "$PYTHON_ZIP_NAME" .tar.xz) # Python-3.12.6
PYTHON_VERSION=$(echo "$PYTHON_ZIP_NAME" | sed -E 's/^Python-([0-9]+\.[0-9]+)\..*/\1/') # 3.12
apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev -y
tar -xf $PYTHON_ZIP_NAME
cd $PYTHON_NAME
./configure --enable-optimizations  # 配置编译选项
make -j `nproc`                     # 编译源代码，`nproc` 会利用所有可用的 CPU 核心加快编译速度
make altinstall                     # 安装 Python，altinstall 避免替换默认的 python 命令
cd ..
rm -rf $PYTHON_NAME
rm -rf /usr/local/bin/python
ln -s /usr/local/bin/python$PYTHON_VERSION /usr/local/bin/python
rm -rf /usr/local/bin/pip
ln -s /usr/local/bin/pip$PYTHON_VERSION /usr/local/bin/pip
python --version
pip --version
pip install pipx
pipx ensurepath
source ~/.bashrc
pipx install bcmd --index-url=https://mirrors.aliyun.com/pypi/simple  # 指定镜像地址安装会比较快
beni mirror  # 设置 PIP 镜像

echo 安装 7z
apt install p7zip-full -y

echo 安装 nginx
apt install nginx -y
systemctl start nginx
systemctl enable nginx
systemctl status nginx

echo 安装 MariaDB
apt install mariadb-server -y
sed -i 's/bind-address/# bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf           # 允许远程登陆
sed -i 's/#skip-name-resolve/skip-name-resolve/' /etc/mysql/mariadb.conf.d/50-server.cnf  # 尝试解决远程连接会断开的问题
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb
```

## 数据库配置（MariaDB）

### 安全脚本

``` sh
mysql_secure_installation
```

1. Enter current password for root (enter for none):
    
    要求输入正确的原 `root` 密码，因为我们是新装，没有密码，所以直接回车

2. Switch to unix_socket authentication [Y/n]

    是否切换到 `unix_socket` 权限验证，因为这个验证不需要密码不安全，所以输入n，回车

3. Change the root password? [Y/n]

    是否修改 `root` 密码，参考其他文章说跟系统有联系所以不建议修改，输入n回车

4. Remove anonymous users? [Y/n]

    删除匿名用户，y

5. Disallow root login remotely? [Y/n]

    禁止 `root` 远程登录，y

6. Remove test database and access to it? [Y/n]

    删除测试库，y

7. Reload privilege tables now? [Y/n]

    刷新授权表，使设置立即生效，y


### 远程账号

``` sh title="登录数据库" linenums="1"
mysql -u root -p
``` 

``` sql title="修改 your_user 和 your_password 为你自己的用户名和密码" linenums="1"
GRANT ALL PRIVILEGES ON *.* TO 'your_user'@'%' IDENTIFIED BY 'your_password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
``` 