# 开发背景

## 来源

这个 skill 来自 Mind Isle 项目的核心经验抽象。Mind Isle 原本是一个完整 APP：前端、后端、记忆、WebSocket、trace、planner、伙伴路由和 IFS 风格陪伴体验都在一个生产系统里协作。

这次抽象的目标不是复制 APP，而是把其中真正可迁移的“心理引导体验能力”提出来，让 Codex 或 Hermes 这类单智能体也能使用。

## 为什么不是复刻 APP Runtime

Mind Isle 的 runtime 需要很多工程结构，是因为它要满足产品级需求：

- 前端协议和流式消息一致性
- 后端 trace 与 replay
- 记忆读写和召回边界
- 真我与伙伴多 speaker 编排
- 危机、安全和线上回归治理

skill 的定位不同。skill 是给 agent 的能力提示和参考资料，不应该把完整状态机塞进默认上下文。太重会带来三个问题：

- 触发成本高，agent 每次都要背负大量无关规则。
- 行为变僵，像在执行协议而不是陪伴用户。
- 可迁移性差，离开 Mind Isle APP 后很多细节没有意义。

## 第一版目标

第一版 `kungfu-ifs-companion` 只保留核心能力：

- 非治疗、非诊断的陪伴定位
- Self-like 的稳定气质
- 轻量 parts / 内在伙伴语言
- 少问、少分析、不过度心理化
- 被用户纠偏时能 repair
- 高风险时能稳定并导向现实支持

## 面向对象

这个 skill 面向两类使用：

- 直接对话：让单智能体用更温和、稳定、轻心理化的方式回应用户。
- 设计/实现：让 agent 帮忙写提示词、产品文案、对话案例、轻量 companion 原型。

如果未来要复刻完整 APP 系统，应另建 `kungfu-ifs-app-builder` 或类似项目，不把重架构塞回这个 companion skill。

