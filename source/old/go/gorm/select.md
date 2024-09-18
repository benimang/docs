# 查询


## 查询单个

``` go linenums="1" hl_lines="4 5 8 9 12 13"
var p product

p = product{}
// 默认加上主键的升序，取第一个
db.First(&p)

p = product{}
// 默认加上主键的降序，取第一个
db.Last(&p)

p = product{}
// 不会添加默认的任何排序，取第一个
db.Take(&p)
```


## 查询全部

``` go linenums="1" hl_lines="2"
var pAry = []product{}
db.Find(&pAry)
```


## 内联条件

提供给 `Find` `Take` `First` `Last` 便捷设置条件的方式

``` go linenums="1"
var p product
var pAry = []product{}

p = product{}
db.Take(&p, 3)

pAry = []product{}
db.Find(&pAry, []int{1, 3, 5})

pAry = []product{}
db.Find(&pAry, "price NOT IN (?)", []int{77, 73})

pAry = []product{}
db.Find(&pAry, "price BETWEEN ? and ?", 85, 95)
```


## Select & Omit

``` go linenums="1"
p := product{}
db.Select("ID", "Name").Take(&p)

p = product{}
db.Omit("Star").Take(&p)
```


## Where

``` go linenums="1"
var p product
var pAry = []product{}

p = product{}
db.Where(3).Take(&p)

pAry = []product{}
db.Where([]int{1, 3, 5}).Find(&pAry)

pAry = []product{}
db.Where("price Not in (?)", []int{77, 73}).Find(&pAry)

pAry = []product{}
db.Where("price BETWEEN ? AND ?", 85, 95).Find(&pAry)
```


## Or

``` go linenums="1"
var pAry = []product{}

pAry = []product{}
db.Where(
	"ID > ?", 3,
).Or(
	"Price > ?", 90,
).Find(
	&pAry,
)

// 条件嵌套使用，可以写出复杂的查询条件
pAry = []product{}
db.Where(
	db.Where("ID > ?", 3).Where("Price > ?", 80),
).Or(
	db.Where("ID > ?", 5).Or("Price > ?", 90),
).Find(&pAry)
fmt.Printf("productAry: %v\n", pAry)
```


## Not

``` go linenums="1"
var pAry = []product{}

pAry = []product{}
db.Not([]uint{3, 5, 7, 9}).Find(&pAry)

pAry = []product{}
db.Not("Price BETWEEN ? AND ?", 80, 90).Find(&pAry)
```


## Count

``` go linenums="1"
var n int64
db.Model(&product{}).Count(&n)
```


## Order

``` go linenums="1"
var pAry []product

pAry = []product{}
db.Order("Price Desc").Find(&pAry)

pAry = []product{}
db.Order("Price Desc").Order("Name").Find(&pAry)
```


## Limit & Offset

``` go linenums="1"
pAry := []product{}
db.Offset(5).Limit(2).Find(&pAry)
```


## Distinct

``` go linenums="1"
pAry := []product{}
db.Distinct("Price").Find(&pAry)
```


## Group & Having

``` go linenums="1"
type pInfo struct {
	Star  uint
	Count uint
}

pInfoAry := []pInfo{}

db.Model(&product{}).Select(
	"Star, COUNT(*) as Count",
).Group(
	"Star",
).Having(
	"Count >= ?", 3,
).Find(&pInfoAry)
```


## Raw & Scan

`Scan` 可以将查询结果赋值到结构体

``` go linenums="1"
type pInfo struct {
	Star  uint
	Count uint
}

pInfoAry := []pInfo{}

db.Raw(
	"SELECT Star, COUNT(*) as Count FROM products GROUP BY Star Having Count >= 3",
).Scan(
	&pInfoAry,
)
```


## 查询结果解析到映射（map）

``` go linenums="1"
var m map[string]interface{}
db.Model(&product{}).Take(&m)

var mAry []map[string]interface{}
db.Model(&product{}).Find(&mAry)
```


## 子查询

``` go linenums="1"
pAry := []product{}
db.Where(
	"Price > (?)",
	db.Model(&product{}).Select("AVG(price)"),
).Find(&pAry)
```


## FirstOrInit

- 根据条件查找记录，如果找到就返回记录
- 如果没有找到记录，就会使用 `Attrs` 定义的数据赋值初始化
- 无论如何都不会对数据执行写入操作

``` go linenums="1"
p := product{
	Name: "product_AA",
}
db.Where(p).Attrs(product{Star: 9}).FirstOrInit(&p)
```


## FirstOrCreate

- 根据条件查找记录，如果找到就返回记录
- 如果没有找到记录，就会数据库写入一条记录，并且会实则这只 `Attrs` 指定的数值

``` go linenums="1"
p := product{
	Name: "product_AA",
}
db.Where(p).Attrs(product{Star: 9}).FirstOrCreate(&p)
```


## Pluck

获取单列数据

``` go linenums="1"
var starAry []uint

db.Model(&product{}).Pluck("Star", &starAry)

db.Model(&product{}).Distinct("Star").Order("Star DESC").Pluck("Star", &starAry)
```