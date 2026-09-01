#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion-zh"

"${repo_root}/scripts/validate_zh.sh"
[[ -f "${skill_dir}/SKILL.md" ]] || exit 1
[[ -f "${skill_dir}/agents/openai.yaml" ]] || exit 1
[[ -d "${skill_dir}/references" ]] || exit 1

while IFS= read -r reference; do
  [[ -f "${skill_dir}/${reference}" ]] || exit 1
done < <(sed -n 's/.*`\(references\/[^`]*\)`.*/\1/p' "${skill_dir}/SKILL.md")

printf '%s\n' 'Chinese Skill layout smoke test passed.'
