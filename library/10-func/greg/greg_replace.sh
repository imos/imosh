# func::greg_replace -- Replace a GREG pattern with a string.
#
# Usage:
#   void func::greg_replace(string* subject, string pattern, string replace)
#
# Replace pattern with replace in *subject.
func::greg_replace() {
  if ! shopt extglob >/dev/null; then
    shopt -s extglob
    func::greg_replace "$@"
    shopt -u extglob
    return "$?"
  fi

  if [ "$#" -ne 3 ]; then
    LOG FATAL 'func::greg_replace takes exactly 3 arguments.'
  fi
  local __greg_replace_subject_variable="${1}"
  local __greg_replace_search="${2}"
  local __greg_replace_replace="${3}"

  eval "${__greg_replace_subject_variable}=\"\${${__greg_replace_subject_variable}//\${__greg_replace_search}/\${__greg_replace_replace}}\""
}
