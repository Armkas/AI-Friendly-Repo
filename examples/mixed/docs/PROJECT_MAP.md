# Project Map (Mixed Platform)

One AI Context Layer; each platform keeps its own runtime architecture.

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

## 顶层结构
- `AGENTS.md` — 认知入口（Agent 工作合同）
- `docs/` — **AI Context Architecture**（跨端领域知识、架构、不变量）
- `ios/` — Runtime：Feature + MVVM / Clean（SwiftUI）
- `android/` — Runtime：Clean + MVI（Compose）
- `web/` — Runtime：Feature-Sliced（React）
- `backend/` — Runtime：Feature + DDD / Clean / DI（FastAPI）

## 子系统定位示例：Voice 领域
跨端业务说明（认知层）在：
- [docs/domains/voice.md](domains/voice.md)

各端运行时实现：
- iOS: `ios/Features/Voice/`
- Android: `android/app/src/main/java/com/example/features/voice/`
- Web: `web/src/features/voice/`
- Backend: `backend/features/voice/`
