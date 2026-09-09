# 🗄️ 数据库物理模式与表结构契约 (Database Schema Contract)

> **原则**：本文档为全项目数据库物理结构的单一真理快照。
> 任何数据库表结构的调整，必须通过递增迁移脚本执行，并在此文档中同步更新字段解释。

---

## 核心设计铁律

1. **增量迁移**：所有变更以 `migrations/` 下带时间戳的 SQL 为准，严禁修改线上历史文件；
2. **枚举小整型化**：涉及状态、分类、类型的字段，推荐使用字典表 ID 或 `SMALLINT`，避免大面积硬编码中文字符串；
3. **行级安全 (RLS)**：多租户/用户数据表必须显式配置行级安全策略。

---

## 核心数据表清单

### 1. 用户基础表 (`users` / `profiles`)

| 字段名 | 类型 | 约束 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY` | 用户唯一标识符 |
| `email` | `VARCHAR(255)` | `UNIQUE, NOT NULL` | 用户注册邮箱 |
| `created_at` | `TIMESTAMPTZ` | `DEFAULT now()` | 注册时间 |
| `updated_at` | `TIMESTAMPTZ` | `DEFAULT now()` | 最后更新时间 |

---

### 2. [业务特性数据表] (`features`)

| 字段名 | 类型 | 约束 | 说明 |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY` | 主键 |
| `user_id` | `UUID` | `REFERENCES users(id)` | 关联用户 |
| `status` | `SMALLINT` | `DEFAULT 0` | 状态码（0: 初始化, 1: 进行中, 2: 已完成） |
