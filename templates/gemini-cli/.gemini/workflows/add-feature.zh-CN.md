# 📱 SOP: 新增与重构业务特性工作流 (Add Feature Workflow)

> **目标**：在为项目新增业务功能模块或重构现有特性时，确保接口先行、分层解耦并符合黄金特性样板规范。

---

## 标准执行步骤

### 步骤 1：参照黄金特性样板定义协议 (Interface First)
严格遵循 [docs/architecture/golden_feature_template.md](../../docs/architecture/golden_feature_template.md)：
1. 在目标 Feature 目录下新建 `Interface/` 子目录；
2. 定义清晰的接口协议（例如 `IFeatureService` 或 `<FeatureName>Protocol`）；
3. 明确方法签名、输入参数约束、返回类型与可能抛出的业务异常。

### 步骤 2：业务编排与实现分离 (Implementation)
1. 在 `Implementation/` 或 `Services/` 目录下编写具体的业务实现类；
2. 状态管理与数据读写分离（例如将网络/数据库 IO 封装在 Service，状态在 Store / ViewModel 维护）；
3. View 展现层仅负责 UI 渲染与用户事件绑定，严禁在视图文件中直接编写底层网络调用或繁重的数据转换。

### 步骤 3：校验单一真理来源 (Single Source of Truth)
1. 检查是否存在硬编码的数字、URL 或状态字符串；
2. 枚举值、常量或配置项必须集中声明在配置文件或公共字典中。

### 步骤 4：运行闭环验证命令 (Verification)
执行 `AGENTS.md` 中声明的自动化验证命令：
```bash
# 静态类型检查
<Typecheck Command>

# 编译与构建测试
<Build Command>
```
确保命令输出 0 报错，不可凭自然语言推测通过。

### 步骤 5：登记系统地图与上下文索引 (Doc-Sync)
- [ ] 在 [docs/PROJECT_MAP.md](../../docs/PROJECT_MAP.md) 中登记新增模块职责与目录归属；
- [ ] 在 [.agents/context-index.md](../context-index.md) 的【核心接口与协议】中注册新增协议路径；
- [ ] 在 [.agents/dependency-map.md](../dependency-map.md) 中核实对上下游依赖关系的影响。
