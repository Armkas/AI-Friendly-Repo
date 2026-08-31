# Project Map (Mixed Platform)

## 顶层结构
- `AGENTS.md` - 全局向导
- `docs/` - **系统认知层**（跨端通用的领域知识、架构图、不变量）
- `ios/` - iOS 客户端 (SwiftUI)
- `android/` - Android 客户端 (Jetpack Compose)
- `web/` - Web 前端
- `backend/` - 后端服务 (FastAPI)

## 子系统定位示例：Voice 领域
无论是哪个端，“Voice”这个业务逻辑的通用说明都在：
- 知识层：[docs/domains/voice.md](file:///Users/puyue/main/标准项目仓库设计/Example_Mixed_Project/docs/domains/voice.md)

代码实现分别位于：
- iOS: [ios/Features/Voice/](file:///Users/puyue/main/标准项目仓库设计/Example_Mixed_Project/ios/Features/Voice/)
- Android: [android/app/src/main/java/com/example/features/voice/](file:///Users/puyue/main/标准项目仓库设计/Example_Mixed_Project/android/app/src/main/java/com/example/features/voice/)
- Web: [web/src/features/voice/](file:///Users/puyue/main/标准项目仓库设计/Example_Mixed_Project/web/src/features/voice/)
- Backend: [backend/features/voice/](file:///Users/puyue/main/标准项目仓库设计/Example_Mixed_Project/backend/features/voice/)
