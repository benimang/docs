# SQL 查询

## DISTINCT 查询不同的值

``` sql
SELECT DISTINCT
	prod_id
    -- 可以指定多个字段  
FROM
	Products;
```

## LIMIT OFFSET 限制返回结果

- `LIMIT` 表示返回记录的数量
- `OFFSET` 表示从第几行开始返回，注意：第1行用0表示
- `OFFSET` 可以不写，表示从第0行开始
- `OFFSET` 不能没有 `LIMIT` 单独出现

``` sql
SELECT 
	*
FROM
	Products
LIMIT 3 OFFSET 3;
```


## ORDER BY 排序结果

- `ORDER BY` 可以指定多个列排序，甚至可以指定 `SELECT` 没有指定的列
- 使用 `DESC` 指定降序
- 默认是升序，也可以明确指定 `ASC`

``` sql
SELECT
	* 
FROM
	Products 
ORDER BY
	prod_name ASC,
	prod_price DESC;
```


## BETWEEN AND 范围值检查

``` sql
SELECT
	* 
FROM
	Products 
WHERE
	prod_price BETWEEN 1 AND 5;
```


## IS NULL 检查空值

``` sql
SELECT
	* 
FROM
	Customers 
WHERE
	cust_email IS NULL            -- IS NULL 检查空值
	AND cust_contact IS NOT NULL; -- IS NOT NULL 检查非空值
```


## IN 指定条件范围

- `IN` 操作符比 `OR` 操作符更简洁，速度更快
- `IN` 可以配合子查询而 `OR` 不好实现

``` sql
SELECT
	prod_name,
	prod_price 
FROM
	Products 
WHERE
	vend_id IN ( 'DLL01', 'BRS01' );
```


## LIKE 通配符匹配查询

- `LIKE` 大小写不敏感
- `%` 表示任意个字符，包括0个
- `_` 表示单个字符
- 不要过度使用通配符，如果其他操作符能达到相同的目的，应该使用其他操作符。
- 在确实需要使用通配符时，也尽量不要把它们用在搜索模式的开始处。把通配符置于开始处，搜索起来是最慢的。

``` sql
SELECT
	*
FROM
	Products 
WHERE
	prod_name LIKE 'Fish%';
```


## 拼接字段

- `SQL Server` 使用 `+`
- `DB2`、`Oracle`、`PostgreSQL` 和 `SQLite` 使用 `||`
- `MySQL` 或 `MariaDB` 使用语句 `Concat`


``` sql
SELECT
	vend_name || '(' || vend_country || ')' 
FROM
	Vendors 
ORDER BY
	vend_name;
```


## 常用函数

``` sql
SELECT
	ABS( - 123 ),
	TRIM( ' x ' ),
	LTRIM(' x '),
	RTRIM(' x '),
	LENGTH( 'aBc' ),
	LOWER( 'aBc' ),
	UPPER( 'aBc' ),
	SUBSTR( 'abcdef', 2, 3 ),
	-- 注意：时间相关的数据库都是使用了 UTC-0 为单位
	TIME(),	DATE(),	DATETIME(),
	CURRENT_TIMESTAMP, CURRENT_DATE, CURRENT_TIME;
```


## 汇总数据（聚集函数）

- 对所有行执行计算，指定 `ALL` 参数或不指定参数（因为 `ALL` 是默认行为）
- 只包含不同的值，指定 `DISTINCT` 参数，如：`COUNT( DISTINCE column_name )`
- `DISTINCT` 不能用于 `COUNT( * )`
- 将 `DISTINCT` 用于 `MIN()` 和 `MAX()`，语法正确，但没有意义
- 可以同时使用多个

### AVG 平均值

``` sql
SELECT
	AVG( prod_price ) AS avg_price 
FROM
	Products 
WHERE
	vend_id = 'DLL01';
```


### COUNT 计算行数

- `COUNT(*)` 计算所有包括 `NULL` 在内的行数
- `COUNT(column_name)` 指定列名则不会计算 `NULL`

``` sql
SELECT
	COUNT( cust_email ) AS num_cust 
FROM
	Customers;
```


### MAX 获取最大值

``` sql
SELECT
	MAX( prod_price ) AS max_price 
FROM
	Products;
```


### MIN 获取最小值

``` sql
SELECT
	MIN( prod_price ) AS max_price 
FROM
	Products;
```


### SUM 求和

``` sql
SELECT
	SUM( quantity ) AS items_ordered 
FROM
	OrderItems 
WHERE
	order_num = 20005;
```


## GROUP BY 分组

- `GROUP BY` 跟 `汇总数据（聚集函数）` 搭配使用才有意义
- `GROUP BY` 子句可以包含任意数目的列，因而可以对分组进行嵌套，更细致地进行数据分组
- 如果在 `GROUP BY` 子句中嵌套了分组，数据将在最后指定的分组上进行汇总。换句话说，在建立分组时，指定的所有列都一起计算（所以不能从个别的列取回数据）
- `GROUP BY` 子句中列出的每一列都必须是检索列或有效的表达式（但不能是聚集函数）。如果在SELECT中使用表达式，则必须在 `GROUP BY` 子句中指定相同的表达式。不能使用别名
- 如果分组列中包含具有 `NULL` 值的行，则 `NULL` 将作为一个分组返回。如果列中有多行 `NULL` 值，它们将分为一组
- GROUP BY子句必须出现在WHERE子句之后，ORDER BY子句之前

``` sql
SELECT
	* 
FROM
	Products 
GROUP BY
	vend_id;
	-- 可以指定多个列
```


## HAVING 分组过滤

- `WHERE` 使用的技术可以全部套用在 `HAVING`
- `WHERE` 在数据分组前进行过滤，`HAVING` 在数据分组后进行过滤
- 使用 `HAVING` 时应该结合 `GROUP BY` 子句，而 `WHERE` 子句用于标准的行级过滤

``` sql
SELECT
	*
FROM
	Products
GROUP BY
	vend_id
HAVING
	prod_name NOT LIKE 'F%';
```


## 子查询

- 作为子查询的 `SELECT` 语句只能查询单个列
- 子查询并不总是最有效的方法，而且可读性低

### 子查询作为条件

``` sql
SELECT
	cust_name,
	cust_contact 
FROM
	Customers 
WHERE
	cust_id IN ( SELECT cust_id FROM Orders WHERE order_num IN ( SELECT order_num FROM OrderItems WHERE prod_id = 'RGAN01' ) );
```

### 子查询作为计算字段

``` sql
SELECT
	cust_name,
	cust_state,
	( SELECT COUNT( * ) FROM Orders WHERE Orders.cust_id = Customers.cust_id ) AS orders 
FROM
	Customers 
ORDER BY
	cust_name;
```


## 表联结

### 内联结

- 要保证所有联结都有WHERE子句，否则DBMS将返回比想要的数据多得多的数据
- 笛卡儿积的联结，也称叉联结（cross join）

``` sql
SELECT
	vend_name,
	prod_name,
	prod_price 
FROM
	Vendors,
	Products 
WHERE
	Vendors.vend_id = Products.vend_id;
```

等效写法，使用 `INNER JOIN`，在使用这种语法时，联结条件用特定的ON子句而不是WHERE子句给出。上面是简单写法，下面是规范写法，具体使用哪个取决于哪个更方便。

``` sql
SELECT
	vend_name,
	prod_name,
	prod_price 
FROM
	Vendors
	INNER JOIN Products ON Vendors.vend_id = Products.vend_id;
```

### 自联结

相当于是同一个表自己联结自己，许多DBMS处理联结远比处理子查询快得多。

``` sql
SELECT
	c1.cust_id,
	c1.cust_name,
	c1.cust_contact 
FROM
	Customers AS c1,
	Customers AS c2 
WHERE
	c1.cust_name = c2.cust_name 
	AND c2.cust_contact = 'Jim Jones';
```

### 外联结

- 与内联结关联两个表中的行不同的是，外联结还包括没有关联行的行
- 在使用OUTER JOIN语法时，必须使用RIGHT或LEFT关键字指定包括其所有行的表
- 左外联结和右外联结，它们之间的唯一差别是所关联的表的顺序
- SQLite支持 `LEFT OUTER JOIN`，但不支持 `RIGHT OUTER JOIN`

``` sql
SELECT
	Customers.cust_id,
	Orders.order_num 
FROM
	Customers
	LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;
```


## UNION 组合查询

- 合并多个查询结果返回
- 使用场景
    - 在一个查询中从不同的表返回结构数据
    - 对一个表执行多个查询，按一个查询返回数据
- `UNION` 中的每个查询必须包含相同的列、表达式或聚集函数（不过，各个列不需要以相同的次序列出）
- `UNION` 从查询结果集中自动去除了重复的行，除非使用 `UNION ALL` 则不取消重复的行
- 只能使用一条 `ORDER BY` 子句，它必须位于最后一条 `SELECT` 语句之后

``` sql
SELECT
	cust_name,
	cust_contact,
	cust_email 
FROM
	Customers 
WHERE
	cust_state IN ( 'IL', 'IN', 'MI' ) UNION
SELECT
	cust_name,
	cust_contact,
	cust_email 
FROM
	Customers 
WHERE
	cust_name = 'Fun4All';
```