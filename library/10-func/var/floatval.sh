# floatval -- Casts a variable as a float value.
#
# Casts variable into float type.  If it fails, returns 1.
#
# Usage:
#     // 1-a. Function form.
#     bool func::floatval(string* output, string input)
#     // 1-b. Inplace function form.
#     bool func::floatval(string* variable)
#     // 2. Command form.
#     bool sub::floatval(string input) > output
func::floatval() {
  if [ "$#" -eq 2 ]; then
    if [[ ! "${2}" =~ ^[[:space:]]*(-?[0-9]+(\.[0-9]+)?) ]]; then
      return 1
    fi
    func::let "${1}" "${BASH_REMATCH[1]}"
  elif [ "$#" -eq 1 ]; then
    eval "func::floatval \"\${1}\" \"\${${1}}\" || return \"\$?\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::floatval() {
  if [ "$#" -eq 1 ]; then
    local __floatval_value="${1}"
    func::floatval __floatval_value || return "$?"
    sub::println "${__floatval_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
