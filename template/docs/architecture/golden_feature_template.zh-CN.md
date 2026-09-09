# 🏆 黄金特性样板指南 (Golden Feature Template)

> [!IMPORTANT]
> **AI 代理核心准则**：
> 当为本项目新增或重构一个业务功能模块 (Feature) 时，**必须严格参照本样板的目录结构与分层规范**，严禁自由发挥或混杂关注点。

---

## 1. 特性标准物理目录结构 (Directory Layout)

以业务特性 `FeatureName` 为例，标准目录推荐结构如下：

```text
features/<FeatureName>/
├── Interface/                          # 1. 核心协议与数据合同 (AI 优先阅读)
│   └── <FeatureName>ServiceProtocol.*  # 声明公开能力、方法签名、返回类型与异常
│
├── Implementation/                     # 2. 业务编排与底层逻辑实现
│   ├── <FeatureName>Manager.*          # 状态维护与业务编排逻辑
│   └── <FeatureName>Repository.*       # 底层数据 IO (网络请求 / 数据库读写)
│
└── Views/                              # 3. 展现层 (只负责渲染与事件触发)
    ├── <FeatureName>View.*             # 特性主视图 / 页面
    └── Components/                     # 模块私有局部 UI 组件
```

---

## 2. 三层解耦核心代码范式

### 第一步：抽象协议定义 (`Interface/`)
> **原则**：只定义“能做什么 (What)”，不包含任何实现细节。文件保持精简，使 AI 能在几十行内完全掌握模块能力边界。

```typescript
// 示例：TypeScript / 接口契约
export interface IFeatureItem {
  id: string;
  title: string;
  createdAt: number;
}

export interface IFeatureService {
  /** 获取特性条目列表 */
  getItems(): Promise<IFeatureItem[]>;

  /** 执行业务操作 */
  executeAction(itemId: string, payload: Record<string, unknown>): Promise<boolean>;
}
```

```swift
// 示例：Swift / Protocol 契约
import Foundation

public protocol FeatureManagerProtocol: ObservableObject {
    var items: [FeatureItem] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }

    func fetchItems() async throws
    func executeAction(itemId: String) async -> Result<Bool, Error>
}
```

### 第二步：业务实现与编排 (`Implementation/`)
> **原则**：依赖第一步定义的 Interface；实现具体的网络调用、缓存存储或状态流转。

```typescript
import { IFeatureService, IFeatureItem } from "../Interface/IFeatureService";

export class FeatureService implements IFeatureService {
  constructor(private readonly apiClient: HttpClient) {}

  async getItems(): Promise<IFeatureItem[]> {
    return await this.apiClient.get<IFeatureItem[]>("/api/features");
  }

  async executeAction(itemId: String, payload: Record<string, unknown>): Promise<boolean> {
    const res = await this.apiClient.post(`/api/features/${itemId}/action`, payload);
    return res.status === 200;
  }
}
```

### 第三步：展现消费层 (`Views/`)
> **原则**：View 层只依赖抽象 Interface 或状态管理器，严禁在视图文件中直接散落复杂的网络请求、数据解析或 SQL 语句。

---

## 📋 3. 新特性交付自检清单 (Checklist)

每次新增或重构 Feature 模块时，AI 代理必须对照以下清单自检：

1. [ ] **Interface 先行**：是否已在 `Interface/` 下定义好了完备的类型与协议契约？
2. [ ] **消除魔法值**：是否已将所有常量、限额、状态枚举集中收敛，无硬编码？
3. [ ] **闭环自检命令**：是否已在终端运行过类型检查与构建命令且 0 报错？
4. [ ] **地图与索引登记**：
   - [ ] 在 `docs/PROJECT_MAP.md` 中登记新 Feature 的职责；
   - [ ] 在 `.agents/context-index.md` 中登记其核心 Interface 路径；
   - [ ] 在 `docs/domains/` 中补充对应的领域业务流转（如适用）。
