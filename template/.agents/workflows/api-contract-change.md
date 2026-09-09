# 🌐 SOP: 接口与网络契约变更工作流 (API Contract Workflow)

> **目标**：在新增、修改后端 API / RPC 端点或云函数时，保证跨端出入参契约完备、向后兼容，且端侧调用无缝对齐。

---

## 标准执行步骤

### 步骤 1：契约文档先行 (Contract First)
在编写服务端或客户端代码前，必须先在 [docs/contracts/backend_rpc.md](../../docs/contracts/backend_rpc.md) 中登记该接口的详细规格：
1. **端点路径与请求方式**（如 `POST /api/v1/user/profile`）；
2. **请求 Headers 与鉴权要求**；
3. **Request Payload Schema**（明确各字段类型、必填性、默认值）；
4. **Response Payload Schema**（成功响应结构）；
5. **业务错误码字典**（明确 HTTP 状态码与业务 `error_code`）。

### 步骤 2：服务端实现与模式校验
1. 实现服务端控制器或路由；
2. 强制使用 Schema 验证器（如 Zod / Pydantic / class-validator）对输入参数做运行时安全校验；
3. 严禁透传未经过滤的数据库敏感字段（如密码哈希、内部审计密钥）。

### 步骤 3：端侧客户端适配 (Client SDK)
1. 在客户端/前端的 API Client 中更新调用方法；
2. 保持向后兼容：如果修改了旧接口字段，禁止直接删除旧字段，应采用可选字段或增加新版本端点；
3. 编写/更新调用方的强类型定义。

### 步骤 4：静态类型检查与联调自检
运行 `AGENTS.md` 中指定的各端类型检查命令，确保客户端与服务端均 0 报错。

### 步骤 5：同步索引 (Doc-Sync)
- [ ] 在 [.agents/context-index.md](../context-index.md) 中登记新接口映射；
- [ ] 在 [.agents/dependency-map.md](../dependency-map.md) 中核实对上下游依赖组件的影响。
