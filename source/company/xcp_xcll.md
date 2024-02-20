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


## SVN
- 前端和后端 `svn://192.168.1.148:11002/xcp_sdk/xcp-admin-xcll`
- API（多项目通用） `svn://192.168.1.148:11002/xcp_sdk/xcp-api`
- DCS（多项目通用） `svn://192.168.1.148:11002/xcp_sdk/xcp-dcs`


## 数据库链接
| 测试后台      | 正式后台      |
| ------------- | ------------- |
| 192.168.1.153 | 192.168.2.101 |
| 3306          | 3307          |
| xcp_xcll_data | xcp_xcll_data |
| xcp_xcll_log  | xcp_xcll_log  |
| xcp_xcll_site | xcp_xcll_site |


## 网址
- 测试后台 <http://xcp-xcll-demo.fire2333.com>
- 正式后台 <https://xcp-xcll-admin.fire233.com>


## 账号密码资料（beni crypto）
```
gAAAAZiu6p1ujewmuFdbBPmgaJ1XMK02nXlFwjdzeD5iQeST7WfDvxnkeCJNnrOhnGLNoj7k81f0AAmpZaC4ZOVw6pimbF7364Q2VlYP6dn9wfpqZpIEvpR9amxF-prnq7I6Wg3NoQVdkXv8XNaDiSW2vIt4sAd_Lo6rw_gN-NVAbJwG3M9_lOEc7jtv-RV70YCzlarMx3bbqfJQXydjpLAuulXpkwaEamhJTA50ej-AQjYQIzBhpZg9NcPrGdSTJP0wgwlByUBqpcGr2FZOEYushI6DNfebcd4724bcc4655ABl1EayMD_m2o1hSTWwvvWVeqBQCC1G5dH4-q5LqHC6WFEj829weQygQdzRcqs_lztDyN4TFxyXaHJjCJkhfmsFewpChdY0ifDmYtjg11Z19_nz-9au91T7A9Oi-2-GTKFerUfmectkqRHclWZNrRthgsu-z4CAWs5llRk7CnYd4313E4F3Htbg-4Nwlz_fMeOXyLV0Yl1ues3ZAYQ7Uq8aG7Gn9MozQw9A8zBO7bRjIooIFvgzj2C5gkG6VfAaEjzvQUnT9CnVW7cKOYfqvpdnpL0=27033f17f23b7831f
```