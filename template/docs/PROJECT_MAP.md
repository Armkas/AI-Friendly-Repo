# Project Map

This document explains the composition and core directory structure of the project.

## Top-Level Structure
- `AGENTS.md` - Global navigation guide
- `.agents/` - Machine-readable indices and AI workflows
- `docs/` - **AI Context Architecture** (Domain knowledge, Architecture, Invariants, ADRs)
- `[Source Code Directory]/` - **Runtime Architecture + Implementation** (declare MVVM / DDD / Clean / … here)

State both planes in this map: what the agent should read first, and which runtime architecture the code actually uses.

## Major Subsystems and Locations
1. **[Business A]**
   - Knowledge Layer: [docs/domains/[Business A].md]
   - Code Layer: [[Source Code Directory]/features/[Business A]/]
