# enumval -- Casts a variable as an enum value.
#
# Casts variable into enum type.  If it fails, returns 1.
#
# Usage:
#     // 1-a. Function from.
#     bool func::enumval(string* output, string input)
#     // 1-b. Inplace function form.
#     bool func::enumval(string* variable)
#     // 2. Command form.
#     bool sub::enumval(string input) > output
func::enumval() {
  if [ "$#" -eq 2 ]; then
    if sub::in_array "${2}" __imosh_enum_values; then
      func::let "${1}" "${2}"
    else
      func::let "${1}" "${__imosh_enum_values[0]}"
      return 1
    fi
  elif [ "$#" -eq 1 ]; then
    eval "func::enumval \"\${1}\" \"\${${1}}\" || return \"\$?\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::enumval() {
  if [ "$#" -eq 1 ]; then
    local __enumval_value="${1}"
    func::enumval __enumval_value || return "$?"
    sub::println "${__enumval_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
