# func::greg_match -- Checks if a string matches a GREG pattern.
#
# greg_match checks if a string matches a GREG pattern.
#
# Usage:
#     // 1. Function form.
#     void func::greg_match(string pattern, string subject)
func::greg_match() {
  if ! shopt extglob > /dev/null; then
    shopt -s extglob
    local result=0
    func::greg_match "$@" || result="$?"
    shopt -u extglob
    return "${result}"
  fi

  if [ "$#" -eq 2 ]; then
    local __greg_match_pattern="${1}"
    local __greg_match_subject="${2}"

    if [[ "${__greg_match_subject}" = ${__greg_match_pattern} ]]; then
      return 0
    else
      return 1
    fi
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
