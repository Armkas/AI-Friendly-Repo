# 🤖 AGENTS.md (Root)

## Project Introduction
This is a FastAPI backend. It demonstrates **AI Context Architecture on top of Feature / Domain + DDD / Clean / Dependency Inversion**, not a replacement for those patterns.

```text
AI Context Layer (this file, docs/, .agents/)
        ↓
Feature / Domain
        ↓
DDD / Clean / Dependency Inversion
        ↓
FastAPI implementation
```

## AI Navigation Guide
1. **Macro Map**: [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)
2. **Domain Knowledge**: `docs/domains/*.md`
3. **Runtime**: `backend/` — read `interface/` and `schemas/` before infrastructure.

## Global Invariants
- Package by business domain (`features/voice/`). Do not use top-level `routers/` / `services/` / `models/` as the primary split.
- DDD / Clean / DI remains the runtime architecture.
