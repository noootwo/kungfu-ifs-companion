# kungfu-ifs-companion

`kungfu-ifs-companion` 是一个轻量级 Skill 项目，用于让 Codex、Hermes 等单智能体以温暖、非临床化、受 IFS 启发的方式进行心理陪伴和内在探索。

本项目将两部分明确分开：

- `skill/kungfu-ifs-companion/`：实际可分发的 Skill。
- `docs/`：开发背景、设计取舍、使用说明、验证记录和发布状态。

这个项目专注于可迁移的陪伴方法，保留稳定的 Self-like 气质、轻量的 parts 语言、现实帮助、修复机制和安全边界。

英文版本：`0.1.4`，版本记录在 `skill/kungfu-ifs-companion/VERSION`。

附加语言包：`0.1.4`，版本记录在 `skill/kungfu-ifs-companion-zh/VERSION`。

源码仓库：<https://github.com/noootwo/kungfu-ifs-companion>

## 本地安装

将 Skill 文件夹复制或同步到 Codex 的 Skills 目录：

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skill/kungfu-ifs-companion "${CODEX_HOME:-$HOME/.codex}/skills/"
```

然后新建一个 Codex 任务并调用：

```text
Use $kungfu-ifs-companion to respond with a warm, non-clinical IFS companion style.
```

## 验证

在项目根目录运行基础验证：

```bash
./scripts/validate.sh
```

该命令会检查 Skill 元数据以及所有引用文件是否存在，依赖 Python 环境中的 `PyYAML`。

验证 Hermes 所需的目录结构：

```bash
./scripts/test_hermes_layout.sh
```

## 打包发布

只分发 `skill/kungfu-ifs-companion/`，不要把外层开发文档混入 Skill 包：

```bash
./scripts/package.sh
```

归档文件会写入 `dist/`。SkillHub 使用 ZIP 包：`SKILL.md` 位于归档根目录，并排除平台不接受的无扩展名 `LICENSE` 和 `VERSION` 文件。源码目录和 TAR 包仍保留 MIT 许可证及版本元数据。

生成另一种语言的 SkillHub 包：

```bash
./scripts/package_zh.sh
```

该包位于 `dist/kungfu-ifs-companion-zh-v0.1.4.zip`，包内 `SKILL.md` 位于根目录。

一键发布到 SkillHub：

```bash
./scripts/publish_skillhub.sh
```

脚本会自动打包并提交当前版本。首次使用可先执行 `skillhub login --key skh_xxx`；也可以临时设置 `SKILLHUB_TOKEN`，Token 不需要写入项目文件。

同时发布到所有已配置平台（SkillHub 与 ClawHub）：

```bash
./scripts/publish_all.sh
```

该命令会先并发生成两个平台所需的包，再并发发布：附加语言包提交到 SkillHub，英文包提交到 ClawHub。ClawHub 会优先使用本机 `clawhub`，没有全局安装时自动使用 `npx clawhub`；两边都需要先完成登录。

## Hermes 集成

Hermes 可以直接使用相同的 Skill 内容。将文件夹复制到 `$HERMES_HOME/skills/kungfu-ifs-companion`，再通过 `--skills kungfu-ifs-companion` 预加载。它以 `SKILL.md` 作为核心指令，并按需读取 `references/` 下的参考资料。

项目中的冒烟测试会把 Skill 临时放入 `$HERMES_HOME/skills/kungfu-ifs-companion`，检查 Hermes 能发现它，并确认 `prompt-size --json` 包含该 Skill 的 `SKILL.md`。该测试不会调用推理模型。

## 文档导航

- [开发背景](docs/development-background.md)
- [设计取舍](docs/design-rationale.md)
- [使用说明](docs/usage.md)
- [验证记录](docs/validation.md)
- [发布状态](docs/status.md)
- [0.1.3 版本记录](docs/releases/0.1.3.md)
- [0.1.4 版本记录](docs/releases/0.1.4.md)
- [评测用例](evals/forward-test-cases.md)
