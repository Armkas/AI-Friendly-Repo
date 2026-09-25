# Runtime Adapters (运行时映射)

This document defines how the universal concepts of the **AI-Native Repository Standard** map to the native mechanisms of specific Agent Runtimes.

## The Mapping Table

| Canonical Concept | Claude Code | Codex / OpenAI | Cursor | Gemini CLI |
| :--- | :--- | :--- | :--- | :--- |
| **Project Entry Instructions** | `CLAUDE.md` | `AGENTS.md` | `AGENTS.md` / `.cursor/rules` | `GEMINI.md` |
| **Skill (Atomic capability)** | `.claude/skills/` | `.agents/skills/` | Cursor Rules | `.gemini/skills/` |
| **Verification Hook** | `.claude/settings.json` | CI / `.agents/hooks/` | N/A (Manual/CI) | `.gemini/hooks/` |
| **Subagent Definition** | `.claude/agents/` | `.agents/subagents/` | N/A | `.gemini/agents/` |
| **Tool / MCP Server** | `.mcp.json` / settings | Codex config | `.cursor/mcp.json` | Gemini MCP settings |
| **Path-Scoped Context** | Claude rules | Scoped instructions | `.cursor/rules/*.mdc` | Hierarchy conventions |

### Adding New Adapters
If your team uses a different Agent Runtime (e.g., Windsurf, Trae, GitHub Copilot), you do NOT need to reinvent the AI-Native architecture. You simply provide a new column in this table mapping how that tool implements entry points, skills, hooks, and scopes.
