# 📋 Manual Operations Checklist (MANUAL_TASKS.md)

[简体中文](MANUAL_TASKS.zh-CN.md) | [日本語](MANUAL_TASKS.ja.md)

> [!NOTE]
> This document tracks tasks that require **human intervention, external configuration, or manual triggers** (such as third-party cloud consoles, payment gateways, app store certificates, production secret provisioning, and physical device validation).
> AI Agents must NEVER pretend to have executed actions on external platforms. When encountering such tasks, register them here with actionable `[ ]` checkboxes and notify the user.

---

## 1. 🔑 Third-Party Cloud Services & Credentials

- [ ] **1.1 Cloud Database / Backend Services (e.g. Supabase / Firebase / AWS)**
  - [ ] Log in to cloud console and create/link production project
  - [ ] Copy client public key and server secret key
  - [ ] Configure CORS allowed origins and redirect URLs in cloud dashboard

- [ ] **1.2 Security & Anti-Abuse (e.g. Cloudflare Turnstile / Captcha)**
  - [ ] Create site and generate Site Key (client) and Secret Key (server)
  - [ ] Configure local debugging domains (`localhost` / `127.0.0.1`)

- [ ] **1.3 Payment & Subscription Gateways (e.g. Stripe / Apple In-App Purchase)**
  - [ ] Create products and pricing plans in merchant dashboard (Price IDs / Product IDs)
  - [ ] Set up Webhook endpoints and record Webhook Signing Secret

---

## 2. 🚀 Production Deployment & Database Migrations

- [ ] **2.1 Production Database Migration Push**
  - Execute migration command (e.g., `supabase db push` / `npx prisma migrate deploy`)
  - Review migration logs to verify zero locking issues and complete backwards compatibility

- [ ] **2.2 Production Environment Variables Provisioning**
  - Inject all required production environment secrets in hosting platform (Vercel / Cloudflare Pages / AWS / K8s)

---

## 3. 📱 Mobile & Distribution Consoles (If Applicable)

- [ ] **3.1 Apple Developer & App Store Connect**
  - [ ] Create App ID and configure required capabilities (Push Notifications, Sign in with Apple)
  - [ ] Set up In-App Purchase items and review metadata
  - [ ] Configure Server-to-Server Notifications endpoint (App Store Server Notifications V2)

---

## 4. 🧪 Physical Hardware & End-to-End Testing

- [ ] **4.1 Real-Device Verification**
  - [ ] Verify system permission prompts (Camera, Microphone, Bluetooth, Push Notifications)
  - [ ] Validate graceful degradation under offline and high-latency network conditions
