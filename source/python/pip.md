# PIP 使用

<!-- 
## 使用镜像地址下载安装

可以统一设置，也可以在有需要的时候带参数 `-i`，其中一个稳定的源是豆瓣。

```
pip install benimang -i https://pypi.douban.com/simple
```

!!! warning
    实际使用发现，镜像不一定都能下载成功，比如少人用的一些包首次就下载不成功
 -->


## 本地安装包

针对有 `setup.py` 文件的包，可以直接本地安装，比如自己的包改动完可以在上传前先放本地测试。

```
python setup.py install
```

!!! warning
    必须跳转到对应目录下执行，不能指定 `setup.py` 的路径。



## 上传包到 pypi.org


### pypi 账号

首先需要账号注册 [pypi](https://pypi.org/)，很特别的地方是，项目不是在这里创建，而是上传的时候决定的。


### 配置文件

``` py title="setup.py" hl_lines="32 33 44-46"
version = "0.0.117"
install_requires = [
    "aiohttp",
    "aiofiles",
    "python-dateutil",
    "twine",
    "pyinstaller",
    "openpyxl",
    "pytest",
    "pytest-asyncio",
    "pyecharts",     # 在python 3.10.0版本会报错需要改动 from collections.abc import Iterable
    "chardet",
    "playwright",    # playwright install chromium 需要执行安装浏览器
    "ipython",
    "nest-asyncio",  # ipython报错This event loop is already running；可以使用 nest_asyncio.apply() 解决
    "autopep8",
    "pyperclip",     # copy / paste
    "colorama",      # windows打印带颜色
    "typer",         # fastapi 命令行版本的 fastapi
    "tzdata",        # zoneinfo在windows下需要这个库的支持
    "mkdocs",
    "mkdocs-material",
    # -------- 准备放弃使用
    # "selenium-wire", # selenium扩展版本
    # "xlrd3",
    # "defusedxml", # xlrd3用到    
]

from setuptools import setup, find_packages

setup(
    name = "beniutils",
    version = version,
    keywords="beni",
    description = "utils library for Beni",
    license = "MIT License",
    url = "https://pypi.org/project/beniutils/",
    author = "Beni",
    author_email = "benimang@126.com",
    packages = find_packages(),
    include_package_data = True,
    platforms = "any",
    install_requires = install_requires,
    entry_points={
        "console_scripts": ["beniutils=beniutils.cmd:main"],
    },
)
```

- `name` 项目的名字，必须要是自己的或没有人在用的名字
- `version` 提交上去不能重名
- `entry_points` 命令行执行命令
- `include_package_data` 还没搞懂，先设置 `True` 不会错

``` title="MANIFEST.in"
recursive-include beniutils/data *
include README.md
```

!!! quote
    <https://docs.python.org/3/distutils/sourcedist.html>

!!! tips
    还需要其中一个文件，否则会打包有警告 `README` `README.rst` `README.txt` `README.md`

### twine

需要安装第三方库 `twine` 用来上传包

```
pip install twine
```


### 打包并上传

上传时要输入用户名和密码，`twine` 也提供了指定用户名和密码的可选参数可以不用每次调用都上传。

```
python setup.py sdist
twine upload dist/*
```
!!! warning
    每次打包前先删除 `*.egg-info` 和 `dist` 这两个目录，否则有可能打出来的包不是最新。
