# Skills by Luke

This repository contains three skills I wrote for coding agents. Each skill provides instructions for approaching a task and examples for checking the results.

[thinktank](skills/thinktank/SKILL.md) investigates a topic through independent reviews. By default, five agents each review the whole task without assigned specialties, and three separate judges score their findings. Request `mode=focused` to assign complementary areas to the reviewers. The coordinating agent ranks the findings and reports disagreements and unanswered questions. For creative decisions, the investigators develop alternatives before seeing proposed solutions, unless you ask them to compare only the options you supply.

Ask your agent to "Use thinktank to compare these options." Add `agents=7`, for example, to use seven investigators. This changes the investigator count; the three judges stay the same. Thinktank requires subagent support. If completed agents still occupy slots and cannot be released, the default team needs nine slots, including the coordinator, with extra capacity for replacements.

[business-logic-review](skills/business-logic-review/SKILL.md) reviews a pull request, diff, feature, or proposal against the product's goals and rules. It checks whether the implementation does what was requested and whether that behavior helps users complete their task. Findings cite the evidence for the expected behavior and the effect on users. Missing or conflicting requirements become product questions rather than assumed defects.

Ask your agent to "Use business-logic-review to review this PR against the product requirements." The review explains the effect on users, recommends corrections or decisions, and suggests scenarios to verify the result. Editing files or posting review comments requires authorization from your request.

[step-back](skills/step-back/SKILL.md) pauses work in progress to check whether it takes the right approach to the right problem. The agent restates the goal and how success will be judged, then names the assumption the approach depends on. It looks at existing solutions, root causes, the layer that should own the fix, scope, and alternatives. It reports whether to continue, adjust, or change course, with the cost of switching.

Ask your agent to "Step back. Is this fix right, or are we patching a symptom?" The agent changes no files during the review. Afterwards it continues within what you already authorized, and waits for you when your answer could change the recommendation.

To install all three skills globally for Codex and Claude Code, use Node.js 24, npm, and Git:

```sh
DISABLE_TELEMETRY=1 npx --yes skills@1.5.23 add 'https://github.com/LukeMccon/skills.git#v0.1.5' --skill '*' --global --agent codex --agent claude-code --yes
```

To install one skill, replace `--skill '*'` with `--skill thinktank`, `--skill business-logic-review`, or `--skill step-back`. The command pins the installer to `skills@1.5.23` and selects release `v0.1.5`. Rerunning it refreshes those skills and preserves skills with other names. Start a new agent session or refresh your application's skill list after installation.

Thinktank was previously named `agent-jury`. Installing the new name leaves an existing `agent-jury` installation in place. If you are upgrading from that version, remove the old skill when you switch.

To check a local checkout, run these commands from the repository root. The workflow check also requires `actionlint`:

```sh
DISABLE_TELEMETRY=1 npx --yes skills@1.5.23 add . --list
bash scripts/smoke-install.sh
actionlint .github/workflows/validate-skills.yml
git diff --check
```

The smoke test installs the skills twice in a temporary home, checks the installed files and discovery locations, and verifies that an unrelated skill survives. CI runs these installation checks on Linux and macOS with Node.js 24 and scans for credentials with Gitleaks. The [thinktank cases](skills/thinktank/references/evaluation.md), [business review cases](skills/business-logic-review/references/evaluation.md), and [step-back cases](skills/step-back/references/evaluation.md) help assess how agents follow the instructions. Installation checks alone do not measure the quality of an agent's conclusions.

Released under the [MIT license](LICENSE).
