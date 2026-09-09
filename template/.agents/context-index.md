# 🧭 Context Index (context-index.md)

[简体中文](context-index.zh-CN.md)

> **Machine-Readable Index for AI Coding Agents**.
> Look up domain concepts, interfaces, endpoints, and architecture rules here. **Do NOT run blanket grep across the entire repository**.

---

## 1. Business Domains

| Domain | Knowledge Document | Core Interface | Implementation |
| :--- | :--- | :--- | :--- |
| **Auth & User** | [docs/domains/auth.md](../docs/domains/auth.md) | `src/features/auth/interface/` | `src/features/auth/implementation/` |
| **Feature Template** | [docs/domains/domain-template.md](../docs/domains/domain-template.md) | `src/features/feature_a/interface/` | `src/features/feature_a/implementation/` |

---

## 2. Key Interfaces & Protocols

Agents must inspect these contracts first before reading implementation files:

| Interface Symbol | File Path | Core Responsibility |
| :--- | :--- | :--- |
| `IAuthService` | `src/features/auth/interface/IAuthService.ts` | Login, logout, session refresh |
| `IFeatureService` | `src/features/feature_a/interface/IFeatureService.ts` | Feature lifecycle and state queries |

---

## 3. Backend RPC & Services

| Endpoint / Function | Contract | Server Implementation | Client Entry |
| :--- | :--- | :--- | :--- |
| `/api/auth/login` | [docs/contracts/backend_rpc.md](../docs/contracts/backend_rpc.md) | `server/controllers/auth.ts` | `src/core/api/authClient.ts` |
| `/api/feature/action` | [docs/contracts/backend_rpc.md](../docs/contracts/backend_rpc.md) | `server/controllers/feature.ts` | `src/core/api/featureClient.ts` |

---

## 4. Architecture, ADR & Invariants

| Asset | Path | Description |
| :--- | :--- | :--- |
| **Project Map** | [docs/PROJECT_MAP.md](../docs/PROJECT_MAP.md) | High-level system structure and tech stack |
| **Golden Feature** | [docs/architecture/golden_feature_template.md](../docs/architecture/golden_feature_template.md) | Canonical layout for new features |
| **Invariants** | [docs/invariants/business_invariants.md](../docs/invariants/business_invariants.md) | Inviolable business rules and guardrails |
| **ADR** | [docs/adr/README.md](../docs/adr/README.md) | Architectural Decision Records (Why) |
| **Dependency Map** | [dependency-map.md](dependency-map.md) | Dependency graph and impact assessment |

---

## 5. Agent Workflows

- **Add Feature SOP**: [workflows/add-feature.md](workflows/add-feature.md)
- **Database Migration SOP**: [workflows/new-database-migration.md](workflows/new-database-migration.md)
- **API Contract SOP**: [workflows/api-contract-change.md](workflows/api-contract-change.md)
