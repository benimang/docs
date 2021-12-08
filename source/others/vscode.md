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
  
| 快捷键                                            | 说明                             |
| ------------------------------------------------- | -------------------------------- |
| ++alt+slash++                                     | 语法提示          ==需要自定义== |
| ++alt+d++                                         | 关闭终端          ==需要自定义== |
| ++ctrl+shift+f++                                  | 全局搜索文本      ==需要自定义== |
| ++ctrl+shift+h++                                  | 全局替换文本                     |
| ++ctrl+semicolon++ -> ++c++                       | `pytest` 清除结果 ==需要自定义== |
| ++ctrl+shift+alt+u++                              | 文本转大写        ==需要自定义== |
| ++ctrl+shift+alt+l++                              | 文本转小写        ==需要自定义== |
| ++ctrl+p++                                        | 打开文件                         |
| ++ctrl+r++                                        | 打开项目（目录）                 |
| ++ctrl+g++                                        | 跳转到某一行                     |
| ++ctrl+f++                                        | 当前文件查找                     |
| ++ctrl+h++                                        | 当前文件替换                     |
| ++ctrl+alt++ + ( ++arrow-up++ or ++arrow-down++ ) | 选中多行文本，选中后可以同时修改 |

!!! warning
    Windows 输入法默认开启了快捷键 ++ctrl+shift+f++ 用于切换简体和繁体，需要屏蔽，否则会跟我们 `vscode` 定义的热键冲突