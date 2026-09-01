#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion-zh"
validator="${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-creator/scripts/quick_validate.py"

[[ -f "${validator}" ]] || {
  printf '%s\n' 'Codex skill validator not found.' >&2
  exit 1
}

python "${validator}" "${skill_dir}"

[[ -f "${skill_dir}/VERSION" ]] || exit 1
[[ "$(tr -d '[:space:]' < "${skill_dir}/VERSION")" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || exit 1
[[ -f "${skill_dir}/LICENSE" ]] || exit 1

while IFS= read -r reference; do
  [[ -f "${skill_dir}/${reference}" ]] || {
    printf 'Missing referenced file: %s\n' "${reference}" >&2
    exit 1
  }
done < <(sed -n 's/.*`\(references\/[^`]*\)`.*/\1/p' "${skill_dir}/SKILL.md")

printf '%s\n' 'Chinese Skill validation passed.'
