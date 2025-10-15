## Why
- 現状はローカル実行に依存しており、`flutter analyze` や `flutter test` の実行状態をPR単位で可視化できない
- main への取り込み時に自動チェックがないと、静的解析エラーやテスト失敗が混入するリスクが高い

## What Changes
- GitHub Actions 上にFlutterプロジェクト用のCIワークフローを追加し、`flutter analyze` と `flutter test` を自動実行する
- トリガーを `pull_request` (対象: main) と `push` (対象: main) に設定し、PRおよびmain更新時の品質チェックを確実にする
- `.fvmrc` に記載された Flutter バージョンを読み取ってセットアップする再利用可能なアクションを `.github/actions` 配下に追加し、ワークフローから呼び出す

## Impact
- main へマージされる前に解析・テスト結果を確認でき、回帰を早期に検知できる
- CIの導入に伴い、開発者はPR作成時点でローカルと同一バージョンのFlutterによる検証が走るようになる
- 共通アクション化により、今後のワークフローでも同じセットアップ手順を使い回せる
- CIがdeps取得やビルドを行うため、多少の実行時間増加が発生するが、品質向上メリットが勝る
