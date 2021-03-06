# fgets -- Gets a line from STDIN.
#
# fgets reads a line and regards it as a result.  fgets does not strip a
# trailing new line.  The function form sets the result to a variable.  The
# subroutine form outputs the result to the standard output.
#
# Usage:
#     // 1. Function form.
#     bool func::fgets(string* variable)
#     // 2. Subroutine form.
#     bool sub::fgets() > line
func::fgets() {
  if [ "$#" -eq 1 ]; then
    local __fgets_buffer=''
    local __fgets_line=''

    func::let "${1}" ''
    # Check if EOF.
    if ! IFS= read -r -n 1 -d '' __fgets_buffer; then
      return 1
    fi
    __fgets_line+="${__fgets_buffer}"
    if [ "${__fgets_buffer}" = $'\n' ]; then
      func::strcpy "${1}" __fgets_buffer
      return
    fi
    if IFS= read -r -d $'\n' __fgets_buffer; then
      __fgets_buffer+=$'\n'
    fi
    __fgets_line+="${__fgets_buffer}"
    func::strcpy "${1}" __fgets_line
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::fgets() {
  if [ "$#" -eq 0 ]; then
    local variable=''
    if ! func::fgets variable; then return 1; fi
    sub::print "${variable}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
