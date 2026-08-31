# 🤖 AGENTS.md (Root)

## 项目简介
本项目是一个大型混合应用，包含 iOS (SwiftUI), Android (Compose), Web Frontend, 以及 Backend (FastAPI)。
本仓库展示了《AI-Native Project Standard 1.0》如何完美解耦“认知层 (Knowledge Layer)”与“代码层 (Code Layer)”。

## AI 导航指南
不论你要修改哪个端，请务必从以下路径获取项目知识：
1. **宏观地图**: [docs/PROJECT_MAP.md](file:///Users/puyue/main/标准项目仓库设计/Example_Mixed_Project/docs/PROJECT_MAP.md) - 定位你要修改的端和对应模块
2. **跨端领域知识**: `docs/domains/` - 理解业务本质（这部分与具体代码端无关，各端通用）
3. **各端独立规则**: 进入对应端目录前，必读该目录下的 `AGENTS.md` (例如 `ios/AGENTS.md`)

## 全局约束 (Invariants)
- **文档唯一事实来源**: 跨端的业务规则（如错误码、核心状态机）统一定义在 `docs/domains/` 中，各端必须严格遵守，不允许各自为政。
