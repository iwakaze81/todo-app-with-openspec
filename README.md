# todo_app_with_openspec

Flutter で構築する TODO アプリのベースプロジェクトです。FVM で Flutter 3.35.6 (stable) を固定し、Riverpod + Hooks を利用した MVVM 構成を採用しています。

## セットアップ

```bash
# 1. 初回のみ FVM が使えることを確認（未インストールなら自動で fvm install 3.35.6 を実行）
make check-fvm

# 2. Flutter SDK の取得と依存関係解決をまとめて実行
make setup

# 3. 以後の依存解決はショートカットを利用
make pub-get
```

> `make check-fvm` / `make setup` 実行時に Flutter SDK のダウンロードが必要になるため、ネットワークに接続していることを確認してください。ダウンロードに失敗した場合はエラーメッセージに従って再実行してください。

## 主なコマンド

```bash
make format              # Dart/Flutter コードのフォーマット
make analyze             # 静的解析
make test                # テスト実行
make pub-get             # FVM を介した依存解決
make build-runner        # コード生成を単発実行（--delete-conflicting-outputs 付き）
make build-runner-watch  # コード生成を監視モードで実行
```

`build_runner` が生成する `*.g.dart` や `*.freezed.dart` などのファイルはリポジトリにコミットする運用です。生成物に差分が出た場合は忘れずにレビュー・コミットしてください。

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
