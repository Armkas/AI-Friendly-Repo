# 🍏 iOS AGENTS.md

## Runtime Architecture
This directory is the **runtime plane**. Keep Feature + MVVM / Clean. The AI Context Layer lives in root `AGENTS.md` and `docs/`.

## Local Rules
Code under this directory must adhere to:

1. **Architectural Pattern**: Feature modules; MVVM / Clean at the runtime layer (View → ViewModel → UseCase / Service → Repository).
2. **Dependency Inversion**: Cross-module dependencies go through `Protocol` in `Interface/`. One real capability → one protocol, not a stack of unused adapters.
3. **UI Framework**: SwiftUI. Avoid UIKit unless there is no alternative.
4. **Concurrency Model**: Swift Concurrency (`async/await`, `Task`, `actor`). No legacy completion handlers or GCD.

> When working in `ios/`, stack root `AGENTS.md` with this file.
