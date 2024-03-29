# vscode

## 常用插件

- `Python` 
- `Pylance` 语言服务器，其中 `typing` 需要这个的支持
- `Markdown All in One`
- `YAML`

## Unity 开发常用插件

- `Unity Tools`
- `Unity Code Snippets`
- `Debugger for Unity`
- `C#`
- `C# XML Documentation Comments`
- `Auto-Using for C#`

## setting.json 工作环境常用配置

``` json
{
    "workbench.editor.enablePreview": false,
    "breadcrumbs.enabled": false,  // 代码顶部导航
    "explorer.autoReveal": false,  // 取消文件自动定位跟踪
    "python.linting.flake8Enabled": false,
    "editor.renderWhitespace": "none",
    "files.eol": "\n",    
    "python.formatting.provider": "autopep8",
    "python.formatting.autopep8Args": [
        "--ignore=E501"  // 换行格式化
    ],

    // typing 语法检查
    "python.languageServer": "Pylance",
    "python.analysis.diagnosticMode": "workspace",  // 检查整个workspace
    "python.analysis.typeCheckingMode": "strict",
    "python.analysis.diagnosticSeverityOverrides": {
        "reportMissingTypeStubs": "none",
        "reportUnknownMemberType": "none",
        "reportUnknownParameterType": "none",
        "reportUnknownVariableType": "none",
        "reportUnknownArgumentType": "none",
        // "reportUnusedCallResult": "warning",
        "reportUnusedClass": "warning",
        "reportUnusedCoroutine": "warning",
        "reportUnusedFunction": "warning",
        "reportUnusedImport": "warning",
        "reportUnusedVariable": "warning",
        "reportImportCycles": "warning",
    },

    // pytest
    "python.testing.pytestArgs": [
        "test",
        "-s",
    ],
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": true,

    // 开发环境下不显示指定文件
    "files.exclude": {
        "**/__pycache__": true,
        ".gitignore": true,
        ".pytest_cache": true,
        "publish.bat": true,
        "setup.py": true,
        "beniutils.egg-info": true,
        "dist": true,
        "build": true,
        "MANIFEST.in": true,
        "README.md": true,
    },
}
```

## setting.json 用户常用配置

``` json
{
    "security.workspace.trust.enabled": false,
    "redhat.telemetry.enabled": false,
    "workbench.startupEditor": "none",
    "window.restoreWindows": "none",
}
```


## 快捷键配置

``` json
[
    {
        // 语法提示
        "key": "alt+/",
        "command": "editor.action.triggerSuggest",
        "when": "editorHasCompletionItemProvider && textInputFocus && !editorReadonly"
    },
    {
        // 关闭终端
        "key": "alt+d",
        "command": "workbench.action.terminal.kill"
    },
    {
        // 全局搜索文本
        "key": "ctrl+shift+f",
        "command": "workbench.action.findInFiles"
    },
    {
        // pytest 清除结果
        "key": "ctrl+; c",
        "command": "testing.clearTestResults"
    },
    {
        // 文本转大写
        "key": "ctrl+shift+alt+u",
        "command": "editor.action.transformToUppercase"
    },
    {
        // 文本转小写
        "key": "ctrl+shift+alt+l",
        "command": "editor.action.transformToLowercase"
    }
]
```


## 常用快捷键
  
| 快捷键                                            | 说明                                    |
| ------------------------------------------------- | --------------------------------------- |
| ++alt+slash++                                     | 语法提示                 ==需要自定义== |
| ++alt+d++                                         | 关闭终端                 ==需要自定义== |
| ++ctrl+shift+f++                                  | 全局搜索                 ==需要自定义== |
| ++ctrl+shift+h++                                  | 全局替换                                |
| ++ctrl+semicolon++ -> ++a++                       | `pytest` 全部测试                       |
| ++ctrl+semicolon++ -> ++e++                       | `pytest` 只测试上次错误                 |
| ++ctrl+semicolon++ -> ++ctrl+a++                  | `pytest` 调试全部                       |
| ++ctrl+semicolon++ -> ++ctrl+e++                  | `pytest` 只调试上次错误                 |
| ++ctrl+semicolon++ -> ++c++                       | `pytest` 清除结果        ==需要自定义== |
| ++ctrl+shift+alt+u++                              | 文本转大写               ==需要自定义== |
| ++ctrl+shift+alt+l++                              | 文本转小写               ==需要自定义== |
| ++ctrl+p++                                        | 打开文件                                |
| ++ctrl+r++                                        | 打开项目（目录）                        |
| ++ctrl+g++                                        | 跳转到某一行                            |
| ++ctrl+f++                                        | 当前文件搜索                            |
| ++ctrl+h++                                        | 当前文件替换                            |
| ++ctrl+alt++ + ( ++arrow-up++ or ++arrow-down++ ) | 选中多行，选中后可以同时修改            |
| ++alt+shift+f++                                   | 格式化                                  |
| ++alt+shift+o++                                   | 格式化import                            |

!!! warning
    Windows 输入法默认开启了快捷键 ++ctrl+shift+f++ 用于切换简体和繁体，需要屏蔽，否则会跟我们 `vscode` 定义的热键冲突


## tasks.json

`tasks.json` 可以用于使用外部的工具，非常有用。[官网参考](https://code.visualstudio.com/docs/editor/tasks)

创建 `tasks.json` 文件

1. 可以在 `.vscode` 目录下直接创建 `tasks.json` 文件
2. 或者使用菜单创建 `Terminal` / `Configure Tasks...`

项目中的启动任务，可以定义 `preLaunchTask` 用于配置启动任务前先执行的任务

!!! quote
    - [官网参考](https://code.visualstudio.com/docs/editor/tasks)
    - [介绍基本用法的参考文章](https://blog.csdn.net/qq_53653262/article/details/120859147)