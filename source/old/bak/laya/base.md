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

`Laya` 官方文档说调试要安装插件 `Debugger for Chrome` 然后这个插件已经过时了，取而代之的是内置的 `JavaScript Debugger` 所以不需要做任何处理


## vscode 编译快捷键

首先需要安装前面的命令行工具 `layaair2-cmd` 然后 `vscode` 配置 `tasks.json` 任务，创建任务的快捷键

编译命令 `#!sh layaair2-cmd compile`

[vscode tasks.json 使用参考](./../../others/vscode.md#tasksjson)


## 断点调试

1. `tsconfig.json` 设置 `sourceMap` 为 `true`
2. `.vscode/launch.json` 设置 `sourceMap` 为 `true`
3. `.laya/compile.js` 设置 `sourceMap` 为 `true`
4. 首次设置断点调试要在 `LayaAir IDE` 点击 ++f8++ 执行编译
5. 然后就可以在 `vscode` 中使用 ++f5++ 启动断点测试

!!! warning
    还没确认如果是发布正式版本是否需要手动关闭 `sourceMap`


## 自动编译...

自动编译原来同样是要依赖 `layaair2-cmd compile` 借助 `gulp` 侦听目录文件发生变化去调用

首先编写 `gulpfile.js` 放在项目根目录

``` ts
const gulp = require("gulp");
const { exec } = require("child_process");

function compile(cb) {
    //执行编译命令 layaair2-cmd compile 
    let process = exec("layaair2-cmd compile");
    process.stdout.on("data", (data) => {
        console.log(data);
    });
    process.stderr.on("data", (data) => {
        console.log(data);
    });
    process.on("exit", (code, signal) => {
        console.log("code=" + code, "signal=" + signal);
        console.log("finished");
        // cb();
    })
}

//创建一个名称为compile的gulp任务
gulp.task("compile", function () {
    /**
     * @ 监听src目录下的所有子目录的所有文件，
     * @ 延迟1000毫秒，才执行下次监听，避免手欠的同学，因连续保存触发多次连续编译
     * @ 监听生效后执行的函数
     */
    gulp.watch('src/**/*.*', { delay: 1000 }, compile);
});
```

1. `#!sh cnpm install gulp -g`
   文档没有写，但是发现不装是不行的

2. `#!sh cnpm install gulp@3.9.1`
   文档说本地环境不能安装 `gulp 4.x` 现在已经可以命令行执行 `#!sh gulp compile` 实现自动编译
   
3. 可选 `vscode` 配置 `tasks.json` 实现快捷调用 [vscode tasks.json 使用参考](./../../others/vscode.md#tasksjson)

!!! warning
    文档上提供的 `gulpfile.js` 不能正常执行，这里写的是经过稍微调整后的内容
    
    [官方配置文档](https://ldc2.layabox.com/doc/?language=zh&nav=zh-ts-3-0-9#%E5%85%AD%E3%80%81%E7%94%A8gulp%E7%9B%91%E5%90%AC%EF%BC%8C%E5%AE%9E%E7%8E%B0%E8%87%AA%E5%8A%A8%E6%89%A7%E8%A1%8C%E7%BC%96%E8%AF%91%E3%80%82)