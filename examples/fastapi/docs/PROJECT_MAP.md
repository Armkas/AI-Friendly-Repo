# Project Map (FastAPI Backend)

This example stacks an AI Context Layer on a conventional backend runtime:

```text
AI Context Layer
        ↓
Feature / Domain
        ↓
DDD / Clean / Dependency Inversion
        ↓
FastAPI Implementation
```

## Top-Level Directory
- `AGENTS.md` — Agent working contract (cognitive entry).
- `.agents/` — Indices and workflows.
- `docs/` — **AI Context Architecture** (domains, specs, architecture).
- `backend/` — **Runtime Architecture + implementation** (Feature + DDD / Clean / DI).

## Business Modules (Features)
1. **Voice Domain**
   - Context: `docs/domains/voice.md`
   - Runtime: `backend/features/voice/` (`interface/` → domain / application → infrastructure / api)
2. **Navigation Domain**
   - Runtime: `backend/features/navigation/`
