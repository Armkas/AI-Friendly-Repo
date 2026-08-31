# DATA FLOW

End-to-end flows with the actual types crossing each boundary. Use this to trace
"where did X go wrong" without opening every file.

## 1. Continuous voice → navigation

```
AVAudioEngine
  │  AudioBuffer (Shared/Models/AudioBuffer.swift)
  ▼
VoiceSession  (Interface/VoiceSession.swift  impl Domain/LiveVoiceSession.swift)
  │  drives the state machine: idle→listening→transcribing→confirming→executing
  ▼
SpeechRecognizer  (Interface/SpeechRecognizer.swift)
  │  impl: DegradingSpeechRecognizer → tries in order:
  │        WebSocketSpeechRecognizer  →  RESTChunkedSpeechRecognizer  →  OnDeviceSpeechRecognizer
  │  AsyncStream<Transcript>  (partial + final)
  ▼
VoiceCommandService  (Interface/VoiceCommandService.swift  impl Infrastructure/LLMVoiceCommandService.swift)
  │  Transcript → VoiceCommand (.navigate(Destination) | .reroute(Preference) | .query(...) | .cancelTrip)
  │  + RiskLevel (.low / .high)
  ▼
Confirmation gate  (Domain/VoiceSessionMachine.swift)
  │  RiskLevel.high  ⇒ emit .confirming(VoiceCommand); wait for user confirm/reject
  │  RiskLevel.low   ⇒ pass straight through
  ▼
VoiceSession.commands  ──▶  App/AppDependencies wiring  ──▶  NavigationService.route(for:)
  │  Route
  ▼
MapScreenModel  ──▶  MapScreen renders the polyline
```

Failure behavior at each hop: see each domain doc's `## Invariants` and
`## State machine`.

## 2. Speech transport degradation (inside SpeechRecognizer)

```
NetworkMonitor.status
  ├─ .satisfied(lowLatency: true)   → WebSocketSpeechRecognizer   (bidirectional, partials)
  ├─ .satisfied(lowLatency: false)  → RESTChunkedSpeechRecognizer  (POST ~2s chunks)
  └─ .unsatisfied                   → OnDeviceSpeechRecognizer     (SFSpeechRecognizer on-device)
```

`DegradingSpeechRecognizer` owns this decision and can **fall back mid-session**
without ending the `VoiceSession`. See
[`adr/ADR-002-voice-degradation-strategy.md`](adr/ADR-002-voice-degradation-strategy.md).

## 3. Resolving named places ("take me home")

```
LLMVoiceCommandService  sees  savedPlace: "home"
  ▼
AccountService.savedPlace(named:)   (Features/Account/Interface/AccountService.swift)
  │  SavedPlace → Coordinate
  ▼
VoiceCommand.navigate(to: .coordinate(...))   (resolved BEFORE the confirmation gate)
```

## 4. App launch / wiring

```
AINativeApp (App/AINativeApp.swift)
  ▼
AppDependencies.live() (App/AppDependencies.swift)   builds concrete adapters + Voice→Nav→Map wiring
  ▼  injected via .environment(...)
RootView (App/RootView.swift)
  ├─ MapScreen              (Features/Map/Presentation)   ← MapScreenModel(routes:)
  └─ VoiceOverlayView       (Features/Voice/Presentation)  ← VoiceOverlayModel(session:)
```
