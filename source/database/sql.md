# SQL 基本语法

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

