# 博客网站部署


## Github Pages

在 [Github](https://github.com/) 托管项目，注意项目必须是 public，并开启 Pages 服务。

目前了解到是最近方便的托管平台了，注册免费，创建仓库免费，Pages 可以免费绑域名和开通 https；也提供了模板生成静态文件。

其他可选的托管平台

- [readthedocs](https://readthedocs.org/) 还没有试过，看介绍好像会放广告进去，除非升级会员，可以绑定 github，但是要设置提交钩子。
- [gitee](https://gitee.com/) 国内是比较快，开通需要身份认证；普通免费会员限制很多，例如提交后要到管理后台手动点击更新，不能绑定域名，不能放广告等等。


## 域名绑定

1. 域名添加 `CNAME` 解析到 `xxx.github.io` {>>我是同时加了www.pytask.com和pytask.com两个解析，当时只加了www好像不行，又加了一个就行了，也不排除是DNS解析域名延迟<<}
2. `Github Pages` 访问的目录下放一个 `CNAME` 的文件，写上域名 `www.pytask.com`，这个文件只能写一个域名，所以文件要先提交上去。
3. `Github Pages` 后台设置 `Custom domain`，设置了 `www.pytask.com`，等待 DNS 检查通过之后再勾上 `Enforce HTTPS`。


## MkDocs

`Github Pages` 提供了 [Jekyll](https://jekyllrb.com/)，相当于只提交 `*.md` 文件就可以直接渲染静态网页。但本地还是要调试检查效果的，由于只对 `Python` 环境比较熟悉，所以就选了 [MkDocs](https://www.mkdocs.org/)。命令其实也就几个，根本都不需要熟悉 `Python`。而且使用很简单，只要启动服务，改动内容浏览器就会刷新（连刷新键都不要按）。

由于 `Github Pages` 上传解析目录只有 `/` 和 `/docs` 两个目录选择，所以我将默认 `MkDocs` 的路径做了调整。将生成的路径改为 `docs`。

```yaml title="mkdocs.yml"
docs_dir: source # 原来是 docs，用来放 md 文件
site_dir: docs # 原来是 site，用来生成 html 资源文件
```


## Material for MkDocs

`MkDocs` 很好用，但是功能也比较简单，所以大部分网站都使用 [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) 这个模板。功能确实丰富了很多，但有少量新功能也是需要付费会员才能使用的。


## 资源网站

- [快捷键显示](https://facelessuser.github.io/pymdown-extensions/extensions/keys/#extendingmodifying-key-map-index)