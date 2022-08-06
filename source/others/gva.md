# Gin-Vue-Admin

## 环境配置补充

前端开发环境使用 `vscode` + `volar` 编辑器无法得到 `TS` 语法提示

1. 文件重命名扩展名 `vite.config.ts`
2. 新增两个文件（使用 `vite` 创建新的 `vue(ts)` 项目中复制过来改动）

```json title="tsconfig.json" hl_lines="18-24"
{
  "compilerOptions": {
    "target": "ESNext",
    "useDefineForClassFields": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "strict": true,
    "jsx": "preserve",
    "sourceMap": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "esModuleInterop": true,
    "lib": [
        "ESNext",
      "DOM"
    ],
    "skipLibCheck": true,
    "allowJs": true,
    "baseUrl": "./",
    "paths": {
      "@/*": [
        "./src/*"
      ],
    }
  },
  "include": [
    "src/**/*.ts",
    "src/**/*.d.ts",
    "src/**/*.tsx",
    "src/**/*.vue"
  ],
  "references": [
    {
      "path": "./tsconfig.node.json"
    }
  ]
}
```

```json title="tsconfig.node.json" hl_lines="8"
{
  "compilerOptions": {
    "composite": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
```