# AI-Native Repository Standard (AI 原生仓库标准)

[🇺🇸 English](README.md) | [🇯🇵 日本語](README.ja.md)

> **不要仅仅给 AI 喂更多的上下文。给它一个原生的工作空间。**

这是一套标准、架构理念和脚手架模板，旨在帮助开发者构建能让 AI 智能体（Coding Agents）自主理解、导航、修改和验证的代码仓库。

---

## ⚠️ Model-Agnostic, Runtime-Aware (模型解耦，运行时适配)

**“语义是统一的，但运行环境是分裂的。”**

截至 2026 年，业界已经意识到，构建一个真正的 AI-Native 仓库必须区分三个独立的层级：
1. **The Model (模型层)**（如 GPT-6 Astra, Claude Opus 5.5, Gemini 3.8 Flash）：决定核心的理解力与推理智商。
2. **The Agent Runtime (智能体运行时)**（如 Cursor, Claude Code, Windsurf, Copilot, Gemini CLI）：决定*如何*读取文件、*何时*触发技能、以及*怎样*执行拦截钩子。
3. **The Repository Standard (仓库标准)**（如 Context, Contracts, Workflows）：你的项目中与具体工具无关的语义真理。

尽管你的业务规则和工作流是 **Model-Agnostic (与模型无关的)**（GPT 和 Claude 都能读懂 `docs/domains/voice.md`），但它们必须是 **Runtime-Aware (运行时感知的)**。
- **Anthropic 的 Claude Code** 期望存在 `.claude/settings.json`（侧重生命周期钩子）。
- **OpenAI 的 Codex / SDK** 期望存在 `AGENTS.md` 与 `.agents/skills/`（侧重渐进式任务发现）。
- **Cursor** 期望存在 `.cursor/rules/*.mdc`（侧重多模型动态 glob 匹配）。
- **GitHub Copilot / Windsurf / Trae** 则有各自原生的路径指令与代理机制。

如果强行在同一个项目里糅合所有这些配置文件，只会导致规则冲突、上下文污染和维护地狱。

因此，本项目提出：
1. **一套底层规范** (`spec/`)：定义工具无关的纯粹理论（如领域知识、契约、工作流怎么写）。
2. **纯净运行时模板** (`templates/`)：直接针对你的团队所购买/使用的具体 Runtime（例如 Cursor），提供最贴合其原生能力的适配器脚手架，杜绝多余工具的干扰。

---

## 🏗 8 大 AI-Native 架构支柱

本标准将代码仓库从“供 AI 阅读的书”升级为“供 AI 工作的车间”。它定义了 8 个架构层：

### 1. Context (认知层：系统是什么)
*`PROJECT_MAP`, `Domains`, `Architecture`*
告诉 AI 整个系统的拓扑结构、业务领域知识以及架构设计的初衷。

### 2. Rules (规则层：必须/禁止做什么)
*`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`*
绝对约束。如代码格式化标准、导入规范、以及不可破损的架构底线。

### 3. Contracts (契约层：模块间如何协作)
*`Protocols`, `Schemas`, `API 契约`*
组件之间的明确边界。AI 对接口契约的依赖远大于人类。

### 4. Skills (技能层：特定任务怎么做)
*`SKILL.md`*
可复用的原子能力（例如：“在这个仓库中如何生成一次数据库迁移”）。

### 5. Workflows (工作流层：如何编排步骤)
*`SOPs`*
多步标准作业程序（例如：“计划 -> 检查不变量 -> 实现 -> 测试 -> 验证 -> 更新文档”）。

### 6. Tools (工具层：如何操作世界)
*`MCP Servers`, `确定性 CLI 脚本`*
安全、结构化的工具接口。允许 Agent 安全地读取数据库、获取日志或编译代码，防止 LLM 在终端盲目通过幻觉执行危险命令。

### 7. Verification (验证层：如何证明做对了)
*`Tests`, `Validators`, `Hooks`*
自动化的闭环验证。只有当校验脚本返回 `exit code 0` 时，Agent 的任务才算真正完成。

### 8. Human / Agent Boundary (边界层：人机信任隔离)
*`MANUAL_TASKS.md`*
清晰的权限划分：哪些事 AI 可以全自动做，哪些高危操作必须人类审批（如生产环境部署），哪些事必须人类亲力亲为（如注入安全密钥）。

---

## 📂 仓库目录结构

```text
AI-Native-Repo/
│
├── 1️⃣ spec/                            # 【标准层】工具无关的理论与哲学
│   ├── repository-standard.md         # 8 大支柱架构定义
│   └── philosophy.md                  # 阐述“Context Must Be Earned”等哲学
│
├── 2️⃣ templates/                       # 【模板层】为你所选的 Agent 提供纯净脚手架
│   ├── claude-code/                   # 纯 Claude 生态环境 (.claude/ 钩子与技能)
│   ├── codex/                         # 纯 OpenAI 环境 (.agents/skills/)
│   ├── cursor/                        # 纯 Cursor 环境 (.cursor/rules/)
│   └── gemini-cli/                    # 纯 Gemini 环境
│
└── 3️⃣ examples/                        # 【范例层】真实世界的对比演示（控制变量法）
    ├── claude-code/                   # 业务代码完全相同的跨平台语音聊天项目，Claude 配置版
    ├── codex/                         # 同上，Codex 配置版
    ├── cursor/                        # 同上，Cursor 配置版
    └── gemini-cli/                    # 同上，Gemini 配置版
```

---

## 📖 选择你的 Agent Runtime（开始使用）

根据你团队实际使用的运行时环境，拷贝对应的模板开始你的 AI-Native 项目：

* **如果你使用 Claude Code** -> 拷贝 `templates/claude-code/`
* **如果你使用 OpenAI / Codex** -> 拷贝 `templates/codex/`
* **如果你使用 Cursor** -> 拷贝 `templates/cursor/` (注：Cursor 是一个多模型运行时)
* **如果你使用 Gemini CLI** -> 拷贝 `templates/gemini-cli/`

深入了解背后的设计哲学，请阅读 [代码仓库设计规范 (Repository Standard)](spec/repository-standard.zh-CN.md)。
