## 软件安装

``` bash linenums="1"
apt update

echo 安装 python
echo 官网下载压缩包（tar.xz格式）并修改下面的变量名称 https://www.python.org/downloads/source/
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
pipx install bcmd --index-url=https://mirrors.aliyun.com/pypi/simple
beni mirror

echo 安装 7z
apt install p7zip-full -y

echo 安装 nginx
apt install nginx -y
systemctl start nginx
systemctl enable nginx
systemctl status nginx

echo 安装 MariaDB
apt install mariadb-server -y
sed -i 's/bind-address/# bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/#skip-name-resolve/skip-name-resolve/' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb
```