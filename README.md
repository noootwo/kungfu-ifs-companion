# kungfu-ifs-companion

`kungfu-ifs-companion` is a lightweight skill project for building and using a warm, non-clinical IFS-inspired companion style with a single AI agent such as Codex or Hermes.

The project keeps two things separate:

- `skill/kungfu-ifs-companion/`: the actual distributable skill.
- `docs/`: development background, design rationale, usage notes, and validation notes.

The skill is intentionally instruction-only. It does not recreate Mind Isle's app runtime, planner contracts, trace pipeline, WebSocket protocol, or memory infrastructure. Its job is to preserve the reusable companion method: Self-like presence, light parts language, repair, practical help, and safety-aware boundaries.

Current release: `0.1.0`, recorded in `skill/kungfu-ifs-companion/VERSION`.

## Install Locally

Copy or sync the skill folder into the Codex skills directory:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skill/kungfu-ifs-companion "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Then start a new Codex task and invoke:

```text
Use $kungfu-ifs-companion to respond with a warm, non-clinical IFS companion style.
```

## Validate

From the project root, run the project validation entrypoint:

```bash
./scripts/validate.sh
```

The entrypoint checks the skill metadata and that all referenced files exist. It uses the Codex validator, so the Python environment must include `PyYAML`.

To verify the layout expected by Hermes skill installation:

```bash
./scripts/test_hermes_layout.sh
```

## Package For Distribution

Distribute only `skill/kungfu-ifs-companion/`, not the surrounding development docs:

```bash
./scripts/package.sh
```

The release archive is written to `dist/`. The skill uses the MIT license; see `skill/kungfu-ifs-companion/LICENSE`.

## Hermes Integration

Hermes can use the same skill content through its local skill directory. Copy the folder to `$HERMES_HOME/skills/kungfu-ifs-companion`, then preload it with `--skills kungfu-ifs-companion`. Load `SKILL.md` as the core instruction and load the relevant files under `references/` on demand.

The smoke test stages the skill under `$HERMES_HOME/skills/kungfu-ifs-companion` in a temporary directory, asks Hermes to discover it, and verifies that `prompt-size --json` includes its `SKILL.md`. It does not call an inference provider.
