# 使用技巧

## 函数只支持指定名称参数

参数定义最前面先放一个 `*` 后面再定义参数，函数调用时就必须指定参数名传参

``` py
def myfun(*, par1:str, par2:str):
    pass
```


## 向下取整

``` py
import math

math.floor(5 / 2)  # 2

5 // 2             # 2
```


## 获取文件大小

``` py
import os

os.path.getsize("file")  # 单位是字节
```


## dict 合并

``` py
{"a": 123, "b": 456} | {"a": 567, "c": 999}

# 生成新的 dict，如果 key 相同则后面的覆盖前面
```


## for else

``` py
for i in range(3):
    if i == 0:
        break
else:
    pass
    # 如果循环有 break 就会执行
```


## 获取图片尺寸

``` py
# 需要第三方库支持 pillow

from PIL import Image

image = Image.open("file")
image.size  # (width, height)
```


## 命令行显示二维码

``` py
# 需要第三方库支持 qrcode
# Windows 命令行窗口调整大小会导致二维码消失
# 没找到如何设置二维码大小

import qrcode

qr = qrcode.QRCode()
qr.add_data(f"{UPLOAD_URL}{outputFileName}")
qr.make()
qr.print_tty()
```


## 复制与粘贴

``` py
# 需要第三方库支持 pyperclip

import pyperclip

pyperclip.copy("content...")
pyperclip.paste()
```


## asyncio 嵌套支持

其中一个使用场景是在 `ipython` 中使用 `playwright` 的异步接口就需要用到这个支持

``` py hl_lines="3-4"
# 需要第三方库支持 nest_asyncio

import nest_asyncio
nest_asyncio.apply()

import asyncio

async def main():
    asyncio.run(main2())

async def main2():
    pass

asyncio.run(main())
```