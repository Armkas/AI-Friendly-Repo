# 🤖 [Project Name] - AI 代理入口指南 (AGENTS.md)

> **本文件为全项目 AI 编程代理（Claude Code、Gemini/Antigravity、Cursor、Windsurf、Copilot 等）的唯一权威规范源 (Canonical Single Source of Truth)**。
> 架构采用**两层治理体系 (Two-Layer Policy)**：
> - **第 1 层（AI Context Architecture）**：由本文档及 `docs/`、`.agents/` 规定系统地图、契约、业务不变式与导航次序；
> - **第 2 层（Software Architecture & Runtime）**：由代码组织、强类型系统、Linter 与自动化构建命令强制校验。

---

## 🧪 验证与质量保证命令 (Commands & Verification)

任何代码修改或新功能实现完成后，**必须按顺序运行以下命令进行闭环验证**。任何报错未解决均视为任务未完成：

```bash
# 1. 静态类型检查（必须 0 报错）
# 例如: npm run typecheck / mypy . / swift build
<Typecheck Command>

# 2. 编译或打包验证（必须成功构建）
# 例如: npm run build / cargo check / xcodebuild ...
<Build Command>

# 3. 核心单元/集成测试（若当前阶段启用测试）
# 例如: npm test / pytest
<Test Command>
```

> 💡 **AI 准则**：严禁在未运行上述命令的情况下口头宣称“修改已完成”。如遇环境缺少依赖或无法执行，必须明确提示用户。

---

## ⚠️ 当前开发范围与状态声明 (Scope & Status)

用于向 AI 明确当前迭代周期的重点与“冻结区域”，防止 AI 分散注意力或在非目标平台上过度推导：

- **暂不开发模块 / 冻结平台**：[例如：Android 端代码暂时冻结，不读取、不修改]
- **测试策略状态**：[例如：当前阶段以类型检查与构建通过为主，暂不编写新单元测试]
- **生产环境操作**：任何涉及外部云端服务与密钥配置，必须登记在 `MANUAL_TASKS.md`，严禁 AI 自作主张。

---

## 🎯 渐进式披露导航 (Progressive Disclosure)

执行任何开发任务前，请严格遵循以下阅读阶梯，**严禁跳过规范直接全局 grep 搜索或通读庞大的实现代码**：

1. **全局与平台规则**：
   - 全局工作规范：[.agents/rules/global.md](.agents/rules/global.md)
   - 平台端侧规范：`.agents/rules/[platform].md`（如 `web.md`, `ios.md`, `backend.md`）
2. **系统全景地图与上下文索引**：
   - 系统宏观拓扑：[docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)
   - 快速索引表：[.agents/context-index.md](.agents/context-index.md)（精准定位接口协议与实现路径）
3. **领域知识 (Domains)**：[docs/domains/](docs/domains/)（理解业务概念、状态机与业务边界）
4. **接口契约 (Contracts)**：[docs/contracts/](docs/contracts/)
   - API / RPC 契约：[backend_rpc.md](docs/contracts/backend_rpc.md)
   - 数据库模型：[database_schema.md](docs/contracts/database_schema.md)
5. **架构决策与不变式**：
   - 决策原因 (Why)：[docs/adr/](docs/adr/)
   - 绝对不可破坏的业务红线：[docs/invariants/](docs/invariants/)
6. **依赖与影响半径分析**：[.agents/dependency-map.md](.agents/dependency-map.md)
7. **特性开发样板**：[docs/architecture/golden_feature_template.md](docs/architecture/golden_feature_template.md)
8. **代码实现层**：仅在确认契约后，深入对应模块的 `Interface`，最后才是 `Implementation`。

---

## 🏛 核心开发红线 (Inviolable Rules)

1. **接口优于实现 (Interface Over Implementation)**：新增或修改功能时，必须先在 `Interface/` 定义抽象协议/类型，严禁直接堆砌数百行缺乏约束的实现。
2. **单一真理来源 (Single Source of Truth)**：全局常量、配置与枚举字典集中声明，严禁在业务视图层散落硬编码魔法数字。
3. **禁止臆测逻辑**：遇到未明确的边界逻辑，优先查阅 Invariants / ADR，不可脑补业务逻辑。
4. **控制上下文体积**：遵循按需展开原则，不阅读与当前任务无关的模块。

---

## 📋 文档同步自检清单 (Doc-Sync Checklist)

任何 AI 代理在交付代码变更前，**必须对照本清单自检并同步更新对应文档，杜绝文档腐化**：

- [ ] **改动了抽象协议 / 接口契约？**
  - 同步更新 [.agents/context-index.md](.agents/context-index.md) 中的接口索引表；
  - 同步更新 [.agents/dependency-map.md](.agents/dependency-map.md) 中的依赖影响分析。
- [ ] **改动了后端 API / 边缘函数出入参？**
  - 同步更新 [docs/contracts/backend_rpc.md](docs/contracts/backend_rpc.md) 中的字段与错误码。
- [ ] **修改了数据库表结构或字段？**
  - 在迁移目录下追加递增时间戳迁移脚本（严禁修改历史迁移）；
  - 同步更新 [docs/contracts/database_schema.md](docs/contracts/database_schema.md)。
- [ ] **新增了业务 Feature 模块？**
  - 严格参照 [docs/architecture/golden_feature_template.md](docs/architecture/golden_feature_template.md) 组织目录；
  - 在 [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) 与 [docs/domains/](docs/domains/) 登记模块职责。
- [ ] **需要人工在第三方后台配置的操作？**
  - 在 [MANUAL_TASKS.md](MANUAL_TASKS.md) 中以复选框 `[ ]` 形式详尽登记。
