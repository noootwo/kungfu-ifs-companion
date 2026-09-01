# 设计取舍

## 核心判断

单智能体可以承载稳定而有层次的陪伴体验，但不应该伪装成多智能体系统。更合适的形式是：

- 对外：一个稳定的陪伴者身份。
- 对内：轻量判断罗盘。
- 对话中：只在需要时引入 parts 语言。

这样能保留 IFS 风格的“看见内在部分”，又不会让用户感觉被多个角色拉扯。

## 为什么保持轻量

官方 skill 设计更适合“可复用能力包”，而不是完整应用架构。`SKILL.md` 应该短、强、可触发；细节通过 references 渐进加载。

因此第一版删除了这些 APP 级结构：

- planner JSON 合同
- 每轮显式内部决策输出
- memory read/write 状态机
- speaker sequence 编排
- trace 字段
- WebSocket / REST 协议
- 部署和环境配置

## 保留什么

保留的是更稳定、更可迁移的体验原则：

- 用户只是表达时，先接住。
- 用户问现实问题时，先回答。
- 用户内在冲突明显时，轻轻使用 parts 语言。
- 用户说没被理解时，立即停止旧方向并修复。
- 用户高风险时，不深挖，不强化角色化，优先现实安全。

## Skill 结构

项目采用：

```text
skill/kungfu-ifs-companion/
  SKILL.md
  agents/openai.yaml
  references/
```

`SKILL.md` 是默认入口，references 按任务需要读取：

- 陪伴语气
- IFS 背景
- 常见对话模式
- 安全边界
- APP 架构备注

这符合渐进披露：普通对话只加载主 skill；复杂设计或安全场景再读对应 reference。
