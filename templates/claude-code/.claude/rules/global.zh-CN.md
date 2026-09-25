# 🤖 全局开发规则与工作规范 (Global Agent Rules)

本项目严格遵循 **AI-Friendly 架构标准**，将系统划分为**AI 上下文认知层（`docs/`、`.agents/`）**与**软件运行时实现层（源代码目录）**。

---

## ⚠️ 绝对红线 (Inviolable Invariants)

1. **接口先行 (Interface First)**：
   - 任何新增功能或模块重构，必须先在 `Interface/` 目录下完成协议/抽象契约的定义。
   - 严禁跳过接口直接堆砌数百行实现代码。
2. **单一真理来源 (Single Source of Truth)**：
   - 系统全局配置、业务限额、枚举字典必须统一收敛在中央配置文件或数据库字典中，严禁在 UI/View 层硬编码魔法数字。
3. **禁止臆测未明确逻辑**：
   - 遇到未清晰规定的边界行为，优先检索 `docs/invariants/` 与 `docs/adr/`，若仍无定论，必须向人类开发者提问，严禁自由脑补。
4. **验证命令必须跑通**：
   - 提交代码前，必须执行 `AGENTS.md` 中声明的验证命令（类型检查、编译构建等），零报错方可宣告完成。

---

## 🎯 渐进式披露阅读顺序 (Progressive Disclosure)

严禁直接全仓盲目搜索或一次性读入数十个实现文件。请按以下顺序获取上下文：

1. **项目入口与规则**：[AGENTS.md](../../AGENTS.md) 与本规则文件；
2. **系统地图与索引**：[docs/PROJECT_MAP.md](../../docs/PROJECT_MAP.md) 及 [.agents/context-index.md](../context-index.md)；
3. **领域业务知识**：`docs/domains/*.md`（理解领域概念与业务流转）；
4. **接口与数据契约**：`docs/contracts/`（出入参结构与数据库模型）；
5. **架构决策与不变式**：`docs/adr/` 与 `docs/invariants/`（了解历史权衡与不可触碰的底线）；
6. **依赖影响评估**：[.agents/dependency-map.md](../dependency-map.md)；
7. **阅读与修改实现**：定位到目标 Feature 目录，先看 `Interface`，后看 `Implementation`。

---

## 📋 文档同步防腐化自检清单 (Doc-Sync Checklist)

完成任何代码修改后，必须执行自检并同步更新文档：

- [ ] **改了 Interface/Protocol**：同步更新 `context-index.md` 与 `dependency-map.md`；
- [ ] **改了 API/RPC 端点**：同步更新 `docs/contracts/backend_rpc.md`；
- [ ] **改了数据库表/字段**：追加增量 SQL 迁移并更新 `docs/contracts/database_schema.md`；
- [ ] **新增业务 Feature**：参照 `golden_feature_template.md`，并在 `PROJECT_MAP.md` 登记；
- [ ] **产生了外部人工配置需求**：在 `MANUAL_TASKS.md` 中登记 `[ ]`。
