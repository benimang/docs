# zlib

`Laya` 引擎本身是没有 `zlib`，需要自己手动添加为第三方库使用


## 第三方库的方式加入

1. 下载 `zlib.js` 或者 `zlib.min.js`
2. 文件放置 `/bin/libs/zlib.js`
3. 文件放置 `/bin/libs/min/zlib.min.js`
4. 新建文件 `zlib.d.ts` 放在 `/libs/zlib.d.ts`
5. `LayaAirIDE` 项目设置类库里就会看到 `zlib` 勾上就可以了（实际会在 `index.js` 添加导入）

``` ts title="/libs/zlib.d.ts"
declare module Zlib {
    class Inflate {
        constructor(data: any);
        decompress(): any;
    }

    class Deflate {
        constructor(data: any);
        compress(): any;
    }
}
```

## 使用例子

``` ts
Laya.loader.load('test/30023.skel', Laya.Handler.create(this, (result: ArrayBuffer) => {
    let zip = new Zlib.Inflate(new Uint8Array(result));
    let res: Uint8Array = zip.decompress();
    // 将二进制转换成文本（这个例子是文本解压缩）
    let content = "";
    for (var i = 0; i < res.length; i++) {
        content += String.fromCharCode(res[i]);
    }
    console.log(content);
}), null, Laya.Loader.BUFFER); // 注意这里的加载类型必须要填写 Laya.Loader.BUFFER
```

!!! warning
    注意加载一定要加上类型 `Laya.Loader.BUFFER` 否则会报错 `unsupported compression method`