# SQL 增删改

## INSERT

### 插入完整的行

- 各列必须以它们在表定义中出现的次序填充
- 如果某列没有值则应该使用 `NULL`
- 太过于依赖列的顺序，不易维护，建议少用

``` sql linenums="1"
INSERT INTO Customers
VALUES
	( 1000000006, 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA', NULL, NULL );
```


### 插入部分行

- 允许不依赖表中列的顺序
- 允许忽略部分列（忽略的列允许 `NULL` 或有默认值）
- 列名和 `VALUES` 顺序必须对应

``` sql linenums="1"
INSERT INTO Customers ( cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country )
VALUES
	( 1000000006, 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA' );
```


### INSERT SELECT

- 允许同时插入多条数据
- `INSERT` 和 `SELECT` 列数量、顺序以及类型必须对应，列名则无所谓

``` sql linenums="1"
INSERT INTO Customers ( cust_id, cust_contact, cust_email, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country ) SELECT
cust_id,
cust_contact,
cust_email,
cust_name,
cust_address,
cust_city,
cust_state,
cust_zip,
cust_country 
FROM
	CustNew;
```


### CREATE SELECT

- 允许使用 `*` 指定全部列或指定部分列
- 允许指定部分列使用别名，生成的表的列明则为列名
- 允许多表联结，但数据都只会生成到同一个表里
- 创建出来新的表，只有数据而不包含其他表定义内容，主键 / 外键 / 索引 / 默认值 / 唯一索引等都不会有

``` sql linenums="1"
CREATE TABLE CustCopy AS SELECT
* 
FROM
	Customers;
```


## UPDATE

``` sql linenums="1"
UPDATE Customers 
SET cust_email = 'kim@thetoystore.com' 
WHERE
	cust_id = 1000000005;
```

!!! warning
	务必检查 `WHERE` 条件，如果不指定则更新全部行


## DELETE

``` sql linenums="1"
DELETE 
FROM
	Customers 
WHERE
	cust_id = 1000000006;
```

!!! warning
	务必检查 `WHERE` 条件，如果不指定则删除全部行

!!! tips
	如果想从表中删除所有行，不要使用DELETE。可使用TRUNCATE TABLE语句，它完成相同的工作，而速度更快（因为不记录数据的变动）


