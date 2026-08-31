# 🤖 AGENTS.md (Root)

## Project Introduction
This mixed app (iOS, Android, Web, FastAPI) demonstrates one **AI Context Architecture** over **different runtime architectures** per platform.

```text
                     AI Context Layer
                            │
             ┌──────────────┴──────────────┐
             ↓                             ↓
      iOS Architecture              Backend Architecture
       MVVM / Clean                  DDD / Clean
             │                             │
             └──────────────┬──────────────┘
                            ↓
                       System Domain
```

Android uses Clean + MVI; Web uses Feature-Sliced Design. The knowledge layer does not invent a new runtime pattern for each end.

## AI Navigation Guide
Regardless of which client you change:

1. **Macro Map**: [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)
2. **Cross-platform domain**: `docs/domains/` (shared business meaning)
3. **Platform runtime rules**: that directory's `AGENTS.md` (e.g. `ios/AGENTS.md`)

## Global Invariants
- **Single source of truth for shared business**: error codes, state machines, and domain rules live in `docs/domains/`. Platforms must not fragment them.
- Each platform keeps its own runtime architecture; all of them must be navigable through this AI Context Layer.
