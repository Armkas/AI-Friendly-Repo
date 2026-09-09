# 🗄️ SOP: Database Migration Workflow (new-database-migration.md)

[简体中文](new-database-migration.zh-CN.md)

> **Objective**: Standard operating procedure for database schema, index, or permission changes to ensure auditability, zero conflicts, and documentation alignment.

---

## Standard Execution Steps

### Step 1: Create an Incremental Timestamped Migration
**Absolute Rule**: Never modify already committed or applied historical migration files. Always append a new timestamped SQL file:
```bash
# Naming pattern: YYYYMMDDHHMMSS_<descriptive_name>.sql
# e.g.: migrations/20260909120000_add_user_status.sql
```

### Step 2: Defensive DDL Principles
1. **Idempotency**: Use `CREATE TABLE IF NOT EXISTS` and `ADD COLUMN IF NOT EXISTS`;
2. **Safe Deprecation**: Avoid destructive `DROP COLUMN` in production; deprecate first and remove in subsequent major versions;
3. **Row-Level Security (RLS)**:
   - For multi-tenant databases with row security policies, explicitly enable RLS:
     ```sql
     ALTER TABLE public.<table_name> ENABLE ROW LEVEL SECURITY;
     ```

### Step 3: Update Database Schema Contracts (Docs-as-Code)
- [ ] Update table snapshot and field definitions in [docs/contracts/database_schema.md](../../docs/contracts/database_schema.md);
- [ ] Verify impact on entity models in [.agents/dependency-map.md](../dependency-map.md).

### Step 4: Local Verification & Manual Task Registration
- Execute local migration tests and confirm syntax correctness;
- If production execution requires human approval, record the push command in [MANUAL_TASKS.md](../../MANUAL_TASKS.md).
