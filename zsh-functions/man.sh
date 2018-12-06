function man {
  env LESS_TERMCAP_md=$'\033[1;34m' \
    LESS_TERMCAP_us=$'\033[0;36m' \
    LESS_TERMCAP_so=$'\033[1;31m' \
    LESS_TERMCAP_mb=$'\033[0m' \
    LESS_TERMCAP_me=$'\033[0m' \
    LESS_TERMCAP_se=$'\033[0m' \
    LESS_TERMCAP_ue=$'\033[0m' \
    man "$@"
}
