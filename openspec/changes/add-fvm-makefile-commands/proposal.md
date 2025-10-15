## Why
- FVM 環境下で `flutter pub get` や `build_runner` の実行手順が Makefile で統一されていない
- 手動でコマンドを入力するとバージョン差異やオプション漏れが起きやすく、セットアップの再現性を損なう

## What Changes
- FVM 経由で主要な開発コマンドを叩ける Make ターゲット（`pub-get`、`build-runner`、`build-runner-watch` など）を追加する
- `build_runner` を利用するための dev_dependencies を追加し、生成コードをコミット対象として扱う運用を明示する
- README に Make コマンドの利用方法を追記し、開発フローを明確にする

## Impact
- アプリ機能そのものへの影響はないが、開発者が共通手順で依存解決やコード生成を行えるようになる
- `build_runner` 生成物の管理方針が共有され、Freezed 等の導入がスムーズになる
- 新しい Make ターゲットを利用する場合、FVM がセットアップ済みであることが前提となる
