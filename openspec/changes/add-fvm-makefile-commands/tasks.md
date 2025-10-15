## 1. Makefile 整備
- [x] 1.1 `make pub-get` で `fvm flutter pub get` を呼び出すターゲットを追加する
- [x] 1.2 `make build-runner`（単発実行）と `make build-runner-watch`（監視実行）を追加し、`--delete-conflicting-outputs` を含める

## 2. 依存と生成物
- [x] 2.1 `pubspec.yaml` に `build_runner` を dev_dependencies として追加し、`fvm flutter pub get` を反映する
- [x] 2.2 生成コードをコミット対象として扱う運用を README で共有し、`.gitignore` による除外がないことを確認する

## 3. ドキュメントと確認
- [x] 3.1 README に新しい Make ターゲットと利用シナリオを追記する
- [x] 3.2 `make pub-get` と `make build-runner` がエラーなく完了することを確認する
