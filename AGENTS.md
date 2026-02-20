# AGENTS

## Purpose
- This repo is a minimal Bash configuration skeleton (Linux only).
- Files here are sourced by `bash` rather than executed.
- Keep defaults minimal; avoid adding behavior unless requested.

## Repository Layout
- `bashrc` is the entrypoint; it loads `lib/loader.sh` and calls `bash_tpl::init`.
- `lib/loader.sh` defines `bash_tpl::*` helpers and load order.
- `conf/env.sh` for environment exports only.
- `conf/path.sh` for PATH updates only.
- `conf/options.sh` for interactive shell options only.
- `conf/completion.sh` for completion setup only.
- `features/core.sh` for user functions only.
- `aliases.d/aliases.sh` for aliases only.
- `prompt/prompt.sh` for prompt setup only.
- `README.md` describes the template layout and usage.
- `docs/` is reserved for configuration-specific documentation.

## Load Order (source-safe)
- Always: `conf/env.sh`, then `conf/path.sh`.
- Interactive only: `conf/options.sh`, `conf/completion.sh`, `features/core.sh`, `aliases.d/aliases.sh`, `prompt/prompt.sh`.
- Use `bash_tpl::try_source` for any optional file sourcing.

## Build / Lint / Test Commands
- Build: none (this is a Bash config template; no build system present).
- Lint: no config in repo; if needed, run ShellCheck manually.
- Example lint: `shellcheck bashrc lib/loader.sh conf/*.sh features/*.sh aliases.d/*.sh prompt/*.sh`
- Single-file lint (closest to “single test”): `shellcheck lib/loader.sh`
- Tests: none; no test framework or test files in this repo.
- Single test: not applicable; add a harness first and update this file.

## Cursor / Copilot Rules
- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` found.
- If you add any of these, summarize them here.

## Shell Dialect and Execution Model
- Bash-only; do not attempt POSIX-sh compatibility.
- All repo files are sourced; avoid `exit` and avoid `set -euo pipefail` in sourced files.
- For standalone scripts you add, use `#!/usr/bin/env bash` and `set -euo pipefail`.
- Treat non-interactive shells as a safe minimal environment.
- Avoid interactive-only commands unless gated behind an interactive check.

## Compatibility
- Linux only; rely on GNU coreutils where needed.
- Avoid hardcoding paths like `/usr/local` or `/opt` unless required.
- Prefer portable Bash features (Bash 4+) unless documented.
- If you require external tools, check availability first.

## Imports and Sourcing
- Prefer `bash_tpl::try_source` for optional files.
- When sourcing explicitly, use `. "$file"` and include `# shellcheck source=/dev/null` if needed.
- Never assume `BASH_TPL_ROOT` is set; resolve with `${BASH_TPL_ROOT:-${HOME}/.bash}`.
- Avoid sourcing files from unknown locations or user input.

## Formatting
- Indentation: 4 spaces; no tabs.
- One blank line between functions.
- Keep lines reasonably short (<= 100 chars).
- Use LF line endings; ASCII only unless the file already contains Unicode.
- Do not align with tabs or extensive padding.

## Naming Conventions
- Functions should be namespaced with `bash_tpl::` (e.g., `bash_tpl::init`).
- Local variables: `lower_snake_case` with `local`.
- Environment exports: `UPPER_SNAKE_CASE`.
- Temporary variables should be scoped and unset only if they might leak globally.
- Use `_name` for file-local helpers if not exported.
- Aliases should be lowercase and predictable.

## Variables and Exports
- Prefer `local` in functions; avoid implicit globals.
- Use `readonly` or `local -r` for constants where useful.
- Quote parameter expansions: "${var}", "${array[@]}".
- Use `${var:-default}` to handle unset values.

## Conditionals and Expressions
- Use `[[ ... ]]` for tests and pattern matches.
- Use `(( ... ))` for arithmetic.
- Prefer `case` for multi-branch pattern logic.
- Always quote variables unless inside `[[`/`((` where safe.
- Use `[[ -n "$var" ]]` or `[[ -z "$var" ]]` for string checks.

## Error Handling and Safety
- Guard optional commands with `command -v` or `type -P`.
- Check file readability before sourcing with `[[ -r "$file" ]]`.
- Avoid `eval` unless the input is fully controlled.
- Avoid `trap` in sourced files unless explicitly requested.
- Do not `return` at top level; only inside functions.

## Output and Logging
- Avoid output in non-interactive shells.
- Prefer `printf '%s\n'` over `echo` for predictable output.
- If adding debug output, gate behind a flag or env var.

## Environment and PATH Updates
- Exports belong in `conf/env.sh`.
- PATH edits belong in `conf/path.sh`.
- Use `PATH="${HOME}/bin:${PATH}"` style with quoting.
- Avoid duplicating PATH entries; check before prepending if necessary.
- Do not override `PATH` entirely unless required.

## Interactive-Only Behavior
- Only set prompt, aliases, completions, and interactive options when interactive.
- Use `bash_tpl::is_interactive` to check.
- Avoid heavyweight commands in interactive startup.

## Aliases
- Keep aliases simple and stable; avoid aliases that shadow essential commands.
- Prefer functions in `features/core.sh` for anything non-trivial.

## Prompt
- Put prompt logic in `prompt/prompt.sh`.
- Avoid slow commands in prompt setup.
- Do not assume color support; detect `tput` or `TERM` when needed.
- Keep prompt changes minimal by default.

## Comments and Documentation
- Keep comments short and explanatory; no decorative blocks.
- Update `README.md` when layout or load order changes.
- If you change `bash_tpl::` namespace, update both `bashrc` and `lib/loader.sh`.

## Files to Modify for Common Tasks
- Add exports: `conf/env.sh`
- Add PATH entries: `conf/path.sh`
- Add shell options: `conf/options.sh`
- Add completions: `conf/completion.sh`
- Add functions: `features/core.sh`
- Add aliases: `aliases.d/aliases.sh`
- Add prompt: `prompt/prompt.sh`
- Change loader behavior: `lib/loader.sh`
- Change entrypoint: `bashrc`

## Testing Guidance (when added later)
- Keep tests self-contained and runnable from repo root.
- Provide a single-test command (e.g., `./tests/foo.bash`) and document it here.
- Prefer minimal dependencies; this repo is intended to be lightweight.
- Add any CI instructions to this file when introduced.

## Example Patterns
- Source optional file: `bash_tpl::try_source "${root}/conf/env.sh"`
- Guard command: `if command -v git >/dev/null 2>&1; then ...; fi`
- Interactive check: `if bash_tpl::is_interactive; then ...; fi`

## Agent Notes
- This repository currently has no CI, build system, or tests.
- Keep edits minimal and consistent with the template’s “no defaults” philosophy.
- If you introduce tooling (formatters, linting, tests), add commands here.
- Re-run ShellCheck manually if you change any sourced files.
- Avoid non-ASCII unless you have a clear reason.
