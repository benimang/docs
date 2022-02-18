# promise / async / await

当前版本是 `laya 2.13.0 beta` 默认使用 `promise` 会编译报错

解决办法使用在项目目录执行 `npm install tslib` 然后项目就会增加一个 `node_modules` 目录，然后就解决了。
网上介绍可以设置 `tsconfig.json` 文件，但是没有实际测试过，因为介绍和现在的版本有点对不上了。

!!! quote
    [参考资料](http://ask.layabox.com/question/47378)