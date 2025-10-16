## ADDED Requirements
### Requirement: Persist TODO list locally
アプリはユーザーが登録した TODO を端末ローカルストレージへ保存し、再起動後に同じ状態で復元できるようにしなければならない (MUST)。

#### Scenario: App restart retains todos
- **GIVEN** ユーザーが少なくとも 1 件の TODO を追加済みである
- **WHEN** アプリを終了し、再度起動する
- **THEN** 保存されていた TODO が同じ件数・内容で表示される

#### Scenario: Completion state is restored
- **GIVEN** TODO の完了状態を切り替えた直後
- **WHEN** アプリを再起動する
- **THEN** 切り替えた完了状態が保持された状態で表示される

#### Scenario: Deleted todo does not reappear
- **GIVEN** TODO を削除したあと
- **WHEN** アプリを再起動する
- **THEN** 削除した TODO は一覧に表示されない
