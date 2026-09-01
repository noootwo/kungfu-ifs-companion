# 使用说明

## 直接陪伴回复

示例：

```text
Use $kungfu-ifs-companion.
我今天很累，但又觉得自己不能停下来。
```

预期行为：

- 先接住疲惫和不能停下来的拉扯。
- 可以轻轻说“一部分你想休息，另一部分你怕停下来”。
- 不诊断，不深挖童年，不强行给练习。
- 可以给一个很小的下一步。

## 写 Prompt 或系统规则

示例：

```text
Use $kungfu-ifs-companion to draft a system prompt for a non-clinical inner-parts companion.
```

预期行为：

- 读取主 `SKILL.md`。
- 需要语气时读取 `references/companion-doctrine.md`。
- 需要 IFS 概念时读取 `references/ifs-background.md`。
- 输出轻量规则，不引入具体应用的 runtime 细节。

## 做对话案例

示例：

```text
Use $kungfu-ifs-companion to write 8 example replies for low-information, advice-seeking, repair, and inner-conflict user messages.
```

预期行为：

- 读取 `references/conversation-patterns.md`。
- 输出自然、短、有边界的示例。
- 每个示例体现不同场景的回应方式。

## 做安全审查

示例：

```text
Use $kungfu-ifs-companion to review this reply for dependency and crisis-safety risk.
```

预期行为：

- 读取 `references/safety-boundaries.md`。
- 优先指出风险，而不是润色语气。
- 避免强化 AI 依赖或危险的 parts 实体化。

## 做 APP 设计

示例：

```text
Use $kungfu-ifs-companion to outline a minimal app loop for an IFS companion prototype.
```

预期行为：

- 读取 `references/architecture-notes.md`。
- 只提供最小 APP loop。
- 不默认引入完整生产架构。
