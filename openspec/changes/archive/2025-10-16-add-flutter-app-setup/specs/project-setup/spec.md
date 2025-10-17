## ADDED Requirements
### Requirement: Flutter Project Scaffolding
Flutter TODO アプリの骨組みは FVM 管理下で生成され、チーム全員が共通の Flutter 3.35.6 (stable) を利用できる状態を **MUST** 保証する。

#### Scenario: FVM Managed Version
- **GIVEN** プロジェクトのルートで `fvm install` を実行したとき
- **THEN** Flutter 3.35.6 (stable) がローカルにインストールされる
- **AND** `.fvm` 設定を通じて `flutter` コマンドが 3.35.6 を指す

#### Scenario: Base Packages Installed
- **GIVEN** `flutter pub get` を実行したとき
- **THEN** Riverpod、Hooks、テスト関連パッケージが解決される
- **AND** プロジェクトがクリーンアーキテクチャ/MVVM 構造を前提にした初期コードを備える
