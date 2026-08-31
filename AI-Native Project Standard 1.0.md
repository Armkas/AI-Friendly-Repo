# AI-Native Project Standard 1.0
## 面向 AI Coding Agent 的项目设计规范

---

# 一、总原则

## Rule 01 — 仓库必须分成“知识层”和“代码层”

整个项目统一抽象为：

```text
Repository
├── Knowledge Layer
│   ├── Agent Rules
│   ├── Project Map
│   ├── Architecture
│   ├── Domain Knowledge
│   ├── Contracts
│   ├── Invariants
│   ├── ADR
│   └── Generated Index
│
└── Code Layer
    ├── iOS
    ├── Backend
    ├── Web
    ├── Worker
    └── Other Components
```

Knowledge Layer 解释：

> 项目是什么、为什么这么设计、东西在哪里、规则是什么。

Code Layer 解释：

> 具体代码到底怎么实现。

---

# 二、AI 不允许“一次性阅读整个项目”

## Rule 02 — AI 必须采用分层读取策略

标准读取顺序：

```text
Level 0
AGENTS.md
        ↓
Level 1
PROJECT_MAP
        ↓
Level 2
DOMAIN_MAP / Architecture
        ↓
Level 3
Interface / Contract
        ↓
Level 4
Invariant / ADR / Tests
        ↓
Level 5
Implementation
```

只有当上一级信息不足时，才进入下一级。

---

## Rule 03 — 默认不主动读取 Implementation

默认：

```text
Interface
Contract
Architecture
Domain
Test
```

优先于：

```text
Implementation
```

但：

> **Implementation 不是“默认正确”，而是“默认不展开”。**

当出现以下情况时，AI 应主动下钻：

```text
Contract 无法解释问题
Test 失败
行为与文档不一致
依赖关系异常
怀疑实现存在 Bug
需要修改实现
```

---

# 三、AI 指令文件

## Rule 04 — 根目录必须有 AGENTS.md

`AGENTS.md` 是整个仓库的 Agent 工作合同。

它负责：

```text
项目是什么
AI 先看什么
目录在哪里
规则是什么
测试怎么执行
什么情况下继续下钻
什么东西禁止修改
```

它不应该变成一篇巨大的技术百科全书。

原则：

> **AGENTS.md 负责导航，不负责承载全部知识。**

---

## Rule 05 — 平台/子项目可以拥有自己的 AGENTS.md

例如：

```text
AGENTS.md

ios/
└── AGENTS.md

backend/
└── AGENTS.md
```

根规则：

> 整个仓库适用。

子规则：

> 当前目录及其子目录适用。

因此 AI 在：

```text
backend/features/voice/
```

工作时，可以同时获得：

```text
根 AGENTS.md
+
backend/AGENTS.md
+
Voice Domain Context
```

---

# 四、项目地图

## Rule 06 — 必须存在 Project Map

建议：

```text
docs/
└── PROJECT_MAP.md
```

它只回答：

> “整个项目是什么，以及东西在哪里。”

它必须包含：

```text
项目简介
顶层目录
主要子系统
主要入口
主要业务领域
系统主数据流
关键依赖
重要规则入口
```

不能把所有实现细节写进去。

---

## Rule 07 — Project Map 必须短

原则：

> 能用 100 行解决，不要写 500 行。

Project Map 的目标是：

```text
快速建立全局认知
```

不是：

```text
完整替代所有文档
```

---

# 五、Context Index

## Rule 08 — 必须存在机器/AI 可快速查询的 Context Index

推荐：

```text
.agents/
└── context-index.md
```

它回答：

> “某个东西到底在哪里？”

例如：

```text
Voice
→ ios/features/voice/
→ backend/features/voice/

Navigation
→ ios/features/navigation/
→ backend/features/navigation/

SpeechService
→ backend/features/voice/interface/speech_service.py
```

---

## Rule 09 — Context Index 中的信息尽可能自动生成

自动生成：

```text
文件位置
Symbol
Protocol
Class
Function
Implementation
Reference
Import
Dependency
Test
```

人工维护：

```text
业务意义
架构意图
设计原因
Invariant
ADR
```

---

# 六、按业务领域组织代码

## Rule 10 — 使用 Vertical Slice / Feature-based Architecture

推荐：

```text
features/
├── voice/
├── navigation/
├── users/
└── billing/
```

不要优先采用：

```text
routers/
services/
models/
controllers/
utils/
```

这种纯技术横向分类。

理由：

> AI 接到一个业务任务时，应能尽可能在一个 Feature 边界内找到大部分相关代码。

---

## Rule 11 — Feature 是 AI 的主要上下文边界

例如：

```text
features/voice/
```

应该尽量包含：

```text
Voice Interface
Voice Domain
Voice Application
Voice Infrastructure
Voice API
Voice Tests
```

AI 在处理 Voice 时，不应无目的扫描整个项目。

---

# 七、Interface / Contract

## Rule 12 — 业务能力必须优先通过 Interface 描述

iOS 使用：

```swift
protocol
```

Python 使用：

```python
typing.Protocol
```

或者其他明确的抽象接口。

---

## Rule 13 — Interface 必须描述 Contract，而不只是函数签名

例如：

```python
class SpeechService(Protocol):
    """
    Converts audio into text.

    Contract:
    - Does not execute user commands.
    - Returns validated text.
    - Provider-specific exceptions must not escape.
    - Network failure may trigger fallback.
    """
```

至少描述：

```text
职责
输入
输出
错误
副作用
关键约束
```

---

## Rule 14 — API Schema 与 Domain Interface 必须分开

例如：

```text
API Contract
    Request
    Response
```

和：

```text
Domain Contract
    Service
    Repository
    Provider
```

不能因为都叫“Interface”就全部混在一起。

---

# 八、Implementation

## Rule 15 — Implementation 应该位于明确的 Infrastructure / Implementation 边界

例如：

```text
voice/
├── interface/
│   └── speech_service.py
│
├── application/
│   └── voice_service.py
│
└── infrastructure/
    ├── openai_speech_service.py
    ├── apple_speech_service.py
    └── fallback_speech_service.py
```

AI 第一次只需要知道：

```text
SpeechService
```

需要时再进入：

```text
OpenAISpeechService
```

---

# 九、Domain Knowledge

## Rule 16 — 每个重要业务领域必须拥有领域说明

例如：

```text
docs/domains/voice.md
```

必须说明：

```text
职责
输入
输出
主要能力
依赖
数据流
状态机
Invariant
错误处理
相关 Interface
相关 Test
```

---

# 十、Invariant

## Rule 17 — 业务规则必须与 Implementation 分离

例如：

```text
Network failure
→ fallback

20 秒无语音
→ Session 结束

高风险操作
→ 必须用户确认
```

这些规则不能只存在于代码里。

应该明确记录：

```text
docs/domains/voice.md
```

或：

```text
docs/INVARIANTS.md
```

---

## Rule 18 — Invariant 优先级高于 Implementation

AI 修改代码时：

```text
Implementation 可以改
Invariant 不能随意改
```

除非用户明确要求改变业务规则。

---

# 十一、ADR

## Rule 19 — 重要架构决策必须有 ADR

例如：

```text
docs/adr/
├── ADR-001-voice-transport.md
├── ADR-002-navigation-engine.md
└── ADR-003-authentication.md
```

每个 ADR 至少写：

```text
问题
决定
为什么这样决定
放弃了哪些方案
带来的代价
未来什么情况下可以改变
```

---

## Rule 20 — ADR 解决“为什么”

Implementation 解决：

> 怎么做。

Interface 解决：

> 能做什么。

Invariant 解决：

> 什么不能破坏。

ADR 解决：

> 为什么这样设计。

四者必须分开。

---

# 十二、Dependency Map

## Rule 21 — 必须能够回答“谁依赖谁”

例如：

```text
VoiceService
├── SpeechService
├── LLMService
└── CommandValidator
```

以及：

```text
NavigationService
├── LocationProvider
├── RouteEngine
└── MapRepository
```

---

# 十三、Usage / Impact Map

## Rule 22 — 必须能够回答“谁使用了它”

例如：

```text
SpeechService
Used By:
- VoiceSession
- VoiceCommandProcessor
- VoiceTests
```

---

## Rule 23 — 必须能够回答“修改它会影响谁”

例如：

```text
Change: SpeechService

Direct Impact:
- VoiceService

Indirect Impact:
- VoiceRouter
- ConversationService

Tests:
- SpeechServiceTests
- VoiceServiceTests
```

这个信息最好自动生成。

---

# 十四、命名

## Rule 24 — Symbol 名必须具有业务含义

尽量避免：

```text
Manager
Helper
Utils
Worker
Handler
Processor
CommonService
```

除非确实有明确语义。

优先：

```text
VoiceCommandRouter
SpeechRecognitionService
NavigationRouteCalculator
UserPermissionChecker
```

原则：

> **名字本身就是 AI 的搜索索引。**

---

# 十五、文件边界

## Rule 25 — 禁止巨大 God File

不要：

```text
Manager.swift
2000 lines
```

里面同时包含：

```text
Network
Database
Navigation
Voice
Analytics
UI
```

一个文件应该尽可能对应一个清晰职责。

---

# 十六、Tests

## Rule 26 — Test 必须成为 AI 的事实来源之一

AI 不应该只相信文档。

应该：

```text
Contract
+
Invariant
+
Test
+
Implementation
```

共同决定系统行为。

---

## Rule 27 — 测试名称必须表达业务行为

例如：

```text
testNetworkFailureFallsBackToLocalRecognition()

testSilenceAfterTwentySecondsEndsSession()

testDangerousNavigationRequiresConfirmation()
```

而不是：

```text
test1()
testVoice()
testService()
```

---

## Rule 28 — 先局部测试，最终仍然要全局验证

推荐：

```text
修改
↓
相关 Unit Test
↓
相关 Integration Test
↓
必要时 Full Test Suite
```

不能为了 AI 省 Token 而取消最终测试。

---

# 十七、Generated Files

## Rule 29 — Generated 内容必须与 Source of Truth 分离

例如：

```text
generated/
```

必须明确：

```text
DO NOT EDIT
```

真正维护的是：

```text
source
```

---

# 十八、AI Rules / Skills / Workflows

## Rule 30 — 通用规则、工作流程和领域知识分开

推荐：

```text
.agents/
├── context-index.md
├── skills/
├── workflows/
└── guardrails/
```

例如：

```text
skills/
    ios-development.md
    fastapi-development.md
    database-migration.md

workflows/
    bug-fix.md
    feature-development.md
    refactor.md

guardrails/
    security.md
    architecture.md
```

不要全部塞进 `AGENTS.md`。

---

# 十九、不要让文档变成第二份代码

## Rule 31 — 文档必须描述“意图”，而不是复制 Implementation

坏：

```text
这里有一个 for loop，然后调用 xxx，然后判断 xxx……
```

好：

```text
该服务负责：
Audio → Transcript。

当 Provider 不可用：
必须进入 fallback。
```

原则：

> 文档应该描述“为什么”和“是什么”，代码描述“怎么做”。

---

# 二十、文档与代码冲突时

## Rule 32 — 代码、测试、文档的事实优先级必须明确

推荐：

```text
Executed Test / Actual System Behavior
        ↓
Current Implementation
        ↓
Contract
        ↓
Documentation
        ↓
Comments
```

但如果发现：

```text
代码与业务文档冲突
```

AI 不应该偷偷修改其中一个。

应该：

```text
标记冲突
判断哪个是当前意图
更新对应文档/代码
```

---

# 二十一、AI 不应该无目的读取这些东西

## Rule 33 — 默认忽略：

```text
build/
DerivedData/
Pods/
node_modules/
.venv/
dist/
generated binaries
large assets
logs
cache
```

除非任务明确涉及这些内容。

---

# 二十二、AI 工作流程

## Rule 34 — 每次修改都采用“先定位、后读取、再修改”

标准流程：

```text
任务
↓
AGENTS
↓
PROJECT_MAP
↓
Domain
↓
Interface
↓
Invariant / ADR
↓
Relevant Test
↓
Dependency / Impact
↓
Implementation
↓
修改
↓
测试
↓
更新必要文档
```

---

# 二十三、最低标准

一个合格的 AI-Native 项目至少应该拥有：

```text
AGENTS.md
docs/PROJECT_MAP.md
docs/ARCHITECTURE.md
docs/domains/
docs/adr/
.agents/context-index.md
```

并且业务 Feature 必须：

```text
有清晰边界
有明确 Interface
有 Tests
有业务规则
```

---

# 二十四、终极目标

AI 不应该：

```text
读完整个项目
↓
形成模糊印象
↓
猜架构
↓
开始修改
```

而应该：

```text
地图
↓
定位
↓
抽象
↓
规则
↓
验证
↓
下钻
↓
修改
```

最终目标：

> **让 AI 在极小 Context 下获得尽可能大的正确理解。**

---

# 二十五、完整范例
# iOS + FastAPI 项目

假设项目叫：

```text
AIMotion
```

产品：

> 一个具有地图、导航和连续语音交互能力的 AI 移动应用。

完整仓库：

```text
AIMotion/
│
├── AGENTS.md
│
├── .agents/
│   ├── context-index.md
│   │
│   ├── skills/
│   │   ├── ios-development.md
│   │   ├── fastapi-development.md
│   │   └── database.md
│   │
│   ├── workflows/
│   │   ├── feature-development.md
│   │   ├── bug-fix.md
│   │   └── refactor.md
│   │
│   └── guardrails/
│       ├── architecture.md
│       └── security.md
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
│   │   ├── map.md
│   │   └── account.md
│   │
│   └── adr/
│       ├── ADR-001-voice-transport.md
│       ├── ADR-002-command-confirmation.md
│       └── ADR-003-route-engine.md
│
├── ios/
│   ├── AGENTS.md
│   │
│   ├── App/
│   │
│   ├── Features/
│   │   ├── Voice/
│   │   │   ├── Interface/
│   │   │   │   ├── VoiceSession.swift
│   │   │   │   ├── VoiceCommandService.swift
│   │   │   │   └── SpeechRecognizer.swift
│   │   │   │
│   │   │   ├── Domain/
│   │   │   │   ├── VoiceCommand.swift
│   │   │   │   └── VoiceSessionState.swift
│   │   │   │
│   │   │   ├── Application/
│   │   │   │   └── VoiceCoordinator.swift
│   │   │   │
│   │   │   ├── Infrastructure/
│   │   │   │   ├── AppleSpeechRecognizer.swift
│   │   │   │   ├── RemoteSpeechRecognizer.swift
│   │   │   │   └── FallbackSpeechRecognizer.swift
│   │   │   │
│   │   │   ├── Presentation/
│   │   │   │   └── VoiceView.swift
│   │   │   │
│   │   │   └── Tests/
│   │   │       └── VoiceSessionTests.swift
│   │   │
│   │   ├── Navigation/
│   │   ├── Map/
│   │   └── Account/
│   │
│   ├── Core/
│   │   ├── Networking/
│   │   ├── Location/
│   │   ├── Storage/
│   │   └── Logging/
│   │
│   └── Tests/
│
└── backend/
    ├── AGENTS.md
    │
    ├── pyproject.toml
    │
    ├── app/
    │   ├── main.py
    │   │
    │   ├── core/
    │   │   ├── config.py
    │   │   ├── database.py
    │   │   ├── security.py
    │   │   └── exceptions.py
    │   │
    │   └── features/
    │       ├── voice/
    │       │   ├── interface/
    │       │   │   ├── speech_service.py
    │       │   │   ├── llm_service.py
    │       │   │   └── command_service.py
    │       │   │
    │       │   ├── domain/
    │       │   │   ├── models.py
    │       │   │   └── rules.py
    │       │   │
    │       │   ├── application/
    │       │   │   └── voice_service.py
    │       │   │
    │       │   ├── infrastructure/
    │       │   │   ├── openai_speech.py
    │       │   │   ├── openai_llm.py
    │       │   │   └── fallback_speech.py
    │       │   │
    │       │   ├── api/
    │       │   │   ├── router.py
    │       │   │   └── schemas.py
    │       │   │
    │       │   └── tests/
    │       │       ├── test_voice_service.py
    │       │       └── test_voice_api.py
    │       │
    │       ├── navigation/
    │       ├── map/
    │       └── account/
    │
    ├── migrations/
    │
    └── tests/
```

---

# 二十六、这个项目的 AGENTS.md

```md
# AIMotion Agent Guide

## Project

AIMotion is an AI-powered mobile navigation system.

Components:

- iOS client
- FastAPI backend

## Start Here

Read in this order:

1. docs/PROJECT_MAP.md
2. docs/ARCHITECTURE.md
3. relevant docs/domains/*.md
4. relevant Interface
5. relevant Tests
6. Implementation only when necessary

## Architecture

The repository uses:

Knowledge Layer + Code Layer.

Business code is organized by feature/domain.

Features must communicate through explicit interfaces.

Do not directly couple one feature to another feature's implementation.

## Important Rule

Do not assume Implementation is correct.

However, do not read or modify unrelated implementations without a reason.

## Before Editing

Identify:

- target domain
- target interface
- invariants
- affected dependencies
- relevant tests

## After Editing

Run:

1. focused tests
2. integration tests when affected
3. full test suite when appropriate

## Documentation

When architectural behavior changes, update the relevant:

- domain documentation
- ADR
- contract
- index

Do not create duplicate documentation.
```

---

# 二十七、Voice Domain 的实际地图

```md
# Voice Domain

## Responsibility

Handles continuous voice interaction.

## System Flow

iOS Microphone
→ VoiceSession
→ Backend
→ Speech Recognition
→ LLM
→ VoiceCommand
→ Confirmation
→ Action

## iOS

Main interfaces:

- VoiceSession
- SpeechRecognizer
- VoiceCommandService

Location:

ios/Features/Voice/

## Backend

Main interfaces:

- SpeechService
- LLMService
- CommandService

Location:

backend/app/features/voice/

## Invariants

1. 20 seconds of silence ends the session.
2. Network failure must trigger fallback.
3. Invalid commands must never execute.
4. High-risk commands require explicit confirmation.
5. Speech recognition must not directly execute navigation.
6. Provider-specific API errors must not leak into the domain layer.

## Related ADR

ADR-001
ADR-002
```

---

# 二十八、iOS Interface

```swift
protocol VoiceSession {
    func start()
    func stop()
}

protocol SpeechRecognizer {
    func startRecognition() async throws
    func stopRecognition() async
}
```

但真正完整的版本应该：

```swift
/// Converts spoken audio into validated VoiceCommand.
///
/// Contract:
/// - Must not execute commands.
/// - Must return a validated command.
/// - Provider-specific errors must be translated.
/// - Network failure may trigger a fallback implementation.
protocol VoiceCommandService {
    func process(
        audio: AudioBuffer
    ) async throws -> VoiceCommand
}
```

---

# 二十九、FastAPI Interface

```python
from typing import Protocol

class SpeechService(Protocol):
    """
    Converts audio into text.

    Contract:
    - Does not execute user commands.
    - Returns validated transcription.
    - Provider-specific exceptions must not escape.
    - Network failures may trigger fallback.
    """

    async def transcribe(
        self,
        audio: bytes,
    ) -> str:
        ...
```

然后具体实现：

```text
infrastructure/
├── openai_speech.py
├── local_speech.py
└── fallback_speech.py
```

---

# 三十、最终 AI 阅读示例

假设开发者告诉 AI：

> “修复连续语音在网络断开之后不能继续工作的问题。”

AI 正确的读取路线应该是：

```text
AGENTS.md
↓
docs/PROJECT_MAP.md
↓
docs/domains/voice.md
↓
ADR-001
↓
Voice interfaces
↓
Voice tests
↓
Dependency Map
↓
找到 Speech / Transport implementation
↓
读取相关 implementation
↓
修改
↓
执行 Voice focused tests
↓
执行 integration tests
```

它没有必要读取：

```text
Account
Billing
Map UI
User Settings
Database migrations
所有第三方依赖
整个 iOS 项目
整个 FastAPI 项目
```

---

# 三十一、这个标准最终解决的不是“Context 太小”

真正解决的是：

```text
传统项目：

Code
+
零散 README
+
Comments
+
隐含知识

↓

AI 必须自己猜架构
```

而 AI-Native Project：

```text
Rules
+
Map
+
Domain
+
Contract
+
Invariant
+
ADR
+
Dependency Graph
+
Tests
+
Implementation

↓

AI 可以逐层建立模型
```

最终达到：

> **Small Context → Large Understanding**

而不是：

> **Large Context → Hope the AI Understands**