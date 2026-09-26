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
find template-source cli/templates spec examples -type f -name "*.md" -exec grep -H "file:///" {} + || true

# 3. Verify git status and ensure no untracked noise or broken artifacts
git status
```

---

## ⚠️ Scope & Status Declaration

- **Primary Mission**: Maintain the [AI-Native Repository Standard](spec/repository-standard.md) and the out-of-the-box [Native Templates](template-source/).
- **Multi-lingual Alignment**: Any conceptual changes to core rules must be reflected in `spec/repository-standard.md`, `spec/repository-standard.zh-CN.md`, `spec/philosophy.md`, `spec/philosophy.zh-CN.md`, `spec/philosophy.ja.md`, and **all** localized `README*.md` files (currently 13 languages — see the language switcher at the top of any `README*.md`). `spec/adapters.md`, `spec/tiers.md`, and `spec/model-compatibility.md` are English-only reference material and are not part of this sync requirement.
- **Semantic-Agnostic, Runtime-Aware, Model-Tunable**: This project specifies an **AI Context Architecture** sitting on top of conventional software architectures (MVVM, Clean, DDD, TCA). It does not invent AI-specific application runtimes, and it keeps Model Provider (OpenAI, Anthropic, Google, DeepSeek, Qwen, ...) strictly separate from Agent Runtime — see [spec/model-compatibility.md](spec/model-compatibility.md).

---

## 🎯 Context Routing Navigation

Before modifying any content, identify the required context area:

1. **Repository Standard (The Rules)**: [spec/repository-standard.md](spec/repository-standard.md)
2. **Philosophy (The Rationale)**: [spec/philosophy.md](spec/philosophy.md) ([简体中文](spec/philosophy.zh-CN.md) · [日本語](spec/philosophy.ja.md))
3. **Runtime Adapters (The Mapping)**: [spec/adapters.md](spec/adapters.md)
4. **Model Compatibility (Model Provider × Runtime)**: [spec/model-compatibility.md](spec/model-compatibility.md)
5. **Tiers (Complexity Profiles)**: [spec/tiers.md](spec/tiers.md)
6. **Native Templates (The Skeletons, Source of Truth)**: [template-source/](template-source/)
   - `common/` (`light/`, `standard/`, `full/`)
   - `runtimes/` (`claude-code/`, `codex/`, `cursor/`, `gemini-cli/`)
   - Generated output for the CLI lives in `cli/templates/` — never hand-edit it, run `scripts/generate-templates.js` instead.
7. **Reference Implementations**: [examples/](examples/) (`claude-code/`, `codex/`, `cursor/`, `gemini-cli/`)

---

## 🏛 Core Inviolable Invariants

1. **Explicit Structure, Not Excessive Abstraction**: Prefer clear responsibilities, boundary-driven interfaces, and concrete documentation over layers of unnecessary facades or proxies.
2. **Docs as Routing Layer, Not Second Copy**: Documentation guides the agent to the right place quickly; it is not a redundant duplicate of the source code.
3. **Semantic Truth vs Runtime Entry**: `docs/` is the semantic truth of a project. `AGENTS.md` (or `.cursor/rules/`, `CLAUDE.md`) is a Runtime Entry Point.

---

## 📋 Doc-Sync Checklist

- [ ] When adding/modifying rules in `spec/repository-standard.md`, update `spec/repository-standard.zh-CN.md`, `spec/philosophy*.md`, and **every** `README*.md` (not just English/Chinese/Japanese) accordingly.
- [ ] When adding a new Model Provider or Runtime, update `spec/model-compatibility.md` only — never add a per-model template or a per-model `README` section.
- [ ] Ensure all relative Markdown links in `template-source/`, `cli/templates/`, and `spec/` point to valid files (run the check in the Verification section above).
