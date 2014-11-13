# ord -- Gets a character's ASCII code.
#
# Sets ASCII value of character to variable.
#
# Usage:
#     // 1-a. Function form.
#     void func::ord(string* variable, string character)
#     // 1-b. Function form.
#     void func::ord(string* variable)
#     // 2. Command form.
#     void sub::ord(string character) > output
func::ord() {
  if [ "$#" -eq 2 ]; then
    func::let "${1}" "$(printf '%d' \'"${2}")"
  elif [ "$#" -eq 1 ]; then
    local __ord_value=''
    func::strcpy __ord_value "${2}"
    func::ord "${1}" "${__ord_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::ord() {
  if [ "$#" -eq 1 ]; then
    local __ord_variable=''
    func::ord __ord_variable "${1}"
    func::println "${__ord_variable}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
