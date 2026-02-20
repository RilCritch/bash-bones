# Bash Bones entrypoint; no configuration.

_bash_tpl_root="${BASH_TPL_ROOT:-${HOME}/.bash}"

if [[ -r "${_bash_tpl_root}/lib/loader.sh" ]]; then
    # shellcheck source=/dev/null
    . "${_bash_tpl_root}/lib/loader.sh"
fi

unset _bash_tpl_root

if declare -F bash_tpl::init >/dev/null 2>&1; then
    bash_tpl::init
fi
