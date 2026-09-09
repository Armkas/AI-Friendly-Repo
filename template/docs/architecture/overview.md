# 🏛️ 系统架构全景概览 (System Architecture Overview)

本文档阐述项目的核心技术选型、分层设计思想与运行时软件架构。

---

## 1. 核心架构设计思想

本项目严格实行**双层架构分离体系**：

```text
┌────────────────────────────────────────────────────────┐
│     AI Context Architecture (知识与认知层)             │
│     AGENTS.md / docs/ / .agents/                       │
│     定义：Agent 认知路径、系统地图、契约、不变式与工作流   │
└───────────────────────────┬────────────────────────────┘
                            │ 映射指导
┌───────────────────────────▼────────────────────────────┐
│     Software Runtime Architecture (软件运行时架构)       │
│     MVVM / DDD / Clean Architecture / Hexagonal        │
│     定义：程序的实际编译、内存模型、状态管理与网络请求      │
└────────────────────────────────────────────────────────┘
```

---

## 2. 技术栈与基础设施

- **客户端 / 前端**：[例如：React / Next.js / SwiftUI / Flutter]
- **服务端 / 后端**：[例如：Node.js / FastAPI / Go / Supabase Edge Functions]
- **持久化与数据库**：[例如：PostgreSQL / SQLite / Redis]
- **第三方集成**：[例如：Stripe / Agora / Apple StoreKit]

---

## 3. 核心分层与数据流转

1. **Presentation Layer (展现层)**：用户界面、路由与事件处理；
2. **Domain / Application Layer (业务编排层)**：核心业务逻辑、状态机与用例编排；
3. **Data / Infrastructure Layer (基础设施层)**：网络通信、本地存储与第三方 SDK 适配器。
