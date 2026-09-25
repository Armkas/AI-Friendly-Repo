# AI-Native Repository Standard

[🇨🇳 简体中文](README.zh-CN.md) | [🇯🇵 日本語](README.ja.md)

> **Don't just give AI more context. Give it a native workspace.**

A standard, architecture, and set of templates for building repositories that AI coding agents can understand, navigate, modify, and verify autonomously.

---

## ⚠️ Model-Agnostic, Runtime-Aware (The "Adapter" Pattern)

**"The semantics are unified, but the runtimes are fragmented."**

As of 2026, the industry has realized that building an AI-Native repository requires separating three distinct layers:
1. **The Model** (e.g., GPT-4o, Claude 3.5, Gemini 1.5): Determines raw intelligence and reasoning.
2. **The Agent Runtime** (e.g., Cursor, Claude Code, Windsurf, Copilot, Gemini CLI): Determines *how* files are read, *when* skills are invoked, and *what* hooks are executed.
3. **The Repository Standard** (e.g., Context, Contracts, Workflows): The universal semantic truth of your project.

While your project's business rules and workflows are **Model-Agnostic** (both GPT and Claude can understand a `docs/domains/voice.md` file), they must be **Runtime-Aware**. 
- **Anthropic's Claude Code** expects `.claude/settings.json` (focusing on lifecycle hooks).
- **OpenAI's Codex / SDK** expects `AGENTS.md` and `.agents/skills/` (focusing on progressive task discovery).
- **Cursor** expects `.cursor/rules/*.mdc` (focusing on multi-model glob matching).
- **GitHub Copilot / Windsurf / Trae** have their own native path-specific instructions.

Forcing all these runtime configurations into a single project root creates rule drift and context pollution. 

Therefore, this repository provides:
1. **One Universal Standard** (`spec/`): Defines the concepts (Domains, Contracts, Skills, Workflows) independent of any tool.
2. **Native Runtime Templates** (`templates/`): Choose the exact Runtime your company uses (e.g., Cursor) and get a pure, native adapter without the clutter of other tools.

---

## 🏗 The 8-Pillar AI-Native Architecture

This standard elevates the repository from a "book for AI to read" into a "workspace for AI to operate". It defines 8 architectural layers:

### 1. Context (The "What")
*`PROJECT_MAP`, `Domains`, `Architecture`*
Tells the AI what the system is, where things are, and why they were built that way.

### 2. Rules (The "Must/Must Not")
*`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`*
The absolute constraints. How code must be formatted, how imports must be handled, and what architectural rules cannot be broken.

### 3. Contracts (The "How they connect")
*`Protocols`, `Schemas`, `API Definitions`*
Explicit boundaries between components. AI agents rely on interfaces far more heavily than humans do.

### 4. Skills (The "How to do a specific task")
*`SKILL.md`*
Reusable, atomic capabilities (e.g., "How to generate a database migration in this repo").

### 5. Workflows (The "How to orchestrate")
*`SOPs`*
Multi-step procedures (e.g., "Plan -> Check Invariants -> Implement -> Test -> Verify -> Update Docs").

### 6. Tools (The "How to touch the world")
*`MCP Servers`, `Deterministic CLI Scripts`*
Safe, structured tools the agent can use to read the database, fetch logs, or compile code, preventing LLM hallucination in terminal commands.

### 7. Verification (The "How to prove it's right")
*`Tests`, `Validators`, `Hooks`*
Automated closing of the loop. An agent's job isn't done until the validator script returns exit code 0.

### 8. Human / Agent Boundary (The "Trust barrier")
*`MANUAL_TASKS.md`*
A clear delineation of permissions: What the AI can do autonomously, what it must ask permission for (e.g., production deploys), and what humans must do manually (e.g., secret injection).

---

## 📂 Repository Structure

```text
AI-Native-Repo/
│
├── 1️⃣ spec/                            # The Standard: Tool-agnostic theories & philosophy
│   ├── repository-standard.md         # The 8-pillar architecture
│   └── philosophy.md                  # "Context Must Be Earned" & "Clone ≠ Trust"
│
├── 2️⃣ templates/                       # The Templates: Empty boilerplates for your agent
│   ├── claude-code/                   # Pure Claude environment (.claude/ hooks & skills)
│   ├── codex/                         # Pure OpenAI environment (.agents/skills/)
│   ├── cursor/                        # Pure Cursor environment (.cursor/rules/)
│   └── gemini-cli/                    # Pure Gemini environment
│
└── 3️⃣ examples/                        # The Examples: Real-world comparison (Control Variables)
    ├── claude-code/                   # Same Voice-Chat project, using Claude ecosystem
    ├── codex/                         # Same Voice-Chat project, using Codex ecosystem
    ├── cursor/                        # Same Voice-Chat project, using Cursor ecosystem
    └── gemini-cli/                    # Same Voice-Chat project, using Gemini ecosystem
```

---

## 📖 Choose Your Agent Runtime (Getting Started)

Start your AI-Native project by copying the template that matches your team's tooling:

* **Using Claude Code?** -> Copy `templates/claude-code/`
* **Using OpenAI / Codex?** -> Copy `templates/codex/`
* **Using Cursor?** -> Copy `templates/cursor/` (Note: Cursor is a multi-model runtime)
* **Using Gemini CLI?** -> Copy `templates/gemini-cli/`

Read the [Repository Standard Specification](spec/repository-standard.md) to understand the design philosophy.
