# 🏛️ System Architecture Overview (overview.md)

This document describes the core technology choices, layer separation, and runtime software architecture.

---

## 1. Two-Layer Architecture Model

This project strictly enforces the separation of **Cognitive Architecture** from **Runtime Architecture**:

```text
┌────────────────────────────────────────────────────────┐
│     AI Context Architecture (Knowledge Layer)          │
│     AGENTS.md / docs/ / .agents/                       │
│     Defines: Agent reading order, maps, contracts,      │
│              invariants, and workflows                 │
└───────────────────────────┬────────────────────────────┘
                            │ Guides
┌───────────────────────────▼────────────────────────────┐
│     Software Runtime Architecture                      │
│     MVVM / DDD / Clean Architecture / Hexagonal        │
│     Defines: Runtime execution, memory models,         │
│              state management, and network calls       │
└────────────────────────────────────────────────────────┘
```

---

## 2. Technology Stack & Infrastructure

- **Client / Frontend**: [e.g., React / Next.js / SwiftUI / Flutter]
- **Server / Backend**: [e.g., Node.js / FastAPI / Go / Cloud Functions]
- **Database**: [e.g., PostgreSQL / SQLite / Redis]
- **Third-Party Integrations**: [e.g., Payment Gateway, Push Notifications, Analytics, Cloud Storage]

---

## 3. Data Flow & Layer Responsibilities

1. **Presentation Layer**: User interfaces, navigation routing, and user event handling;
2. **Domain / Application Layer**: Core business rules, state machines, and use case orchestration;
3. **Data / Infrastructure Layer**: Network communication, local storage, and third-party SDK adapters.
