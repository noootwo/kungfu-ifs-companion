#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion"
validator="${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-creator/scripts/quick_validate.py"

if [[ ! -f "${validator}" ]]; then
  printf '%s\n' 'Codex skill validator not found. Set CODEX_HOME or install skill-creator under ~/.codex.' >&2
  exit 1
fi

python "${validator}" "${skill_dir}"

[[ -f "${skill_dir}/VERSION" ]] || {
  printf '%s\n' 'Missing skill VERSION file.' >&2
  exit 1
}

version="$(tr -d '[:space:]' < "${skill_dir}/VERSION")"
if [[ ! "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  printf 'Invalid version: %s\n' "${version}" >&2
  exit 1
fi

[[ -f "${skill_dir}/LICENSE" ]] || {
  printf '%s\n' 'Missing skill LICENSE file.' >&2
  exit 1
}

while IFS= read -r reference; do
  [[ -f "${skill_dir}/${reference}" ]] || {
    printf 'Missing referenced file: %s\n' "${reference}" >&2
    exit 1
  }
done < <(sed -n 's/.*`\(references\/[^`]*\)`.*/\1/p' "${skill_dir}/SKILL.md")

printf '%s\n' 'Project validation passed.'
