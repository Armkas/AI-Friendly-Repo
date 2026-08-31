# 🤖 AGENTS.md (Root)

## 项目简介
本项目是一个纯后端 (FastAPI) 服务。展示了按照《AI-Native Project Standard 1.0》结构组织的 Python 服务架构。

## AI 导航指南
1. **宏观地图**: [docs/PROJECT_MAP.md](file:///Users/puyue/main/标准项目仓库设计/Example_FastAPI_Project/docs/PROJECT_MAP.md) - 了解整体构成
2. **领域知识**: `docs/domains/*.md` - 了解业务
3. **实现细节**: `backend/` 目录中，优先阅读 `interface/` 模块和 `schemas/` 协议。

## 全局约束 (Invariants)
- **按领域分包**: API 路由、业务服务、数据模型应按业务（如 `features/voice/`）内聚，禁止纯粹按照 `routers/`, `services/`, `models/` 在顶层横向分包。
