@AGENTS.md

## 💡 Gemini / Antigravity 专属避坑指南 (Gemini Adapter)

1. **严禁臆测文件路径与组件位置**：执行任何修改前，必须先查阅 [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) 与 [.agents/context-index.md](.agents/context-index.md)，严禁凭空假设未确认的文件路径。
2. **禁止擅自篡改历史数据库迁移**：对数据库的任何改动，必须追加递增时间戳的新增量迁移脚本，不可直接修改已经执行过的历史迁移文件。
3. **遵循渐进式披露**：优先阅读抽象接口（Interface / Protocol）与契约规范，严禁一次性将无关文件全部塞满上下文。
4. **修改后主动运行验证**：完成修改后必须主动运行 `AGENTS.md` 中声明的验证命令（如类型检查与构建）进行闭环自检。
