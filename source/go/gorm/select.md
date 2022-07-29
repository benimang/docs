# 查询


## 单个查询

```go
var product Product

// 默认加上主键的升序，取第一个
product = Product{}
db.First(&product)

// 默认加上主键的降序，取第一个
product = Product{}
db.Last(&product)

// 不会添加默认的任何排序，取第一个
product = Product{}
db.Take(&product)
```