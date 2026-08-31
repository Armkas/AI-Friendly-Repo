# 🐍 Backend AGENTS.md

## 局部规则 (Local Rules)
当在 `backend/` 目录下工作时，遵守以下 Python 和 FastAPI 开发约定：

1. **依赖注入**: 必须使用 FastAPI 的 `Depends` 实现依赖注入。路由 (Router) 不应该知道具体实现，而应该依赖于 `Protocol` 和 `Dependency Provider`。
2. **接口先行**: 领域逻辑接口必须定义为 `typing.Protocol` 并放置于各自业务的 `interface/` 包中。
3. **数据模型验证**: 使用 Pydantic V2 定义 `schemas`，并和 DB `models` 分离。
4. **异步先行**: IO 密集型操作必须是 `async def`，不要混用同步 IO 和异步框架。
