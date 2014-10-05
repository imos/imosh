# func::greg_replace -- Replace a GREG pattern with a string.
#
# greg_replace replaces substrings matching a pattern with a string.
#
# Usage:
#     void func::greg_replace(string* subject, string pattern, string replace)
func::greg_replace() {
  if ! shopt extglob >/dev/null; then
    shopt -s extglob
    func::greg_replace "$@"
    shopt -u extglob
    return "$?"
  fi

  if [ "$#" -eq 3 ]; then
    local __greg_replace_subject_variable="${1}"
    local __greg_replace_search="${2}"
    local __greg_replace_replace="${3}"

    eval "${__greg_replace_subject_variable}=\"\${${__greg_replace_subject_variable}//\${__greg_replace_search}/\${__greg_replace_replace}}\""
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
