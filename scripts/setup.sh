#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REQUIRED_VERSION="3.35.6"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHECK_SCRIPT="$SCRIPT_DIR/check_fvm.sh"

STYLES_BOLD=$'\033[1m'
STYLES_DIM=$'\033[2m'
STYLES_BLUE=$'\033[34m'
STYLES_GREEN=$'\033[32m'
STYLES_YELLOW=$'\033[33m'
STYLES_RESET=$'\033[0m'

print_banner() {
  printf '\n%s%s========================================%s\n' "$STYLES_BLUE" "$STYLES_BOLD" "$STYLES_RESET"
  printf '%s%s Flutter Setup (v%s) %s\n' "$STYLES_BLUE" "$STYLES_BOLD" "$REQUIRED_VERSION" "$STYLES_RESET"
  printf '%s%s========================================%s\n\n' "$STYLES_BLUE" "$STYLES_BOLD" "$STYLES_RESET"
}

log_step() {
  printf '%s➜ %s%s%s\n' "$STYLES_DIM" "$STYLES_BOLD" "$1" "$STYLES_RESET"
}

log_substep() {
  printf '   %s- %s%s%s\n' "$STYLES_DIM" "$STYLES_BOLD" "$1" "$STYLES_RESET"
}

log_success() {
  printf '\n%s%s✔ %s%s\n\n' "$STYLES_GREEN" "$STYLES_BOLD" "$1" "$STYLES_RESET"
}

log_warn() {
  printf '%s%s! %s%s\n' "$STYLES_YELLOW" "$STYLES_BOLD" "$1" "$STYLES_RESET"
}

on_exit() {
  local status=$?
  if [[ $status -ne 0 ]]; then
    printf '\n%s%s✖ セットアップ中にエラーが発生しました (exit %d)%s\n' "$STYLES_YELLOW" "$STYLES_BOLD" "$status" "$STYLES_RESET"
  fi
}

trap on_exit EXIT

main() {
  print_banner

  log_step "Checking FVM environment"
  "$CHECK_SCRIPT" "$REQUIRED_VERSION"

  log_step "Configuring Flutter SDK"
  log_substep "fvm use $REQUIRED_VERSION"
  fvm use "$REQUIRED_VERSION" --force

  if [[ ! -f "$PROJECT_ROOT/pubspec.yaml" ]]; then
    log_substep "Creating Flutter project skeleton"
    fvm flutter create --project-name todo_app_with_openspec "$PROJECT_ROOT"
  else
    log_substep "既存プロジェクトを検出"
  fi

  log_step "Resolving dependencies"
  if ! fvm flutter pub get; then
    log_warn "fvm flutter pub get が失敗しました。フォールバックで再試行します。"
    FALLBACK_FLUTTER="$PROJECT_ROOT/.fvm/flutter_sdk/bin/flutter"
    if [[ ! -x "$FALLBACK_FLUTTER" ]]; then
      printf '%s%s✖ フォールバック用 Flutter 実行ファイルが見つかりません。%s\n' "$STYLES_YELLOW" "$STYLES_BOLD" "$STYLES_RESET" >&2
      exit 1
    fi

    if ! "$FALLBACK_FLUTTER" pub get; then
      printf '%s%s✖ flutter pub get に失敗しました。FVM 設定やネットワークを確認してください。%s\n' "$STYLES_YELLOW" "$STYLES_BOLD" "$STYLES_RESET" >&2
      exit 1
    fi
  fi

  log_success "Setup completed"
}

main "$@"
