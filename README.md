# todo_app_with_openspec

Flutter で構築する TODO アプリのベースプロジェクトです。FVM で Flutter 3.35.6 (stable) を固定し、Riverpod + Hooks を利用した MVVM 構成を採用しています。

## セットアップ

```bash
# 1. 初回のみ FVM が使えることを確認（未インストールなら自動で fvm install 3.35.6 を実行）
make check-fvm

# 2. Flutter SDK の取得と依存関係解決をまとめて実行
make setup
```

> `make check-fvm` / `make setup` 実行時に Flutter SDK のダウンロードが必要になるため、ネットワークに接続していることを確認してください。ダウンロードに失敗した場合はエラーメッセージに従って再実行してください。

## 主なコマンド

```bash
make format   # Dart/Flutter コードのフォーマット
make analyze  # 静的解析
make test     # テスト実行
```

## CI

GitHub Actions で `flutter analyze` と `flutter test` を実行するワークフローを用意しています。

- 対象ブランチ: `main`
  - `push` イベント
  - `pull_request` イベント
- `.github/actions/setup-flutter` が `.fvmrc` を読み込み、Flutter 3.35.6 (stable) を自動セットアップします。
- 依存取得 (`flutter pub get`) 後に解析とテストを行い、失敗するとワークフロー全体が失敗します。

ローカルでも `.fvmrc` と同じバージョンの Flutter を利用することで、CI と同一環境で検証できます。

## プロジェクト構成 (抜粋)

```
lib/
  src/
    domain/        - エンティティやリポジトリインターフェース
    application/   - ユースケースや Provider の束ね役
    infrastructure/ - データソース実装（現在は InMemory のみ）
    presentation/  - Riverpod + Hooks を用いた UI 層
```

## 開発方針
- Riverpod を利用して ViewModel を状態管理の中心に据え、UI は ViewModel への依存だけで構築する
- TDD を意識し、ウィジェットテストやユニットテストを逐次整備する
- 将来的な外部 API 連携を見据えて Repository 層を抽象化し、差し替えやすい構成にする
