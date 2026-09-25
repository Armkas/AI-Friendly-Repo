# 🗄️ Database Schema Contracts (database_schema.md)

> **Principle**: This document is the snapshot source of truth for the physical database structure.
> All database schema changes must be applied via incremental migration scripts and documented here.

---

## Core DDL Principles

1. **Incremental Migrations**: All changes live in `migrations/` with timestamp prefixes. Never edit historical migrations;
2. **SmallInt / Dictionary Enums**: For status, categories, and types, use dictionary IDs or `SMALLINT` rather than hardcoded string literals;
3. **Row-Level Security (RLS)**: Enforce RLS policies for multi-tenant and user-owned tables.

---

## Core Tables

### 1. User Profile (`users` / `profiles`)

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY` | Unique user identifier |
| `email` | `VARCHAR(255)` | `UNIQUE, NOT NULL` | Registration email |
| `created_at` | `TIMESTAMPTZ` | `DEFAULT now()` | Creation timestamp |
| `updated_at` | `TIMESTAMPTZ` | `DEFAULT now()` | Last update timestamp |

---

### 2. [Feature Table] (`features`)

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY` | Primary key |
| `user_id` | `UUID` | `REFERENCES users(id)` | Associated user |
| `status` | `SMALLINT` | `DEFAULT 0` | Status code (0: Init, 1: Active, 2: Completed) |
