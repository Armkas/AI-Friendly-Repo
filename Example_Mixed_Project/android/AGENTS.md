# 🤖 Android AGENTS.md

## 局部规则 (Local Rules)
当在 `android/` 目录下工作时，遵守以下 Android 开发约定：

1. **UI 框架**: 全部使用 Jetpack Compose。严禁使用旧版 XML 布局。
2. **架构模式**: 采用 Clean Architecture 和 MVI。
3. **依赖注入**: 统一使用 Hilt 进行依赖注入。
4. **并发模型**: 使用 Kotlin Coroutines 和 Flows。
