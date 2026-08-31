# Project Map (iOS App)

本文件说明项目的构成与核心目录结构。

## 顶层目录
- `AGENTS.md` - 全局 AI 工作指南入口
- `.agents/` - AI 的索引与技能池
- `docs/` - **整个项目的知识层**（架构、领域模型、架构决策纪录）
- `ios/` - **具体的代码层**（iOS 原生实现）

## 主要子系统与位置
1. **Voice 领域**
   - 知识层：[docs/domains/voice.md](file:///Users/puyue/main/标准项目仓库设计/Example_iOS_Project/docs/domains/voice.md)
   - 代码层：[ios/Features/Voice/](file:///Users/puyue/main/标准项目仓库设计/Example_iOS_Project/ios/Features/Voice/)
2. **Navigation 领域**
   - 代码层：[ios/Features/Navigation/](file:///Users/puyue/main/标准项目仓库设计/Example_iOS_Project/ios/Features/Navigation/)
