#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/scripts/_functions"

version="v0.0.1"

# nix/flake.nix が aarch64-darwin 固定のため、他の環境には対応しない
[[ "$(uname -s)" == "Darwin" ]] ||
  fail "未対応のOSです: $(uname -s)"
[[ "$(uname -m)" == "arm64" ]] ||
  fail "未対応のアーキテクチャです: $(uname -m)"

rid="osx-arm64"
sha256="3c96beef4c60037d08e6a49f48ee7b0fbe95c4cbf0fe655ab3cfa671d797e546"

archive="ScriptCommandRunner-${version}-${rid}.tar.gz"
url="https://github.com/tetsuzin/ScriptCommandRunner/releases/download/${version}/${archive}"

work_dir="$(mktemp -d)"
trap 'rm -rf "${work_dir}"' EXIT

command -v curl &>/dev/null ||
  fail "curl が必要です"

log_step "ScriptCommandRunner ${version} (${rid}) のダウンロード"
curl --proto '=https' --tlsv1.2 -fsSL "${url}" -o "${work_dir}/${archive}"

log_step "チェックサムの検証"
echo "${sha256}  ${work_dir}/${archive}" | shasum -a 256 -c - >/dev/null ||
  fail "チェックサムが一致しません: ${archive}"

log_step "setup の配置"
tar -xzf "${work_dir}/${archive}" -C "${work_dir}" ScriptCommandRunner
install -m 755 "${work_dir}/ScriptCommandRunner" "${SCRIPT_DIR}/setup"

log_step "完了しました"
log_info "続けて ./setup prepare を実行してください"
