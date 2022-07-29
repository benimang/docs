# 查询


## 单个查询

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