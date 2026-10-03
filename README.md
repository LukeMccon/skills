# Skills by Luke

Reusable skills I author for coding agents. Each skill includes its instructions and any supporting references in one directory.

| Skill | Use it to |
| --- | --- |
| [agent-jury](skills/agent-jury/SKILL.md) | Investigate a question with independent agents and rank findings using three judges. |
| [business-logic-review](skills/business-logic-review/SKILL.md) | Review a PR, diff, feature, or proposal against product goals, business rules, and user expectations. |

`agent-jury` requires a runtime with subagent support and capacity for three independent judges. `business-logic-review` includes [evaluation cases](skills/business-logic-review/references/evaluation.md) for checking review quality.

## Install the skills you want

The repository is currently private. Install both skills globally for Codex and Claude Code using authenticated GitHub SSH access:

```sh
DISABLE_TELEMETRY=1 npx --yes skills@1.5.23 add 'git@github.com:LukeMccon/skills.git#v0.1.2' --skill '*' --global --agent codex --agent claude-code --yes
```

To install one skill, replace `--skill '*'` with `--skill business-logic-review` or `--skill agent-jury`. Installation is additive; differently named skills remain installed. Start a new agent session after installation.

The repository contains my authored skills. Third-party skill selections and personal machine setup belong in the consuming configuration.

## Validate a checkout before releasing it

Use Node.js 22.20.0 or newer, npm, and Git. Discover the collection and exercise installation twice in a disposable home:

```sh
DISABLE_TELEMETRY=1 npx --yes skills@1.5.23 add . --list
bash scripts/smoke-install.sh
actionlint .github/workflows/validate-skills.yml
git diff --check
```

The smoke check verifies Codex and Claude Code discovery and preserves an unrelated skill. CI runs it on Linux and macOS. Test coverage does not establish that agents will reach correct conclusions; review each skill's instructions and evaluate it against representative tasks.

Create an immutable repository release tag after validation. Tags version the collection as a whole.

Released under the [MIT license](LICENSE).
