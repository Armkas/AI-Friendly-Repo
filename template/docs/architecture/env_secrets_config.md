# 🔐 环境变量与密钥配置规范 (Env & Secrets Architecture)

> [!IMPORTANT]
> **安全红线**：
> 1. 严禁将真实敏感密钥（私钥、API Secret、数据库密码）提交到 Git 仓库；
> 2. 严禁在客户端代码或公开前端页面中引用管理级别的高权私钥；
> 3. 本地开发必须依赖 `.env.example` 模版复制为 `.env` 进行配置。

---

## 1. 环境变量命名与分级规范

| 级别 / 分类 | 变量命名前缀规则 | 安全属性 | 典型使用场景 |
| :--- | :--- | :--- | :--- |
| **公开客户端变量** | `NEXT_PUBLIC_*` / `VITE_*` / `EXPO_PUBLIC_*` | **公开安全** (打包到客户端) | 客户端 API 地址、公开站点 Key、应用版本号 |
| **服务端保密变量** | `API_SECRET_*` / `DB_PASSWORD` / `SECRET_KEY` | **严格保密** (仅服务端内存可读) | 数据库连接串、支付商户私钥、第三方高权 Token |

---

## 2. 现代规范与历史兼容读取范式 (Modern API & Secrets Mapping)

为了防止 AI 代理生成废弃命名的环境变量，建议在代码读取处采用双向降级兼容写法：

```typescript
// 示例：Node.js / Edge Function 服务端保密读取
const adminSecret = process.env.SERVICE_SECRET_KEY 
  ?? process.env.LEGACY_SERVICE_ROLE_KEY;

if (!adminSecret) {
  throw new Error("Missing SERVICE_SECRET_KEY in environment");
}
```

```typescript
// 示例：Web 客户端公钥读取
const publishableKey = import.meta.env.VITE_PUBLISHABLE_KEY 
  ?? import.meta.env.VITE_ANON_KEY;
```

---

## 3. 本地环境变量示例模版 (.env.example)

所有开发者与 AI 代理在新增环境变量时，必须同步在本项目的 `.env.example` 中补充变量名与说明注释。
