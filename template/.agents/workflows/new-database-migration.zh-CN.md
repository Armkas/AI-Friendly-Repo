# 🗄️ SOP: 数据库安全迁移工作流 (Database Migration Workflow)

> **目标**：对数据库进行表结构、字段、索引或权限安全策略调整时，确保可追溯、无冲突、零事故、文档实时对齐。

---

## 标准执行步骤

### 步骤 1：按时间戳生成递增迁移文件
**绝对红线**：严禁直接修改已提交或已上线的历史迁移文件。必须在迁移目录下追加新的增量 SQL 脚本：
```bash
# 命名范式: YYYYMMDDHHMMSS_<descriptive_name>.sql
# 例如: migrations/20260909120000_add_user_status.sql
```

### 步骤 2：防御性 DDL 规范 (Defensive DDL)
1. **幂等性与防御语法**：创建表与索引时优先使用 `CREATE TABLE IF NOT EXISTS`、`ADD COLUMN IF NOT EXISTS`；
2. **安全撤销与回滚考量**：避免在生产环境执行破坏性的 `DROP COLUMN`，建议先弃用再在下个大版本清理；
3. **权限与行级安全 (RLS)**：
   - 所有新建表必须显式设置权限；
   - 若数据库支持行级安全策略（RLS），建议显式开启：
     ```sql
     ALTER TABLE public.<table_name> ENABLE ROW LEVEL SECURITY;
     ```

### 步骤 3：同步更新数据库契约文档 (Docs-as-Code)
- [ ] 在 [docs/contracts/database_schema.md](../../docs/contracts/database_schema.md) 中更新最新的表结构快照与字段释义；
- [ ] 在 [.agents/dependency-map.md](../dependency-map.md) 中核查是否影响实体模型或前端接口。

### 步骤 4：本地测试与人工操作登记
- 本地执行迁移测试命令，确认语法通过；
- 若涉及线上生产环境的迁移推送，在 [MANUAL_TASKS.md](../../MANUAL_TASKS.md) 中登记推送命令与核对项。
