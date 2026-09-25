# Runtime Adapters (运行时映射)

This document defines how the universal concepts of the **AI-Native Repository Standard** map to the native mechanisms of specific Agent Runtimes.

> **The semantics are unified, but the runtimes are fragmented.**
> A Runtime Adapter is the translation layer between the universal AI-Native Standard (`docs/`) and the specific tool used by the developer.

## Adapter Responsibilities

An Adapter must fulfill the following responsibilities:
1. **Entry Point Provisioning**: Provide the root instructions file expected by the tool (e.g. `CLAUDE.md`, `.cursor/rules/core.mdc`).
2. **Context Routing**: The adapter MUST route the agent into the `docs/` folder. It must not duplicate the domain rules.
3. **Capability Mapping**: If the Standard specifies a Skill or Hook, the adapter maps it to the tool's native syntax.
4. **Graceful Degradation (N/A)**: If a tool lacks a capability (e.g. Cursor lacks lifecycle hooks), the adapter safely ignores it or maps it to manual steps. **N/A is perfectly acceptable.**

## The Mapping Table

| Canonical Concept | Claude Code | Codex / OpenAI | Cursor | Gemini CLI |
| :--- | :--- | :--- | :--- | :--- |
| **Project Entry Instructions** | `CLAUDE.md` | `AGENTS.md` | `AGENTS.md` / `.cursor/rules/core.mdc` | `GEMINI.md` |
| **Skill (Atomic capability)** | `.claude/skills/` | `.agents/skills/` | `.cursor/rules/*.mdc` | `.gemini/skills/` |
| **Verification Hook** | `.claude/settings.json` | CI / `.agents/hooks/` | N/A (Manual/CI) | `.gemini/hooks/` |
| **Subagent Definition** | `.claude/agents/` | `.agents/subagents/` | N/A | `.gemini/agents/` |
| **Tool / MCP Server** | `.mcp.json` / settings | Codex config | `.cursor/mcp.json` | Gemini MCP settings |
| **Path-Scoped Context** | Claude rules | Scoped instructions | `.cursor/rules/*.mdc` | Hierarchy conventions |
| **Ignore Config** | `.claudeignore` | `.agentsignore` | `.cursorignore` | `.geminiignore` |

### Adding New Adapters
If your team uses a different Agent Runtime (e.g., Windsurf, Trae, GitHub Copilot), you do NOT need to reinvent the AI-Native architecture. You simply provide a new column in this table mapping how that tool implements entry points, skills, hooks, and scopes.

If the tool does not support a feature (e.g., Windsurf does not have native subagents), mark it as **N/A**. The repository remains AI-Native, the runtime simply lacks the capability to execute all of it natively.
