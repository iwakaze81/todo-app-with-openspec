## 1. CIワークフロー整備
- [x] 1.1 `.github/actions/setup-flutter/action.yml` を作成し、`.fvmrc` からFlutterバージョンを読み込んだ上でセットアップする再利用可能アクションを定義する
- [x] 1.2 `.github/workflows/flutter-ci.yml` を作成し、workflow名・権限・実行環境を定義する
- [x] 1.3 トリガーを `pull_request` (対象: main) と `push` (対象: main) に設定し、main更新とPR作成/更新で発火させる
- [x] 1.4 再利用アクションを呼び出して Flutter 3.35.6 (stable) をセットアップし、`flutter pub get` を実行する
- [x] 1.5 CIジョブ内で `flutter analyze` と `flutter test` を実行し、失敗時にジョブ全体が失敗するよう構成する

## 2. ドキュメント整備
- [x] 2.1 README などに CI ワークフローの存在と実行内容を簡単に追記する（必要最低限で可）

## 3. 確認
- [x] 3.1 ワークフローファイルのYAML構文を確認し、`openspec validate add-ci-github-actions --strict` を実行して Spec 整合性を確認する
