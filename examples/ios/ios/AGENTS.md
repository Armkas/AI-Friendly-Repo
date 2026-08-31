# 🍏 iOS AGENTS.md

## Local Rules
Code under this directory (and its subdirectories) must adhere to the following iOS / Swift development conventions:

1. **Architectural Pattern**: Adopt Clean Architecture concepts.
2. **Dependency Inversion**: Dependencies between business modules must use `Protocol`, and the Protocol definition should be located in the `Interface/` directory.
3. **UI Framework**: Exclusively use SwiftUI. Avoid UIKit unless there is no alternative.
4. **Concurrency Model**: Use Swift Concurrency (`async/await`, `Task`, `actor`). Legacy completion handlers or GCD are forbidden.

> When working in the `ios/` directory, keep in mind the combined constraints of the root `AGENTS.md` and this file.
