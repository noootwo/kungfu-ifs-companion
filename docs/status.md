# Distribution Status

Last checked: September 1, 2026

## Release

- Skill: `kungfu-ifs-companion`
- Version: `0.1.1`
- License: MIT
- Local validation: passed with `./scripts/validate.sh` and `./scripts/test_hermes_layout.sh`
- Release archives: generated locally by `./scripts/package.sh`; SkillHub upload uses the ZIP archive with `SKILL.md` at its root and without the platform-incompatible extensionless `LICENSE` and `VERSION` entries.

## Platforms

| Platform | Status | Notes |
| --- | --- | --- |
| GitHub | Published | Public source repository: `noootwo/kungfu-ifs-companion`; `v0.1.0` and `v0.1.1` releases are published. |
| Hermes | In progress | PR [#100197](https://github.com/NousResearch/hermes-agent/pull/100197) is open; local discovery/preload passed and the scan result is `SAFE`. |
| ClawHub | Blocked on login | The local CLI is installed, but no ClawHub token is available. |
| Tencent SkillHub | Submitted, under review | `Kungfu IFS Companion` v0.1.1 was submitted from the authenticated `noootwo` account on September 1, 2026; the dashboard shows `安全审核中`. |

Statuses in this file are updated only after a fresh command or platform check.
