@AGENTS.md

## 💡 Gemini / Antigravity Adapter

1. **Verify File Paths**: Check [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) and [.agents/context-index.md](.agents/context-index.md) before assuming file paths or components.
2. **Never Mutate Historical Migrations**: All database schema changes must be appended as new timestamped migration files; never edit historical migrations.
3. **Follow Progressive Disclosure**: Prioritize abstract interfaces and contracts; do not load bulky implementation files into context prematurely.
4. **Active Closed-Loop Verification**: Always execute the verification commands declared in `AGENTS.md` (such as typecheck and build) before concluding.
