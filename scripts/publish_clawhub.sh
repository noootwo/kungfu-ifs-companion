#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion"
version="$(tr -d '[:space:]' < "${skill_dir}/VERSION")"
changelog="${CLAWHUB_CHANGELOG:-整理陪伴表达、安全边界与发布包结构。}"

if [[ "${CLAWHUB_SKIP_PACKAGE:-0}" != "1" ]]; then
  "${repo_root}/scripts/package.sh"
fi

[[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
  printf 'Invalid version: %s\n' "${version}" >&2
  exit 1
}

clawhub_bin="${CLAWHUB_BIN:-clawhub}"
clawhub_package="${CLAWHUB_PACKAGE:-clawhub@latest}"
if command -v "${clawhub_bin}" >/dev/null 2>&1; then
  clawhub_cmd=("${clawhub_bin}")
else
  command -v npx >/dev/null 2>&1 || {
    printf '%s\n' '未找到 clawhub 或 npx，无法发布到 ClawHub。' >&2
    exit 1
  }
  clawhub_cmd=(npx --yes "${clawhub_package}")
fi

source_commit="$(git -C "${repo_root}" rev-parse HEAD)"
source_ref="$(git -C "${repo_root}" rev-parse --abbrev-ref HEAD)"

"${clawhub_cmd[@]}" --no-input skill publish "${skill_dir}" \
  --slug kungfu-ifs-companion \
  --name 'Kungfu IFS Companion' \
  --version "${version}" \
  --changelog "${changelog}" \
  --tags latest \
  --source-repo noootwo/kungfu-ifs-companion \
  --source-commit "${source_commit}" \
  --source-ref "${source_ref}" \
  --source-path skill/kungfu-ifs-companion \
  --json
