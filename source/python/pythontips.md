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


## 获取图片尺寸

``` py
from PIL import Image

image = Image.open("file")
image.size  # (width, height)
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
