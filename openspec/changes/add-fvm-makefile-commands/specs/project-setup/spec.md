## ADDED Requirements
### Requirement: Makefile Automation for FVM Commands
FVM 管理された Flutter プロジェクトでは、依存解決と `build_runner` 実行を Makefile で共通化し、チーム全員が同一のコマンドセットを使える状態を **MUST** 保証する。

#### Scenario: Pub Get Shortcut
- **GIVEN** プロジェクトのルートで `make pub-get` を実行したとき
- **THEN** `fvm flutter pub get` が呼び出され、`.fvmrc` で指定されたバージョンの Flutter SDK で依存関係が解決される
- **AND** コマンド終了時に `pubspec.lock` が最新化される

#### Scenario: Build Runner Build Shortcut
- **WHEN** `make build-runner` を実行したとき
- **THEN** `fvm flutter pub run build_runner build --delete-conflicting-outputs` が実行され、既存の生成物の競合が解消される
- **AND** 生成されたコードはリポジトリの管理対象として扱える

#### Scenario: Build Runner Watch Shortcut
- **WHEN** `make build-runner-watch` を実行したとき
- **THEN** `fvm flutter pub run build_runner watch --delete-conflicting-outputs` が監視モードで起動し、ソース変更に追従して生成物を更新する
- **AND** プロセス停止（Ctrl+C など）まで監視が継続する
