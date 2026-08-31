# DEPENDENCY MAP  (hand-maintained summary)

The authoritative, generated edge list is
[`generated/DEPENDENCY_GRAPH.md`](generated/DEPENDENCY_GRAPH.md). This file is the
human-curated "what should be true" version. If they disagree, the generated file
is reality and one of {this file, the code} is wrong.

## Module-level (allowed imports)

```
App
 ├─▶ Voice.Interface, Voice.Presentation, Voice.Domain, Voice.Infrastructure
 ├─▶ Navigation.Interface, Navigation.Infrastructure
 ├─▶ Map.Interface, Map.Presentation
 ├─▶ Account.Interface
 └─▶ Core.*, Shared

Voice.Presentation ─▶ Voice.Interface, Shared
Voice.Domain       ─▶ Voice.Interface, Shared
Voice.Infrastructure ─▶ Voice.Interface, Account.Interface,
                        Core.Networking, Core.Logging, Shared, (Apple Speech)

Navigation.Infrastructure ─▶ Navigation.Interface, Core.Location, Core.Networking, Core.Storage, Shared
Map.Presentation          ─▶ Map.Interface, Navigation.Interface, Shared, (MapKit)
Account.Infrastructure    ─▶ Account.Interface, Core.Networking, Core.Storage, Shared

Core.*  ─▶ Shared           (only)
Shared  ─▶ (nothing)
```

## Key object graph (runtime, Voice)

```
VoiceOverlayModel
 └─▶ VoiceSession  (LiveVoiceSession)
      ├─▶ VoiceSessionMachine        (pure)
      ├─▶ MicrophoneCapturing        (AVAudioEngineMicrophone)
      ├─▶ SpeechRecognizer  (DegradingSpeechRecognizer)
      │    ├─▶ WebSocketSpeechRecognizer ─▶ WebSocketChannel (Core)
      │    ├─▶ RESTChunkedSpeechRecognizer ─▶ HTTPClient (Core)
      │    ├─▶ OnDeviceSpeechRecognizer  ─▶ SFSpeechRecognizer (Apple)
      │    └─▶ NetworkMonitor (Core)
      └─▶ VoiceCommandService  (LLMVoiceCommandService)
           ├─▶ HTTPClient (Core)
           └─▶ AccountService  (resolve saved places)
```

## Forbidden edges (enforced by review; script flags some)

- `*.Presentation` ◀── anything except `App`.
- `*.Infrastructure` ◀── another feature.
- `Core/*` ─▶ `Features/*`  (Core must not know features exist).
- any `View` ─▶ `URLSession` / `HTTPClient` / `WebSocketChannel`.
