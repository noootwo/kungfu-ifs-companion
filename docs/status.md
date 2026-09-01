# 发布状态

最后检查时间：2026 年 9 月 1 日

## 版本信息

- Skill：`kungfu-ifs-companion`
- 英文版本：`0.1.4`
- 附加语言包：`0.1.4`
- 许可证：MIT
- 本地验证：`./scripts/validate.sh` 和 `./scripts/test_hermes_layout.sh` 已通过。
- 中文本地验证：`./scripts/validate_zh.sh` 和 `./scripts/test_zh_layout.sh` 已通过。
- 发布归档：由 `./scripts/package.sh` 和 `./scripts/package_zh.sh` 生成；ZIP 包的 `SKILL.md` 位于归档根目录，并排除平台不接受的无扩展名 `LICENSE` 和 `VERSION` 文件。
- 单平台发布：`./scripts/publish_skillhub.sh` 和 `./scripts/publish_clawhub.sh` 分别发布到 SkillHub、ClawHub。
- 全平台发布：`./scripts/publish_all.sh` 会先并发打包，再并发发布两个平台；凭据使用各自本地登录会话。

## 平台状态

| 平台 | 状态 | 说明 |
| --- | --- | --- |
| GitHub | 已发布 | 公开源码仓库：`noootwo/kungfu-ifs-companion`；全平台发布脚本与幂等修复已推送。 |
| Hermes | 进行中 | PR [#100197](https://github.com/NousResearch/hermes-agent/pull/100197) 已创建；本地发现和预加载验证通过，扫描结果为 `SAFE`。 |
| ClawHub | 已接收，待审核发布 | `v0.1.4` 已由全平台命令提交；返回 `versionId=k9717w6pc18t49gq60e9m7pk0s8djnsg`、`publicationStatus=pending`、`attemptId=zx7273ehrca4zt0q479nqxj6mh8djjtj`。公开查询暂仍显示 `v0.1.1`，等待平台处理完成。 |
| 腾讯 SkillHub | 已提交，待审核 | `kungfu-ifs-companion@0.1.4` 已通过一键发布脚本提交成功；Skill ID 为 `179841`，版本 ID 为 `281229`，当前内容审核和安全扫描均为进行中。 |

本文件只在完成新的命令或平台检查后更新状态。
