# 使用技巧


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
