# 🐍 Backend AGENTS.md

## Local Rules
When working in the `backend/` directory, adhere to the following Python and FastAPI development conventions:

1. **Dependency Injection**: Must use FastAPI's `Depends` for dependency injection. Routers should not know the concrete implementation; they should depend on `Protocol` and `Dependency Provider`.
2. **Interface First**: Domain logic interfaces must be defined as `typing.Protocol` and placed in the `interface/` package of their respective business domain.
3. **Data Model Validation**: Use Pydantic V2 to define `schemas`, separated from DB `models`.
4. **Async First**: IO-bound operations must be `async def`. Do not mix sync IO with async frameworks.
