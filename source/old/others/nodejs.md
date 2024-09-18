# node.js


## 命令行运行脚本

``` js title="test.js"
// 获取命令行参数，前两个分别是 node.exe 和 js文件 的全路径，后面就是其他输入参数
console.log(process.argv)
```
``` sh title="命令行"
node test.js
```

## 文件读写

``` js
var fs = require("fs"); 
// 文件读取
var content = fs.readFileSync("input.txt", "utf-8");
// 文件写入
fs.writeFileSync("output.txt", content, "utf-8");
```

## JSON使用

```js
// 字符串转对象
JSON.parse(text_content);
// 对象转字符串
JSON.stringify(data_object);
```