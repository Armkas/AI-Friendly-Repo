# DOMAIN MAP  (L1)

Business domains, their responsibilities, entry points, and how they relate.
Pick the **one** domain that owns your task, then go to its doc + `Interface/`.

```
                 ┌──────────────┐
    speech       │    Voice     │  mic → text → VoiceCommand → confirmation
   ───────────▶  │              │
                 └──────┬───────┘
                        │ confirmed VoiceCommand
                        ▼
                 ┌──────────────┐        ┌──────────────┐
                 │  Navigation  │ route  │     Map      │
                 │              ├───────▶│              │
                 └──────┬───────┘        └──────────────┘
                        │ needs identity / saved places
                        ▼
                 ┌──────────────┐
                 │   Account    │
                 └──────────────┘
```

---

## Voice   → [`domains/voice.md`](domains/voice.md)

- **Responsibility:** capture microphone audio, transcribe it (with graceful
  degradation across transports), convert transcript → structured `VoiceCommand`,
  gate high-risk commands behind user confirmation, own the session state machine.
- **Entry:** `Features/Voice/Interface/` — `VoiceSession`, `VoiceCommandService`,
  `SpeechRecognizer`.
- **Depends on:** `Core/Networking` (HTTP, WebSocket, NetworkMonitor),
  Apple `Speech` framework (in Infrastructure), `Navigation.Interface` (to name
  intents; not to execute).
- **Used by:** `App` (hosts the overlay), `Map.Presentation` (shows transcript).
- **Does NOT:** execute navigation, draw on the map, persist raw audio.

## Navigation   → [`domains/navigation.md`](domains/navigation.md)

- **Responsibility:** compute routes, recompute on deviation, own a navigation
  session with progress (distance/time remaining, next maneuver).
- **Entry:** `Features/Navigation/Interface/` — `NavigationService`.
- **Depends on:** `Core/Location`, `Core/Networking`.
- **Used by:** `Voice` (command target), `Map` (renders route + maneuvers).
- **Does NOT:** own the camera or annotations (that's Map), know about speech.

## Map   → [`domains/map.md`](domains/map.md)

- **Responsibility:** camera control, follow-user mode, annotations, drawing the
  active route + next-maneuver hint.
- **Entry:** `Features/Map/Interface/` — `MapController`.
- **Depends on:** `Core/Location`, `Navigation.Interface` (observes route),
  MapKit (Infrastructure).
- **Used by:** `App` (root screen).
- **Does NOT:** compute routes, recognize speech.

## Account   → [`domains/account.md`](domains/account.md)

- **Responsibility:** sign-in, profile, saved places ("home", "work"),
  entitlements (e.g. premium voice).
- **Entry:** `Features/Account/Interface/` — `AccountService`.
- **Depends on:** `Core/Networking`, `Core/Storage`.
- **Used by:** `Voice` (resolve "home"), `Navigation` (saved places), `App`.
- **Does NOT:** handle payment UI flows in this template.

---

## Allowed dependency edges (features)

```
Voice.Interface       ←  App, Map.Presentation
Navigation.Interface  ←  App, Voice.*, Map.*
Map.Interface         ←  App
Account.Interface     ←  App, Voice.Infrastructure, Navigation.Infrastructure
```

Anything not listed is a violation — see `AI/ARCHITECTURE.md`.
