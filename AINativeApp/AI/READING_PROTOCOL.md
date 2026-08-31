# READING PROTOCOL

The point of this repo's layout is **hierarchical context retrieval**: start with
tiny map files, expand context only along the path to the code you must change.

## Levels

### L0 — Enter the project
Read `AGENTS.md` + `AI/PROJECT_MAP.md`. ~2 short files. You now know the domains,
entry points, and layering rules. Do **not** open Swift files yet.

### L1 — Locate the domain
Read `AI/DOMAIN_MAP.md`. Map the task ("continuous voice drops after silence") to
exactly one owning domain (Voice) and note its dependencies.

### L2 — Understand the capability
Read `AI/domains/<domain>.md`, then that feature's `Interface/` folder:
- the `protocol`s (what operations exist),
- the `Contract:` doc comments (inputs, outputs, failure modes, side effects,
  forbidden behavior),
- the DTOs.
For most tasks you now know *what* the module promises. This is the cheap layer:
`Interface/` folders are intentionally small and implementation-free.

### L3 — Learn what must not break
Read `AI/INVARIANTS.md` and the domain doc's `## Invariants`. Read any ADR the
task touches (linked from the domain doc). These tell you the boundaries of an
acceptable change and *why the current design is the way it is*.

### L4 — Confirm current behavior
Read `Tests/<Domain>Tests/*`. Test names are behavior specs
(`test_silenceBeyondTimeout_endsSession`). If a test already covers your case, you
know the intended behavior without reading the implementation.

### L5 — Drill into implementation (only if needed)
Trigger conditions:
- an `Interface`/`Contract` cannot explain the observed behavior, **or**
- a test fails, **or**
- behavior contradicts a `Contract:`.
Then read `Features/<Domain>/Infrastructure/*` and `Domain/*`. Use
`AI/generated/SYMBOL_INDEX.md` (definitions) and `AI/generated/DEPENDENCY_GRAPH.md`
(who-calls-whom, who-implements-what) to jump directly instead of scanning.

## Navigation queries the indexes answer

| Question | Source |
| -------- | ------ |
| Where is `X` defined? | `AI/generated/SYMBOL_INDEX.md` |
| What implements protocol `X`? | `AI/generated/SYMBOL_INDEX.md` (conformances) |
| Who depends on module `X`? | `AI/generated/DEPENDENCY_GRAPH.md`, `AI/DEPENDENCY_MAP.md` |
| If I change `X`, what breaks? | `AI/CHANGE_IMPACT.md` |
| Why is `X` designed this way? | `AI/adr/` |

## Editing

After L5, make the change in `Infrastructure/`/`Domain/`. Then:
1. Run the touched domain's tests.
2. Run the full suite.
3. Update any `AI/` doc your change invalidated.
4. Re-run `Scripts/generate_ai_index.sh` if you added/removed/moved public symbols
   or changed dependencies.

## When docs and code disagree

Code + passing tests are the source of truth. Flag the stale doc explicitly in
your response and fix it in the same change.
