# CONVENTIONS

## Naming — names are the index

AI navigation is mostly search over symbols. Generic names defeat it.

**Banned as a whole name:** `Manager`, `Helper`, `Util`/`Utils`, `Common`,
`Handler`, `Worker`, `Processor`, `Service` (alone), `Data`, `Info`, `Object`.

**Do:** name the responsibility precisely.

| Instead of | Use |
| ---------- | --- |
| `VoiceManager` | `VoiceSession`, `VoiceSessionMachine` |
| `SpeechHelper` | `DegradingSpeechRecognizer`, `OnDeviceSpeechRecognizer` |
| `RouteManager` | `RouteRecalculationService` |
| `NetworkUtils` | `HTTPClient`, `WebSocketChannel`, `NetworkMonitor` |
| `MapHelper` | `MapCameraController` |

Protocol / implementation pair: `Foo` (protocol) + `<Adjective>Foo`
(`DefaultFoo`, `LLMVoiceCommandService`, `WebSocketSpeechRecognizer`, `MockFoo`).

## Files

- One primary type per file; file name == type name.
- Target < 300 lines. Split when a file passes ~400 or mixes concerns.
- One `Interface/` file per capability (protocol + its DTOs + Contract).
- No `+Extensions.swift` grab-bags; name by what the extension does.

## Interface / Contract doc comment

Every `protocol` in `Interface/` carries:

```swift
/// One-sentence purpose.
///
/// Contract:
/// - Input:   what it accepts, preconditions.
/// - Output:  what it returns / streams.
/// - Failure: which errors, when; what does NOT throw.
/// - Effects: side effects (I/O, persistence, notifications). "None" if pure.
/// - Forbidden: things an implementation must never do.
/// - Threading: actor / main-actor / thread-safe / caller's context.
protocol Foo { ... }
```

## SwiftUI

- View = layout + bindings only. State + logic in an `@Observable` model
  (`FooScreenModel`, `VoiceOverlayModel`) in `Presentation/`.
- Models are `@MainActor @Observable final class`.
- Dependencies enter via `@Environment` (protocol types), never constructed in a
  `View`.
- No `Task`/`URLSession`/timers in a `View` body or `.onAppear` beyond calling a
  model method.
- Previews use `Mock*` / `Preview*` implementations.

## Concurrency

- Prefer `async` funcs; streams as `AsyncStream` / `AsyncThrowingStream`.
- Network/hardware adapters are `actor`s unless the `Contract:` says thread-safe.

## Tests

- File: `<TypeUnderTest>Tests.swift`, mirroring the source path under `Tests/`.
- Name: `test_<condition>_<expectedResult>()`
  - `test_networkUnavailable_usesOnDevice()`
  - `test_silenceBeyondTimeout_endsSession()`
  - `test_highRiskCommand_requiresConfirmation()`
- One behavior per test. The name is documentation — a reader should not need the
  body to know the rule.
- Each `Interface/` protocol ⇒ at least one `*Tests` file.

## Errors

- One `enum <Domain>Error: Error` per feature in `Interface/`.
- Adapters map SDK/transport errors into the domain error; they never leak
  `URLError`, provider SDK errors, etc. across an `Interface/` boundary.

## ADRs

- New non-obvious decision, or reversing an old one ⇒ add
  `AI/adr/ADR-NNN-<slug>.md` (template in `AI/adr/README.md`). Link it from the
  affected domain doc.
