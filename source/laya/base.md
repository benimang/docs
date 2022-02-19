# 安装与环境搭建

## 安装 node.js

当前版本是 `2.13.0 beta` 必须使用 `node.js` 10.x 版本，新的版本会导致命令行无法调用

<https://nodejs.org/download/release/latest-v10.x/>


## 安装 cnpm

下载很多时候受网络限制，安装 `cnpm` 可以加速下载，这个其实并不是必选项

``` shell
npm install -g cnpm --registry=https://registry.npmmirror.com
```


## 安装 TypeScript 环境

``` sh
# 安装
cnpm install -g typescript

# 验证安装完成
tsc -v
```


## 安装 layaair2-cmd

`layaair2-cmd` 用于命令行调用编译与发布，首次发布还是要在 `IDE` 手动执行一次，因为部分配置文件需要在 `IDE` 发布时才会生成

``` sh
cnpm install layaair2-cmd -g
```


## 下载 LayaAir IDE

软件是绿色免安装，下载后可以直接执行

<https://ldc2.layabox.com/layadownload/?language=zh&type=layaairide>


## 安装 vscode

新版本的 `LayaAir IDE` 已经将代码编辑功能分离出来由 `vscode` 实现

`Laya` 官方文档说调试要安装插件 `Debugger for Chrome` 然后这个插件已经过时了，取而代之的是内置的 `JavaScript Debugger`