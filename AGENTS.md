# Repository instructions

- Publish only skills authored by Luke. Install third-party skills from their upstream sources in the consuming setup.
- Keep skills in `skills/<name>/SKILL.md` with a unique normalized frontmatter `name`, a concise `description`, and supporting files inside the same skill directory.
- Keep personal configuration, fleet deployment, hooks, credentials, employer material, and unrelated generated files outside this repository.
- Keep `skills@1.5.23` pinned unless an upgrade is explicitly requested and tested.
- Validate provider discovery and additive installation on isolated temporary homes. Never modify live global skills as a side effect of tests.
- Preserve unrelated working-tree changes. Do not commit or push unless requested. Do not publish this repository or change its visibility without explicit authorization.

Run checks relevant to the change:

```sh
DISABLE_TELEMETRY=1 npx --yes skills@1.5.23 add . --list
bash scripts/smoke-install.sh
actionlint .github/workflows/validate-skills.yml
git diff --check
```
