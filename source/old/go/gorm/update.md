# 更新


## Save

`Save` 会将全部字段更新，即便字段是零值

``` go linenums="1"
var p product
p.ID = 1
p.Name = "product_AAA"
db.Save(&p)
```


## Update

`Update` 会更新指定某一字段

``` go linenums="1"
var p product
p.ID = 1	
db.Model(&p).Update("Name", "product_Axx3")
```


## Updates

- 参数如果是结构体，结构体内零值不会更新
- 参数如果是 `map`，零值也会被更新

``` go linenums="1"
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


## Select & Omit

可以结合 `Select` 和 `Omit` 指定或忽略某些字段更新

``` go linenums="1"
var p product
p.ID = 1
// 结构体的零值同样可以使用 Select 强制作为更新字段
db.Model(&p).Select("Name", "Price").Updates(
	product{
		Name:  "product_A",
		Price: 0,
	},
)
```


## 跳过勾子以及时间追踪

- `UpdateColumn` 方法与 `Update` 类似，但可以跳过勾子以及时间追踪
- `UpdateColumns` 方法与 `Updates` 类似，但可以跳过勾子以及时间追踪