## 更新注意事项

- 涉及到从 `kafka` 拉去数据的改动，需要修改数据表 `basic_config` 里面的字段 `is_stop_load_data_kafak=1` ，触发重启，否则更新无效果
- 涉及到 `kafka` 里面用到的 `topic` 不能随意添加，需要 `kafka` 后台添加（目前在 `xcp-api` 项目里的 `setting.yaml` 配置有用到）
- 新增其他游戏研发后台，前端项目需要新建环境变量文件（如：`.env.xcll` 和 `.env.xcll_demo` ），在 `package.json` 的 `scripts` 里添加对应的打包命令
- 涉及到以下文件的改动，是不会同步到服务器上打包，需要在服务器上直接改动
    - `xcp-vue/vue.config.js`
    - `xcp-server/config/*`
    - `xcp-server/**/*.yaml`
    - `xcp-api/**/*.yaml`
    - `xcp-dcs/local/classes/config.php`


## Server DAO

1. `xcp-server/config/config.yaml` 文件最下面的一段注释打开，修改服务器链接、表明、分组信息
2. `gf gen dao` 执行命令行生成


## 搭建步骤

1. 定义游戏名称（用在分支名称以及数据库名称）
2. 创建分支 `xcp-admin-xxx`（前后端代码）
3. 本地项目切换到新的分支
4. `xcp-vue` 修改 `package.json` 和 `package-lock.json` （确保使用 `hssh` 或 `xcll` 的版本）
5. `xcp-vue` 整理打包环境变量文件，将不需要用到的删除（`.env.xxx`）
6. `xcp-vue` `.env.development` 文件确保要保留修改成里面的名称
7. `xcp-vue` 整理打包脚本（修改 `package.json` 里面的 `build:xxx`）
8. `xcp-server` 本地后端使用新的数据库地址（`config/config/yaml`）
9. 测试本地是否能正常启动前后端访问
10. 检查定时器是否正常设置并启动 `crontab -l` （192.168.1.153）
11. 检查定时器运行的输出目录是否存在（如果目录不存在会导致执行失败）
12. 检查测试后台 api post 能否正常请求将数据入库
13. 检查正式后台 api post 能否正常请求将数据入库
14. 将 `cp_api_url_config` 里面的 bas`e_url 都改成不存在的域名，避免误请求数据
15. 将测试数据库中的 `data` 库克隆到正式数据库中
16. 检查测试后台网址是否能正常进入
17. 检查正式后台网址是否能正常进入
18. 将测试数据库中的不需要用到的内容都删除
19. 检查测试后台的前后端打包，以及 `dcs` 以及 `api` 打包是否正常
20. 检查正式后台的前后端打包，以及 `dcs` 以及 `api` 打包是否正常


## 查看 kafka 接收信息

1. 登录远程机器 `192.168.1.153`
2. 进入目录 `/opt/www/kafka-test`
3. 修改文件 `main.go` 修改
    - `groupID` 
    - `logTypeFilter` 
    - `gameKeyFilter` 
    - `readOrder` 
    - `maxMessages`
5. 执行查询 `go run main.go`