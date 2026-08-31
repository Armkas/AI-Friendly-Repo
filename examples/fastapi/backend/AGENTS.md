# 🐍 Backend AGENTS.md

## Runtime Architecture
This directory is the **runtime plane**. Keep Feature / Domain + DDD / Clean / Dependency Inversion. The AI Context Layer lives in root `AGENTS.md` and `docs/`.

## Local Rules
When working in `backend/`:

1. **Dependency Injection**: Use FastAPI `Depends`. Routers depend on `Protocol` and a provider, not a concrete SDK.
2. **Interface First**: Domain capabilities are `typing.Protocol` in that feature's `interface/` package. One capability → one protocol.
3. **Data Model Validation**: Pydantic V2 `schemas`, separate from DB `models`.
4. **Async First**: IO-bound work is `async def`. Do not mix sync IO into the async stack.
