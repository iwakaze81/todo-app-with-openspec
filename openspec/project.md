# Project Context

## Purpose
Flutter と Dart を用いて、ローカル完結型の TODO アプリを開発する。将来的な拡張（同期機能や外部サービス連携）を見据えつつ、まずはシンプルかつ堅牢な MVP を構築する。

## Tech Stack
- フレームワーク: Flutter
- 言語: Dart
- 状態管理: Riverpod（Hooks 併用可）
- アーキテクチャ: クリーンアーキテクチャ / MVVM ベース
- テスト: Flutter/Dart 標準のユニットテスト・ウィジェットテスト

## Project Conventions

### Code Style
- Flutter/Dart のデフォルトフォーマッタ（`dart format`）と命名規則（UpperCamelCase のクラス、lowerCamelCase のメソッド/変数など）に準拠する。
- UI は特定の ViewModel から構築できるようにし、UI 側からビジネスロジックへ不要な依存が発生しないようにする。

### Architecture Patterns
- クリーンアーキテクチャを意識し、ドメイン層・アプリケーション層・プレゼンテーション層を明確に分離する。
- MVVM を基本に、ViewModel が状態を Riverpod で公開し、UI 層は Hooks を用いて購読・描画する。
- Repository やデータソース層をインターフェース経由で抽象化し、ローカル実装と将来的な外部 API 実装を容易に切り替えられるようにする。
- UseCase / Service 層は非同期処理を Future ベースで提供し、API クライアントやストレージの差し替えに備える。

### Testing Strategy
- TDD を基本とし、ユニットテスト・ウィジェットテストを先行または最小遅延で作成する。
- VRT は初期段階では実施しないが、スクリーンショット比較など簡易的な UI 検証手段を整備することを目標とする。
- 重要な ViewModel / 状態管理ロジックにはテストを必須化し、回帰防止を図る。

### Git Workflow
- 現時点では明確なブランチ戦略なし。実装時は PR を作成し、最終的に squash merge で main に取り込む。
- コミットメッセージは日本語で要約を記載し、PR でコンテキストがわかるようにする。

## Domain Context
- 現段階ではローカルデータのみを扱う TODO 管理アプリ。
- ユーザーアカウントや同期機能は未実装だが、将来的なクラウド連携を想定して拡張しやすい構造を保つ。

## Important Constraints
- 初期バージョンはオフラインで完結させ、外部通信やサーバー依存を避けるが、外部 API 連携へ移行しやすい抽象化を維持する。
- UI とビジネスロジックの分離を徹底し、テスタビリティと保守性を優先する。
- Riverpod と Hooks を主要な状態管理手段として活用する。

## External Dependencies
- 現時点で外部サービス・API への依存なし。
- 将来の外部連携候補（例: 認証、同期サービス）は未定。
