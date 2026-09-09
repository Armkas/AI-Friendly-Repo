# 📚 业务领域知识库 (Business Domains)

本目录下存放各业务垂直领域的专业业务逻辑文档。每个核心业务域对应一份独立的 markdown 文件（如 `auth.md`、`billing.md`、`chat.md`）。

---

## 领域文档列表 (Domain Directory)

| 领域文档 | 涵盖业务能力 | 对应物理代码目录 |
| :--- | :--- | :--- |
| [domain-template.md](domain-template.md) | 领域知识编写标准模版 | N/A |
| `auth.md` | 用户注册、鉴权、会话管理 | `src/features/auth/` |
| `[feature].md` | [主业务特性逻辑与状态机] | `src/features/[feature]/` |

---

## 编写原则
1. **只讲业务，不贴大段实现代码**：重点阐明业务术语、用户旅程、状态机转换规则与边界情况；
2. **链接到契约**：在文档中链接到对应的 `Interface` 与 `docs/contracts/`，便于 AI 快速下钻。
