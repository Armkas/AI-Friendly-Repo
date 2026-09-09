# 🤖 Global Agent Rules & Guidelines (global.md)

[简体中文](global.zh-CN.md)

This project follows the **AI-Friendly Repository Standard**, strictly separating the **AI Context Architecture (`docs/`, `.agents/`)** from the **Software Runtime Architecture (source code)**.

---

## ⚠️ Inviolable Invariants

1. **Interface First**:
   - For any new feature or refactoring, abstract contracts must be declared in `Interface/` first.
   - Never pile hundreds of lines of implementation code into a file without interface definitions.
2. **Single Source of Truth (SoT)**:
   - Configuration constants, limits, and status dictionaries must be declared centrally. Never hardcode magic numbers or literals in View files.
3. **Never Guess Logic**:
   - If encountering unspecified business boundaries, inspect `docs/invariants/` and `docs/adr/`. If still unresolved, ask the user directly.
4. **Mandatory Verification**:
   - Before completing any task, execute the verification commands declared in `AGENTS.md` (typecheck, build, lint). Zero errors are required.

---

## 🎯 Progressive Disclosure Navigation

Never run blanket grep searches across the entire repo. Follow this reading sequence:

1. **Root Specs & Rules**: [AGENTS.md](../../AGENTS.md) and this file;
2. **System Map & Index**: [docs/PROJECT_MAP.md](../../docs/PROJECT_MAP.md) and [.agents/context-index.md](../context-index.md);
3. **Domain Knowledge**: `docs/domains/*.md` (Understand business terminology and state machines);
4. **Contracts**: `docs/contracts/` (API payloads and database schema);
5. **Decisions & Invariants**: `docs/adr/` and `docs/invariants/` (Learn historical trade-offs and non-negotiables);
6. **Impact Radius**: [.agents/dependency-map.md](../dependency-map.md);
7. **Implementation Code**: Navigate to the target Feature, read `Interface` first, then inspect `Implementation`.

---

## 📋 Doc-Sync Anti-Corruption Checklist

Whenever you modify code, cross-check and update documentation:

- [ ] **Modified an Interface / Protocol**: Update `context-index.md` and `dependency-map.md`;
- [ ] **Modified an API / RPC endpoint**: Update `docs/contracts/backend_rpc.md`;
- [ ] **Modified database tables or columns**: Add a timestamped migration and update `docs/contracts/database_schema.md`;
- [ ] **Added a new Feature**: Follow `golden_feature_template.md` and register in `PROJECT_MAP.md`;
- [ ] **Generated external manual requirements**: Register in `MANUAL_TASKS.md` with `[ ]`.
