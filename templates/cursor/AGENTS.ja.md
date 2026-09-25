# 🤖 [プロジェクト名] - AI エージェント用ガイド (AGENTS.md)

[English](AGENTS.md) | [简体中文](AGENTS.zh-CN.md)

> **唯一の規範源 (Canonical Single Source of Truth)**：本ドキュメントは、すべての AI コーディングエージェント（Claude Code、Gemini/Antigravity、Cursor、Windsurf、Copilot 等）に対する第一のエントリポイントおよび仕様書です。
> 本プロジェクトは**2層ポリシー (Two-Layer Policy)** を採用しています：
> - **第 1 層（AI Context Architecture）**：本文、`docs/`、および `.agents/` によって規定され、全体図、規約、不変条件、探索階層を定義します。
> - **第 2 層（Software Runtime Architecture）**：コンパイラ、静的型チェッカー、リンター、ビルドコマンドによって強制されます。

---

## 🧪 検証および品質保証コマンド (Commands & Verification)

コードの変更や機能の実装が完了した後は、**必ず以下のコマンドを順番に実行して閉ループ検証を行ってください**。エラーが残っている場合はタスク未完了とみなされます：

```bash
# 1. 静的型チェック (エラー 0 であること)
# 例: npm run typecheck / mypy . / swift build
<Typecheck Command>

# 2. コンパイルまたはビルド検証 (ビルドが成功すること)
# 例: npm run build / cargo check / xcodebuild ...
<Build Command>

# 3. 単体/統合テスト (現フェーズでテストが有効な場合)
# 例: npm test / pytest
<Test Command>
```

> 💡 **エージェントへの要求**：上記の検証コマンドを実行することなく「完了しました」と宣言することは禁じられています。環境に依存関係が不足している場合やコマンドが実行できない場合は、ユーザーに明確に報告してください。

---

## ⚠️ 開発範囲および状態宣言 (Scope & Status)

現在の開発境界を明確にし、エージェントが無駄なトークンを消費したり、凍結領域で不必要な推論を行ったりするのを防ぎます：

- **一時凍結モジュール / プラットフォーム**：[例: Android クライアントは現在凍結中。読み込みや変更を行わないこと]
- **テスト戦略方針**：[例: 型チェックとビルドの通過を優先し、現段階では新規の単体テストを作成しない]
- **外部運用の境界**：外部 Web コンソール、本番マイグレーション、シークレットの設定が必要な場合は、[MANUAL_TASKS.md](MANUAL_TASKS.md) に記録してください。

---

## 🎯 漸進的な情報開示 (Progressive Disclosure)

常に以下の順序でコンテキストを取得してください。**決して実装ファイルを直接開いたり、コードベース全体を grep 検索したりしないでください**：

1. **全体およびプラットフォーム別ルール**：
   - 全体ルール：[.agents/rules/global.md](.agents/rules/global.md)
   - プラットフォーム別ルール：`.agents/rules/[platform].md`（例: `web.md`, `ios.md`, `backend.md`）
2. **システム全体図とコンテキストインデックス**：
   - システム全体図：[docs/PROJECT_MAP.md](docs/PROJECT_MAP.md)
   - 機械可読インデックス：[.agents/context-index.md](.agents/context-index.md)（インターフェースやシンボルの位置特定）
3. **ドメイン知識**：[docs/domains/](docs/domains/)（ビジネスフロー、ライフサイクル、状態マシンの理解）
4. **規約・コントラクト**：[docs/contracts/](docs/contracts/)
   - API / RPC 規約：[backend_rpc.md](docs/contracts/backend_rpc.md)
   - データベーススキーマ：[database_schema.md](docs/contracts/database_schema.md)
5. **設計決定と不変条件**：
   - 意思決定の背景 (Why)：[docs/adr/](docs/adr/)
   - 不可侵のビジネスルール：[docs/invariants/](docs/invariants/)
6. **依存関係と影響範囲の分析**：[.agents/dependency-map.md](.agents/dependency-map.md)
7. **標準機能テンプレート**：[docs/architecture/golden_feature_template.md](docs/architecture/golden_feature_template.md)
8. **実装コード**：対応する `Interface` を確認した後にのみ、実装コードへ下鑽します。

---

## 🏛 核心的な不変ルール (Core Rules)

1. **実装よりインターフェース優先**：実装を書く前に必ず `Interface/` で抽象プロトコルや型を定義してください。
2. **唯一の真実の源 (Single Source of Truth)**：ビジネス定数や設定、列挙型は中央設定ファイルまたは辞書テーブルに集約してください。
3. **ロジックの憶測禁止**：曖昧な境界条件に直面した場合は、`docs/invariants/` と `docs/adr/` を確認してください。不明な場合は自己判断せずユーザーに質問してください。
4. **コンテキスト予算の節約**：不要なファイルを大量にコンテキストに読み込まないでください。

---

## 📋 ドキュメント防腐化チェックリスト (Doc-Sync Checklist)

コードの変更を完了する前に、**ドキュメントの陳腐化を防ぐために以下のチェックリストと照合してください**：

- [ ] **プロトコルまたはインターフェースを変更したか？**
  - [.agents/context-index.md](.agents/context-index.md) のキーインターフェース一覧を更新
  - [.agents/dependency-map.md](.agents/dependency-map.md) の依存関係図を更新
- [ ] **API / RPC の入出力パラメータを変更したか？**
  - [docs/contracts/backend_rpc.md](docs/contracts/backend_rpc.md) を更新
- [ ] **データベース構造を変更したか？**
  - 増分マイグレーション SQL ファイルを追加（過去のマイグレーションは編集不可）
  - [docs/contracts/database_schema.md](docs/contracts/database_schema.md) を更新
- [ ] **新しい Feature モジュールを追加したか？**
  - [docs/architecture/golden_feature_template.md](docs/architecture/golden_feature_template.md) の構造に準拠
  - [docs/PROJECT_MAP.md](docs/PROJECT_MAP.md) と [docs/domains/](docs/domains/) に登録
- [ ] **外部コンソールでの手動設定が必要か？**
  - [MANUAL_TASKS.md](MANUAL_TASKS.md) に `[ ]` チェックボックス形式で追記
