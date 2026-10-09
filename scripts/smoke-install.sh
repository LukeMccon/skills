#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

isolated_home="$(mktemp -d)"
trap 'rm -rf "${isolated_home}"' EXIT
mkdir -p "${isolated_home}/.agents/skills/unrelated-sentinel"
printf '%s\n' '---' 'name: unrelated-sentinel' 'description: Must survive provider installation.' '---' \
  > "${isolated_home}/.agents/skills/unrelated-sentinel/SKILL.md"

for attempt in 1 2; do
  HOME="${isolated_home}" \
  CODEX_HOME="${isolated_home}/.codex" \
  CLAUDE_CONFIG_DIR="${isolated_home}/.claude" \
  XDG_STATE_HOME="${isolated_home}/state" \
  XDG_CONFIG_HOME="${isolated_home}/config" \
  XDG_CACHE_HOME="${isolated_home}/cache" \
  XDG_DATA_HOME="${isolated_home}/data" \
  NPM_CONFIG_CACHE="${isolated_home}/npm-cache" \
  DISABLE_TELEMETRY=1 \
    npx --yes skills@1.5.23 add . --skill '*' --global --agent codex --agent claude-code --yes
done

test -f "${isolated_home}/.agents/skills/unrelated-sentinel/SKILL.md"
SKILLS_SMOKE_HOME="${isolated_home}" node --input-type=module <<'NODE'
import assert from 'node:assert/strict';
import { lstat, readFile, readdir, realpath } from 'node:fs/promises';
import { join } from 'node:path';

async function verifyInstalledContent(source, installed) {
  for (const entry of await readdir(source, { withFileTypes: true })) {
    const sourcePath = join(source, entry.name);
    const installedPath = join(installed, entry.name);
    if (entry.isDirectory()) await verifyInstalledContent(sourcePath, installedPath);
    else {
      assert.ok(entry.isFile(), `Unsupported source entry: ${sourcePath}`);
      assert.deepEqual(await readFile(installedPath), await readFile(sourcePath),
        `Installed resource must match its source: ${sourcePath}`);
    }
  }
}

const home = process.env.SKILLS_SMOKE_HOME;
const names = [];
for (const entry of await readdir('skills', { withFileTypes: true })) {
  assert.ok(entry.isDirectory(), `Expected a skill directory: ${entry.name}`);
  const content = await readFile(join('skills', entry.name, 'SKILL.md'), 'utf8');
  const name = content.match(/^name:\s*(.+)$/m)?.[1];
  assert.equal(name, entry.name, 'Frontmatter name must match the directory');
  assert.match(name, /^[a-z0-9][a-z0-9-]{0,63}$/);
  assert.ok(content.match(/^description:\s*\S.+$/m), 'Describe when to use the skill');
  assert.ok(!names.includes(name), `Duplicate skill: ${name}`);
  names.push(name);
  const canonical = join(home, '.agents/skills', name);
  const claude = join(home, '.claude/skills', name);
  assert.ok((await lstat(join(canonical, 'SKILL.md'))).isFile());
  assert.ok((await lstat(claude)).isSymbolicLink());
  assert.equal(await realpath(claude), await realpath(canonical));
  await verifyInstalledContent(join('skills', entry.name), canonical);
}
assert.deepEqual((await readdir(join(home, '.agents/skills'))).sort(), [...names, 'unrelated-sentinel'].sort());
console.log(`Verified repeat installation of ${names.length} authored skills for Codex and Claude Code.`);
NODE
