# Usage:
#   void func::str_replace(string* subject, string search, string replace)
#
# Replace search with replace in *subject.
func::str_replace() {
  if [ "$#" -ne 3 ]; then
    LOG FATAL 'func::str_replace takes exactly 3 arguments.'
  fi
  local __str_replace_subject_variable="${1}"
  local __str_replace_search="${2}"
  local __str_replace_replace="${3}"

  eval "${__str_replace_subject_variable}=\"\${${__str_replace_subject_variable}//\"\${__str_replace_search}\"/\${__str_replace_replace}}\""
}
