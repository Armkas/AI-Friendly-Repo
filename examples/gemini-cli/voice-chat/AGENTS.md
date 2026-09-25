# 🤖 AGENTS.md (Root)

## Project Introduction
This is a SwiftUI iOS app. It demonstrates **AI Context Architecture on top of Feature + MVVM / Clean**, not a replacement for MVVM.

```text
AI Context Layer (this file, docs/, .agents/)
        ↓
Feature-based boundaries (ios/Features/*)
        ↓
MVVM / Clean (runtime)
        ↓
Swift implementation
```

## AI Navigation Guide
Follow this **cognitive** order before opening implementation:

1. **Macro Map**: [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)
2. **Domain Knowledge**: `docs/domains/*.md` (e.g. Voice)
3. **Architecture & Decisions**: `docs/architecture/` and `docs/adr/`
4. **Runtime code**: `ios/` — View / ViewModel / UseCase / Repository. Prefer `Interface/` before concrete types.

## Global Invariants
- Business modules in `ios/` are split by Feature. Do not dump all business into `Controllers/` / `Models/`.
- MVVM / Clean remains the runtime architecture; do not invent an "AI-MVVM".
- This file is the map entrance, not an encyclopedia.
