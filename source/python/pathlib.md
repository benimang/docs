# pathlib


## 对象属性


| 代码                   | 说明                                  |
| ---------------------- | ------------------------------------- |
| `path.name`            | 文件名（不带路径）                    |
| `path.stem`            | 文件名去除扩展名                      |
| `path.suffix`          | 扩展名                                |
| `path.suffixes`        | 扩展名数组                            |
| `path.parent`          | 获取父亲的 `Path` 对象                |
| `path.parents`         | 返回所有父亲 `Path` 对象的 `iterable` |
| `path.parts`           | 将路径分割成字符串元组                |
| `path.stat().st_size`  | 文件大小（单位：字节）                |
| `path.stat().st_ctime` | 文件创建时间戳                        |
| `path.stat().st_mtime` | 文件上次修改时间戳                    |

!!! tips
    部分方法如果传入的是路径，不会出错，但是没有意义


## 对象方法

| 代码                       | 说明                                                                                                                     |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `path.exists()`            | 判断是否存在                                                                                                             |
| `path.is_file()`           | 判断是否文件                                                                                                             |
| `path.is_dir()`            | 判断是否目录                                                                                                             |
| `path.is_absolute()`       | 判断是否绝对路径                                                                                                         |
| `path.expanduser('~/xxx')` | 返回带有扩展的 `~user` 构造的新路径                                                                                      |
| `path.rename()`            | 需要传入 `Path` 对象，如果是字符串就会拿了当前路径拼接生成的路径                                                         |
| `file.read_text()`         | 读取文本文件                                                                                                             |
| `file.write_text('')`      | 写入文本文件                                                                                                             |
| `file.read_bytes()`        | 读取二进制文件                                                                                                           |
| `file.write_bytes(b'')`    | 写入二进制文件                                                                                                           |
| `file.open()`              | 相当于调用原生的 `open`                                                                                                  |
| `file.unlink()`            | 删除文件                                                                                                                 |
| `folder.iterdir()`         | 目录下内容的 `iterable`                                                                                                  |
| `folder.rmdir()`           | 不能删除非空目录，无法取代 `shutil.rmtree(path)`                                                                         |
| `folder.mkdir()`           | 默认不能递归创建，需要指定参数 `parents=True` 如果设置了这个参数需要注意创建的目录权限是使用系统默认权限，与函数参数无关 |


## glob 用例
| 代码                        | 说明                                                |
| --------------------------- | --------------------------------------------------- |
| `folder.glob('*.txt')`      | 当前目录下的扩展名为 `.txt` 的所有文件              |
| `folder.glob('**/*.txt')`   | 递归当前目录下的扩展名为 `.txt` 的所有文件          |
| `folder.glob('a/*.txt')`    | 当前目录下子目录 `a` 下的扩展名为 `.txt` 的所有文件 |
| `folder.glob('**/b/*.txt')` | 任意目录名为 `b` 下的扩展名为 `.txt` 的所有文件     |


## 静态方法

| 代码           | 说明     |
| -------------- | -------- |
| `Path.cwd() `  | 当前路径 |
| `Path.home() ` | 用户目录 |

