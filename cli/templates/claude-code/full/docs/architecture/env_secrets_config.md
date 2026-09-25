# 🔐 Environment Variables & Secrets Architecture (env_secrets_config.md)

> [!IMPORTANT]
> **Security Red Lines**:
> 1. Never commit real production secrets (private keys, API secrets, database credentials) to Git;
> 2. Never expose administrative service keys in client-side code or public web pages;
> 3. Local development must copy `.env.example` to `.env`.

---

## 1. Environment Variable Tiers

| Tier / Category | Prefix Convention | Visibility | Typical Use Case |
| :--- | :--- | :--- | :--- |
| **Public Client Variables** | `NEXT_PUBLIC_*` / `VITE_*` / `EXPO_PUBLIC_*` | **Public** (Bundled in client) | Public API URLs, public site keys, app version |
| **Private Server Secrets** | `API_SECRET_*` / `DB_PASSWORD` / `SECRET_KEY` | **Confidential** (Server memory only) | DB connection strings, merchant secrets, high-privilege tokens |

---

## 2. Backward-Compatible Reading Patterns

To prevent agents from hallucinating deprecated environment keys, use dual-fallback reading patterns:

```typescript
// Server-side confidential reading
const adminSecret = process.env.SERVICE_SECRET_KEY 
  ?? process.env.LEGACY_SERVICE_ROLE_KEY;

if (!adminSecret) {
  throw new Error("Missing SERVICE_SECRET_KEY in environment");
}
```

```typescript
// Web client public key reading
const publishableKey = import.meta.env.VITE_PUBLISHABLE_KEY 
  ?? import.meta.env.VITE_ANON_KEY;
```

---

## 3. Template Configuration (.env.example)

When adding a new environment variable, agents must document its name and purpose in the root `.env.example`.
