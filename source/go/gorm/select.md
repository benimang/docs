# 查询


## 查询单个

```go hl_lines="4 5 8 9 12 13"
var product Product

product = Product{}
// 默认加上主键的升序，取第一个
db.First(&product)

product = Product{}
// 默认加上主键的降序，取第一个
db.Last(&product)

product = Product{}
// 不会添加默认的任何排序，取第一个
db.Take(&product)
```


## 查询全部

```go hl_lines="2"
var products = []Product{}
db.Find(&products)
// SELECT * FROM `products` WHERE `products`.`deleted_at` IS NULL
```


## 内联条件

提供给 `Find` `Take` `First` `Last` 便捷设置条件的方式

```go
var product Product
var productAry = []Product{}

product = Product{}
db.Take(&product, 3)

productAry = []Product{}
db.Find(&productAry, []int{1, 3, 5})

productAry = []Product{}
db.Find(&productAry, "price NOT IN (?)", []int{77, 73})

productAry = []Product{}
db.Find(&productAry, "price BETWEEN ? and ?", 85, 95)
```


## where

```go
var product Product
var productAry = []Product{}

product = Product{}
db.Where(3).Take(&product)

productAry = []Product{}
db.Where([]int{1, 3, 5}).Find(&productAry)

productAry = []Product{}
db.Where("price Not in (?)", []int{77, 73}).Find(&productAry)

productAry = []Product{}
db.Where("price BETWEEN ? AND ?", 85, 95).Find(&productAry)
```