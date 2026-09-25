# 🌐 Backend API & RPC Contracts (backend_rpc.md)

> **Principle**: Backend API and RPC schemas are firm cross-platform contracts.
> Register request/response payloads here before implementing endpoints.

---

## Standard Response Envelope

All API / RPC endpoints return a standardized envelope structure:

```json
{
  "code": 0,
  "message": "success",
  "data": {},
  "timestamp": 1773180000000
}
```

---

## Endpoint Specifications

### 1. User Authentication (`POST /api/v1/auth/login`)
- **Access**: Public
- **Headers**:
  - `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "account": "user@example.com",
    "password": "hashed_password"
  }
  ```
- **Success Response Data**:
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
- **Error Codes**:
  - `40101`: Invalid account or password
  - `40302`: Account suspended or in cooldown

---

### 2. [Feature Action Endpoint] (`POST /api/v1/...`)
- **Access**: Bearer Token required
- **Request Body**:
  ```json
  {}
  ```
- **Response**:
  ```json
  {}
  ```
