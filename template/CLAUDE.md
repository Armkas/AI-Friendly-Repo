@AGENTS.md

## 💡 Claude Code 专属避坑指南 (Claude Code Adapter)

1. **禁止省略代码与折叠输出**：Claude 在生成大文件时倾向于使用 `// ... existing code ...` 或省略 import/类型定义。在修改或创建代码文件时，**必须输出完整、无截断、可直接编译运行的代码**。
2. **保持强类型严谨性**：严禁随意使用 `any` 或放宽类型约束，所有类型定义必须与契约或数据库模型对齐。
3. **遵循渐进式披露**：优先阅读抽象接口（Interface / Protocol）与 [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)，严禁全仓盲目搜索。
4. **修改后主动运行验证**：完成修改后必须主动运行 `AGENTS.md` 中指定的验证命令（如类型检查与构建）进行闭环自检。
