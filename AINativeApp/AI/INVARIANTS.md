# INVARIANTS

Rules that must hold **after any refactor**. You may rewrite any implementation.
You may not violate these. Each has an owning test; if you change behavior such
that an invariant no longer applies, that requires an ADR, not just a code edit.

## Global

| # | Invariant | Enforced by |
| - | --------- | ----------- |
| G1 | A feature accesses another feature only via its `Interface/` types. | review + `generate_ai_index.sh` warning |
| G2 | `Infrastructure/` and `Core/` never import `Presentation/` or SwiftUI. | review + script check |
| G3 | Business rules never live in a SwiftUI `View`. Views only render + forward intents. | review |
| G4 | `Core/` never imports `Features/`. | review + script check |
| G5 | No secrets, tokens, or PII in logs, URLs, or query strings. | `Core/Logging` redaction + review |
| G6 | Every `protocol` in an `Interface/` folder has a `Contract:` doc comment and a `*Tests` file. | review |
| G7 | `AI/generated/*` is only written by `Scripts/generate_ai_index.sh`. | review |

## Voice

| # | Invariant | Test |
| - | --------- | ---- |
| V1 | A speech-recognition transport failure must **not** end the `VoiceSession`; it triggers degradation to the next transport. | `DegradingSpeechRecognizerTests.test_transportFailure_fallsBackWithoutEndingStream` |
| V2 | When the network is unavailable, the session continues on `OnDeviceSpeechRecognizer`. | `DegradingSpeechRecognizerTests.test_networkUnavailable_usesOnDevice` |
| V3 | User silence longer than `VoiceConfig.silenceTimeout` (default 20s) ends the session and returns to `.idle`. | `VoiceSessionMachineTests.test_silenceBeyondTimeout_endsSession` |
| V4 | A `VoiceCommand` with `RiskLevel.high` is never executed without an explicit user confirmation event. | `VoiceSessionMachineTests.test_highRiskCommand_requiresConfirmation` |
| V5 | Raw audio is never persisted to disk and never leaves the device except as an in-flight recognition request. | `LLMVoiceCommandServiceTests` + review |
| V6 | `VoiceCommandService` returns a validated `VoiceCommand` or throws; it never returns a partially-formed command or guesses on an ambiguous transcript. | `LLMVoiceCommandServiceTests.test_ambiguousTranscript_throwsRatherThanGuessing` |
| V7 | Voice never calls `NavigationService` directly for a high-risk command — it goes through the session machine's confirmation gate. | `VoiceSessionMachineTests.test_highRiskCommand_requiresConfirmation` |
| V8 | Any fatal error transitions the machine to `.idle` (never a stuck state). | `VoiceSessionMachineTests.test_fatalError_returnsToIdle` |

## Navigation

| # | Invariant | Test |
| - | --------- | ---- |
| N1 | A `Route` always contains at least an origin and a destination. | `NavigationServiceTests` |
| N2 | Auto-reroute is suppressed while GPS horizontal accuracy is worse than `NavConfig.minAccuracy` (default 50m). | `NavigationServiceTests` |
| N3 | With no network, `route(for:)` returns the last cached route for the same destination if present, else throws `NavigationError.offline`. | `NavigationServiceTests` |

## Account

| # | Invariant | Test |
| - | --------- | ---- |
| A1 | Entitlement checks fail **closed**: unknown/expired entitlement ⇒ treated as not entitled. | `AccountServiceTests` |
| A2 | Auth tokens are stored only in Keychain, never in `KeyValueStore`/`UserDefaults`. | review + `AccountServiceTests` |
