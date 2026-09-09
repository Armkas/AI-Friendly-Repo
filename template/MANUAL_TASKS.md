# 📋 待办人工操作清单 (Manual Operations Checklist)

> [!NOTE]
> 本文档记录在开发与发布过程中需要**人类工程师配合配置或手动触发执行**的操作（如第三方云平台控制台、支付通道、应用商店证书、生产环境变量注入与真机联调）。
> AI Agent 严禁越权假装已在外部平台完成配置。遇到此类任务，必须在此文件中以 `[ ]` 复选框清晰登记，并向用户报告。

---

## 1. 🔑 外部云服务与第三方凭证配置

- [ ] **1.1 云数据库 / 后端服务 (如 Supabase / Firebase / AWS)**
  - [ ] 登录云平台控制台并创建/关联生产项目
  - [ ] 复制客户端公开 Key 与服务端管理员 Secret
  - [ ] 在控制台配置 CORS 白名单与重定向 URL

- [ ] **1.2 安全与风控服务 (如 Cloudflare Turnstile / 验证码)**
  - [ ] 申请 Site Key（客户端）与 Secret Key（服务端）
  - [ ] 配置本地联调域名（`localhost` / `127.0.0.1`）

- [ ] **1.3 支付与订阅通道 (如 Stripe / Apple In-App Purchase)**
  - [ ] 在商户后台创建商品与定价方案 (Price IDs / Product IDs)
  - [ ] 配置 Webhook 回调接收端点，并保存 Webhook Signing Secret

---

## 2. 🚀 生产环境发布与数据库迁移

- [ ] **2.1 数据库增量迁移推送**
  - 执行迁移命令（如 `supabase db push` / `npx prisma migrate deploy`）
  - 检查迁移执行日志，确认无锁表或数据不兼容问题

- [ ] **2.2 线上环境变量注入**
  - 在托管控制台（Vercel / Cloudflare Pages / AWS）录入生产所需的所有敏感环境变量

---

## 3. 📱 移动端与平台分发（若适用）

- [ ] **3.1 Apple Developer & App Store Connect**
  - [ ] 申请 App ID、Capabilities（如推送、Sign in with Apple）
  - [ ] 在 App Store Connect 登记内购商品元数据与审核截图
  - [ ] 配置内购交易服务器通知地址 (Server Notifications V2)

---

## 4. 🧪 真实环境验收与硬件联调

- [ ] **4.1 物理真机测试**
  - [ ] 摄像头、麦克风、蓝牙或推送通知的系统权限弹窗流程验证
  - [ ] 断网、飞行模式及弱网环境下的优雅降级体验验证
