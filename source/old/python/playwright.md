# playwright

## 恢复登录状态

使用 `storage_state` 可以恢复登录状态

``` py linenums="1"
# 登录后存储状态
storage = context.storage_state(path="state.json")

# 使用之前存储的状态
context = browser.new_context(storage_state="state.json")
```

还可以使用其他方法恢复登录状态

- 模拟登录操作（如：输入用户名和密码，然后点击登录）
- 利用恢复 `session storage` 
- Multi-factor authentication (MFA) 

!!! quote
    <https://playwright.dev/python/docs/auth#automate-logging-in>



## 使用 Chrome 浏览器

默认使用 `Chromium` 但是某些特殊情况需要使用原生的 `Chrome` 替代，例如视频编码。

``` py linenums="1"
playwright.chromium.launch(channel="chrome")
```


## CSS 选择器

页面上要获取某个元素，用到 `CSS Selector` 没有必要纯手写。

`Chrome 开发者工具` 页面上 ++ctrl+shift+c++ 定位到想要的元素，或者 `Elements` 页签找到对应的元素，右键选择 `Copy selector`。


## 获取元素

### locator

使用 `#!py page.locator` 传入 `selector` 参数；无论找到多少个匹配的元素，都会返回 `Locator` 对象，`#!py locator.count()` 可以获取数量，`#!py locator.nth(...)` 可以获取指定某个元素。

大部分操作其实都可以不用直接获取元素，比如想获取文本，可以直接用 `#!py page.inner_text(...)`

!!! quote
    <https://playwright.dev/python/docs/api/class-locator>

### Element Handles

!!! warning
    新版本已经警告不要使用，要求使用 `locator` 替代；其中一个原因是说，如果定位到元素后，元素可能会发生改变，这个时候 `locator` 会自动处理。


## 处理新打开页面

!!! quote
    <https://playwright.dev/python/docs/pages#handling-new-pages>

!!! tips
    注意两种方式都要执行等待加载 `wait_for_load_state()`

### context.expect_page

``` py linenums="1"
with context.expect_page() as new_page_info:
    page.click('a[target="_blank"]') # Opens a new tab
new_page = new_page_info.value

new_page.wait_for_load_state()
print(new_page.title())
```

### context.on

``` py linenums="1"
def handle_page(page):
    page.wait_for_load_state()
    print(page.title())

context.on("page", handle_page)
```