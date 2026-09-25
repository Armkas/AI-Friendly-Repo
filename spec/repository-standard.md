# AI-Native Repository Standard 2.0

[简体中文](repository-standard.zh-CN.md)

## Repository Design Specification for AI Coding Agents

> For the reasoning behind these rules, see [Philosophy](philosophy.md)
> ([简体中文](philosophy.zh-CN.md) · [日本語](philosophy.ja.md)).

---

# 0. The AI-Native Shift

This standard elevates the repository from a passive "book for AI to read" into an active "workspace for AI to operate."

We define the **8-Pillar AI-Native Architecture** that sits alongside your traditional Software Architecture (MVVM, Clean, DDD, etc.):

1. **Context** (Project Map, Domains, Architecture) - *What the system is.*
2. **Rules** (AGENTS.md, Cursor Rules) - *What the agent must/must not do.*
3. **Contracts** (Protocols, Schemas) - *How components collaborate.*
4. **Skills** (SKILL.md) - *How to perform specific atomic tasks.*
5. **Workflows** (SOPs) - *How to orchestrate a complex development process.*
6. **Tools** (MCP, CLI, Scripts) - *How the agent touches the world.*
7. **Verification** (Tests, Validators, Hooks) - *How to prove the agent did it right.*
8. **Human / Agent Boundary** (MANUAL_TASKS.md) - *What decisions must be made by humans.*

---

# I. Context Must Be Earned

## Rule 01 — Context must be loaded on-demand
Do not bloat the agent's context window by injecting all domains, rules, and skills for every task. The global router (`AGENTS.md`) should remain small (< 2KB). Specific context (e.g., a Database Schema or a Feature Development Skill) must only be loaded when the specific task requires it.

## Rule 02 — Progressive Disclosure
Standard reading order:
`Command` → `Workflow` → `Skill` → `Context (Domain/Contract)` → `Tool/Implementation`

---

# II. Standardize Concepts, Isolate Runtimes

## Rule 03 — Model-Agnostic, Runtime-Aware
The AI industry requires separating three distinct layers:
1. **The Model** (e.g., GPT-6 Astra, Claude Opus 5.5): The underlying reasoning engine.
2. **The Agent Runtime** (e.g., Cursor, Claude Code, Windsurf, Codex): *How* files are read, *when* skills are invoked, and *what* hooks execute.
3. **The Repository Standard** (The semantics): *What* your project is.

Your repository's semantics (Domains, Contracts, Workflows) must be **Model-Agnostic**. However, because different agent runtimes expect configurations in different directories (`.claude/`, `.cursor/rules/`, `.agents/skills/`), your repository's setup must be **Runtime-Aware**.

**Do not force multiple runtime configs into a single production repository.**
Your team should pick ONE primary agent runtime for a project. The business logic (`docs/domains`) remains universal, but the runtime configuration (`CLAUDE.md`, `.claude/skills`) should be a pure, native adapter specific to your chosen tool (e.g. Cursor).

---

# III. The Human-Agent Boundary

## Rule 04 — Clone ≠ Trust
Agent scripts, Hooks (e.g., `PreToolUse`), and MCP server configurations can be version-controlled in Git to ensure reproducibility. However, **cloning a repository does not equal trust.** Any automated hook or tool that can execute code or modify the environment must require explicit human authorization before being enabled.

## Rule 05 — Explicit Permission Boundaries (`MANUAL_TASKS.md`)
Every AI-Native repository must define what the AI is allowed to do autonomously versus what requires human intervention.
- **[Autonomous]**: e.g., Write code, run tests, format files.
- **[Approval Required]**: e.g., Production database migrations, pushing to the main branch.
- **[Manual Only]**: e.g., Injecting production secrets, updating DNS records, physical device testing.

---

# IV. Cognitive Structure

## Rule 06 — The Project Map
A concise `< 100 lines` map (e.g., `docs/PROJECT_MAP.md`) must exist to quickly build global awareness of where major components live.

## Rule 07 — Interfaces Before Implementations
Business capabilities must prioritize Interface definitions (Protocols, abstract classes). Interfaces must document responsibilities, inputs, outputs, errors, and side effects.

## Rule 08 — Invariants
Business rules that must never be broken (e.g., "Network failure → fallback" or "High-risk action → explicit confirmation") must be explicitly documented (e.g., `docs/invariants/`), not just hidden in code.

---

# V. Verification

## Rule 09 — Closed-Loop Verification
An AI agent's job is not complete when the code is written. The repository must provide deterministic validators (e.g., `scripts/validate.sh`, linters, type checkers, test suites). The agent must run these tools and confirm a `0` exit code before concluding a task.

---

# VI. Explicit structure, not excessive abstraction

AI-Native ≠ Abstraction-Heavy. Keep architectural boundaries explicit, files small (< 500 lines preferred), and symbol names meaningful. The goal is smaller cognitive boundaries for the AI.