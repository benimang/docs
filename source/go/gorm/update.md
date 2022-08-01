# 更新


## Save

`Save` 会将全部字段更新，即便字段是零值

```go
var p product
p.ID = 1
p.Name = "product_AAA"
db.Save(&p)
```


## Update

`Update` 会更新指定某一字段

```go
var p product
p.ID = 1	
db.Model(&p).Update("Name", "product_Axx3")
```


## Updates

- 参数如果是结构体，结构体内零值不会更新
- 参数如果是 `map`，零值也会被更新

```go
var p product
p.ID = 1
// 以结构体形式调用 Updates 方法，结构体内零值不会更新
db.Model(&p).Updates(
	product{
		Name:  "product_Axx3xx!",
		Price: 0,
	},
)

// 以映射 map 方式调用 Updates 方法，可以将所有即便零值更新
db.Model(&p).Updates(map[string]interface{}{
	"Name":  "product_Axx3xx!!",
	"Price": 0,
})
```