# 创建记录


## 创建记录

```go hl_lines="5"
product := Product{
	Name:  "product_x",
	Price: 99,
}
result := db.Create(&product)
// INSERT INTO `products` (`created_at`,`updated_at`,`deleted_at`,`name`,`price`) VALUES ("2022-07-28 19:35:58.379","2022-07-28 19:35:58.379",NULL,"product_x",99) RETURNING `id`
fmt.Println(
	product.ID,          // 创建记录的主键
	result.Error,        // 如果执行没错，这里是 nil
	result.RowsAffected, // 插入记录的条数
)
```


## 创建记录（指定字段）

```go hl_lines="5-6 13-14"
p1 := Product{
	Name:  "product_1",
	Price: 99,
}
// 指定需要的字段
db.Select("Name").Create(&p1)
// INSERT INTO `products` (`created_at`,`updated_at`,`name`) VALUES ("2022-07-28 19:42:24.444","2022-07-28 19:42:24.444","product_x") RETURNING `id`

p2 := Product{
	Name:  "product_2",
	Price: 99,
}
// 指定忽略的字段
db.Omit("Name").Create(&p2)
// INSERT INTO `products` (`created_at`,`updated_at`,`deleted_at`,`price`) VALUES ("2022-07-28 19:46:09.891","2022-07-28 19:46:09.891",NULL,99) RETURNING `id`
```


## 批量创建记录

```go
productAry := [3]Product{
	{Name: "product_3", Price: 98},
	{Name: "product_4", Price: 98},
	{Name: "product_5", Price: 98},
}
db.Create(&productAry)
```