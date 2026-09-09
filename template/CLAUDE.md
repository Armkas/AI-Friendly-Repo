@AGENTS.md

## 💡 Claude Code Adapter

1. **No Code Truncation**: Claude tends to omit sections with `// ... existing code ...` when modifying large files. Always output complete, fully compilable code.
2. **Strict Typing**: Avoid `any` or loose type definitions; all types must strictly align with domain contracts and schemas.
3. **Follow Progressive Disclosure**: Always read `Interface` protocols and [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) before inspecting implementation files.
4. **Active Closed-Loop Verification**: Always execute the verification commands declared in `AGENTS.md` (such as typecheck and build) before concluding.
