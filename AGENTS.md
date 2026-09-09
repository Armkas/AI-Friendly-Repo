# 🤖 AI-Friendly Repo - Central AI Agent Guide (AGENTS.md)

> **Canonical Single Source of Truth**: This repository is the open-source specification, template, and showcase for the **AI-Friendly Repo Standard**.
> When working within this repository, all AI agents must adhere to the standards defined in `spec/`.

---

## 🧪 Verification & Quality Assurance Commands

Whenever modifications are made to this repository (spec, templates, or examples), execute the following checks to verify integrity:

```bash
# 1. Check for broken file links and syntax consistency across Markdown files
find template spec examples -type f -name "*.md" -exec grep -H "file:///" {} + || true

# 2. Verify git status and ensure no untracked noise or broken artifacts
git status
```

---

## ⚠️ Scope & Status Declaration

- **Primary Mission**: Maintain the [AI-Friendly Repo Standard](spec/repository-standard.md) and the out-of-the-box [Scaffolded Template](template/).
- **Multi-lingual Alignment**: Any conceptual changes to core rules must be reflected in `spec/repository-standard.md`, `spec/philosophy.md`, `spec/philosophy.zh-CN.md`, and the localized `README` files (`README.md`, `README.zh-CN.md`, `README.ja.md`).
- **Do Not Invent Runtime Architectures**: This project specifies an **AI Context Architecture** sitting on top of conventional software architectures (MVVM, Clean, DDD, TCA). Never replace conventional architectures with artificial "AI-*" runtime variants.

---

## 🎯 Progressive Disclosure Navigation

Before modifying any content, follow this progressive reading order:

1. **Repository Standard (The Rules)**: [spec/repository-standard.md](spec/repository-standard.md)
2. **Philosophy (The Rationale)**: [spec/philosophy.md](spec/philosophy.md) ([简体中文](spec/philosophy.zh-CN.md) · [日本語](spec/philosophy.ja.md))
3. **Scaffold Template (The Skeleton)**: [template/](template/)
   - Root configuration: [template/AGENTS.md](template/AGENTS.md) & [template/.agentsignore](template/.agentsignore)
   - Operations boundary: [template/MANUAL_TASKS.md](template/MANUAL_TASKS.md)
   - Operational workflows: [template/.agents/workflows/](template/.agents/workflows/)
   - Architecture & Golden Feature: [template/docs/architecture/golden_feature_template.md](template/docs/architecture/golden_feature_template.md)
4. **Reference Implementations**: [examples/](examples/) (`ios/`, `fastapi/`, `mixed/`)

---

## 🏛 Core Inviolable Invariants

1. **Explicit Structure, Not Excessive Abstraction**: Prefer clear responsibilities, explicit interfaces, and concrete documentation over layers of unnecessary facades or proxies.
2. **Docs as Routing Layer, Not Second Copy**: Documentation guides the agent to the right place quickly; it is not a redundant duplicate of the source code.
3. **Multi-Agent Interoperability**: `AGENTS.md` remains the single canonical source of truth; platform adapters (`CLAUDE.md`, `GEMINI.md`) thin-wrap it via `@AGENTS.md`.

---

## 📋 Doc-Sync Checklist

- [ ] When adding/modifying rules in `spec/repository-standard.md`, update `spec/philosophy*.md` and localized `README*.md` accordingly;
- [ ] Ensure all relative Markdown links in `template/` and `docs/` point to valid files.
