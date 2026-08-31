# 🤖 AGENTS.md (Root)

## Project Introduction
This project is a pure Backend (FastAPI) service. It demonstrates the Python service architecture organized according to the "AI-Friendly Repo Standard 1.0".

## AI Navigation Guide
1. **Macro Map**: [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) - Understand the overall structure.
2. **Domain Knowledge**: `docs/domains/*.md` - Understand business rules.
3. **Implementation Details**: In the `backend/` directory, prioritize reading the `interface/` modules and `schemas/` contracts.

## Global Invariants
- **Domain-based Packaging**: API routers, business services, and data models must be cohesive by business domain (e.g., `features/voice/`). Pure horizontal packaging by `routers/`, `services/`, `models/` at the top level is strictly forbidden.
