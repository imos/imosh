# strval -- Casts a variable as a string value.
#
# Casts variable into string type.
#
# Usage:
#     // 1-a. Function from.
#     void func::strval(string* output, string input)
#     // 1-b. Inplace function form.
#     void func::strval(string* variable)
#     // 2. Command form.
#     bool sub::strval(string input) > output
func::strval() {
  if [ "$#" -eq 2 ]; then
    func::let "${1}" "${2}"
  elif [ "$#" -eq 1 ]; then
    func::strcpy "${1}" "${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::strval() {
  if [ "$#" -eq 1 ]; then
    local __strval_value="${1}"
    func::strval __strval_value || return "$?"
    sub::println "${__strval_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
