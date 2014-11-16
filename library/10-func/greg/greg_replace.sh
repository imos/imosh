# greg_replace -- Replace a GREG pattern with a string.
#
# greg_replace replaces substrings matching a pattern with a string.
#
# Usage:
#     // 1. Function form.
#     void func::greg_replace(string* subject, string pattern, string replace)
#     // 2. Command form.
#     void sub::greg_replace(
#         string subject, string pattern, string replace) > output
func::greg_replace() {
  if ! shopt extglob >/dev/null; then
    local __greg_replace_status=0
    shopt -s extglob
    func::greg_replace "$@"
    shopt -u extglob
  elif [ "$#" -eq 3 ]; then
    eval "${1}=\"\${${1}//\${2}/\${3}}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::greg_replace() {
  if [ "$#" -eq 3 ]; then
    local __greg_replace_subject="${1}"
    func::greg_replace __greg_replace_subject "${2}" "${3}"
    sub::println "${__greg_replace_subject}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
