# 🤖 AGENTS.md (Root)

## Project Introduction
This project is a pure iOS (SwiftUI) application project. It demonstrates how to build a project knowledge layer using the "AI-Friendly Repo Standard 1.0".

## AI Navigation Guide
Please strictly follow this order to understand the project context:

1. **Macro Map**: [docs/PROJECT_MAP.md](file:///Users/puyue/main/标准项目仓库设计/examples/ios/docs/PROJECT_MAP.md) - Understand the overall structure.
2. **Domain Knowledge**: `docs/domains/*.md` - When encountering specific business logic (e.g., Voice), read the corresponding Domain document first.
3. **Architecture & Decisions**: `docs/architecture/` and `docs/adr/`.
4. **Concrete Implementation**: Only dive into the concrete code in the `ios/` directory when troubleshooting bugs or executing modification tasks.

## Global Invariants
- All business modules in `ios/` must be divided by Feature boundaries. Pure horizontal layering (like mixing all business logic in `Controllers/`, `Models/`) is strictly prohibited.
- Do not explain all details in this file; this is just the map entrance!
