# 删除


## Delete

``` go linenums="1"
var p product
p.ID = 1
db.Delete(&p)

db.Delete(&product, 2)

db.Where("Price > ?", 80).Delete(&product{})
```


## Returning 

针对支持 `Returning` 的数据库，可以实现删除并返回

``` go linenums="1"
var p product
db.Clauses(clause.Returning{}).Delete(&p, 3)
```


## 软删除

`Gorm` 支持的特性，数据记录删除时间，但并不真正删除

可以使用 `gorm.Model` 或 手动添加 `DeletedAt DeletedAt` 就可以实现

使用 `Unscoped` 可以忽略软删除操作数据

``` go linenums="1"
var pAry []product

db.Unscoped().Find(&pAry)
// SELECT * FROM `products`

db.Find(&pAry)
// SELECT * FROM `products` WHERE `products`.`deleted_at` IS NULL
```