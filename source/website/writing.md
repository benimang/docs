# 内容编辑





## 标题

- `# 一级标题`
- `## 二级标题`
- `### 三级标题`
- `#### 四级标题`
- `##### 五级标题`
- `###### 六级标题`

!!! warning    
    在 mkdocs-material 的样式中，四级标题有加粗效果，感觉不太好，不建议使用。

!!! warning    
    markdown 标准定义文字底部加 `===` 表示一级标题，文字底部加 `---` 表示二级标题，阅读性很差，不建议使用。





## 文字格式化





### 粗体和斜体

===! "表现效果"
    - **粗体**
    - *斜体*

=== "Markdown"
    ```markdown
    **粗体**
    *斜体*
    ```

!!! warning
    markdown 标准定义中支持以下划线 `_` 代替 `*` 实现粗体和斜体，但并不建议。





### Caret Mark Tilde

===! "表现效果"
    - ==This was marked==
    - ^^This was inserted^^
    - ~~This was deleted~~

=== "Markdown"
    ```md
    ==This was marked==
    ^^This was inserted^^
    ~~This was deleted~~
    ```

=== "mkdocs.yml"
    ```yaml
    markdown_extensions:
      - pymdownx.mark
      - pymdownx.caret
      - pymdownx.tilde
    ```

!!! quote
    <https://squidfunk.github.io/mkdocs-material/reference/formatting/#highlighting-text>{:target="_blank"}





### Critic Markup

===! "表现效果"
    - `{--deleted--}`
    - `{++added++}`
    - `{~~deleted~>added~~}`
    - `{==highlighting==}`

=== "Markdown"
    ```md
    {--deleted-- }
    {++added++ }
    {~~deleted~>added~~ }
    {==highlighting== }
    ```

=== "mkdocs.yml"
    ```yaml
    markdown_extensions:
      - pymdownx.critic
    ```

!!! tip    
    这个语法在块中也可以使用。

!!! quote
    <https://squidfunk.github.io/mkdocs-material/reference/formatting/#highlighting-changes>{:target="_blank"}





### 键盘按键

===! "表现效果"
    - ++ctrl+alt+del++
    - ++alt+f4++

=== "Markdown"
    ```md
    ++ctrl+alt+del++
    ++alt+f4++
    ```

=== "mkdocs.yml"
    ```yaml
    markdown_extensions:
      - pymdownx.keys
    ```

!!! quote
    <https://facelessuser.github.io/pymdown-extensions/extensions/keys/#extendingmodifying-key-map-index>{:target="_blank"}



