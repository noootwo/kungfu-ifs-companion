#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion"
tmp_root="$(mktemp -d)"
trap 'rm -rf "${tmp_root}"' EXIT

hermes_home="${tmp_root}/hermes"
mkdir -p "${hermes_home}/skills"
cp -R "${skill_dir}" "${hermes_home}/skills/"
installed="${hermes_home}/skills/kungfu-ifs-companion"

[[ -f "${installed}/SKILL.md" ]] || exit 1
[[ -f "${installed}/VERSION" ]] || exit 1
[[ -f "${installed}/LICENSE" ]] || exit 1
[[ -f "${installed}/agents/openai.yaml" ]] || exit 1

while IFS= read -r reference; do
  [[ -f "${installed}/${reference}" ]] || {
    printf 'Missing installed Hermes reference: %s\n' "${reference}" >&2
    exit 1
  }
done < <(sed -n 's/.*`\(references\/[^`]*\)`.*/\1/p' "${installed}/SKILL.md")

if command -v hermes >/dev/null 2>&1; then
  skills_output="$(HERMES_HOME="${hermes_home}" hermes --ignore-user-config skills list --source local)"
  printf '%s\n' "${skills_output}" | rg -F --quiet 'kungfu-ifs-companion'

  prompt_output="$(HERMES_HOME="${hermes_home}" hermes --ignore-user-config --skills kungfu-ifs-companion prompt-size --json)"
  printf '%s\n' "${prompt_output}" | rg -F --quiet '"name": "kungfu-ifs-companion"'
  printf '%s\n' "${prompt_output}" | rg -F --quiet '"skill_md_bytes"'
fi

printf '%s\n' 'Hermes skill discovery and preload smoke test passed.'
