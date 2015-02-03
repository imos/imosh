# intval -- Casts a variable as an integer value.
#
# Casts variable into integer type.  If it fails, returns 1.
#
# Usage:
#     // 1-a. Function from.
#     bool func::intval(string* output, string input)
#     // 1-b. Inplace function form.
#     bool func::intval(string* variable)
#     // 2. Command form.
#     bool sub::intval(string input) > output
func::intval() {
  if [ "$#" -eq 2 ]; then
    if [[ ! "${2}" =~ ^[[:space:]]*(-?[0-9]+) ]]; then
      func::let "${1}" 0
      return 1
    fi
    func::let "${1}" "${BASH_REMATCH[1]}"
  elif [ "$#" -eq 1 ]; then
    eval "func::intval \"\${1}\" \"\${${1}}\" || return \"\$?\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::intval() {
  if [ "$#" -eq 1 ]; then
    local __intval_value="${1}"
    func::intval __intval_value || return "$?"
    sub::println "${__intval_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
