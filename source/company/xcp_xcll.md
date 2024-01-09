# 研发后台（消除来了）


## 更新

### 测试后台
- 后端 `sh /opt/www/scripts/game/demo/rsync_go_game_xcll_admin.sh`
- 前端 `sh /opt/www/scripts/game/demo/rsync_vue_game_xcll_admin.sh`
- API `sh /opt/www/scripts/game/demo/rsync_xcp_api.sh`
- DCS `sh /opt/www/scripts/game/demo/rsync_xcp_dcs.sh`

### 正式后台
- 后端 `sh /opt/www/scripts/game/xcll/rsync_go_game_admin.sh`
- 前端 `sh /opt/www/scripts/game/xcll/rsync_vue_game_admin.sh`
- API `sh /opt/www/scripts/game/xcll/rsync_xcp_api.sh`
- DCS `sh /opt/www/scripts/game/xcll/rsync_xcp_dcs.sh`


## 数据库链接
| 测试后台      | 正式后台      |
| ------------- | ------------- |
| 192.168.1.153 | 192.168.2.101 |
| 3306          | 3307          |
| xcp_xcll_data | xcp_xcll_data |
| xcp_xcll_log  | xcp_xcll_log  |
| xcp_xcll_site | xcp_xcll_site |


## 账号密码资料（beni pwd）
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdGV4dF9BIUAkLEZKQCNhZHNma2wiOiJcdTZkNGJcdThiZDVcdTU0MGVcdTUzZjBcdTY1NzBcdTYzNmVcdTVlOTNcclxuaG9zdDogMTkyLjE2OC4xLjE1M1xyXG5wb3J0OiAzMzA2XHJcbnVzZXI6IGNwZGF0YW15c3FsdVxyXG5wYXNzOiB4Y3Byb290QGxteVxyXG5cclxuXHJcblx1NmI2M1x1NWYwZlx1NTU1ZTkzXHJcbmhvc3Q6IDE5Mi4xNjguMi4xMDFcclxucG9ydDogMzMwN1xyXG51c2VyOiB4Y2xsbXlzcWxcclxucGFzczogeGNsbEBteXhjcDEzNjIiLCJfc2FsdF9AIyVAI3hhZkRHQXoubnEiOiI4NjVjNTJmMy02ZDEwLTRhM2QtOTFjZi03OTM3OWNlMmFmZmYifQ.rT0mL-eoamZrMtk6feKtghjQSN_-2QnJZIXnNCGsSz0QwZVx1NTNmMFx1NjU3MFx1NjM2ZVx1NWU5M1x1ZmYwOFx1NTNlYVx1OGJmYlx1ZmYwOVxyXG5ob3N0OiAxOTIuMTY4LjIuMTAxXHJcbnBvcnQ6IDMzMDdcclxudXNlcjogeGNsbG15c3FscmVhZFxyXG5wYXNzOiB4Y2xsQHJlYWQxMzYyXHJcblxyXG5cclxuXHU2YjYzXHU1ZjBmXHU1NDBlXHU1M2YwXHU2NTcwXHU2MzZlXH
```