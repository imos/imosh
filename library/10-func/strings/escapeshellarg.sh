# escapeshellarg -- Escapes a variable as a shell argument.
#
# escapeshellarg escapes variable's content so as to use it as a shell argument.
#
# Usage:
#     // 1. Function form.
#     void func::escapeshellarg(string* variable)
func::escapeshellarg() {
  if [ "$#" -eq 1 ]; then
    local __escapeshellarg_value=''
    func::strcpy __escapeshellarg_value "${1}"
    if [ "${__escapeshellarg_value}" == '' ]; then
      func::let "${1}" "''"
      return
    fi
    if [ "${__escapeshellarg_value//[[:alnum:]\,\-\.\_\/\:\@]/}" == '' ]; then
      return
    fi
    func::str_replace __escapeshellarg_value "'" "'\\''"
    func::let "${1}" "'${__escapeshellarg_value}'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
