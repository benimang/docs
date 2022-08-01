# 删除


## Delete

```go
var p product
p.ID = 1
db.Delete(&p)

db.Delete(&product, 2)

db.Where("Price > ?", 80).Delete(&product{})
```


## Returning 

针对支持 `Returning` 的数据库，可以实现删除并返回

```go
var p product
db.Clauses(clause.Returning{}).Delete(&p, 3)
```

