# Bash Bones Template

## Overview
This is a Linux-only, bones-only Bash configuration skeleton with zero defaults.
It provides a clear, explicit structure that you extend over time.

## Layout
```
bashrc
lib/
  loader.sh
conf/
  env.sh
  path.sh
  options.sh
  completion.sh
features/
  core.sh
aliases.d/
  aliases.sh
prompt/
  prompt.sh
docs/
```

## Load Order
1) Always-load (safe for non-interactive shells)
   - conf/env.sh
   - conf/path.sh
2) Interactive-only
   - conf/options.sh
   - conf/completion.sh
   - features/core.sh
   - aliases.d/aliases.sh
   - prompt/prompt.sh

## Usage
Place this template in a directory (default: ~/.bash).

Example ~/.bashrc:
```bash
if [[ -r "${HOME}/.bash/bashrc" ]]; then
    . "${HOME}/.bash/bashrc"
fi
```

To use a different location, set BASH_TPL_ROOT before sourcing:
```bash
export BASH_TPL_ROOT="$HOME/path/to/bash-bones"
if [[ -r "${BASH_TPL_ROOT}/bashrc" ]]; then
    . "${BASH_TPL_ROOT}/bashrc"
fi
```

## Namespace Customization
The loader uses the `bash_tpl::` namespace intentionally as a placeholder.
To rename it:
1) Replace `bash_tpl::` in bashrc and lib/loader.sh with your preferred prefix.
2) No other files depend on the namespace in this template.

## How to Extend
- Add environment exports in conf/env.sh
- Add PATH updates in conf/path.sh
- Add interactive shell options in conf/options.sh
- Add completion setup in conf/completion.sh
- Add functions in features/core.sh
- Add aliases in aliases.d/aliases.sh
- Add prompt configuration in prompt/prompt.sh
- Add configuration-specific docs in docs/

## Design Principles
- Explicit, minimal load order
- Interactive-only separation
- No defaults by design
