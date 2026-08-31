# Project Map (iOS App)

This example stacks an AI Context Layer on a conventional iOS runtime:

```text
AI Context Layer
        ↓
Feature-based Architecture
        ↓
MVVM / Clean
        ↓
Swift Implementation
```

## Top-Level Directory
- `AGENTS.md` — Agent working contract (cognitive entry).
- `.agents/` — Indices and skills.
- `docs/` — **AI Context Architecture** (architecture, domains, ADRs, invariants).
- `ios/` — **Runtime Architecture + implementation** (Feature + MVVM / Clean).

## Major Subsystems and Locations
1. **Voice Domain**
   - Context: [docs/domains/voice.md](domains/voice.md)
   - Runtime: `ios/Features/Voice/` (`Interface/` → `Application/`)
2. **Navigation Domain**
   - Runtime: `ios/Features/Navigation/`
