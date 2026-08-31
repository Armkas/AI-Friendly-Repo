# 🍏 iOS AGENTS.md

## 局部规则 (Local Rules)
本目录（及其子目录）下的代码必须遵循以下 iOS / Swift 开发规范：

1. **架构模式**: 采用 Clean Architecture 概念。
2. **依赖倒置**: 业务模块之间的依赖必须通过 `Protocol`，并且 Protocol 的定义应该位于 `Interface/` 目录下。
3. **UI 框架**: 全部使用 SwiftUI，避免使用 UIKit 除非没有替代方案。
4. **并发模型**: 使用 Swift Concurrency (`async/await`, `Task`, `actor`)，禁止使用旧版的 completion handlers 或 GCD。

> 当在 `ios/` 目录下工作时，请牢记根目录 `AGENTS.md` 和本文件的叠加约束。
