#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_dir="${repo_root}/skill/kungfu-ifs-companion"
version_file="${skill_dir}/VERSION"
output_dir="${repo_root}/dist"

if [[ ! -f "${version_file}" ]]; then
  printf '%s\n' 'Missing skill VERSION file.' >&2
  exit 1
fi

version="$(tr -d '[:space:]' < "${version_file}")"
if [[ ! "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  printf 'Invalid version: %s\n' "${version}" >&2
  exit 1
fi

[[ -f "${skill_dir}/LICENSE" ]] || {
  printf '%s\n' 'Missing skill LICENSE file.' >&2
  exit 1
}

"${repo_root}/scripts/validate.sh"
"${repo_root}/scripts/test_hermes_layout.sh"
mkdir -p "${output_dir}"
archive="${output_dir}/kungfu-ifs-companion-v${version}.tar.gz"
tar -czf "${archive}" -C "${repo_root}/skill" kungfu-ifs-companion

zip_archive="${output_dir}/kungfu-ifs-companion-v${version}.zip"
# SkillHub rejects extensionless metadata entries; the source and TAR archive
# still carry the license and version files, while the marketplace ZIP omits
# only those platform-incompatible entries.
rm -f "${zip_archive}"
(cd "${skill_dir}" && zip -qr "${zip_archive}" . -x 'LICENSE' '*/LICENSE' 'VERSION' '*/VERSION')

printf 'Created %s\n' "${archive}"
printf 'Created %s\n' "${zip_archive}"
