# 🌐 SOP: API Contract Change Workflow (api-contract-change.md)

[简体中文](api-contract-change.zh-CN.md)

> **Objective**: Standard operating procedure for adding or modifying backend API / RPC endpoints or cloud functions, ensuring contract completeness and cross-platform backward compatibility.

---

## Standard Execution Steps

### Step 1: Contract First
Before writing server or client code, register the specification in [docs/contracts/backend_rpc.md](../../docs/contracts/backend_rpc.md):
1. **Endpoint and HTTP Method** (e.g. `POST /api/v1/user/profile`);
2. **Request Headers and Authentication Requirements**;
3. **Request Payload Schema** (Field types, required/optional flags, default values);
4. **Response Payload Schema** (Success response envelope);
5. **Business Error Codes Dictionary** (HTTP status codes and domain `error_code` values).

### Step 2: Server Implementation and Schema Validation
1. Implement route/controller logic;
2. Enforce runtime schema validation (e.g., Zod, Pydantic, class-validator) on all inputs;
3. Never expose unparsed database secrets or hashes in API responses.

### Step 3: Client SDK Adaptation
1. Update API client methods across frontend/mobile applications;
2. Maintain backward compatibility: do not drop fields without deprecation periods;
3. Update strong type definitions for callers.

### Step 4: Verification Commands
Execute typecheck commands declared in `AGENTS.md` across both client and server to verify zero errors.

### Step 5: Update Indices (Doc-Sync)
- [ ] Update [.agents/context-index.md](../context-index.md);
- [ ] Verify impact in [.agents/dependency-map.md](../dependency-map.md).
