# 🛑 Business Invariants & Guardrails (business_invariants.md)

[简体中文](business_invariants.zh-CN.md)

> [!CAUTION]
> **Core Agent Directive**:
> This document defines the **non-negotiable business rules (Invariants)** of the system.
> Implementation details may evolve, but **unless the user explicitly requests a business requirement change, no agent may violate these rules**.

---

## 1. Core Business Logic Invariants

1. **Unidirectional State Transitions**:
   - Once an order or session reaches a terminal state ("Completed", "Cancelled"), it must never transition back to "In-Progress".
2. **Quota & Balance Integrity**:
   - Deductions and balance mutations must be processed inside atomic server-side transactions; clients must never report deduction results directly.
   - Pre-condition check `balance >= amount` is mandatory prior to execution; insufficient balance must result in a hard rejection.
3. **Sensitive Operations Re-Authentication**:
   - Account deletion, email/phone unbinding, and high-value transactions must require password re-verification or two-factor authentication.

---

## 2. Platform Compliance & App Store Guardrails (If Applicable)

1. **Apple App Store Review Guidelines**:
   - Digital goods and virtual currencies must strictly use Apple In-App Purchase (IAP); never link to external payment gateways.
   - User-Generated Content (UGC) features must include reporting, blocking, and moderation mechanisms.
2. **Data Privacy**:
   - Provide an accessible "Delete Account" flow.
   - Never collect location or audio data in the background without explicit user permission.
