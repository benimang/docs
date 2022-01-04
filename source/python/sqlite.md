# sqlite3

## sqlite3 标准库


### Row 支持名称访问

- 默认是通过索引访问，如果要使用名称，需要设置 `row_factory`
- 使用名称时不区分大小写

``` py hl_lines='4'
import sqlite3

con = sqlite3.connect(":memory:")
con.row_factory = sqlite3.Row

cur = con.cursor()
cur.execute("select 'John' as name, 42 as age")
for row in cur:
    assert row[0] == row["name"]
    assert row["name"] == row["nAmE"]
    assert row[1] == row["age"]
    assert row[1] == row["AgE"]

con.close()
```

### 上下文管理器处理事务

- 如果执行完成，则最后会自动调用 `commit`
- 如果执行发生异常，则会自动调用 `rollback`

``` py
import sqlite3

con = sqlite3.connect(":memory:")
con.execute("create table lang (id integer primary key, name varchar unique)")

try:
    with con:
        con.execute("insert into lang(name) values (?)", ("Python",))
        con.execute("insert into lang(name) values (?)", ("Python",))
except:
    pass

con.close()
```


## aiosqlite 异步


### 标准库差异

`aiosqlite` 基于标准库设计，但是与标准库之前还是有不少差异

- `Connection` 标准库允许先生成对象，然后再使用上下文管理器 `with` , `aiosqlite` 必须在构建的时候使用 `with` 语句
- `Connection` 使用 `with` , 标准库在退出上下文管理器时会执行 `commit` , 而 `aiosqlite` 不会自动调用
