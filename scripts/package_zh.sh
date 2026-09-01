#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion-zh"
version_file="${skill_dir}/VERSION"
output_dir="${repo_root}/dist"

version="$(tr -d '[:space:]' < "${version_file}")"
[[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || exit 1
[[ -f "${skill_dir}/LICENSE" ]] || exit 1

"${repo_root}/scripts/test_zh_layout.sh"
mkdir -p "${output_dir}"

archive="${output_dir}/kungfu-ifs-companion-zh-v${version}.tar.gz"
tar -czf "${archive}" -C "${repo_root}/skill" kungfu-ifs-companion-zh

zip_archive="${output_dir}/kungfu-ifs-companion-zh-v${version}.zip"
rm -f "${zip_archive}"
staging_dir="$(mktemp -d)"
trap 'rm -rf "${staging_dir}"' EXIT
cp -R "${skill_dir}/." "${staging_dir}/"
awk -v version="${version}" 'NR == 3 {
  print
  print "slug: kungfu-ifs-companion"
  print "version: " version
  print "displayName: Kungfu IFS Companion"
  print "summary: 温暖、非临床化的 IFS 启发式陪伴 Skill。"
  print "license: MIT"
  print "homepage: https://github.com/noootwo/kungfu-ifs-companion"
  next
}
{ print }' "${skill_dir}/SKILL.md" > "${staging_dir}/SKILL.md"
(cd "${staging_dir}" && zip -qr "${zip_archive}" . -x 'LICENSE' '*/LICENSE' 'VERSION' '*/VERSION')

printf 'Created %s\n' "${archive}"
printf 'Created %s\n' "${zip_archive}"
