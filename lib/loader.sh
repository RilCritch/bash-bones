bash_cfg::try_source() {
    local file="$1"

    if [[ -r "$file" ]]; then
        # shellcheck source=/dev/null
        . "$file"
    fi
}

bash_cfg::is_interactive() {
    [[ $- == *i* ]]
}

bash_cfg::init() {
    local root="${BASH_TPL_ROOT:-${HOME}/.bash}"

    bash_cfg::try_source "${root}/conf/env.sh"
    bash_cfg::try_source "${root}/conf/path.sh"

    if bash_cfg::is_interactive; then
        bash_cfg::try_source "${root}/conf/options.sh"
        bash_cfg::try_source "${root}/conf/completion.sh"
        bash_cfg::try_source "${root}/features/core.sh"
        bash_cfg::try_source "${root}/aliases.d/aliases.sh"
        bash_cfg::try_source "${root}/prompt/prompt.sh"
    fi
}
