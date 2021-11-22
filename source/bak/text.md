# 文字效果





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





## 粗体 / 斜体

===! "表现效果"
    - **粗体**
    - *斜体*

=== "Markdown"
    ``` md
    **粗体**
    *斜体*
    ```

!!! warning
    markdown 标准定义中支持以下划线 `_` 代替 `*` 实现粗体和斜体，但并不建议。





## 高亮 / 删除 / 下划

===! "表现效果"
    - ==pymdownx.mark==
    - ~~pymdownx.tilde~~
    - ^^pymdownx.caret^^

=== "Markdown"
    ``` md
    ==pymdownx.mark==
    ~~pymdownx.tilde~~
    ^^pymdownx.caret^^
    ```

=== "mkdocs.yml"
    ``` yaml
    markdown_extensions:
      - pymdownx.mark
      - pymdownx.caret
      - pymdownx.tilde
    ```

!!! quote
    <https://squidfunk.github.io/mkdocs-material/reference/formatting/#highlighting-text>{:target="_blank"}





## Critic Markup

===! "表现效果"
    - {--deleted--}
    - {++added++}
    - {~~deleted~>added~~}
    - {==highlighting==}
    - {>>comments<<}

=== "Markdown"
    ``` md
    # 注意：右花括号前面的空白不需要
    {--deleted-- }
    {++added++ }
    {~~deleted~>added~~ }
    {==highlighting== }
    {>>comments<< }
    ```

=== "mkdocs.yml"
    ``` yaml
    markdown_extensions:
      - pymdownx.critic
    ```

!!! tip
    这个插件在块中也可以正常展示。

!!! quote
    <https://squidfunk.github.io/mkdocs-material/reference/formatting/#highlighting-changes>{:target="_blank"}





## 上标 / 下标

===! "表现效果"
    - A^T^A
    - H~2~0

=== "Markdown"
    ``` md
    A^T^A
    H~2~0
    ```





## 键盘按键

===! "表现效果"
    - ++ctrl+alt+del++
    - ++alt+f4++

=== "Markdown"
    ``` md
    ++ctrl+alt+del++
    ++alt+f4++
    ```

=== "mkdocs.yml"
    ``` yaml
    markdown_extensions:
      - pymdownx.keys
    ```

!!! quote
    <https://facelessuser.github.io/pymdown-extensions/extensions/keys/#extendingmodifying-key-map-index>{:target="_blank"}

