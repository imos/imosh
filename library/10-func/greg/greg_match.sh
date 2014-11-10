# greg_match -- Checks if a string matches a GREG pattern.
#
# greg_match checks if a string matches a GREG pattern.
#
# Usage:
#     // 1. Command form.
#     bool sub::greg_match(string pattern, string subject)
sub::greg_match() {
  if ! shopt extglob > /dev/null; then
    shopt -s extglob
    local __greg_match_result=0
    sub::greg_match "$@" || __greg_match_result="$?"
    shopt -u extglob
    return "${__greg_match_result}"
  elif [ "$#" -eq 2 ]; then
    [[ "${2}" = ${1} ]] || return 1
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
