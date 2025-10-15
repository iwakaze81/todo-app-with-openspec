#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FVMRC_PATH="$PROJECT_ROOT/.fvmrc"
REQUIRED_VERSION="${1:-}"

if ! command -v fvm >/dev/null 2>&1; then
  echo "[ERROR] FVM がインストールされていません。brew などで 'fvm' をインストールしてください。" >&2
  exit 1
fi

if [[ -z "$REQUIRED_VERSION" ]]; then
  if [[ -f "$FVMRC_PATH" ]]; then
    REQUIRED_VERSION="$(FVMRC_PATH="$FVMRC_PATH" python3 <<'PY'
import json
import os

path = os.environ.get('FVMRC_PATH')
if not path:
    raise SystemExit(1)

with open(path, 'r', encoding='utf-8') as f:
    data = json.load(f)

flutter = data.get('flutter', '')
print(flutter)
PY
)"
  else
    echo "[ERROR] .fvmrc が見つかりません。" >&2
    exit 1
  fi
fi

if [[ -z "$REQUIRED_VERSION" ]]; then
  echo "[ERROR] 使用する Flutter バージョンが特定できません。" >&2
  exit 1
fi

SDK_DIR="$HOME/fvm/versions/$REQUIRED_VERSION"

if [[ ! -d "$SDK_DIR" ]]; then
  echo "[INFO] Flutter $REQUIRED_VERSION がローカルに存在しません。自動でインストールを試みます。"
  if ! fvm install "$REQUIRED_VERSION"; then
    echo "[ERROR] Flutter $REQUIRED_VERSION のインストールに失敗しました。ネットワーク接続などを確認してください。" >&2
    exit 1
  fi
fi

echo "FVM: OK (version $REQUIRED_VERSION)"
