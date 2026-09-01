#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="$(tr -d '[:space:]' < "${repo_root}/skill/kungfu-ifs-companion/VERSION")"
zh_version="$(tr -d '[:space:]' < "${repo_root}/skill/kungfu-ifs-companion-zh/VERSION")"

[[ "${version}" == "${zh_version}" ]] || {
  printf '英文与附加语言包版本不一致: %s != %s\n' "${version}" "${zh_version}" >&2
  exit 1
}

tmp_root="$(mktemp -d)"
trap 'rm -rf "${tmp_root}"' EXIT

wait_and_report() {
  local label="$1"
  local pid="$2"
  local status=0

  wait "${pid}" || status=$?
  printf '\n[%s]\n' "${label}"
  cat "${tmp_root}/${label}.log"
  if [[ "${status}" -eq 0 ]]; then
    printf '[%s] 完成\n' "${label}"
  else
    printf '[%s] 失败，退出码 %s\n' "${label}" "${status}" >&2
  fi
  return "${status}"
}

printf '准备并发发布版本 %s：SkillHub（语言包） + ClawHub（英文包）\n' "${version}"

"${repo_root}/scripts/package.sh" >"${tmp_root}/package-en.log" 2>&1 &
package_en_pid=$!
"${repo_root}/scripts/package_zh.sh" >"${tmp_root}/package-zh.log" 2>&1 &
package_zh_pid=$!

failed=0
wait_and_report package-en "${package_en_pid}" || failed=1
wait_and_report package-zh "${package_zh_pid}" || failed=1
if [[ "${failed}" -ne 0 ]]; then
  printf '%s\n' '打包失败，未开始平台发布。' >&2
  exit 1
fi

SKILLHUB_SKIP_PACKAGE=1 "${repo_root}/scripts/publish_skillhub.sh" >"${tmp_root}/skillhub.log" 2>&1 &
skillhub_pid=$!
CLAWHUB_SKIP_PACKAGE=1 "${repo_root}/scripts/publish_clawhub.sh" >"${tmp_root}/clawhub.log" 2>&1 &
clawhub_pid=$!

failed=0
wait_and_report skillhub "${skillhub_pid}" || failed=1
wait_and_report clawhub "${clawhub_pid}" || failed=1

if [[ "${failed}" -ne 0 ]]; then
  printf '%s\n' '至少一个平台发布失败，请查看上方对应日志。' >&2
  exit 1
fi

printf '\n%s\n' "全部平台发布完成：${version}"
