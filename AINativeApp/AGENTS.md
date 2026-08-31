# AGENTS.md — How to work in this repository

This file is the entry point for any AI coding agent (Cursor, Claude Code, etc.).
It tells you **how to operate here**. It does not describe what the project is —
for that, read [`AI/PROJECT_MAP.md`](AI/PROJECT_MAP.md).

`CLAUDE.md` imports this file; `.cursor/rules/` refines it with scoped rules.

---

## The reading protocol (do this, in order)

Full detail: [`AI/READING_PROTOCOL.md`](AI/READING_PROTOCOL.md). Summary:

| Level | When | Read |
| ----- | ---- | ---- |
| **L0** | First time in the repo | `AGENTS.md`, `AI/PROJECT_MAP.md` |
| **L1** | You know the task touches "some business area" | `AI/DOMAIN_MAP.md` |
| **L2** | You know the domain | `AI/domains/<domain>.md`, then `Features/<Domain>/Interface/*` |
| **L3** | Before changing anything | `AI/INVARIANTS.md` (+ domain invariants), relevant `AI/adr/*` |
| **L4** | To confirm current behavior | `Tests/<Domain>Tests/*` |
| **L5** | Only if L2–L4 cannot explain the problem | `Features/<Domain>/Infrastructure/*`, `Domain/*`, `AI/generated/*` |

**Do not** open implementation files (`Infrastructure/`, `Domain/`) until an
interface, a contract, a test, or an invariant fails to explain what you need.

## Rules

1. **No aimless whole-repo scans.** Navigate the map. If you find yourself
   grepping broadly, stop and re-read `AI/DOMAIN_MAP.md`.
2. **Interface first.** A `protocol` plus its `Contract:` doc comment is the
   canonical description of a capability. Trust it as *intent*, verify with tests.
3. **Implementation is "not yet read", never "assumed correct".** If tests fail or
   behavior contradicts a `Contract:`, the bug is likely in `Infrastructure/` —
   drill in then.
4. **Invariants are non-negotiable.** You may rewrite any implementation. You may
   not violate anything in `AI/INVARIANTS.md` or a domain's `## Invariants`.
5. **Respect ADRs.** If a change reverses a decision in `AI/adr/`, do not make it
   silently. Call it out and propose a new ADR.
6. **Estimate blast radius first.** Check `AI/CHANGE_IMPACT.md` for the module.
   State expected affected modules / interfaces / tests before editing.
7. **Cross-feature calls go through `Interface/` only.** A feature never imports
   another feature's `Infrastructure/`, `Domain/`, or `Presentation/`.
8. **Do not read** `build/`, `DerivedData/`, `*.xcodeproj/`, `Pods/`,
   `AI/generated/` (unless at L5), snapshots, or generated fixtures.
9. **Keep the map honest.** If your change makes an `AI/` doc wrong, update the
   doc in the same change. If `AI/generated/*` is stale, run
   `./Scripts/generate_ai_index.sh`.
10. **Tests: local then global.** Run the touched domain's tests while iterating;
    run the full suite before declaring done. Never skip the full suite to "save
    tokens" — a dependency change can break far-away call sites.

## Editing conventions (see `AI/CONVENTIONS.md` for the full list)

- One primary type per file. Target < 300 lines; split past ~400.
- Names are searchable: `RouteRecalculationService`, not `RouteManager`/`Helper`/`Utils`.
- SwiftUI views are dumb; state lives in an `@Observable` model in `Presentation/`.
- New capability → add the `protocol` + `Contract:` in `Interface/` first, then a
  test, then the implementation.
- New public type → it will appear in `AI/generated/SYMBOL_INDEX.md` after you run
  the script; add a one-liner to the domain doc if it's a notable entry point.

## Definition of done

- [ ] Invariants respected; ADRs not silently reversed.
- [ ] Touched-domain tests pass; full suite passes.
- [ ] `AI/` docs affected by the change are updated.
- [ ] `./Scripts/generate_ai_index.sh` run if symbols/dependencies changed.
- [ ] New behavior covered by a behavior-named test.
