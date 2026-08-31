# ARCHITECTURE

## Shape: feature-based vertical slices + shared Core

```
App/                     composition root (wires protocols → implementations)
│
Features/<Domain>/
│   Interface/            protocols + Contract docs + DTOs         (public face)
│   Domain/               pure logic: state machines, orchestration (no I/O)
│   Infrastructure/       concrete adapters: network, SDKs, on-device
│   Presentation/         SwiftUI views + @Observable models
│
Core/                    cross-domain capabilities (HTTP, WebSocket, Location, Storage, Log)
Shared/                   leaf value types + extensions
Tests/                    mirrors Features/
```

Why feature-based and not `Views/ Models/ Services/`:
see [`adr/ADR-001-feature-based-architecture.md`](adr/ADR-001-feature-based-architecture.md).

## Dependency rule (compile-time direction)

```
Presentation ──▶ Interface ◀── Domain
                    ▲            │
                    │            ▼
              Infrastructure ──▶ Core ──▶ Shared
```

- **Everything points at `Interface/`.** Nothing points back out of it.
- `Domain/` and `Infrastructure/` depend on their own `Interface/`, never on
  `Presentation/`.
- `Core/` depends only on `Shared/`. `Shared/` depends on nothing.
- A feature may import **another feature's `Interface/` only** — never its
  `Domain/`, `Infrastructure/`, or `Presentation/`.
- `App/` is the only place allowed to name concrete implementation types.

## Interface / Implementation separation

Rationale: [`adr/ADR-003-interface-implementation-separation.md`](adr/ADR-003-interface-implementation-separation.md).

Each capability is a `protocol` in `Interface/` with a `Contract:` doc comment
covering: **inputs, outputs, failure modes, side effects, forbidden behavior,
threading**. Implementations live in `Infrastructure/`. Agents read the interface
first; they open the implementation only when the interface/tests can't explain a
problem (L5).

The interface is **intent**. It is not a promise the implementation is correct —
tests and invariants are how correctness is checked.

## Composition

`App/AppDependencies.swift` is the single wiring point. It builds concrete
adapters and exposes them as their protocol types via SwiftUI `Environment`.
Swapping an implementation (e.g. mock speech in tests, on-device only in a debug
build) is a one-line change there.

## Concurrency

- Protocols use `async`/`await`; long-lived streams use `AsyncStream`.
- `@Observable` presentation models are `@MainActor`.
- `Infrastructure/` types that touch hardware/network are `actor`s or documented
  as thread-safe in their `Contract:`.

## SwiftUI

- Views are declarative and stateless beyond `@State` for pure view concerns.
- All screen state + intent handling lives in an `@Observable` model in
  `Presentation/`, injected from `Environment`.
- No `URLSession`, no business rules, no `Task { }` orchestration inside a `View`.

## Testing strategy

- Unit tests target `Domain/` (pure) and `Infrastructure/` (against fakes for
  `Core/`).
- Every `protocol` in `Interface/` has a corresponding `*Tests` file.
- Test names are behavior statements. See `AI/CONVENTIONS.md`.
