# 🤖 Android AGENTS.md

## Local Rules
When working in the `android/` directory, adhere to the following Android development conventions:

1. **UI Framework**: Exclusively use Jetpack Compose. Using legacy XML layouts is strictly forbidden.
2. **Architectural Pattern**: Clean Architecture and MVI at the **runtime** plane. Shared business meaning stays in `docs/domains/`.
3. **Dependency Injection**: Use Hilt uniformly for dependency injection.
4. **Concurrency Model**: Use Kotlin Coroutines and Flows.
