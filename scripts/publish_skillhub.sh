#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skillhub_bin="${SKILLHUB_BIN:-skillhub}"
skillhub_host="${SKILLHUB_API_BASE:-https://api.skillhub.cn}"
archive="${repo_root}/dist/kungfu-ifs-companion-zh-v$(tr -d '[:space:]' < "${repo_root}/skill/kungfu-ifs-companion-zh/VERSION").zip"
changelog="${SKILLHUB_CHANGELOG:-发布整理后的当前版本，保留温暖陪伴、IFS 启发式内在探索、现实帮助、修复和安全边界。}"

command -v "${skillhub_bin}" >/dev/null 2>&1 || {
  printf '未找到 skillhub CLI: %s\n' "${skillhub_bin}" >&2
  exit 1
}

if [[ "${SKILLHUB_SKIP_PACKAGE:-0}" != "1" ]]; then
  "${repo_root}/scripts/package_zh.sh"
fi
[[ -f "${archive}" ]] || {
  printf '发布包不存在: %s\n' "${archive}" >&2
  exit 1
}

publish_args=("${archive}" --host "${skillhub_host}" --changelog "${changelog}" --json)
if [[ -n "${SKILLHUB_TOKEN:-}" ]]; then
  publish_args+=(--token "${SKILLHUB_TOKEN}")
fi

publish_output=""
publish_status=0
publish_output="$("${skillhub_bin}" publish "${publish_args[@]}" 2>&1)" || publish_status=$?
printf '%s\n' "${publish_output}"

if [[ "${publish_status}" -ne 0 ]] && printf '%s\n' "${publish_output}" | rg -F --quiet 'VERSION_EXISTS'; then
  printf 'SkillHub 已存在 %s，跳过重复提交。\n' "$(basename "${archive}")"
  exit 0
fi

exit "${publish_status}"
