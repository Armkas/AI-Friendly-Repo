# 🤖 AGENTS.md (Root)

## Project Introduction
This project is a large-scale mixed application containing iOS (SwiftUI), Android (Compose), Web Frontend, and Backend (FastAPI).
This repository demonstrates how the "AI-Friendly Repo Standard 1.0" perfectly decouples the "Knowledge Layer" and the "Code Layer".

## AI Navigation Guide
Regardless of which client/end you are modifying, you must obtain project knowledge from the following paths:
1. **Macro Map**: [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) - Locate the end and corresponding module you want to modify.
2. **Cross-Platform Domain Knowledge**: `docs/domains/` - Understand the essence of the business (this part is agnostic to the specific code end and is common to all platforms).
3. **Independent Rules per Platform**: Before entering a specific platform's directory, you must read the `AGENTS.md` in that directory (e.g., `ios/AGENTS.md`).

## Global Invariants
- **Single Source of Truth for Documentation**: Cross-platform business rules (e.g., error codes, core state machines) are uniformly defined in `docs/domains/`. All platforms must strictly adhere to them; fragmentation is not allowed.
