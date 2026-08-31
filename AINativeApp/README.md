# AINativeApp — AI-Friendly Codebase Standard 1.0 (iOS / SwiftUI)

This repository is a **reference template**, not a shipping app. It demonstrates a
repository layout, documentation system, and set of conventions designed so that
an AI coding agent can build a correct mental model of the project **without
reading the whole codebase**.

## The core idea

> The goal is **not** "let the AI read the whole project".
> The goal is "let the AI understand the whole project **without** reading all of it".

An agent enters through a small **map layer**, narrows to one **domain**, reads
the **interface + contract + invariants + tests** for the module it must change,
and only then — if necessary — opens the **implementation**.

```
AGENTS.md  ─▶  AI/PROJECT_MAP.md  ─▶  AI/DOMAIN_MAP.md  ─▶  AI/domains/<x>.md
   ─▶  Features/<X>/Interface/*  ─▶  AI/INVARIANTS.md + AI/adr/*  ─▶  Tests/*
   ─▶  (only if needed)  Features/<X>/Infrastructure/*  +  AI/generated/*
```

## Where to start reading (humans and agents)

| You want to…                          | Read                                            |
| ------------------------------------- | ----------------------------------------------- |
| Understand the whole project          | [`AI/PROJECT_MAP.md`](AI/PROJECT_MAP.md)         |
| Know how an agent should work here    | [`AGENTS.md`](AGENTS.md)                         |
| Find which domain owns a problem      | [`AI/DOMAIN_MAP.md`](AI/DOMAIN_MAP.md)           |
| Understand the layering rules         | [`AI/ARCHITECTURE.md`](AI/ARCHITECTURE.md)       |
| See what must never break             | [`AI/INVARIANTS.md`](AI/INVARIANTS.md)           |
| Understand why something is like this | [`AI/adr/`](AI/adr/)                             |
| Estimate blast radius of a change     | [`AI/CHANGE_IMPACT.md`](AI/CHANGE_IMPACT.md)     |

## Layout

```
AINativeApp/
├── AGENTS.md                 # how an agent should operate in this repo (also CLAUDE.md)
├── CLAUDE.md                 # -> imports AGENTS.md
├── .cursor/rules/            # scoped, versioned agent rules (Cursor)
│
├── AI/                       # the map layer — hand-written intent + generated indexes
│   ├── PROJECT_MAP.md        # L0: what the project is, entry points, top rules
│   ├── DOMAIN_MAP.md         # L1: business domains and how they relate
│   ├── ARCHITECTURE.md       # layering, dependency direction, module boundaries
│   ├── DATA_FLOW.md          # request/event flows end to end
│   ├── DEPENDENCY_MAP.md     # who depends on whom (hand-maintained summary)
│   ├── INVARIANTS.md         # rules that survive any refactor
│   ├── CONVENTIONS.md        # naming, file size, SwiftUI patterns
│   ├── CHANGE_IMPACT.md      # blast-radius table per module
│   ├── READING_PROTOCOL.md   # the L0..L5 read order, in detail
│   ├── domains/              # L2: one file per domain
│   ├── adr/                  # architecture decision records
│   └── generated/            # L4/L5 indexes produced by Scripts/generate_ai_index.sh
│
├── Scripts/
│   └── generate_ai_index.sh  # regenerates AI/generated/* from source
│
├── App/                      # composition root only — no business logic
├── Features/                 # vertical slices, one folder per domain
│   └── Voice/                # <-- fully worked example
│       ├── Interface/        # L2: protocols + Contract docs + DTOs. Cheap to read.
│       ├── Domain/           # pure logic: state machines, orchestration
│       ├── Infrastructure/   # L5: concrete adapters (network, on-device, SDKs)
│       └── Presentation/     # SwiftUI views + @Observable models
├── Core/                     # cross-domain capabilities (networking, location, ...)
├── Shared/                   # leaf models + extensions, no dependencies
└── Tests/                    # mirrors Features/, test names describe behavior
```

## Regenerating the indexes

```bash
./Scripts/generate_ai_index.sh
```

Hand-maintained: intent, architecture, invariants, ADRs.
Machine-maintained: symbol locations, conformances, dependency edges.
If the two disagree, **code + tests win** and the map is flagged stale.
