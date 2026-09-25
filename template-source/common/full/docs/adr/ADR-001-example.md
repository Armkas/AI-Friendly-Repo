# ADR-001: Adopt Feature-First Layout Over Layer-First Flat Folders

- **Status**: Accepted
- **Deciders**: Architecture Committee
- **Date**: 2026-09-09

---

## 1. Context & Problem Statement
Historically, the project grouped files by technical type (`/controllers`, `/services`, `/models`, `/views`). Implementing a single feature required modifying files across 5-6 directories. AI Coding Agents were forced to scan the entire repository, driving up token consumption and increasing accidental cross-module regressions.

---

## 2. Considered Options
- **Option A (Keep Layer-First Flat Folders)**: Familiar to some developers, but incurs high context overhead for AI agents.
- **Option B (Feature-First Vertical Slices - Accepted)**: Group code by business feature, with isolated `Interface/`, `Implementation/`, and `Views/`.

---

## 3. Decision Outcome & Rationale
Adopted **Option B**. Locating all feature-related code in one directory ensures the AI agent's primary context boundary is tightly contained within the feature slice.

---

## 4. Trade-offs & Consequences
- **Positive Consequences**: AI search radius reduced by ~80%; clear blast radius; easier module decoupling.
- **Negative Consequences**: Cross-feature communication must use explicit public interfaces rather than direct internal calls.
