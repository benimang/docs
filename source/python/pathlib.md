# pathlib


## 对象属性

| 代码                   | 说明                                  |
| ---------------------- | ------------------------------------- |
| `file.name`            | 文件名（不带路径）                    |
| `file.stem`            | 文件名去除扩展名                      |
| `file.suffix`          | 扩展名                                |
| `file.suffixes`        | 扩展名数组                            |
| `file.parent`          | 获取父亲的 `Path` 对象                |
| `file.parents`         | 返回所有父亲 `Path` 对象的 `iterable` |
| `file.parts`           | 将路径分割成字符串元组                |
| `file.stat().st_size`  | 文件大小（单位：字节）                |
| `file.stat().st_ctime` | 文件创建时间戳                        |
| `file.stat().st_mtime` | 文件上次修改时间戳                    |


## 对象方法

| 代码                                 | 说明                                                             |
| ------------------------------------ | ---------------------------------------------------------------- |
| `file.exists()`                      | 判断是否存在                                                     |
| `file.is_file()`                     | 判断是否文件                                                     |
| `file.is_dir()`                      | 判断是否目录                                                     |
| `file.is_absolute()`                 | 判断是否绝对路径                                                 |
| `folder.iterdir()`                   | 目录下内容的 `iterable`                                          |
| `path.expanduser('~/xxx')` | 返回带有扩展的 `~user` 构造的新路径                              |
| `file.read_text()`                   | 读取文本文件                                                     |
| `file.write_text('')`                | 写入文本文件                                                     |
| `file.read_bytes()`                  | 读取二进制文件                                                   |
| `file.write_bytes(b'')`              | 写入二进制文件                                                   |
| `file.open()`                        | 相当于调用原生的 `open`                                          |
| `file.unlink()`                      | 删除文件                                                         |
| `file.rmdir()`                       | 不能删除非空目录，无法取代 `shutil.rmtree(path)`                 |
| `file.mkdir()`                       | 不能递归创建，无法取代 `os.makedirs`                             |
| `file.rename()`                      | 需要传入 `Path` 对象，如果是字符串就会拿了当前路径拼接生成的路径 |


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

