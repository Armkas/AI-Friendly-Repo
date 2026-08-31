# PROJECT MAP  (L0)

> Read this first. It should be enough to know *where to go next* for any task.
> If you need more than this to decide, that's a bug in this file — fix it.

## What this is

**AINativeApp** is an iOS app (SwiftUI, iOS 17+) for map + turn-by-turn navigation
with a continuous voice assistant. A user can speak naturally ("take me home",
"avoid the highway", "how long is left?") and the app recognizes speech, turns it
into a structured command, confirms risky actions, and drives the map/navigation.

This repo as published is a **standard/reference template** — the Voice feature is
fully worked; Navigation / Map / Account are skeletons that show the pattern.

## Architecture in one line

**Feature-based vertical slices** over a shared **Core**, with a strict
`Interface → Domain/Infrastructure` split inside each feature. Details:
[`ARCHITECTURE.md`](ARCHITECTURE.md).

## Business domains

| Domain | Owns | Doc |
| ------ | ---- | --- |
| **Voice** | mic capture, speech→text, text→structured command, confirmation gate, session state | [`domains/voice.md`](domains/voice.md) |
| **Navigation** | route calculation, re-routing, navigation session + progress | [`domains/navigation.md`](domains/navigation.md) |
| **Map** | camera, annotations, rendering the route, follow-user mode | [`domains/map.md`](domains/map.md) |
| **Account** | sign-in, profile, saved places, entitlements | [`domains/account.md`](domains/account.md) |

## Core flow

```
mic → Voice (speech → command) → confirmation gate → Navigation (route) → Map (render)
```

Full flows with types: [`DATA_FLOW.md`](DATA_FLOW.md).

## Entry points

| Thing | File |
| ----- | ---- |
| App / composition root | `App/AINativeApp.swift`, `App/AppDependencies.swift` |
| Root UI | `App/RootView.swift` |
| Voice session (start/stop/state) | `Features/Voice/Interface/VoiceSession.swift` |
| Speech → command | `Features/Voice/Interface/VoiceCommandService.swift` |
| Speech → text (degrading) | `Features/Voice/Interface/SpeechRecognizer.swift` |
| Navigation | `Features/Navigation/Interface/NavigationService.swift` |
| Map | `Features/Map/Interface/MapController.swift` |
| Account | `Features/Account/Interface/AccountService.swift` |

## Directory responsibilities

| Path | Responsibility | May depend on |
| ---- | -------------- | ------------- |
| `App/` | wire dependencies, host root view. **No business logic.** | every `Interface/`, `Core/` |
| `Features/<X>/Interface/` | protocols, `Contract:` docs, DTOs for domain X | `Shared/`, other features' `Interface/` |
| `Features/<X>/Domain/` | pure orchestration/state machines for X | X's `Interface/`, `Shared/` |
| `Features/<X>/Infrastructure/` | concrete adapters for X (network, SDK, on-device) | X's `Interface/`, `Core/`, `Shared/` |
| `Features/<X>/Presentation/` | SwiftUI + `@Observable` models for X | X's `Interface/`, `Shared/` |
| `Core/` | cross-domain capability (HTTP, WebSocket, Location, Storage, Log) | `Shared/` only |
| `Shared/` | leaf value types, extensions | nothing in this repo |
| `Tests/` | behavior-named tests mirroring `Features/` | anything |

## Top rules (full list in AI/INVARIANTS.md)

1. A feature talks to another feature **only** through its `Interface/`.
2. `Infrastructure/` and `Core/` never import `Presentation/`.
3. Business rules never live in a SwiftUI `View`.
4. Voice never executes a high-risk command without explicit user confirmation.
5. Never edit `AI/generated/*` by hand — run `Scripts/generate_ai_index.sh`.

## Do not read (unless explicitly needed)

`build/`, `DerivedData/`, `*.xcodeproj/`, `Pods/`, `.swiftpm/`, snapshot images,
`AI/generated/*` (that's an L5 index, not L0 context).
