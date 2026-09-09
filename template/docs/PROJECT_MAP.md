# 🗺️ Project Map (PROJECT_MAP.md)

[简体中文](PROJECT_MAP.zh-CN.md)

> This document provides a high-level architectural overview of the system, directory composition, and technology stacks.

---

## 1. Top-Level Physical Structure

```text
.
├── .agentsignore       # AI retrieval noise reduction & exclusion rules
├── AGENTS.md           # Canonical Single Source of Truth for all AI agents
├── CLAUDE.md           # Claude Code adapter
├── GEMINI.md           # Gemini / Antigravity adapter
├── MANUAL_TASKS.md     # Human operational boundaries & manual checklist ([ ])
├── README.md           # Developer introduction
│
├── .agents/            # Machine-readable indices and agent SOPs
│   ├── context-index.md    # Quick symbol/interface lookup index
│   ├── dependency-map.md   # Topology graph & impact radius (Mermaid)
│   ├── rules/              # Platform & global rules
│   └── workflows/          # Standard SOPs (Feature, Migration, API)
│
├── docs/               # Knowledge Layer (AI Context Architecture)
│   ├── architecture/       # System architecture & golden_feature_template
│   ├── contracts/          # API RPC & database schema contracts
│   ├── invariants/         # Inviolable business rules & guardrails
│   ├── adr/                # Architectural Decision Records
│   └── domains/            # Vertical business domain knowledge
│
└── [src / apps / ...]  # Software Runtime Architecture & Implementation
    └── features/           # Feature-based business modules
```

---

## 2. Core Subsystems & Directory Mappings

| Subsystem / Module | Responsibility | Knowledge Layer Document | Code Implementation |
| :--- | :--- | :--- | :--- |
| **Auth & User** | Login, registration, session management | [docs/domains/auth.md](domains/auth.md) | `src/features/auth/` |
| **Core Feature** | Primary business flow and state machine | [docs/domains/domain-template.md](domains/domain-template.md) | `src/features/[feature]/` |
| **Common Infrastructure** | HTTP client, common utility functions | [docs/architecture/overview.md](architecture/overview.md) | `src/core/` / `src/shared/` |

---

## 3. Technology Stack Declarations

- **Frontend / Client**: [e.g., Next.js / TypeScript / TailwindCSS or SwiftUI / MVVM]
- **Backend / Server**: [e.g., FastAPI / Python or Node.js / Express or Supabase Functions]
- **Database**: [e.g., PostgreSQL / Supabase]
