# 🌐 后端接口与 RPC 契约 (Backend RPC Contracts)

> **原则**：后端 API / RPC 契约是跨端协作的硬性合同。
> 新增或修改接口前，**必须先在此文档中登记出入参模式**，并在代码中严格遵循。

---

## 通用响应封装格式 (Standard Response Envelope)

所有 API / RPC 接口统一返回以下顶层结构：

```json
{
  "code": 0,
  "message": "success",
  "data": {},
  "timestamp": 1773180000000
}
```

---

## 接口清单与规格示例

### 1. 用户登录 / 认证 (`POST /api/v1/auth/login`)
- **权限**：公开访问 (`Public`)
- **请求头 (Headers)**：
  - `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "account": "user@example.com",
    "password": "hashed_password"
  }
  ```
- **Success Response (Data)**:
  ```json
  {
    "token": "jwt_token_string",
    "expires_in": 7200,
    "user": {
      "id": "uuid-1234",
      "name": "Alex"
    }
  }
  ```
- **业务错误码**:
  - `40101`: 账号或密码错误
  - `40302`: 账号已被封禁或处于冷却期

---

### 2. [业务接口名] (`POST /api/v1/...`)
- **权限**：需要 Bearer Token
- **Request Body**:
  ```json
  {}
  ```
- **Response**:
  ```json
  {}
  ```
