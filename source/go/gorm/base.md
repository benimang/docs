# 基础


## 测试用例

```go hl_lines="32-33 39-42 44-45"
package main

import (
	"math/rand"
	"os/user"
	"time"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

type Product struct {
	gorm.Model
	Name  string
	Price uint
}

func (p Product) print() {
	fmt.Printf("Product:{ID:%v Name:%v, Price:%v}\n", p.ID, p.Name, p.Price)
}

var db *gorm.DB

func main() {

	u, err := user.Current()
	if err != nil {
		panic(err)
	}

	dbFile := u.HomeDir + "/Desktop/test.db"
	// 数据库链接
	_db, err := gorm.Open(sqlite.Open(dbFile), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	db = _db

	// 迁移 schema
	db.AutoMigrate(
		&Product{},
	)

	// 开启调试模式用于打印 sql 语句
	db = db.Debug()

	// 随机种子
	rand.Seed(time.Now().UnixNano())

	// 创建用于测试的记录
	{
		var n int64
		db.Model(&Product{}).Count(&n)
		if n == 0 {
			var ptrProductAry [10]*Product
			n := len(ptrProductAry)
			for i := 0; i < n; i++ {
				p := new(Product)
				p.Name = "product_" + string(rune(65+i))
				p.Price = uint(70 + rand.Intn(30))
				ptrProductAry[i] = p
			}
			db.Create(ptrProductAry)
		}
	}

	goTest()
}

func goTest() {

}

```


## 获取表的记录数量


```go
var n int64
db.Model(&Product{}).Count(&n)
```