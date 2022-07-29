# 基础


## 测试用例

```go hl_lines="29-30 36-39 41-42"
package gormDemo

import (
	"math/rand"
	"os/user"
	"time"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

type product struct {
	gorm.Model
	Name  string
	Price uint
	Star  uint `gorm:"default:1"`
}

var db *gorm.DB

func Run() {

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
		&product{},
	)

	// 开启调试模式用于打印 sql 语句
	db = db.Debug()

	// 随机种子
	rand.Seed(time.Now().UnixNano())

	// 创建用于测试的记录
	{
		var n int64
		db.Model(&product{}).Count(&n)
		if n == 0 {
			var ptrProductAry [10]*product
			n := len(ptrProductAry)
			for i := 0; i < n; i++ {
				p := new(product)
				p.Name = "product_" + string(rune(65+i))
				p.Price = uint(70 + rand.Intn(30))
				p.Star = uint(1 + rand.Intn(5))
				ptrProductAry[i] = p
			}
			db.Create(ptrProductAry)
		}
	}

	// 开始测试
	runTry()
}

func runTry() {
	// todo...
}
```
