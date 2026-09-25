# AI-Native Repository Tiers

The AI-Native Repository Standard introduces **Tiers** to define the complexity, maturity, and automation profile of a repository. 
Tier is completely orthogonal to the Agent Runtime (e.g., Claude Code, Cursor) and the Model (e.g., GPT-6, Opus).

You choose a Tier based on your team's needs, not the tool you use.

## Tier 1: Light
**Goal:** Provide the core benefits of AI navigation with minimal setup overhead.
**Best for:** Prototypes, personal projects, new repositories, or teams taking their first step into AI-native engineering.

**Core Capabilities:**
- **Context:** `PROJECT_MAP.md` + minimal architecture overview.
- **Rules:** Root instruction entrypoint (e.g., `CLAUDE.md` or `.cursor/rules/core.mdc`).
- **Skills/Workflows:** 0 to 1 core skill.
- **Verification:** Basic testing.
- **Human Boundary:** Minimal but explicit.

*Philosophy:* Establish Context Routing first, before building heavy automation infrastructure.

## Tier 2: Standard
**Goal:** The recommended default for production software teams.
**Best for:** Most active production repositories with a small to mid-sized team.

**Core Capabilities:**
- **Context:** Project Map, Domain Docs, Explicit Contracts, Invariants, ADRs.
- **Rules:** Root instructions + scoped local rules.
- **Skills/Workflows:** Several core reusable workflows (Feature Dev, Bug Fix, Verification).
- **Verification:** Unit tests, linting, CI, repository validation.
- **Human Boundary:** Explicit `MANUAL_TASKS.md` for production and destructive actions.

*Philosophy:* A balanced workspace where AI has structured knowledge and deterministic guardrails.

## Tier 3: Full
**Goal:** Advanced, highly automated Agent Workspace.
**Best for:** High-maturity, long-term, large-scale repositories.

**Core Capabilities:**
- **Context:** Generated context indexes, dependency maps, machine-readable manifest (`anr.yaml`), freshness checks.
- **Rules:** Detailed scoped rules, strict distinction between Advisory Rules and Guardrails.
- **Skills/Workflows:** Rich ecosystem of specialized agent sub-roles, MCP tool integrations, lifecycle hooks.
- **Verification:** Strong CI, Agent Behavior Evaluation, static analysis.
- **Human Boundary:** Strict permission boundaries and detailed approval flows.

*Philosophy:* Maximum automation, but with strictly controlled Context Cost and rigid verification closed-loops.
