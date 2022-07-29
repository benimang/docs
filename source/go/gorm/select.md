# 查询


## 查询单个

```go hl_lines="4 5 8 9 12 13"
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

```go hl_lines="2"
var pAry = []product{}
db.Find(&pAry)
```


## 内联条件

提供给 `Find` `Take` `First` `Last` 便捷设置条件的方式

```go
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


## Where

```go
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

```go
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

```go
var pAry = []product{}

pAry = []product{}
db.Not([]uint{3, 5, 7, 9}).Find(&pAry)

pAry = []product{}
db.Not("Price BETWEEN ? AND ?", 80, 90).Find(&pAry)
```


## Count

```go
var n int64
db.Model(&product{}).Count(&n)
```


## Order

```go
var pAry []product

pAry = []product{}
db.Order("Price Desc").Find(&pAry)

pAry = []product{}
db.Order("Price Desc").Order("Name").Find(&pAry)
```