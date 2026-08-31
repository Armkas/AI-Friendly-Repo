# 🤖 Web AGENTS.md

## Local Rules
When working in the `web/` directory, adhere to the following Web Frontend development conventions:

1. **Framework Stack**: React + TypeScript + Vite.
2. **Architectural Pattern**: Feature-Sliced Design at the **runtime** plane. Shared business meaning stays in `docs/domains/`.
3. **State Management**: Prioritize local state. For cross-component state, use React Context or Zustand.
4. **Styling**: Use TailwindCSS (or a designated CSS-in-JS solution).
