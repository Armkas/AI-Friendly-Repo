# ADR-001: 采用 Feature-First 目录架构替代技术类型平铺

- **状态 (Status)**: 已采纳 (Accepted)
- **决策者 (Deciders)**: 架构委员会
- **生效日期 (Date)**: 2026-09-09

---

## 1. 背景与上下文 (Context & Problem Statement)
过去项目采用传统的技术分层平铺（如 `/controllers`, `/services`, `/models`, `/views`）。随着业务扩展，一个新需求的改动往往需要横跨 5~6 个顶层技术目录。AI Coding Agent 在处理任务时，被迫检索整个仓库并读取大量无关技术文件，导致 Token 消耗急剧攀升且容易误伤其他业务。

---

## 2. 备选方案对比 (Considered Options)
- **方案 A (保持平铺技术分层)**：人类旧习惯熟悉，但 AI 跨模块修改成本极高，容易产生全局依赖纠缠。
- **方案 B (Feature-First 纵向切片 - 采纳)**：每个业务模块高内聚聚合，包含独立的 Interface、Implementation 与 Views。

---

## 3. 最终决策与理由 (Decision Outcome & Why)
采纳 **方案 B**。让所有与某一业务相关的逻辑就近聚合，使得 AI 在定位和修改某一具体业务时，上下文边界收敛在单个 Feature 目录内。

---

## 4. 权衡与已接受的代价 (Trade-offs & Consequences)
- **正向收益**：AI 任务检索范围缩小 80%，修改影响面清晰，模块更易解耦。
- **已接受的代价**：跨 Feature 通信需要通过显式的 Public Interface 暴露，禁止跨 Feature 私自调用内部实现。
