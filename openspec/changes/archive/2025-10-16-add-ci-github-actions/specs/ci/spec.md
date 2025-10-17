## ADDED Requirements
### Requirement: Flutter CI workflow
GitHub Actions ワークフロー MUST execute `flutter analyze` と `flutter test` for changes that affect the `main` ブランチ。

#### Scenario: Pull request targets main
- **GIVEN** 対象ブランチが `main` の Pull Request が作成または更新され
- **WHEN** CI ワークフローが走ると
- **THEN** `flutter analyze` を実行し、その結果でジョブを成否判定しなければならない
- **AND** `flutter test` を実行し、その結果でジョブを成否判定しなければならない

#### Scenario: Push to main
- **WHEN** `main` ブランチへ push されたとき
- **THEN** CI ワークフローが実行され、`flutter analyze` と `flutter test` をそれぞれ失敗時にジョブを失敗させる形で走らせなければならない

#### Scenario: Flutter version alignment via .fvmrc
- **WHEN** CI ワークフローが環境をセットアップするとき
- **THEN** `.fvmrc` に記載された Flutter バージョンを読み取り、対応する stable チャネルの Flutter を使用して `flutter pub get`・解析・テストを実行しなければならない

#### Scenario: Reusable setup action
- **WHEN** CI ワークフローが Flutter をセットアップするとき
- **THEN** `.github/actions/setup-flutter` に定義された再利用可能アクションを呼び出してセットアップを完了しなければならない
