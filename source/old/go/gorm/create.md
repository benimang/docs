# 创建


## 创建单个记录

``` go linenums="1" hl_lines="5"
p := product{
	Name:  "product_x",
	Price: 99,
}
result := db.Create(&p)

fmt.Println(
	p.ID,                // 创建记录的主键
	result.Error,        // 如果执行没错，这里是 nil
	result.RowsAffected, // 插入记录的条数
)
```


## 创建单个记录（指定字段）

``` go linenums="1" hl_lines="5-6 12-13"
p1 := product{
	Name:  "product_1",
	Price: 99,
}
// 指定需要的字段
db.Select("Name").Create(&p1)

p2 := product{
	Name:  "product_2",
	Price: 99,
}
// 指定忽略的字段
db.Omit("Name").Create(&p2)
```


## 批量创建记录

``` go linenums="1"
productAry := [3]product{
	{Name: "product_3", Price: 98},
	{Name: "product_4", Price: 98},
	{Name: "product_5", Price: 98},
}
db.Create(&productAry)
```


## 根据 Map 创建

``` go linenums="1" hl_lines="1-3 5 11"
// 只会添加指定的字段（created_at / update_at 都不会添加）
// 官网文档介绍不会自动填充主键，但是 sqlite 试过自增主键可以
// 官网文档介绍不会处理 association
db.Model(&product{}).Create(
	map[string]interface{}{
		"Name":  "product_6",
		"Price": 97,
	},
)

// 批量操作在 sqlite 尝试过无法使用，不确定 mysql 是否正常
// db.Model(&product{}).Create(
// 	[]map[string]interface{}{
// 		{"ID": 21, "Name": "product_7", "price": 97},
// 		{"ID": 22, "Name": "product_8", "price": 97},
// 		{"ID": 23, "Name": "product_9", "price": 97},
// 	},
// )
```


## upsert

``` go linenums="1" hl_lines="8-14 20-24 30-37 43-51"
p := product{
	Name:  "product_xx",
	Price: 105,
}
p.ID = 1

db.Clauses(
	// 定义冲突时的处理逻辑
	clause.OnConflict{
		// 指定冲突的条件
		Columns: []clause.Column{{Name: "ID"}},
		// 发生冲突时什么都不做
		DoNothing: true,
	},
).Create(
	&p,
)

db.Clauses(
	// 发生冲突时，更新主键以外的所有值
	// 结构体中不定义的值也会使用零值更新到数据库
	clause.OnConflict{
		UpdateAll: true,
	},
).Create(
	&p,
)

db.Clauses(
	// 发生冲突时，只更新指定的字段
	clause.OnConflict{
		DoUpdates: clause.AssignmentColumns(
			[]string{
				"Name",
			},
		),
	},
).Create(
	&p,
)

db.Clauses(
	// 发生冲突时，指定要更新的字段和值
	clause.OnConflict{
		DoUpdates: clause.Assignments(
			map[string]interface{}{
				"Name":  "product_yyyyy",
				"Price": 997,
			},
		),
	},
).Create(
	&p,
)
```