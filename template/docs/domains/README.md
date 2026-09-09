# 📚 Business Domain Knowledge (docs/domains/)

This directory stores documentation for vertical business domains. Each core domain has an independent markdown document (e.g. `auth.md`, `billing.md`, `chat.md`).

---

## Domain Directory

| Document | Business Capabilities | Code Directory |
| :--- | :--- | :--- |
| [domain-template.md](domain-template.md) | Standard domain documentation template | N/A |
| [auth.md](auth.md) | Registration, login, session management | `src/features/auth/` |
| `[feature].md` | Primary feature business logic and state machine | `src/features/[feature]/` |

---

## Principles
1. **Explain the Business, Not Raw Code**: Focus on ubiquitous language, user journeys, state machines, and edge cases;
2. **Link to Contracts**: Connect domain documents to corresponding `Interface` definitions and `docs/contracts/` for quick agent drill-down.
