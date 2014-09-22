# Usage:
#   void func::greg_match(string pattern, string subject)
#
# Replace pattern with replace in *subject.
func::greg_match() {
  if ! shopt extglob >/dev/null; then
    shopt -s extglob
    func::greg_match "$@"
    local result="$?"
    shopt -u extglob
    return "${result}"
  fi

  if [ "$#" -ne 2 ]; then
    LOG FATAL 'func::greg_match takes exactly 2 arguments.'
  fi
  local __greg_match_pattern="${1}"
  local __greg_match_subject="${2}"

  if [[ "${__greg_match_subject}" = ${__greg_match_pattern} ]]; then
    return 0
  else
    return 1
  fi
}
