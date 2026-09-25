# 🧭 上下文快速定位索引 (Context Index)

> **本文件为 AI 代理的机器可读索引表**。
> 当需要定位特定领域概念、接口协议、后端接口或架构规则时，直接查阅下表，**严禁全库大范围盲目 grep 搜索**。

---

## 1. 业务领域与概念 (Business Domains)

| 领域模块 | 领域知识文档 | 核心接口 (Interface) | 业务实现 (Implementation) |
| :--- | :--- | :--- | :--- |
| **认证与用户 (Auth)** | [docs/domains/auth.md](../docs/domains/auth.md) | `src/features/auth/interface/` | `src/features/auth/implementation/` |
| **主业务模版 (Feature)** | [docs/domains/domain-template.md](../docs/domains/domain-template.md) | `src/features/feature_a/interface/` | `src/features/feature_a/implementation/` |

---

## 2. 核心接口与协议契约 (Key Interfaces & Protocols)

AI 代理在修改或调用业务前，必须优先阅读以下接口定义，而非直接通读数百行实现：

| 接口契约符号 | 所在物理文件路径 | 核心职责概述 |
| :--- | :--- | :--- |
| `IAuthService` | `src/features/auth/interface/IAuthService.ts` | 用户登录、注销、Token 刷新 |
| `IFeatureService` | `src/features/feature_a/interface/IFeatureService.ts` | 主业务 A 的生命周期与状态查询 |

---

## 3. 后端服务与 API 契约 (Backend RPC & Services)

| 接口端点 / 函数名 | 契约文档 | 服务端实现文件 | 客户端调用入口 |
| :--- | :--- | :--- | :--- |
| `/api/auth/login` | [docs/contracts/backend_rpc.md](../docs/contracts/backend_rpc.md) | `server/controllers/auth.ts` | `src/core/api/authClient.ts` |
| `/api/feature/action` | [docs/contracts/backend_rpc.md](../docs/contracts/backend_rpc.md) | `server/controllers/feature.ts` | `src/core/api/featureClient.ts` |

---

## 4. 架构、决策与不变量 (Architecture, ADR & Invariants)

| 资产名称 | 路径 | 用途与说明 |
| :--- | :--- | :--- |
| **系统全景地图** | [docs/PROJECT_MAP.md](../docs/PROJECT_MAP.md) | 顶层物理结构与技术栈说明 |
| **黄金特性样板** | [docs/architecture/golden_feature_template.md](../docs/architecture/golden_feature_template.md) | 新建 Feature 时的标杆代码目录规范 |
| **核心业务不变式** | [docs/invariants/business_invariants.md](../docs/invariants/business_invariants.md) | 绝对不可破坏的业务底线与红线 |
| **架构决策记录** | [docs/adr/README.md](../docs/adr/README.md) | 历史技术选型与妥协权衡 (Why) |
| **依赖拓扑图** | [.agents/dependency-map.md](dependency-map.md) | 跨层依赖关系与改动影响评估 |

---

## 5. 标准研发工作流 (Agent Workflows)

- **新增特性 SOP**：[.agents/workflows/add-feature.md](workflows/add-feature.md)
- **数据库迁移 SOP**：[.agents/workflows/new-database-migration.md](workflows/new-database-migration.md)
- **接口变更 SOP**：[.agents/workflows/api-contract-change.md](workflows/api-contract-change.md)
