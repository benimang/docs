# 研发后台

## 更新注意事项
- 涉及到从 `kafka` 拉去数据的改动，需要修改数据表 `basic_config` 里面的字段 `is_stop_load_data_kafak=1` ，触发重启，否则更新无效果
- 涉及到 `kafka` 里面用到的 `topic` 不能随意添加，需要 `kafka` 后台添加（目前在 `xcp-api` 项目里的 `setting.yaml` 配置有用到）
- 新增其他游戏研发后台，前端项目需要新建环境变量文件（如： `.env.xcll` 和 `.env.xcll_demo` ），在 `package.json` 的 `scripts` 里添加对应的打包命令
- 涉及到以下文件的改动，是不会同步到服务器上打包，需要在服务器上直接改动
    - `xcp-vue/vue.config.js`
    - `xcp-server/config/*`
    - `xcp-server/**/*.yaml`
    - `xcp-api/**/*.yaml`
    - `xcp-dcs/local/classes/config.php`

