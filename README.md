# AI-Friendly Repo

> A practical repository architecture designed for AI coding agents.

Build software that is easy for **humans to understand** and **AI agents to navigate**.

AI coding agents are becoming a normal part of software development. But most repositories were designed before agents existed: architecture is implicit, important knowledge is scattered across files, and agents often have to read large amounts of code before they can safely make a small change.

**AI-Friendly Repo** is a practical architecture, documentation system, and project template for building repositories that are easier for AI coding agents to understand, navigate, modify, and verify.

---

## The Problem

Traditional repositories are optimized primarily for human developers.

A developer may already know:

* where the important code lives
* which service owns a feature
* why a strange implementation exists
* which files are safe to modify
* which business rules must never be broken

An AI coding agent usually does not know any of this.

So a simple task can become:

```text
Task
 ↓
Search the repository
 ↓
Read many unrelated files
 ↓
Infer the architecture
 ↓
Guess hidden business rules
 ↓
Find the implementation
 ↓
Modify code
 ↓
Discover a forgotten dependency
 ↓
Break something else
```

This wastes context, increases cost, and makes AI-assisted development less reliable.

---

## The Idea

AI-Friendly Repo treats the repository as two layers:

```text
┌─────────────────────────────────────┐
│          Knowledge Layer            │
│                                     │
│  Agent Rules                        │
│  Project Map                        │
│  Architecture                       │
│  Domain Knowledge                   │
│  Contracts / Interfaces             │
│  Invariants                         │
│  ADRs                               │
│  Context Index                      │
└──────────────────┬──────────────────┘
                   │
                   ↓
┌─────────────────────────────────────┐
│             Code Layer              │
│                                     │
│  iOS                                │
│  Backend                            │
│  Web                                │
│  Workers                            │
│  Infrastructure                     │
└─────────────────────────────────────┘
```

The AI should not start by reading the entire codebase.

It should **navigate the knowledge layer first**, then progressively enter the relevant part of the codebase.

---

## Core Principle

> **Small Context → Large Understanding**

Instead of:

```text
Read everything
    ↓
Try to understand everything
```

AI-Friendly Repo uses:

```text
Map
 ↓
Locate
 ↓
Understand the domain
 ↓
Read the contract
 ↓
Read the rules
 ↓
Inspect the relevant implementation
 ↓
Modify
 ↓
Verify
```

---

# What Makes a Repository AI-Friendly?

## 1. A Repository Map

Every project should have a compact map describing:

* what the project does
* where major components live
* what the major domains are
* where the important entry points are
* where to find deeper documentation

The map is a navigation layer, not a giant manual.

---

## 2. Layered Context

Information is organized by depth:

```text
Level 0
Agent instructions

Level 1
Project map

Level 2
Architecture + domain map

Level 3
Interfaces / contracts

Level 4
Invariants + ADRs + tests

Level 5
Implementation
```

Agents expand the context only when necessary.

---

## 3. Feature-Based Architecture

Business code is organized by domain or feature rather than by technical type.

Prefer:

```text
features/
├── voice/
├── navigation/
├── account/
└── billing/
```

over:

```text
routers/
services/
models/
controllers/
utils/
```

The goal is to make a business task map to a small, coherent part of the repository.

---

## 4. Interfaces Before Implementations

Important capabilities should have explicit interfaces.

Swift:

```swift
protocol SpeechRecognizer {
    func start() async throws
    func stop() async
}
```

Python:

```python
class SpeechService(Protocol):
    async def transcribe(
        self,
        audio: bytes,
    ) -> str:
        ...
```

The interface describes what a component can do.

The implementation describes how it does it.

Agents should normally understand the interface before opening the implementation.

---

## 5. Contracts

Interfaces should describe more than method signatures.

A useful contract may specify:

```text
Responsibility
Input
Output
Errors
Side effects
Constraints
```

This gives an agent a compact and reliable model of a component.

---

## 6. Invariants

Important business rules should exist outside implementation details.

Example:

```text
20 seconds of silence ends the voice session.

Network failure must trigger fallback.

Unvalidated commands must never execute.

High-risk actions require explicit user confirmation.
```

Implementation can change.

The invariant should not change unless the product requirement changes.

---

## 7. Architecture Decision Records

Important architectural decisions should explain **why** the system works the way it does.

Example:

```text
ADR-001

Decision:
Use WebSocket as the primary voice transport.

Why:
Low latency and bidirectional communication.

Fallback:
REST streaming → local processing.

Do not replace WebSocket unless:
The latency and reliability requirements are reconsidered.
```

This prevents an AI agent from “simplifying” a deliberate architectural decision.

---

## 8. Tests as Executable Knowledge

Tests are not only verification.

They also communicate expected system behavior.

Prefer:

```text
testNetworkFailureFallsBackToLocalRecognition()
```

over:

```text
test1()
```

The agent should use:

```text
Contract
+
Invariant
+
Test
+
Implementation
```

to understand the actual behavior of the system.

---

## 9. Dependency and Impact Awareness

An AI-friendly repository should make it possible to answer:

```text
Who depends on this?

Who calls this?

What will be affected if I change this?
```

Example:

```text
VoiceService
├── SpeechService
├── LLMService
└── CommandValidator

Used by:
├── VoiceSession
└── ConversationService
```

Where possible, this information should be generated automatically.

---

## 10. Progressive Disclosure

Do not put every piece of information into one giant `AGENTS.md`.

Instead:

```text
AGENTS.md
      ↓
context index
      ↓
architecture
      ↓
domain knowledge
      ↓
contract
      ↓
implementation
```

Each layer should answer a different question.

---

# Repository Structure

A typical AI-Friendly Repo may look like:

```text
project/
│
├── AGENTS.md
│
├── .agents/
│   ├── context-index.md
│   ├── skills/
│   ├── workflows/
│   └── guardrails/
│
├── docs/
│   ├── PROJECT_MAP.md
│   ├── ARCHITECTURE.md
│   ├── DATA_FLOW.md
│   ├── DEPENDENCY_MAP.md
│   ├── INVARIANTS.md
│   │
│   ├── domains/
│   │   ├── voice.md
│   │   ├── navigation.md
│   │   └── account.md
│   │
│   └── adr/
│       ├── ADR-001.md
│       └── ADR-002.md
│
├── ios/
│
└── backend/
```

The exact implementation is not mandatory.

The principles are.

---

# Example Project

This repository contains a complete example project combining:

```text
iOS + FastAPI
```

Example:

```text
examples/
└── ios-fastapi/
    ├── ios/
    └── backend/
```

The example demonstrates:

* Feature-based architecture
* AI-readable documentation
* Interface / implementation separation
* Domain contracts
* Business invariants
* ADRs
* Dependency mapping
* Focused testing
* AI agent workflows

---

# AI Agent Workflow

When an agent receives a task such as:

> Fix continuous voice mode when the network disconnects.

The intended workflow is:

```text
AGENTS.md
    ↓
PROJECT_MAP
    ↓
Voice Domain
    ↓
Voice Contract
    ↓
Voice Invariants
    ↓
Relevant Tests
    ↓
Dependency / Impact
    ↓
Implementation
    ↓
Focused Tests
    ↓
Integration Tests
```

The agent does not need to scan the entire repository.

---

# What This Project Is Not

AI-Friendly Repo is not:

* a replacement for Cursor
* a replacement for Claude Code
* a prompt collection
* a specific programming framework
* a single application architecture
* a requirement to use one specific AI provider

It is a **repository design methodology**.

It can be used with different languages, frameworks, and coding agents.

---

# Supported Project Types

The architecture can be used for:

```text
iOS
Android
FastAPI
Django
Node.js
Go
Rust
React
Full-stack applications
Monorepos
Libraries
CLI tools
Backend services
```

The knowledge layer remains conceptually the same.

Only the code layer changes.

---

# Design Philosophy

### 1. Structure over prompts

Prompts are temporary.

Repository structure is persistent.

### 2. Context over context window size

A larger context window does not automatically produce a better understanding of a codebase.

Good structure reduces the amount of context an agent needs.

### 3. Explicit knowledge over implicit knowledge

If an important rule exists only in the original developer's memory, the agent cannot reliably use it.

### 4. Progressive disclosure over full-code ingestion

Agents should discover information as needed.

### 5. Machine-readable where possible

Indexes, symbols, dependencies, and other structural information should be generated automatically whenever practical.

Human-written documentation should focus on intent, rules, and decisions.

---

# Quick Start

Clone the repository:

```bash
git clone https://github.com/<your-name>/ai-friendly-repo.git
cd ai-friendly-repo
```

Explore the standard:

```text
docs/
```

Explore the templates:

```text
template/
```

Explore the complete example:

```text
examples/ios-fastapi/
```

Copy the template into a new project and adapt:

```text
AGENTS.md
docs/
.agents/
```

Then begin development.

---

# Project Status

AI-Friendly Repo is an evolving open-source standard.

The goal is not to define a single “correct” architecture.

The goal is to discover practical patterns that make software repositories easier for both humans and AI coding agents to understand and maintain.

Contributions, experiments, examples, and alternative approaches are welcome.

---

# Contributing

We welcome contributions that improve:

* repository structure
* AI context management
* documentation patterns
* agent workflows
* language-specific examples
* architecture patterns
* testing strategies
* automated context generation

Please keep proposals general enough to be useful beyond a single AI tool.

---

# License

MIT
