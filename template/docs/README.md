# 📖 知识层文档索引 (AI Context Architecture Docs)

> 本目录为 AI 编程代理与人类架构师共享的**项目知识中心 (AI Context Layer)**。

---

## 目录结构导航

```text
docs/
├── PROJECT_MAP.md              # 1. 项目全景图（宏观拓扑、子系统位置与技术栈）
├── architecture/               # 2. 系统架构、设计思想与规范
│   ├── overview.md             #    架构设计思想与技术栈
│   ├── golden_feature_template.md # 黄金特性样板（新 Feature 必须遵循）
│   └── env_secrets_config.md   #    环境变量与密钥配置规范
├── contracts/                  # 3. 接口与数据库契约
│   ├── backend_rpc.md          #    API / RPC 出入参与错误码
│   └── database_schema.md      #    数据库表结构物理模式快照
├── invariants/                 # 4. 业务不变式与安全合规红线
│   └── business_invariants.md  #    绝对不可打破的核心业务规则
├── adr/                        # 5. 架构决策记录 (ADR)
│   ├── README.md               #    ADR 索引表
│   └── ADR-000-template.md     #    标准 ADR 模版
└── domains/                    # 6. 业务垂直领域知识库
    ├── README.md               #    领域索引
    └── domain-template.md      #    领域文档模版
```
