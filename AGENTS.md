# 🤖 AI-Native Repo - Central AI Agent Guide (AGENTS.md)

> **Semantic Truth & Runtime Entry**: This repository is the open-source specification, template, and showcase for the **AI-Native Repository Standard**.
> When working within this repository, all AI agents must adhere to the standards defined in `spec/`.

---

## 🧪 Verification & Quality Assurance Commands

Whenever modifications are made to this repository (spec, templates, or examples), execute the following checks to verify integrity:

```bash
# 1. Run the official self-validation script
./scripts/validate.sh

# 2. Check for broken file links and syntax consistency across Markdown files
find templates spec examples -type f -name "*.md" -exec grep -H "file:///" {} + || true

# 3. Verify git status and ensure no untracked noise or broken artifacts
git status
```

---

## ⚠️ Scope & Status Declaration

- **Primary Mission**: Maintain the [AI-Native Repository Standard](spec/repository-standard.md) and the out-of-the-box [Native Templates](templates/).
- **Multi-lingual Alignment**: Any conceptual changes to core rules must be reflected in `spec/repository-standard.md`, `spec/philosophy.md`, `spec/philosophy.zh-CN.md`, and the localized `README` files (`README.md`, `README.zh-CN.md`, `README.ja.md`).
- **Model-Agnostic, Runtime-Aware**: This project specifies an **AI Context Architecture** sitting on top of conventional software architectures (MVVM, Clean, DDD, TCA). It does not invent AI-specific application runtimes.

---

## 🎯 Context Routing Navigation

Before modifying any content, identify the required context area:

1. **Repository Standard (The Rules)**: [spec/repository-standard.md](spec/repository-standard.md)
2. **Philosophy (The Rationale)**: [spec/philosophy.md](spec/philosophy.md) ([简体中文](spec/philosophy.zh-CN.md) · [日本語](spec/philosophy.ja.md))
3. **Runtime Adapters (The Mapping)**: [spec/adapters.md](spec/adapters.md)
4. **Native Templates (The Skeletons)**: [templates/](templates/)
   - `claude-code/`
   - `codex/`
   - `cursor/`
   - `gemini-cli/`
5. **Reference Implementations**: [examples/](examples/) (`claude-code/`, `codex/`, `cursor/`, `gemini-cli/`)

---

## 🏛 Core Inviolable Invariants

1. **Explicit Structure, Not Excessive Abstraction**: Prefer clear responsibilities, boundary-driven interfaces, and concrete documentation over layers of unnecessary facades or proxies.
2. **Docs as Routing Layer, Not Second Copy**: Documentation guides the agent to the right place quickly; it is not a redundant duplicate of the source code.
3. **Semantic Truth vs Runtime Entry**: `docs/` is the semantic truth of a project. `AGENTS.md` (or `.cursor/rules/`, `CLAUDE.md`) is a Runtime Entry Point.

---

## 📋 Doc-Sync Checklist

- [ ] When adding/modifying rules in `spec/repository-standard.md`, update `spec/philosophy*.md` and localized `README*.md` accordingly.
- [ ] Ensure all relative Markdown links in `templates/` and `docs/` point to valid files.
