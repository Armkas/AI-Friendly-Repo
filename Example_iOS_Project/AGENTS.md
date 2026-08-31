# 🤖 AGENTS.md (Root)

## 项目简介
本项目是一个纯 iOS (SwiftUI) 应用项目。它展示了如何采用《AI-Native Project Standard 1.0》规范构建项目知识层。

## AI 导航指南
请严格遵循以下顺序了解项目上下文：

1. **宏观地图**: [docs/PROJECT_MAP.md](file:///Users/puyue/main/标准项目仓库设计/Example_iOS_Project/docs/PROJECT_MAP.md) - 了解整体构成
2. **领域知识**: `docs/domains/*.md` - 遇到具体业务（如 Voice）时，先阅读对应的 Domain 文档
3. **架构与决策**: `docs/architecture/` 和 `docs/adr/`
4. **具体实现**: 只有在排查 Bug 或执行修改任务时，再深入 `ios/` 目录的具体代码

## 全局不变量 (Invariants)
- `ios/` 中的所有业务模块必须以 Feature 为边界划分，严禁使用纯横向分层（如 `Controllers/`, `Models/` 混杂存放所有业务）。
- 不要在这个文件中解释所有细节，这里只是地图的入口！
