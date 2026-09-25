# 🤖 [Project Name] - Central AI Agent Guide (AGENTS.md)

[简体中文](AGENTS.zh-CN.md) | [日本語](AGENTS.ja.md)

> **Canonical Single Source of Truth**: This file is the primary entry point and specification for all AI coding agents (Claude Code, Gemini/Antigravity, Cursor, Windsurf, Copilot, etc.).
> The repository adheres to a **Two-Layer Policy**:
> - **Layer 1 (AI Context Architecture)**: Governed by this file, `docs/`, and `.agents/`, defining maps, contracts, invariants, and navigation hierarchy;
> - **Layer 2 (Software Runtime Architecture)**: Enforced by the compiler, static typechecker, linter, and build commands.

---

## 🧪 Verification & Quality Assurance Commands

After modifying code or adding features, **you must execute the following commands in sequence for closed-loop verification**. Any unaddressed failure means the task is incomplete:

```bash
# 1. Static type checking (Must be 0 errors)
# e.g., npm run typecheck / mypy . / swift build
<Typecheck Command>

# 2. Compilation or bundle build (Must succeed)
# e.g., npm run build / cargo check / xcodebuild ...
<Build Command>

# 3. Core unit or integration tests (If tests are active in current phase)
# e.g., npm test / pytest
<Test Command>
```

> 💡 **Agent Mandate**: Never claim "the task is finished" without executing these verification commands. If dependencies are missing or the environment cannot run them, explicitly notify the user.

---

## ⚠️ Scope & Status Declaration

Define the current development boundaries to prevent agents from wasting tokens or hallucinating across frozen areas:

- **Frozen Modules / Platforms**: [e.g. Android client is currently frozen; do NOT read or modify]
- **Testing Directives**: [e.g. Focus on typechecking and build passing; do not write unit tests in this phase]
- **Operational Boundary**: Any operation involving external web consoles, production migrations, or credentials must be registered in [MANUAL_TASKS.md](MANUAL_TASKS.md).

---

## 🎯 Progressive Disclosure Navigation

Always follow this reading hierarchy. **Never jump directly into implementation files or run blanket grep across the entire codebase**:

1. **Global and Platform Rules**:
   - Global rules: [.agents/rules/global.md](.agents/rules/global.md)
   - Platform rules: `.agents/rules/[platform].md` (e.g., `web.md`, `ios.md`, `backend.md`)
2. **System Map and Context Index**:
   - System topology: [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)
   - Machine-readable index: [.agents/context-index.md](.agents/context-index.md) (Locates interface and model symbols)
3. **Domain Knowledge**: [docs/domains/](docs/domains/) (Understand business flows, lifecycle, and state machines)
4. **Contracts**: [docs/contracts/](docs/contracts/)
   - API / RPC contracts: [backend_rpc.md](docs/contracts/backend_rpc.md)
   - Database schema: [database_schema.md](docs/contracts/database_schema.md)
5. **Architectural Decisions & Invariants**:
   - Historical trade-offs (Why): [docs/adr/](docs/adr/)
   - Inviolable business rules: [docs/invariants/](docs/invariants/)
6. **Dependency & Impact Analysis**: [.agents/dependency-map.md](.agents/dependency-map.md)
7. **Feature Blueprint**: [docs/architecture/golden_feature_template.md](docs/architecture/golden_feature_template.md)
8. **Implementation Code**: Only dive into implementation after inspecting the corresponding `Interface`.

---

## 🏛 Core Inviolable Invariants

1. **Interface Over Implementation**: Always define interfaces/protocols in `Interface/` before writing implementations. Never pile hundreds of lines of code into a single file without contracts.
2. **Single Source of Truth (SoT)**: Centralize business thresholds, enums, and configuration in central config or database dictionaries. Never hardcode magic literals in UI layers.
3. **Never Guess Logic**: When encountering ambiguous boundary conditions, check `docs/invariants/` and `docs/adr/`. If unresolved, ask the user instead of guessing.
4. **Preserve Context Budget**: Adhere to progressive disclosure; do not read unrelated files into context.

---

## 📋 Doc-Sync Checklist (Anti-Corruption Discipline)

Before submitting any code changes, **cross-check against this checklist to prevent documentation rot**:

- [ ] **Modified an abstract protocol or interface?**
  - Update Key Interfaces in [.agents/context-index.md](.agents/context-index.md);
  - Update [.agents/dependency-map.md](.agents/dependency-map.md).
- [ ] **Modified backend API / RPC inputs or outputs?**
  - Update schema and error codes in [docs/contracts/backend_rpc.md](docs/contracts/backend_rpc.md).
- [ ] **Modified database tables or columns?**
  - Append an incremental timestamped migration SQL file (never edit historical migrations);
  - Update [docs/contracts/database_schema.md](docs/contracts/database_schema.md).
- [ ] **Added a new Feature module?**
  - Follow [docs/architecture/golden_feature_template.md](docs/architecture/golden_feature_template.md);
  - Register module in [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) and [docs/domains/](docs/domains/).
- [ ] **Requires manual configuration on external web dashboards?**
  - Record the task in [MANUAL_TASKS.md](MANUAL_TASKS.md) with `[ ]`.
