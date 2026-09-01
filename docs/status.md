# 发布状态

最后检查时间：2026 年 9 月 1 日

## 版本信息

- Skill：`kungfu-ifs-companion`
- 版本：`0.1.1`
- 许可证：MIT
- 本地验证：`./scripts/validate.sh` 和 `./scripts/test_hermes_layout.sh` 已通过。
- 发布归档：由 `./scripts/package.sh` 生成；SkillHub 使用 ZIP 包，`SKILL.md` 位于归档根目录，并排除平台不接受的无扩展名 `LICENSE` 和 `VERSION` 文件。

## 平台状态

| 平台 | 状态 | 说明 |
| --- | --- | --- |
| GitHub | 已发布 | 公开源码仓库：`noootwo/kungfu-ifs-companion`；`v0.1.0` 和 `v0.1.1` 已发布。 |
| Hermes | 进行中 | PR [#100197](https://github.com/NousResearch/hermes-agent/pull/100197) 已创建；本地发现和预加载验证通过，扫描结果为 `SAFE`。 |
| ClawHub | CLI 授权待完成 | CLI 已安装，但本地尚未检测到有效令牌；需要完成设备授权后才能发布。 |
| 腾讯 SkillHub | 已提交，审核中 | `Kungfu IFS Companion` v0.1.1 已于 2026 年 9 月 1 日通过已认证的 `noootwo` 账号提交；后台显示“安全审核中”。 |

本文件只在完成新的命令或平台检查后更新状态。
